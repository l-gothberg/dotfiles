#!/bin/bash
# =============================================================================
#  chezmoi dotfiles bootstrap script
#  Run this on a fresh machine (macOS or Linux)
# =============================================================================

set -euo pipefail

# =================== GitHub Repo Location ===================
REPO_URL="git@github.com:l-gothberg/dotfiles.git"
# ============================================================

CHEZMOI_DIR="$HOME/.local/share/chezmoi"
BOOTSTRAP_SCRIPT="$CHEZMOI_DIR/run_once_bootstrap.sh"

echo "=== Starting dotfiles bootstrap ==="

# ─── Import SSH key from USB flash drive titled BOOTSTRAP ─────────────────────
import_ssh_key_from_bootstrap_usb() {
    local usb_path=""
    local key_file="gmail"
    local key_dest="$HOME/.ssh/id_ed25519"

    echo "→ Searching for flash drive named 'BOOTSTRAP'..."

    if [[ "$(uname)" == "Darwin" ]]; then
        usb_path="/Volumes/BOOTSTRAP"
    else
        for prefix in "/media/$USER" "/run/media/$USER" "/mnt"; do
            if [[ -d "$prefix/BOOTSTRAP" ]]; then
                usb_path="$prefix/BOOTSTRAP"
                break
            fi
        done
    fi

    if [[ -z "$usb_path" || ! -d "$usb_path" ]]; then
        echo "→ Flash drive 'BOOTSTRAP' not found or not mounted."
        echo "   Continuing without importing SSH key."
        return 0
    fi

    echo "→ Found flash drive at: $usb_path"

    local src_key="$usb_path/$key_file"
    if [[ ! -f "$src_key" ]]; then
        echo "→ File '$key_file' not found in root of BOOTSTRAP volume."
        echo "   Continuing without key. (looked for: $src_key)"
        return 0
    fi

    echo "→ Found key: $src_key"

    # Create and secure ~/.ssh early
    mkdir -p "$HOME/.ssh" || { echo "Failed to create ~/.ssh"; return 1; }

    # Fix ownership (non-sudo first, sudo fallback)
    if ! chown "$(whoami)" "$HOME/.ssh" 2>/dev/null; then
        sudo chown "$(whoami)" "$HOME/.ssh" || { echo "Failed to set ownership on ~/.ssh"; return 1; }
    fi
    chmod 700 "$HOME/.ssh" || { echo "Failed to chmod ~/.ssh"; return 1; }

    # Copy private key + fix ownership & perms immediately
    cp -p "$src_key" "$key_dest" || { echo "Failed to copy private key"; return 1; }
    chown "$(whoami)" "$key_dest" || sudo chown "$(whoami)" "$key_dest"
    chmod 600 "$key_dest"

    # Copy public key if present
    if [[ -f "$usb_path/${key_file}.pub" ]]; then
        local pub_dest="${key_dest}.pub"
        cp -p "$usb_path/${key_file}.pub" "$pub_dest" || { echo "Failed to copy public key"; return 1; }
        chown "$(whoami)" "$pub_dest" || sudo chown "$(whoami)" "$pub_dest"
        chmod 644 "$pub_dest"
        echo "→ Also copied public key → $pub_dest"
    fi

    echo "→ SSH key imported successfully:"
    echo "  → $key_dest (600)"
    if [[ -f "${key_dest}.pub" ]]; then
        echo "  → ${key_dest}.pub (644)"
    fi
    echo "  → Verify with: ls -l ~/.ssh/"
}

# Run early — before git clone
import_ssh_key_from_bootstrap_usb

# 1. Install chezmoi if missing
if ! command -v chezmoi >/dev/null 2>&1; then
    echo "→ Installing chezmoi..."
    if [[ "$(uname)" == "Darwin" ]]; then
        # macOS
        if ! command -v brew >/dev/null 2>&1; then
    echo "→ Installing Homebrew (you will be prompted for password)..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
        echo "Homebrew install failed. Please run the following manually and retry:"
        echo "    /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        exit 1
    }
    # Re-source Homebrew environment (especially important on Apple Silicon)
    if [ -x /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -x /usr/local/bin/brew ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
fi
        brew install chezmoi
    else
        # Linux
        sudo apt update && sudo apt install -y chezmoi || {
            echo "→ Falling back to official installer..."
            sh -c "$(curl -fsLS https://git.io/chezmoi)" -- -b /usr/local/bin
        }
    fi
fi

# 2. Clone (or update) the repo
if [ ! -d "$CHEZMOI_DIR" ]; then
    echo "→ Cloning dotfiles repo..."
    git clone "$REPO_URL" "$CHEZMOI_DIR"
else
    echo "→ Dotfiles repo already exists, pulling latest changes..."
    cd "$CHEZMOI_DIR" && git pull
fi

# 3. Run your custom bootstrap (installs brew/oh-my-zsh/plugins/etc.)
if [ -f "$BOOTSTRAP_SCRIPT" ]; then
    echo "→ Executing bootstrap script..."
    bash "$BOOTSTRAP_SCRIPT"
else
    echo "⚠️  Bootstrap script not found at $BOOTSTRAP_SCRIPT"
    echo "    Continuing with chezmoi apply anyway..."
fi

# 4. Final apply (this installs .zshrc, .p10k.zsh, etc.)
echo "→ Running chezmoi apply..."
chezmoi apply

echo "=================================================="
echo "✅ Bootstrap complete!"
echo ""
echo "Next steps:"
echo "   • Restart your terminal"
echo "   • Or run:  exec zsh"
echo ""
echo "You're all set! ✨"