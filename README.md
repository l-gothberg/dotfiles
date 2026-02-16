# My Dotfiles

This is my personal dotfiles repository managed with Chezmoi. It configures Zsh for macOS and Linux (Ubuntu family), including custom aliases, OS-aware functions, and Powerlevel10k prompt theming inspired by the Vira Graphite High Contrast VS Code theme. For private use only.

## Installation

# My Dotfiles

Modern, cross-platform (macOS + Ubuntu-family) dotfiles managed with **chezmoi**.

**Current stack (Feb 2026):**

- **Terminal**: Ghostty
- **Shell**: vanilla zsh
- **Prompt**: Starship (Material Design Colors palette)
- **Editor**: VS Code (`code --wait`)
- **Tools**: eza, bat, fd, ripgrep, zoxide, mise, gh, fzf…
- **Management**: chezmoi + Brewfile (macOS) + curated apt repos (Linux)

## One-command install

`curl -fsLS https://raw.githubusercontent.com/yourusername/dotfiles/main/raw_install.sh | bash`

Or run `raw_install.sh` manually.

## Daily commands

- `ca` → `chezmoi apply`
- `reload` → reload zsh
- `install <pkg>` / `uninstall <pkg>` → works on both macOS and Linux
- `ls` family → eza with icons + git status

## Structure

- `dot_zshrc.tmpl` – clean zsh config
- `starship.toml.tmpl` – beautiful prompt
- `run_once_bootstrap.sh.tmpl` – full system bootstrap
- `Brewfile` – macOS packages
- `packages-linux.txt` + repo logic – Linux packages

**Important:** Back up before first run.  
After bootstrap, just restart the terminal (or run `exec zsh`).

## TODO

Items that still need attention or would be nice improvements.

### Cleanup (should be done soon)

- NONE

### Nice-to-have (low effort, high reward)

- [ ] Add `delta` to Brewfile (macOS) and Linux bootstrap script  
       → Then set `git config --global core.pager "delta"` for beautiful git diffs
- [ ] Add `lazygit` to both macOS (Brewfile) and Linux bootstrap  
       → Very useful companion for the current git-heavy workflow
- [ ] Consider adding `yazi` (fast terminal file manager with image previews)  
       → Add to Brewfile and Linux bootstrap when the workflow calls for it

Feel free to check these off as they're completed and commit the changes.

Copyright L. Gothberg all rights reserved.
