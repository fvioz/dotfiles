# History setup
HISTFILE=$HOME/.zhistory
HISTSIZE=1000
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt append_history
setopt share_history
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_save_no_dups
setopt hist_verify

# GPG
export GPG_TTY=$(tty)

# Alias
alias ccat="$(which cat)"
alias cat="$(which bat)"
alias gst="$(which git) status"
alias ga="$(which git) add"
alias gc="$(which git) commit --verbose"
alias gl="$(which git) pull"
alias ls="$(which eza) --icons=always"

# Man
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

# Keybindings
bindkey -e
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down

# Zinit (Plugin manager)
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Install Zinit if not already installed
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Load Zinit
source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz compinit && compinit
(( ${+_comps} )) && _comps[zinit]=_zinit
zinit cdreplay -q

# Zsh plugins
zinit light Aloxaf/fzf-tab
zinit light MichaelAquilina/zsh-you-should-use
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-history-substring-search

# Starship (Customizable prompt)
zinit ice as"command" from"gh-r" \
          atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
          atpull"%atclone" src"init.zsh"
zinit load starship/starship

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Fuzzy finder
source <(fzf --zsh)

# Zoxide (Smarter cd command)
eval "$(zoxide init zsh --cmd cd)"

# Mise (Tool version manager)
eval "$(mise activate zsh --shims)"
