# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ---- PATH: Metasploit Framework, PostgreSQL, openjdk, libpq, .local/bin ----
typeset -U path

path=(
/opt/homebrew/opt/openjdk/bin
    /opt/homebrew/opt/postgresql@15/bin
    /opt/homebrew/opt/libpq/bin
    /opt/metasploit-framework/bin
    ~/.local/bin
    $path
)

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
path=("$PNPM_HOME/bin" $path)
# pnpm end

# zsh-completions
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/vaibhav/.docker/completions $fpath)
# End of Docker CLI completions

# bun completions
[ -s "/Users/vaibhav/.bun/_bun" ] && source "/Users/vaibhav/.bun/_bun"

# OpenClaw Completion
source "$HOME/.openclaw/completions/openclaw.zsh"

# ---- oh my zsh ----
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST

plugins=(
  git
  zsh-defer
  web-search
  ssh-agent
  deno
  bun
  fzf
  zsh-autosuggestions
  fast-syntax-highlighting
  fzf-tab
)

source $ZSH/oh-my-zsh.sh

# aliases
alias reload-zsh="source ~/.zshrc"
alias edit-zsh="nvim ~/.zshrc"
alias reload-tmux="tmux source ~/.tmux.conf"
alias brewlist="brew leaves | xargs -I{} brew desc {}"
alias casklist="brew ls --casks | xargs brew desc --eval-all"

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=100000
HISTSIZE=100000
setopt share_history 
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_find_no_dups

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ---- FZF (already initialized in omz plugins) -----
# --- setup fzf theme ---
fg="#f8f8f2"
bg="#282a36"
hl="#bd93f9"
fg_plus="#f8f8f2"
bg_plus="#44475a"
hl_plus="#bd93f9"
info="#ffb86c"
prompt_color="#50fa7b"
pointer="#ff79c6"
marker="#ff79c6"
spinner="#ffb86c"
header="#6272a4"
selected_bg="#45475A"
border="#6C7086"
label="#CDD6F4"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${hl},fg+:${fg_plus},bg+:${bg_plus},hl+:${hl_plus},info:${info},prompt:${prompt_color},pointer:${pointer},marker:${marker},spinner:${spinner},header:${header},selected-bg:${selected_bg},border:${border},label:${label} --height=40%"

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd \
  --hidden \
  --strip-cwd-prefix \
  --exclude .git \
  --exclude node_modules \
  --exclude dist \
  --exclude .next \
  --exclude .svelte-kit"
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

# use bat to preview files in fzf and nvim to open
alias ff='() { file=$(fzf --preview="bat --color=always {}") && [[ -n "$file" ]] && nvim "$file"; }'

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
zstyle ':fzf-tab:*' fzf-preview '
if [[ -d "$realpath" ]]; then
    eza --tree --icons=always --color=always "$realpath" | head -200
elif [[ -f "$realpath" ]]; then
    bat --style=numbers --color=always --line-range=:500 "$realpath"
fi
'
# custom fzf flags
# NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
zstyle ':fzf-tab:*' fzf-flags ${=FZF_DEFAULT_OPTS} --bind=tab:accept
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
# "popup" feature for tmux disabled coz the popup was way too small
# zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
# completion cache optimization
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh

# ---- Eza (better ls) ----
alias ls="eza --icons=always"

export EZA_CONFIG_DIR="$HOME/.config/eza"

# ---- Zoxide (better cd) ----
zsh-defer eval "$(zoxide init --cmd cd zsh)"

# ---- thefuck ----
zsh-defer eval "$(thefuck --alias)"

# ---- bat ----
alias cat="bat --paging=never"

# ---- Yazi Setup ----
export EDITOR="nvim"

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command bat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

command -v python3 >/dev/null && alias python=python3

# Lazy loaded NVM related bindings
export NVM_DIR="$HOME/.nvm"

_lazy_load_nvm() {
    unset -f nvm node npm npx corepack
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
    "$@"
}

nvm()      { _lazy_load_nvm nvm "$@"; }
node()     { _lazy_load_nvm node "$@"; }
npm()      { _lazy_load_nvm npm "$@"; }
npx()      { _lazy_load_nvm npx "$@"; }
corepack() { _lazy_load_nvm corepack "$@"; }

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

