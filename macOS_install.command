#!/bin/bash
# ┌──────────────────────────────────────────────────────────────────────────────────────┐
# │        Single Click Bootstrapper for New macOS Installs — managed by chezmoi         │
# └──────────────────────────────────────────────────────────────────────────────────────┘

# This script is intended to be double-clicked in Finder (hence .command extension).
# It sets up the minimal structure needed to bootstrap the full chezmoi-managed dotfiles.

set -euo pipefail  # strict mode

# ─────────────── Setup Logging ───────────────
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="/tmp/macos_bootstrap_${TIMESTAMP}.log"
PERSISTENT_LOG="/Volumes/BOOTSTRAP/macos_bootstrap_ERROR_${TIMESTAMP}.log"

echo "macOS Bootstrap started at $(date)" | tee "$LOG_FILE"

log() {
    echo "[$(date +'%H:%M:%S')] $*" | tee -a "$LOG_FILE"
}

success() {
    log "SUCCESS: $*"
}

error() {
    log "ERROR: $*"
    log "Bootstrap failed."

    # Copy log to BOOTSTRAP volume for persistence in case of error
    if [ -d "/Volumes/BOOTSTRAP" ] && cp "$LOG_FILE" "$PERSISTENT_LOG" 2>/dev/null; then
        log "Error log copied to: $PERSISTENT_LOG"
        echo ""
        echo "┌────────────────────────────────────────────────────────────┐"
        echo "│ Bootstrap failed — log file saved at:                      │"
        echo "│   • Persistent (on BOOTSTRAP): $PERSISTENT_LOG   │"
        echo "└────────────────────────────────────────────────────────────┘"
    else
        log "Could not copy log to BOOTSTRAP volume."
        echo ""
        echo "┌────────────────────────────────────────────────────────────┐"
        echo "│ Bootstrap failed — temporary log saved only at:            │"
        echo "│   $LOG_FILE                                         │"
        echo "└────────────────────────────────────────────────────────────┘"
    fi

    exit 1
}

cleanup_success() {
    if [ -f "$LOG_FILE" ]; then
        log "All steps completed successfully."
        rm -f "$LOG_FILE"
        echo ""
        echo "Bootstrap finished successfully — no errors logged."
    fi
}

trap 'error "Script interrupted"' INT TERM
trap cleanup_success EXIT

# ─────────────── Check for SSH keys on BOOTSTRAP volume ───────────────
BOOTSTRAP_VOLUME="/Volumes/BOOTSTRAP"

if [ ! -d "$BOOTSTRAP_VOLUME" ]; then
    error "BOOTSTRAP volume not found at $BOOTSTRAP_VOLUME"
fi

# Define expected key paths
GMAIL_PRIV="$BOOTSTRAP_VOLUME/gmail"
GMAIL_PUB="$BOOTSTRAP_VOLUME/gmail.pub"
STARTMAIL_PRIV="$BOOTSTRAP_VOLUME/startmail"
STARTMAIL_PUB="$BOOTSTRAP_VOLUME/startmail.pub"

missing=()

[ -f "$GMAIL_PRIV" ]     || missing+=("gmail")
[ -f "$GMAIL_PUB" ]      || missing+=("gmail.pub")
[ -f "$STARTMAIL_PRIV" ] || missing+=("startmail")
[ -f "$STARTMAIL_PUB" ]  || missing+=("startmail.pub")

