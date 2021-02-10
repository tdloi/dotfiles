# ｄｏｔｆｉｌｅｓ

- Theme: `arc-gtk-theme`
- Icons: `papirus`
- Cursor: [Breeze Hacked](https://github.com/tdloi/breeze-hacked)

## Scripts
### Package list
```bash
comm -23 <(pacman -Qqen | sort) <(pacman -Qqeg base-devel xorg xorg-apps | sort) > PKG
```
### Xfce4 shortcuts
- Dump: `xfconf-query -c xfce4-keyboard-shortcuts -lv > xfce4/keyboard-shortcuts`
- Restore:
```bash
# https://forum.xfce.org/viewtopic.php?id=12822
while read line
do
	xfconf-query -c xfce4-keyboard-shortcuts -p "$(echo $line | awk '{print $1}')" -s "$(echo $line | awk '{print $2}')" -n
done < xfce4/keyboard-shortcuts
```

## Packages
### Xfce4
- xfce4-power-manager
- xfce4-session
- xfce4-settings
- xfdesktop
- xfwm4

### Zephyrus G14
- linux-zen-g14<sup><sup>AUR<sup><sup>
- asus-nb-ctrl-git<sup><sup>AUR<sup><sup>
- acpi_call: Fan mode
- amd-ucode
- xf86-video-amdgpu
- nvidia-dkms
- nvidia-prime
- nvidia-settings
- nvidia-utils
