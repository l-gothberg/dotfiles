# My Dotfiles

This is my personal dotfiles repository managed with Chezmoi. It configures Zsh for macOS and Linux (Ubuntu family), including custom aliases, OS-aware functions, and Powerlevel10k prompt theming inspired by the Vira Graphite High Contrast VS Code theme. For private use only.

## Installation

1. Install Chezmoi: On macOS, `brew install chezmoi`; on Linux, `sudo apt install chezmoi`.
2. Clone the repo: `git clone https://github.com/yourusername/dotfiles.git ~/.local/share/chezmoi` (replace with your private repo URL).
3. Apply: `chezmoi apply`.

**Note:** Back up existing dotfiles. For updates, `chezmoi update` or `ca` (alias for `chezmoi apply`).

## Usage

Zsh loads via Oh My Zsh and Powerlevel10k. Managed files: `.zshrc`, `.p10k.zsh`.

- **Prompt**: Powerlevel10k-themed (run `p10k configure` to adjust).
- **Common Aliases**:
  - `edit="code"` (open in VS Code)
  - `reload="source ~/.zshrc && clear"`
  - `ca="chezmoi apply"`
- **OS-Aware Aliases** (ls variants with colors, human-readable sizes, grouped directories on macOS/Linux):
  - `la`: Almost all files (`-A -F -h --group-directories-first --color=always --time-style=long-iso`)
  - `ll`: Long format with hidden (`-A -F -h -l --group-directories-first --color=always --time-style=long-iso`)
  - `lt`: Long, newest first (`-A -F -h -l -t --group-directories-first --color=always --time-style=long-iso`)
  - `ltr`: Long, oldest first (`-A -F -h -l -t -r --group-directories-first --color=always --time-style=long-iso`)
  - `ld`: Dotfiles only (`-d .* -F -h --color=always --time-style=long-iso`)
  - `l1`: One per line (`-1 -A -F -h --group-directories-first --color=always --time-style=long-iso`)
  - `lx`: Long, by extension (`-A -F -h -l -X --group-directories-first --color=always --time-style=long-iso`)
  - `lk`: Long, by size (`-A -F -h -l -S --group-directories-first --color=always --time-style=long-iso`)
- **OS-Aware Functions**:
  - `install <pkg(s)>`: Install via brew (macOS) or apt (Linux).
  - `uninstall <pkg(s)>`: Uninstall via brew (macOS) or apt (Linux).
  - `update`: Update packages/system via brew (macOS) or apt (Linux).

## Configuration Examples

To add an alias: Edit `dot_zshrc.tmpl` in Chezmoi source, e.g.,

```bash
alias foo="echo bar"
```

Then `ca` and `reload`.

Tweak prompt: `p10k configure` or edit `~/.p10k.zsh`, then `ca` to sync.

## Screenshots

- Terminal with prompt: [Add path to screenshot]
- Aliases in action: [Add path to screenshot]

## Troubleshooting

- gls missing on macOS: `brew install coreutils`.
- Prompt issues: Check `source ~/.p10k.zsh` in `.zshrc`.
- Chezmoi diagnostics: `chezmoi doctor`.
- Test changes: `source ~/.zshrc`.

Copyright L. Gothberg all rights reserved.
