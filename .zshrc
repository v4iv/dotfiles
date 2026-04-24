# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ---- oh my zsh ----
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

autoload -U compinit && compinit

plugins=(git web-search fzf-tab zsh-autosuggestions fast-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

alias terminfo="uname -a"
alias reload-zsh="source ~/.zshrc"
alias edit-zsh="nvim ~/.zshrc"
alias reload-tmux="tmux source ~/.tmux.conf"
alias brewlist="brew leaves | xargs brew desc --eval-all"
alias casklist="brew ls --casks | xargs brew desc --eval-all"
alias myip='ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2'

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history 
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ---- FZF -----

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# --- setup fzf theme ---
fg="#CDD6F4"
bg="#1E1E2E"
bg_plus="#313244"
spinner="#F5E0DC"
hl="#F38BA8"
header="#F38BA8"
info="#CBA6F7"
pointer="#F5E0DC"
marker="#B4BEFE"
fg_plus="#CDD6F4"
prompt_color="#CBA6F7"
hl_plus="#F38BA8"
selected_bg="#45475A"
border="#6C7086",
label="#CDD6F4"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${hl},fg+:${fg_plus},bg+:${bg_plus},hl+:${hl_plus},info:${info},prompt:${prompt_color},pointer:${pointer},marker:${marker},spinner:${spinner},header:${header},selected-bg:${selected_bg},border:${border},label:${label} --height=40%"

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# use bat to preview files in fzf
alias ff='() { file=$(fzf --preview="bat --color=always {}") && [[ -n "$file" ]] && nvim "$file"; }'

# ---- Eza (better ls) ----
alias ls="eza --icons=always"

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"

alias cd="z"

alias python="python3"

# ---- fzf-tab ----
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# custom fzf flags
# NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
# "popup" feature for tmux
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

# ---- openjdk ----
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# ---- PostgreSQL ---- 
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

# ---- libpq ---- 
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# ---- Metasploit Framework ----
# export PATH="/opt/metasploit-framework/bin:$PATH"
PATH=$PATH:/opt/metasploit-framework/bin
export PATH=$PATH:/opt/metasploit-framework/bin

# pnpm
export PNPM_HOME="/Users/vaibhav/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# NVM related bindings
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun completions
[ -s "/Users/vaibhav/.bun/_bun" ] && source "/Users/vaibhav/.bun/_bun"

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/vaibhav/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

# OpenClaw Completion
source "$HOME/.openclaw/completions/openclaw.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

