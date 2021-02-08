```bash
comm -23 <(pacman -Qqen | sort) <(pacman -Qqeg base base-devel xorg xorg-apps xfce4 | sort) > pacman
```
