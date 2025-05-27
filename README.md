# Dotfiles

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Quick Start

```bash
./bootstrap.sh  # Install dependencies (Git, Stow, Homebrew on macOS)
./install.sh    # Install packages and symlink configs
```

## Structure

- `config/` - Stow packages for various programs
- `packages/` - Lists of packages to install per platform
- `bootstrap.sh` - Install essential dependencies
- `install.sh` - Install packages and symlink dotfiles

## Manual Setup

```bash
cd config
stow nvim  # Symlink Neovim config
stow git   # Symlink Git config
stow zsh   # Symlink Zsh config
```