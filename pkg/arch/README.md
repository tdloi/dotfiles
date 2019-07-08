# Package lists
dump:
```bash
comm -23 <(pacman -Qqen | sort) <(pacman -Qqeg base base-devel xorg xorg-apps i3 xfce4 xfce4-goodies | sort) > pacman
```

# TOC
1. [Terminal](#terminal)
2. [Shell](#shell)
3. [Browser](#browser)
4. [IDE - Editor](#ide---editor)
5. [Dev](#dev)
6. [Viewer - Player](#viewer---player)
7. [Fonts](#fonts)
8. [Utils](#utils)
9. [Other](#other)

### Terminal
- [Alacritty](https://github.com/jwilm/alacritty)
- [tmux](https://wiki.archlinux.org/index.php/tmux)
<!-- - Termite -->
<!-- - Tilix -->

### Shell
- [zsh](https://wiki.archlinux.org/index.php/zsh)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [zsh powerlevel9k theme](https://github.com/bhilburn/powerlevel9k)

### Browser
- Firefox
- Firefox Developer Edition
- Chromium
- Chrome ~~for game~~

### IDE - Editor
- VSCode
- PyCharm Professional
- xed
- vim
- sigil (Epub)
- picard (Music info)

### Dev
- [Docker](https://www.docker.com/)
- Docker Compose
- Insomnia
- Postman
- httpie


### Viewer - Player
- feh (images)
- imv (gif)
- mpv (video)
- cmus (music)
    + libmad (mp3)
- Zathura (pdf/epub) <sup>zathura-pdf-mupdf</sup>
- ranger <sup>terminal</sup> (files)
- nemo
    + nemo-fileroller

### Fonts
- noto-fonts-cjk
- noto-fonts-emoji
- ttf-inconsolata
- ttf-roboto
- [Hacked Nerd Fonts](https://github.com/ryanoasis/nerd-fonts)
- [Fantasque Sans Mono](https://github.com/belluzj/fantasque-sans)

### Utils
- [fzf](https://github.com/junegunn/fzf)
- [fd](https://github.com/sharkdp/fd)
- [exa](https://github.com/ogham/exa)
- fcitx (input)
- piper (mouse color led)

### Others
- [polybar](https://github.com/polybar/polybar)
- [rofi](https://github.com/davatorium/rofi)
- [anki](https://apps.ankiweb.net/)
- texlive-* (latex)
