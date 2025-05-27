#!/usr/bin/env bash

# Install script - idempotent installation of packages and dotfiles

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🚀 Starting installation from ${DOTFILES_DIR}..."

# Detect OS
OS="$(uname -s)"
case "${OS}" in
    Linux*)
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            DISTRO=$ID
        fi
        ;;
    Darwin*)
        DISTRO="macos"
        ;;
    *)
        echo "❌ Unsupported OS: ${OS}"
        exit 1
        ;;
esac

echo "📦 Installing packages for ${DISTRO}..."

# Install packages based on distribution
case "${DISTRO}" in
    "arch"|"cachyos")
        echo "📦 Installing pacman packages..."
        if [ -f "${DOTFILES_DIR}/packages/pacman.txt" ]; then
            sudo pacman -S --needed --noconfirm $(grep -v '^#' "${DOTFILES_DIR}/packages/pacman.txt" | tr '\n' ' ')
        fi
        
        echo "📦 Installing AUR packages..."
        if [ -f "${DOTFILES_DIR}/packages/aur.txt" ] && command -v paru &> /dev/null; then
            paru -S --needed --noconfirm $(grep -v '^#' "${DOTFILES_DIR}/packages/aur.txt" | tr '\n' ' ')
        fi
        ;;
        
    "ubuntu"|"debian")
        echo "📦 Installing apt packages..."
        if [ -f "${DOTFILES_DIR}/packages/apt.txt" ]; then
            sudo apt update
            sudo apt install -y $(grep -v '^#' "${DOTFILES_DIR}/packages/apt.txt" | tr '\n' ' ')
        fi
        ;;
        
    "macos")
        echo "📦 Installing Homebrew packages..."
        
        # Ensure Homebrew is installed
        if ! command -v brew &> /dev/null; then
            echo "⚠️  Homebrew not found. Please install it first:"
            echo "   /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
            exit 1
        fi
        
        # Update Homebrew first
        echo "  Updating Homebrew..."
        brew update
        
        if [ -f "${DOTFILES_DIR}/packages/Brewfile" ]; then
            brew bundle --file="${DOTFILES_DIR}/packages/Brewfile"
        fi
        ;;
esac

# Install global npm packages
if [ -f "${DOTFILES_DIR}/packages/npm-global.txt" ] && command -v npm &> /dev/null; then
    echo "📦 Installing global npm packages..."
    while IFS= read -r package; do
        # Skip comments and empty lines
        [[ "$package" =~ ^#.*$ ]] || [[ -z "$package" ]] && continue
        
        # Check if already installed
        if ! npm list -g "$package" &> /dev/null; then
            echo "  Installing: $package"
            npm install -g "$package"
        else
            echo "  Already installed: $package"
        fi
    done < "${DOTFILES_DIR}/packages/npm-global.txt"
fi

echo "🔗 Setting up dotfiles with stow..."

# Remove any existing symlinks that might conflict
[ -L ~/.config/nvim ] && rm ~/.config/nvim

# Stow dotfiles
cd "${DOTFILES_DIR}/config"

# Stow all config directories
for dir in */; do
    dir="${dir%/}"
    if [ -d "$dir" ]; then
        echo "  Stowing: $dir"
        stow -R "$dir" -t ~
    fi
done

echo "✅ Installation complete!"
echo ""
echo "📝 Next steps:"
echo "  1. Restart your shell or source your config files"
echo "  2. Run 'nvim' to let Neovim install its plugins"
echo "  3. Add more dotfiles to the repo and re-run this script"