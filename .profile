#
# ~/.profile
#

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export ELECTRON_TRASH=gio

# Ensure that zshenv will be sourced
[ -f ~/.zshenv ] && . ~/.zshenv

# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  eval $(ssh-agent -s)
  exec startx
fi
