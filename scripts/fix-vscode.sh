#!/bin/bash

# Change default extension directory to $XDG_DATA_HOME/code-oss/extensions
# on desktop file in /usr/share/applications
# REQUIRE SUDO
echo -e "\033[0;31mWARNING: This script required to run under sudo to modify vscode file under /usr/share\033[0m"

if [ -f /tmp/code-oss.desktop ]; then
    sudo cp -fi /tmp/code-oss.desktop /usr/share/applications/code-oss.desktop
fi

cp -fi /usr/share/applications/code-oss.desktop /tmp/code-oss.desktop
sudo sed -i 's/Exec=code-oss /Exec=code-oss --extensions-dir .local\/share\/vscode-oss\/extensions /g' /usr/share/applications/code-oss.desktop

iconname=${$(grep "[^#]*icon-theme" $XDG_CONFIG_HOME/gtk-3.0/settings.ini)/gtk-icon-theme*=}
sudo mv /usr/share/pixmaps/code-oss.png /tmp/code.png
inkscape -z -e /tmp/code-oss.png -w 1024 -h 1024 $HOME/.icons/$iconname/64x64/apps/visual-studio-code.svg
sudo cp -f /tmp/code-oss.png /usr/share/pixmaps/code-oss.png
