# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# ---- OS Detection ----
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
    export ANDROID_HOME=$HOME/Library/Android/sdk
    # Homebrew paths (macOS ARM)
    export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
    export LDFLAGS="-L/opt/homebrew/opt/ruby/lib"
    export CPPFLAGS="-I/opt/homebrew/opt/ruby/include"
    export PATH="/opt/homebrew/bin:$PATH"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
    export ANDROID_HOME=$HOME/Android/Sdk
    export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
fi

# NVM Setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Android SDK
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# LM Studio CLI
export PATH="$PATH:$HOME/.cache/lm-studio/bin"

# Windsurf
export PATH="/Users/oytun/.codeium/windsurf/bin:$PATH"

# Yarn global binaries
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Cargo (Rust) - used on remote machines
if [ -d "$HOME/.cargo/bin" ]; then
  export PATH="$PATH:$HOME/.cargo/bin"
fi

# Kanata keyboard remapping alias
# NOTE: Remove passwords from aliases for security. Use sudo configuration instead.
# To enable passwordless sudo for kanata, add to sudoers:
#   %wheel ALL=(ALL) NOPASSWD: /usr/bin/killall kanata
#   %wheel ALL=(ALL) NOPASSWD: /usr/local/bin/kanata
# Then use: alias rk='sudo killall kanata 2>/dev/null; sudo kanata --cfg ~/.config/kanata/config.kbd &'
# alias rk='...'  # Uncomment after setting up sudo config

# Load environment variables from .env file (if it exists)
# .env should contain sensitive credentials and is gitignored
[ -f "$HOME/.env" ] && source "$HOME/.env"

# pipx
export PATH="$PATH:$HOME/.local/bin"

# Yazi Setup
export EDITOR="nvim"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Initialize zoxide
eval "$(zoxide init zsh)"

# ---- Powerlevel10k Theme ----
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS Homebrew
    [ -f /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme ] && \
        source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux Linuxbrew or system install
    [ -f /home/linuxbrew/.linuxbrew/share/powerlevel10k/powerlevel10k.zsh-theme ] && \
        source /home/linuxbrew/.linuxbrew/share/powerlevel10k/powerlevel10k.zsh-theme
    [ -f /usr/share/powerlevel10k/powerlevel10k.zsh-theme ] && \
        source /usr/share/powerlevel10k/powerlevel10k.zsh-theme
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Fallback if Powerlevel10k isn't available
if [[ -z "${POWERLEVEL10K_LOADED-}" ]] && [[ -z "${PROMPT:-}" || "$PROMPT" == "%m%# " ]]; then
    PROMPT='%F{cyan}%~%f %# '
fi

# ---- Zsh Plugins ----
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS Homebrew
    [ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && \
        source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    [ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
        source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux - check both Linuxbrew and system locations
    [ -f /home/linuxbrew/.linuxbrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && \
        source /home/linuxbrew/.linuxbrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && \
        source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    [ -f /home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
        source /home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && \
        source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# ---- History Setup ----
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# Completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ---- Eza (better ls) -----
alias ls="eza --icons=always"

# ---- FZF Configuration ----
# Show hidden files in fuzzy finder (excluding .git)
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'

# Set up fzf key bindings and fuzzy completion
if command -v fzf >/dev/null 2>&1; then
  if [[ "$OSTYPE" == "darwin"* ]]; then
    [ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ] && source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
    [ -f /opt/homebrew/opt/fzf/shell/completion.zsh ] && source /opt/homebrew/opt/fzf/shell/completion.zsh
  else
    [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
    [ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
  fi
fi
