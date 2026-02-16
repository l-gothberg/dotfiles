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
    local key_dest="$HOME/.ssh/id_ed25519"   # ← destination name (you can change)

    echo "→ Searching for flash drive named 'BOOTSTRAP'..."

    if [[ "$(uname)" == "Darwin" ]]; then
        usb_path="/Volumes/BOOTSTRAP"
    else
        # Linux — try common auto-mount locations
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
        echo "   (You can manually copy the key later: cp /path/to/BOOTSTRAP/KEY ~/.ssh/)"
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

    mkdir -p ~/.ssh
    chmod 700 ~/.ssh

    # Copy and rename to standard name (most tools expect id_ed25519 / id_rsa)
    cp -p "$src_key" "$key_dest"
    chmod 600 "$key_dest"

    # Also copy public key if it exists (named KEY.pub)
    if [[ -f "$usb_path/${key_file}.pub" ]]; then
        cp -p "$usb_path/${key_file}.pub" "${key_dest}.pub"
        chmod 644 "${key_dest}.pub"
        echo "→ Also copied public key (${key_file}.pub)"
    fi

    echo "→ SSH key copied to ~/.ssh/id_ed25519 (permissions fixed)"
    echo "   You may want to verify: ls -l ~/.ssh/"
}

# Run early — before git clone
import_ssh_key_from_bootstrap_usb

# 1. Install chezmoi if missing
if ! command -v chezmoi >/dev/null 2>&1; then
    echo "→ Installing chezmoi..."
    if [[ "$(uname)" == "Darwin" ]]; then
        # macOS
        if ! command -v brew >/dev/null 2>&1; then
            echo "→ Installing Homebrew first..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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