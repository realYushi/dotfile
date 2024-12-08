# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load Antidote for plugin management
source "$(brew --prefix)/opt/antidote/share/antidote/antidote.zsh"

# Initialize plugins statically with ${ZDOTDIR:-~}/.zsh_plugins.txt
antidote load

# Load Powerlevel10k configuration
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Environment variables
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_DEFAULT_COMMAND='fd --type file '
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
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

# Source additional scripts
source <(fzf --zsh)
# Initialize tools
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"
eval "$(thefuck --alias)"

# Added by Windsurf
export PATH="/Users/yushi/.codeium/windsurf/bin:$PATH"
