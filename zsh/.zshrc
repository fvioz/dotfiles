# History setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999

setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }

# GPG
export GPG_TTY=$(tty)

# Alias
alias cd="z"
alias ccat="$(which cat)"
alias cat="$(which bat)"
alias gst="$(which git) status"
alias gc="$(which git) commit --verbose"
alias ls="$(which eza) --icons=always"

# Man
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

# Bindkey
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# Zsh plugins
fpath=($(brew --prefix)/share/zsh-completions $fpath)

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh
source $(brew --prefix)/share/zsh-you-should-use/you-should-use.plugin.zsh
source <(fzf --zsh)

# Starship (Customizable prompt)
eval "$(starship init zsh)"

# Zoxide (Smarter cd command)
eval "$(zoxide init zsh)"

# Mise (Tool version manager)
eval "$(mise activate zsh --shims)"
