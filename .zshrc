# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#
# Basic ZSH Setup
#
autoload -Uz compinit
compinit

#
# Plugin Management (Antidote)
#
source "/opt/homebrew/opt/antidote/share/antidote/antidote.zsh"
antidote load
# zsh-vim
zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')
ZVM_READKEY_ENGINE=$ZVM_READKEY_ENGINE_NEX
ZVM_INIT_MODE=sourcing
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
#
# FZF Configuration
#
# File search options

export FZF_DEFAULT_COMMAND='fd --type file'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# CTRL+T specific options (preview and navigation)
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# Default appearance (Catppuccin Latte theme colors)
export FZF_DEFAULT_OPTS=" \
--height 40% --tmux bottom,40% --layout reverse --border top \
--color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39 \
--color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 \
--color=marker:#7287fd,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39 \
--color=selected-bg:#bcc0cc \
--multi"

#
# Tool Configurations
#
export EZA_CONFIG_DIR="~/.config/eza"
export BAT_THEME="Catppuccin Latte"

#
# Aliases
#
# Modern replacements for traditional commands
alias ls='eza -alh --icons --group-directories-first'
alias cat="bat --theme=$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo default || echo GitHub)"
# Safety aliases
alias rm='echo "use trash-put"; false'
alias aider="aider --architect --model openrouter/deepseek/deepseek-r1 --editor-model openrouter/deepseek/deepseek-chat"
alias owu="DATA_DIR=~/.open-webui uvx --python 3.11 open-webui@latest serve"
#
# Custom Functions
#
# Yazi file manager with directory tracking
y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(<"$tmp")" && [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
    cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}
function _mommy_random() {
  [ $(( RANDOM % 100 )) -lt 30 ] && mommy -1 -s $? 
}
precmd() { _mommy_random $? }
#
# ZSH Completion Configuration
#
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
#
# Tool Initializations
#
source <(fzf --zsh)
eval "$(pay-respects zsh --alias)"
eval "$(zoxide init zsh --cmd cd)"
eval "$(/opt/homebrew/bin/mise activate zsh)"
export PATH="$HOME/.local/bin:$PATH"
export TMUX_PLUGIN_MANAGER_PATH="$HOME/.tmux/plugins/"
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/yushi/.lmstudio/bin"

export PATH="$PATH:/Applications/screenpipe.app/Contents/MacOS"

# bun completions
[ -s "/Users/yushi/.bun/_bun" ] && source "/Users/yushi/.bun/_bun"
