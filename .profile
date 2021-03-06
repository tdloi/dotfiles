#
# ~/.profile
#

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# set env when not using a greeter
# lightdm will set XAUTHORITY to /run/lightdm/$USER/xauthority
# override XAUTHORITY will cause infinite login loop due to missing permission
[[ -z "$XAUTHORITY" ]] && export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
# ICEAuthority
export ICEAUTHORITY="$XDG_CACHE_HOME"/ICEauthority

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export ELECTRON_TRASH=gio
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Ensure that zshenv will be sourced
[[ -f ~/.zshenv ]] && source ~/.zshenv

# include .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
fi

setxkbmap -option caps:escape
# numlockx

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
