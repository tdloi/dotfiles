#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
LS_COLORS=$LS_COLORS:'di=1;31:ex=1;104'; export LS_COLORS

# http://bluesock.org/~willg/dev/ansi.html
PS1='\[\033[1;32m\]\w \[\033[0;39m\]'

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# screenfetch
# if [[ ./ -ef ~ ]]; then screenfetch -w -d '-host;-kernel;'
# fi

# Custom script
if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# Alias
alias pacman='sudo pacman'
alias aur='rm rf * && git reset --hard HEAD && git pull'
alias poweroff='sudo poweroff'
alias reboot='sudo reboot'
alias df='df -h'
alias vol="amixer sget Master | awk -F'[][]' '/dB/ { print \$2 }'"

# python
alias py='python'
alias pips='pipenv shell'
alias venv='source venv/bin/activate'

# docker
alias docker='sudo docker'
alias docker-compose='sudo docker-compose'
