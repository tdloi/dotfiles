#!/bin/bash

print() {
    echo -e "\033[0;32m$1\033[0m"
}

CURRENT_DIR=$(dirname ${BASH_SOURCE[0]})

if [ $USER == "root" ]; then
    echo "Running as root. Abort"
    exit;
fi;


print "Install packages"
sudo pacman -S $(cat $CURRENT_DIR/PKG)


print "Create folder Pictures/screenshots for Flameshot"
mkdir -p ~/Pictures/screenshots


print "Create folder cache for vim"
mkdir -p ~/.cache/vim/{swap,backup,undo}


print "Symlink dotfiles"
for i in ".bashrc" ".profile" ".xinitrc" ".zshenv"; do
    echo "- Symlink $i"
    ln -sf $CURRENT_DIR/$i ~/$i
done


print "Copy scripts .local/bin"
mkdir -p ~/.local/bin
cp $CURRENT_DIR/.local/bin/* ~/.local/bin


print "Copy config files"
mkdir -p ~/.config
cp -rf $CURRENT_DIR/.config/* ~/.config


print "Symlink config files"
# symlink config
declare -a arr=("alacritty" "dunst" "fcitx5"
                "fontconfig" "mpv" "polybar" "rofi"
                "systemd" "tmux" "vim" "zsh"
                )
# cd to CURRENT_DIR to get filename easier
cd $CURRENT_DIR;
for i in "${arr[@]}"; do
    echo "- Symlink $i"
    for x in $(find .config/$i -type f); do
        ln -sf $PWD/$x ~/$x
    done;
done;


# XFCE4
print "Restore XFCE4 shortcuts"
while read line
do
	xfconf-query -c xfce4-keyboard-shortcuts -p "$(echo $line | awk '{print $1}')" -s "$(echo $line | awk '{print $2}')" -n
done < xfce4/keyboard-shortcuts

print "Set XFCE4 theme"
xfconf-query -c xsettings -p /Net/ThemeName -s Arc-Dark && echo "Set theme to Arc-Dark"
xfconf-query -c xsettings -p /Net/IconThemeName -s Papirus-Dark && echo "Set icon theme to Papirus-Dark"
echo "Download folder color change for Papirus"
curl -o papirus-folders https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-folders/v1.8.0/papirus-folders
/bin/bash papirus-folders -C bluegrey --theme Papirus-Dark && echo "Changed folder to bluegrey" && rm papirus-folders
echo "Download Nerd fonts"
mkdir -p ~/.local/share/fonts
curl -L -O https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/RobotoMono.zip
unzip RobotoMono.zip -d ~/.local/share/fonts/RobotoMono && rm RobotoMono.zip
xfconf-query -c xfwm4 -p /general/title_font -s "Roboto 12" echo "Set title font to Roboto"
echo "Download Breeze Hacked cursor"
mkdir ~/.icons
curl -L -O https://github.com/tdloi/breeze-hacked/releases/download/v0.1/Breeze_Hacked.zip
unzip Breeze_Hacked -d ~/.icons/Breeze_Hacked && rm Breeze_Hacked.zip
xfconf-query -c xsettings -p /Gtk/CursorThemeName -s "Breeze_Hacked" && echo "Set cursor theme to Breeze Hacked"
