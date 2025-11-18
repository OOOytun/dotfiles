#!/bin/bash
# Dotfiles installation script - creates symlinks for config files

set -e

DOTFILES_DIR="$HOME/dotfiles"

echo "Installing dotfiles from $DOTFILES_DIR..."

# Create .config directory if it doesn't exist
mkdir -p "$HOME/.config"

# Function to create symlink
create_symlink() {
    local source="$DOTFILES_DIR/$1"
    local target="$HOME/.config/$1"

    if [ -e "$target" ]; then
        if [ -L "$target" ]; then
            echo "✓ Symlink already exists: $target"
        else
            echo "⚠ Backing up existing $target to ${target}.backup"
            mv "$target" "${target}.backup"
            ln -s "$source" "$target"
            echo "✓ Created symlink: $target"
        fi
    else
        ln -s "$source" "$target"
        echo "✓ Created symlink: $target"
    fi
}

# Create symlinks for each config
create_symlink "nvim"
create_symlink "yazi"

echo ""
echo "✓ Dotfiles installation complete!"
echo "  - nvim: $HOME/.config/nvim → $DOTFILES_DIR/nvim"
echo "  - yazi: $HOME/.config/yazi → $DOTFILES_DIR/yazi"
echo ""
echo "To add new configs:"
echo "  1. Copy config to ~/dotfiles/app-name"
echo "  2. Add 'create_symlink \"app-name\"' to this script"
echo "  3. Run: $DOTFILES_DIR/install.sh"
