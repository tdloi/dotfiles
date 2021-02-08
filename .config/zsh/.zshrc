HISTFILE="$ZDOTDIR/.histfile"
HISTSIZE=1000000
SAVEHIST=1000000

source "$ZDOTDIR/zenv"
source "$ZDOTDIR/zalias"
source "$ZDOTDIR/zkey"

source "$ZDOTDIR/powerlevel9k.zsh"



### setopt
setopt append_history         # Allow multiple terminal sessions to all append to one zsh command history
setopt auto_cd
setopt auto_pushd             # push old cd to dir stack
setopt pushd_ignore_dups      # don't push dup to dir stack
setopt correct
setopt notify
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data
setopt hist_find_no_dups      # Don't display results already cycled through twice
setopt hist_ignore_all_dups
setopt NO_BEEP


# Not add anything to $PATH if it's there already
typeset -U path
path=($path[@])


### Completion
autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
fpath=($ZDOTDIR/completion $fpath)
# Ignore completion functions for commands you don’t have
zstyle ':completion:*:functions' ignored-patterns '_*'
# zstyle ':completion:*' completer _match _approximate
# zstyle ':completion:*:match:*' original only
# zstyle ':completion:*:approximate:*' max-errors 2 numeric
# Ignore .git venv folder
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#.git' '(*/)#.venv'
# Using cache to speed up
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $ZDOTDIR/cache
compinit


# run-help
autoload -Uz run-help
unalias run-help
alias help=run-help

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
