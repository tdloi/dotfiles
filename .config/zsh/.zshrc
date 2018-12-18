HISTFILE="$ZDOTDIR/.histfile"
HISTSIZE=1000000
SAVEHIST=1000000

source "$ZDOTDIR/zenv"
source "$ZDOTDIR/zalias"
source "$ZDOTDIR/zkey"


### Powerline9k themes
# getColorCode background/foreground
source /usr/share/zsh-theme-powerlevel9k/powerlevel9k.zsh-theme
source /usr/share/fonts/awesome-terminal-fonts/devicons-regular.sh
source /usr/share/fonts/awesome-terminal-fonts/octiocns-regular.sh
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=false
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir dir_writable)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(pyenv vcs vi_mode)
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="\u$CODEPOINT_OF_AWESOME_TERMINAL  "
## dir
POWERLEVEL9K_HOME_ICON="\u$CODEPOINT_OF_AWESOME_HOME"
POWERLEVEL9K_HOME_SUB_ICON="\u$CODEPOINT_OF_AWESOME_FOLDER"
POWERLEVEL9K_ETC_ICON=''
# POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
# POWERLEVEL9K_SHORTEN_STRATEGY="truncate_to_first_and_last"
## vcs
POWERLEVEL9K_HIDE_BRANCH_ICON=true
POWERLEVEL9K_SHOW_CHANGESET=true
POWERLEVEL9K_CHANGESET_HASH_LENGTH=6
POWERLEVEL9K_VCS_SHORTEN_LENGTH=6
POWERLEVEL9K_VCS_SHORTEN_MIN_LENGTH=11
POWERLEVEL9K_VCS_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_VCS_SHORTEN_DELIMITER=".."
POWERLEVEL9K_VCS_GIT_HOOKS=(vcs-detect-changes git-remotebranch git-untracked git-aheadbehind git-tagname)
POWERLEVEL9K_VCS_GIT_GITHUB_ICON="\u$CODEPOINT_OF_AWESOME_GITHUB"
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='rosybrown'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='tan'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='lightslateblue'
### vi_mode
POWERLEVEL9K_VI_INSERT_MODE_STRING="INS"
POWERLEVEL9K_VI_COMMAND_MODE_STRING="NOR"
POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND='palegreen3'
POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND='black'
POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND='mediumpurple4'
POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND='black'


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
