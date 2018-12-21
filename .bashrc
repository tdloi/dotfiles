#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# http://bluesock.org/~willg/dev/ansi.html
PS1='\[\033[1;32m\]\w \[\033[0;39m\]'

source $ZDOTDIR/zenv
source $ZDOTDIR/zalias