if [ ${#missing[@]} -gt 0 ]; then
    log "Missing SSH key files on $BOOTSTRAP_VOLUME:"
    for f in "${missing[@]}"; do
        log "  - $f"
    done
    error "Both gmail(+.pub) and startmail(+.pub) key pairs are required.\nPlease place all four files in the root of the BOOTSTRAP volume and try again."
fi

log "All required SSH keys found — proceeding."

# ─────────────── Provision SSH Keys ───────────────
SSH_DIR="$HOME/.ssh"
mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

copy_ssh_key() {
    local src_name="$1"
    local dst_name="$2"
    local src_priv="$BOOTSTRAP_VOLUME/$src_name"
    local src_pub="$BOOTSTRAP_VOLUME/$src_name.pub"
    local dst_priv="$SSH_DIR/$dst_name"
    local dst_pub="$SSH_DIR/$dst_name.pub"

    cp "$src_priv" "$dst_priv"
    cp "$src_pub" "$dst_pub"
    chmod 600 "$dst_priv"
    chmod 644 "$dst_pub"
    success "Copied and secured SSH key: $dst_name"
}

copy_ssh_key "gmail"    "id_ed25519"
copy_ssh_key "startmail" "startmail"

chown -R "$(whoami)":staff "$SSH_DIR"

# ─────────────── Install Xcode Command Line Tools ───────────────
log "Checking for Xcode Command Line Tools..."
if ! xcode-select -p &>/dev/null; then
    log "Installing Xcode Command Line Tools (a popup may appear)..."
    xcode-select --install || error "Failed to trigger Xcode CLI tools install."
    # Wait until installed
    until xcode-select -p &>/dev/null; do sleep 5; done
    success "Xcode Command Line Tools installed."
else
    success "Xcode Command Line Tools already installed."
fi

# ─────────────── Install / Ensure Homebrew ───────────────
log "Setting up Homebrew..."

if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

if ! command -v brew >/dev/null; then
    log "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || error "Homebrew install failed"
    # Re-eval after install
    if [ -x /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -x /usr/local/bin/brew ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    log "Homebrew already installed."
fi

# ─────────────── Install chezmoi ───────────────
log "Installing chezmoi if missing..."
if ! command -v chezmoi >/dev/null; then
    curl -fsSL https://git.io/chezmoi | bash || error "chezmoi install failed"
fi
success "chezmoi ready."

# ─────────────── Clone & Apply Dotfiles via SSH ───────────────
# Using SSH URL — assumes keys were copied and added to GitHub
REPO_URL="git@github.com:l-gothberg/dotfiles.git"
if [ ! -d "$HOME/.local/share/chezmoi" ]; then
    log "Initializing chezmoi with SSH remote: $REPO_URL"
    chezmoi init --apply "$REPO_URL" || error "chezmoi init --apply failed (check that your SSH key is added to GitHub)"
else
    log "chezmoi repo already exists → updating & applying..."
    chezmoi cd
    git remote set-url origin "$REPO_URL" || true
    git fetch || log "git fetch had issues — continuing anyway"
    cd - >/dev/null
    chezmoi update || log "chezmoi update had issues — continuing anyway"
    chezmoi apply || error "chezmoi apply failed"
fi

success "Dotfiles applied!"

# ─────────────── Set macOS Finder / Interface Defaults (runs late) ───────────────
log "Applying Finder & UI defaults (late in bootstrap)..."

# Disable natural scrolling → "classic" / normal direction
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Default Finder view: Column view
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Show folders first
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Sort by name (reinforce default)
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"  # current folder
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Aggressively clear .DS_Store files across the entire filesystem
log "Removing .DS_Store files system-wide (this may take a moment; password prompt may appear)..."
sudo find / -name .DS_Store -delete 2>/dev/null || true

# Refresh Finder & preferences
killall Finder cfprefsd 2>/dev/null || true
success "Finder defaults applied (column view, folders first, normal scroll, system-wide .DS_Store cleanup)"

# ─────────────── Final message ───────────────
echo ""
echo "┌────────────────────────────────────────────────────────────┐"
echo "│                  Bootstrap Complete!                       │"
echo "│                                                            │"
echo "│ • SSH keys copied & secured                                │"
echo "│ • Homebrew + chezmoi installed                             │"
echo "│ • Dotfiles cloned & applied via SSH                        │"
echo "│ • Finder defaults set (column view, normal scroll)         │"
echo "│ • .DS_Store files removed system-wide                      │"
echo "│                                                            │"
echo "│ Open a new Terminal window and run:                        │"
echo "│   ca          → apply any pending chezmoi changes          │"
echo "│   reload      → reload zsh config                          │"
echo "│   ssh -T git@github.com  → verify GitHub SSH auth          │"
echo "│                                                            │"
echo "└────────────────────────────────────────────────────────────┘"

exit 0