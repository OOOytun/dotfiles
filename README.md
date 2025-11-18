# Dotfiles

Personal configuration files for terminal applications.

## Contents

- **nvim/** - Neovim configuration with lazy.nvim plugin manager
- **yazi/** - Yazi file manager configuration with zoxide integration

## Installation

### On a new machine:

```bash
git clone git@github.com:OOOytun/dotfiles.git ~/dotfiles && ~/dotfiles/install.sh
```

This will:
1. Clone the repository
2. Create symlinks from ~/.config/ to ~/dotfiles/

### Manual setup (if needed):

```bash
# Clone the repo
git clone git@github.com:OOOytun/dotfiles.git ~/dotfiles

# Run install script
~/dotfiles/install.sh
```

## Adding new configurations

1. Copy your config to ~/dotfiles/:
   ```bash
   cp -r ~/.config/myapp ~/dotfiles/
   ```

2. Add symlink creation to install.sh:
   ```bash
   create_symlink "myapp"
   ```

3. Commit and push:
   ```bash
   cd ~/dotfiles
   git add .
   git commit -m "Add myapp configuration"
   git push
   ```

4. On other machines, pull changes and run install.sh

## Dependencies

- **Neovim** 0.8+
- **Yazi** (file manager)
- **zoxide** (smart directory jumping)
- **fzf** (fuzzy finder)

## Notes

- Each config is symlinked from ~/.config/ to maintain a clean structure
- Original ~/.config files are backed up before symlinking
- Configs are version controlled independently via this single repository
