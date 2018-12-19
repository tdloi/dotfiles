#
# ~/.zprofile
#

# Source xprofile if exist
[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile


export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export ELECTRON_TRASH=gio


if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
