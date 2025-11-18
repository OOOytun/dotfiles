# Dotfiles

Personal configuration files for terminal applications.

## Contents

- **nvim/** - Neovim configuration with lazy.nvim plugin manager
- **yazi/** - Yazi file manager configuration with zoxide integration
- **wezterm/** - WezTerm terminal emulator configuration
- **zsh/** - Zsh shell configuration with Powerlevel10k theme

## Installation

### On a new machine:

```bash
git clone git@github.com:OOOytun/dotfiles.git ~/dotfiles && ~/dotfiles/install.sh
```

This will:
1. Clone the repository
2. Create symlinks from ~/.config/ to ~/dotfiles/

Symlinks created:
- nvim → ~/.config/nvim
- yazi → ~/.config/yazi
- wezterm → ~/.config/wezterm
- zsh → ~/.zshrc

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

- Each config is symlinked to maintain a clean structure
  - App configs symlink from ~/.config/ (nvim, yazi, wezterm)
  - Shell config (.zshrc) symlinks from ~/ (home directory)
- Original files are backed up before symlinking
- Configs are version controlled independently via this single repository
- Zsh config is cross-platform compatible (detects macOS vs Linux)

## Zsh Configuration (.zshrc)

The zsh configuration includes:
- **Powerlevel10k** theme for a beautiful prompt
- **Cross-platform support** - automatically detects macOS vs Linux and loads appropriate paths
- **Security improvements** - removed hardcoded passwords, uses conditional sourcing
- **Plugin support** - zsh-autosuggestions and zsh-syntax-highlighting
- **Yazi integration** - smart directory jumping
- **Zoxide integration** - better cd command
- **NVM support** - Node version management
- **JAVA_HOME and ANDROID_HOME** - development environment setup

## Environment Variables (.env)

Sensitive credentials are managed via a `.env` file that is **gitignored** and never committed to the repository.

### Setup:

1. **Copy the template:**
   ```bash
   cp ~/dotfiles/.env.example ~/dotfiles/.env
   ```

2. **Edit with your credentials:**
   ```bash
   nano ~/dotfiles/.env
   ```

3. **Add to ~/.zshrc (if using zsh):**
   The zsh configuration automatically sources `~/.env` if it exists

### Available variables:

- `AFFINE_BASE_URL` - Affine MCP base URL
- `AFFINE_API_TOKEN` - Affine MCP API token

Add more variables as needed - they'll be automatically sourced on shell startup.

### On new machines:

1. Clone dotfiles and run install.sh
2. Create your own `.env` file with your credentials
3. Never commit `.env` to git

### Security Notes

- `.env` is gitignored to prevent accidental credential leaks
- Removed hardcoded passwords from aliases (original stored in backup)
- For sudo-based aliases, use proper sudo configuration instead of passwords in dotfiles
- Keep `.env` with restricted permissions: `chmod 600 ~/dotfiles/.env`
