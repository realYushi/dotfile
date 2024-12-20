autoload -Uz compinit
compinit
# Load Antidote for plugin management
source "$(brew --prefix)/opt/antidote/share/antidote/antidote.zsh"

# Initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load


# Environment variables
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_DEFAULT_COMMAND='fd --type file '
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS=" \
--height 40% --tmux bottom,40% --layout reverse --border top \
--color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39 \
--color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 \
--color=marker:#7287fd,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39 \
--color=selected-bg:#bcc0cc \
--multi"
export EZA_CONFIG_DIR="~/.config/eza"
export BAT_THEME="Catppuccin Latte"
# Aliases
alias ls='eza -alh --icons --group-directories-first'
alias cat="bat --theme=$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo default || echo GitHub)"
alias rm='echo "use trash-put"; false'
# Functions
y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(<"$tmp")" && [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
    cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Source additional scripts
source <(fzf --zsh)
# Initialize tools
POSH_THEMES_PATH=$(brew --prefix oh-my-posh)/themes
eval "$(oh-my-posh completion zsh)"
eval "$(zoxide init zsh)"
eval "$(thefuck --alias)"
eval "$(/opt/homebrew/bin/mise activate zsh)" 

eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh-theme.json)"


. "$HOME/.local/bin/env"
