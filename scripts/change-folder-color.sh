#!/bin/bash

# Change folder color
if [ -f $1 ]; then
    echo -e "\033[0;31mPlease pass folder color!\033[0m"
    exit 1;
fi;

iconconfig=$(grep "[^#]*icon-theme" $XDG_CONFIG_HOME/gtk-3.0/settings.ini)
icon=${iconconfig/gtk-icon-theme*=/}
for i in $(fd -t f "$1" "$HOME/.icons/$icon"); do
    ln -srf "$i" ${i/-"$1"/}
done
