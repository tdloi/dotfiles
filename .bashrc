#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
LS_COLORS=$LS_COLORS:'di=1;31:ex=1;104'; export LS_COLORS

# http://bluesock.org/~willg/dev/ansi.html
PS1='\[\033[1;32m\]\w \[\033[0;39m\]'

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# pyenv
export PYENV_ROOT="$XDG_CONFIG_HOME/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# pylint
export PYLINTHOME="$XDG_CONFIG_HOME/pylint"

# npm
export NPM_CONFIG_CACHE="$XDG_CONFIG_HOME/npm"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NPM_CONFIG_PREFIX="$XDG_DATA_HOME/npm/global"

# nvm
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# httpie
export HTTPIE_CONFIG_DIR="$XDG_CONFIG_HOME/httpie"

# docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"


# Custom script
if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$HOME/.local/bin:$PATH"
fi

export PATH="$XDG_DATA_HOME/npm/global/bin:$PATH"
export PATH="$XDG_DATA_HOME/yarn/global/node_modules/.bin:$PATH"

setxkbmap -option caps:escape


# Alias
alias Syu='sudo pacman -Syu'
alias aur='rm -rf * && git reset --hard HEAD && git pull'
alias poweroff='sudo poweroff'
alias reboot='sudo reboot'
alias df='df -h'
alias vol="amixer sget Master | awk -F'[][]' '/dB/ { print \$2 }'"
alias nano='vim'

# python
alias py='python'
alias pips='pipenv shell'
alias venv='source venv/bin/activate'

# Wireguard
alias wgu='wg-quick up'
alias wgd='wg-quick down'

# docker
alias d='sudo docker'
alias dc='sudo docker-compose'

# git
alias gcp='git-commit.py'

alias dbeaver='dbeaver -data $XDG_CONFIG_HOME/dbeaver'
