#!/bin/bash
# Dotfiles installation script - creates symlinks for config files

set -e

DOTFILES_DIR="$HOME/dotfiles"

echo "Installing dotfiles from $DOTFILES_DIR..."

# Create .config directory if it doesn't exist
mkdir -p "$HOME/.config"

# Function to create symlink in ~/.config/
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

# Function to create symlink in home directory
create_home_symlink() {
    local source="$DOTFILES_DIR/$1"
    local filename="$2"
    local target="$HOME/$filename"

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
create_symlink "wezterm"

# Create symlinks for home directory dotfiles
create_home_symlink "zsh/.zshrc" ".zshrc"

echo ""
echo "✓ Dotfiles installation complete!"
echo "  - nvim: $HOME/.config/nvim → $DOTFILES_DIR/nvim"
echo "  - yazi: $HOME/.config/yazi → $DOTFILES_DIR/yazi"
echo "  - wezterm: $HOME/.config/wezterm → $DOTFILES_DIR/wezterm"
echo "  - zsh: $HOME/.zshrc → $DOTFILES_DIR/zsh/.zshrc"
echo ""
echo "To add new configs:"
echo "  1. Copy config to ~/dotfiles/app-name"
echo "  2. Add 'create_symlink \"app-name\"' to this script"
echo "  3. Run: $DOTFILES_DIR/install.sh"
