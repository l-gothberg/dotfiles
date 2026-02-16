#!/bin/bash
# =============================================================================
#  chezmoi dotfiles bootstrap script
#  Run this on a fresh machine (macOS or Linux)
# =============================================================================

set -euo pipefail

# =================== GitHub Repo Location ===================
REPO_URL="https://github.com/yourusername/dotfiles.git"
# ============================================================

CHEZMOI_DIR="$HOME/.local/share/chezmoi"
BOOTSTRAP_SCRIPT="$CHEZMOI_DIR/run_once_bootstrap.sh"

echo "=== Starting dotfiles bootstrap ==="

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