#!/bin/bash

print() {
    echo -e "\033[0;32m$1\033[0m"
}

CURRENT_DIR=$(dirname ${BASH_SOURCE[0]})

if [ $USER == "root" ]; then
    echo "Running as root. Abort"
    exit;
fi;


install_package() {
    print "Install packages"
    sudo pacman -S $(cat $CURRENT_DIR/PKG)
}


setup_config() {
    print "Copy config files"
    mkdir -p ~/.config
    cp -rf $CURRENT_DIR/.config/* ~/.config

    CURRENT_PATH=$(pwd)
    cd $CURRENT_DIR;

    print "Symlink dotfiles"
    for i in ".bashrc" ".profile" ".xinitrc" ".zshenv"; do
        echo "- Symlink $i"
        ln -sf $PWD/$i ~/$i
    done


    print "Symlink config files"
    # symlink config
    declare -a arr=("alacritty" "dunst" "fcitx5"
                    "fontconfig" "mpv" "polybar" "rofi"
                    "systemd" "tmux" "vim" "zsh"
                    )
    for i in "${arr[@]}"; do
        echo "- Symlink $i"
        for x in $(find .config/$i -type f); do
            ln -sf $PWD/$x ~/$x
        done;
    done;

    cd $CURRENT_PATH;
}


config_xfce4() {
    print "--- Restore XFCE4 shortcuts ---"
    while read line
    do
        key="$(echo $line | awk '{print $1}')"
        value="$(echo "$line" | awk '{$1=""; print $0}' | xargs)";
        xfconf-query -c xfce4-keyboard-shortcuts -p "$key" -s "$value" -n
        if [ ! $? -eq 0 ]; then
            if [ $value = 'true' ]; then
                xfconf-query -c xfce4-keyboard-shortcuts -p "$key" -s "$value" -n -t bool
            else
                xfconf-query -c xfce4-keyboard-shortcuts -p "$key" -s "$value" -n -t string
            fi
        fi
    done < $CURRENT_DIR/xfce4/keyboard-shortcuts


    print "--- Set XFCE4 theme ---"
    xfconf-query -c xsettings -p /Net/ThemeName -s Arc-Dark && \
        echo "Set theme to Arc-Dark"
    xfconf-query -c xsettings -p /Net/IconThemeName -s Papirus-Dark && \
        echo "Set icon theme to Papirus-Dark"
    echo "Download folder color change for Papirus"
    curl -sSL -o papirus-folders https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-folders/v1.8.0/papirus-folders && \
        chmod +x $CURRENT_DIR/papirus-folders && \
        $CURRENT_DIR/papirus-folders -C bluegrey --theme Papirus-Dark && \
        rm papirus-folders
    echo "Download Nerd fonts"
    mkdir -p ~/.local/share/fonts
    curl -sSL -O https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/RobotoMono.zip && \
        unzip -o RobotoMono.zip -d ~/.local/share/fonts/RobotoMono && \
        rm RobotoMono.zip && \
    xfconf-query -c xfwm4 -p /general/title_font -s "Roboto 12" echo "Set title font to Roboto"
    echo "Download Breeze Hacked cursor"
    mkdir -p ~/.icons
    curl -sSL -O https://github.com/tdloi/breeze-hacked/releases/download/v0.1/Breeze_Hacked.zip && \
        unzip -o Breeze_Hacked -d ~/.icons/ && \
        rm Breeze_Hacked.zip && \
    xfconf-query -c xsettings -p /Gtk/CursorThemeName -s "Breeze_Hacked" && echo "Set cursor theme to Breeze Hacked"
}


resilient_config() {
    # pacman hooks
    sudo mkdir -p /etc/pacman.d/hooks
    sudo cp $CURRENT_DIR/etc/pacman.d/hooks/* /etc/pacman.d/hooks
    # Create folder Pictures/screenshots for Flameshot
    mkdir -p ~/Pictures/screenshots
    # Create folder cache for vim
    mkdir -p ~/.cache/vim/{swap,backup,undo}
    # Copy scripts .local/bin
    mkdir -p ~/.local/bin
    cp $CURRENT_DIR/.local/bin/* ~/.local/bin
    # Initialize and configure lightdm folder
    sudo mkdir -p /var/lib/lightdm
    sudo mkdir -p /var/lib/lightdm-data/$USER
    sudo chown -R lightdm:lightdm /var/lib/lightdm
    sudo chown -R lightdm:lightdm /var/lib/lightdm-data
}


setup_system() {
    print "Setup system configurations"
    print "- Setup lightdm"
    sudo mkdir -p /etc/lightdm/
    sudo cp -r $CURRENT_DIR/etc/lightdm/* /etc/lightdm/

    print "- Setup modprode"
    sudo mkdir -p /etc/modprode.d/
    sudo cp -r $CURRENT_DIR/etc/modprode.d/* /etc/modprode.d/

    print "- Setup xorg conf"
    sudo mkdir -p /etc/X11/xorg.conf.d/
    sudo cp -r $CURRENT_DIR/etc/X11/xorg.conf.d/* /etc/X11/xorg.conf.d/
    sudo mkinitcpio -P

    print "- Setup iwd"
    sudo mkdir -p /etc/iwd/
    sudo cp -r $CURRENT_DIR/etc/iwd/* /etc/iwd/
    systemctl enable \
            systemd-networkd \
            systemd-resolved \
            iwd \
            ntpd

    print "- Setup NVIDIA"
    if pacman -Qs $package > /dev/null; then
        sudo nvidia-xconfig
    else
        sudo pacman -S --noconfirm nvida-dkms nvida-prime nvidia-settings nvidia-utils && \
        sudo nvidia-xconfig
    fi
}


show_help() {
    echo "Initialize configurations"
    echo " "
    echo "config.sh [options]"
    echo " "
    echo "options:"
    echo "-h, --help    Show help"
    echo "--pkg         Install all packages"
    echo "--setup       Copy and symlink configuration files"
    echo "--system      Config system related file"
    echo "--xfce        Setup shortcuts, theme, icon xfce4"
    echo "--all         Run all script except install packages"
}


if [ ! $# -gt 0 ]; then
    show_help
    exit 0
fi


while test $# -gt 0; do
    case "$1" in
    -h|--help)
        show_help
        exit 0
        ;;
    --pkg)
        install_package
        shift
        ;;
    --setup)
        resilient_config
        setup_config
        shift
        ;;
    --system)
        setup_system
        shift
        ;;
    --xfce)
        resilient_config
        config_xfce4
        shift
        ;;
    --all)
        resilient_config
        setup_config
        setup_system
        config_xfce4
        shift
        ;;
    *)
        break
        ;;
    esac
done

