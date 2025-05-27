#!/usr/bin/env bash

# Bootstrap script - installs package managers and essential tools

set -e

echo "🚀 Starting bootstrap process..."

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

echo "📦 Detected: ${DISTRO}"

# Install package managers and core tools
case "${DISTRO}" in
    "arch"|"cachyos")
        echo "📦 Installing paru for AUR access..."
        if ! command -v paru &> /dev/null; then
            sudo pacman -S --needed base-devel git
            git clone https://aur.archlinux.org/paru.git /tmp/paru
            cd /tmp/paru
            makepkg -si --noconfirm
            cd -
            rm -rf /tmp/paru
        fi
        
        echo "📦 Installing stow..."
        sudo pacman -S --needed stow
        ;;
        
    "ubuntu"|"debian")
        echo "📦 Updating package lists..."
        sudo apt update
        
        echo "📦 Installing stow..."
        sudo apt install -y stow
        ;;
        
    "macos")
        echo "📦 Installing Homebrew..."
        if ! command -v brew &> /dev/null; then
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            
            # Add Homebrew to PATH
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
        
        echo "📦 Installing stow..."
        brew install stow
        ;;
        
    *)
        echo "❌ Unsupported distribution: ${DISTRO}"
        exit 1
        ;;
esac

echo "✅ Bootstrap complete! You can now run ./scripts/install.sh"