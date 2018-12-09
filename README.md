# ｄｏｔｆｉｌｅｓ
> *`.files are means to be shared`*

![](img/terminal.png)

## Screenshot
<div align="center">
    <img src="img/polybar.png" alt="polybar right panel">
</div>

## Symlink

I prefer using symlink over git on home folder, because there are some applications keep changing their config files ([`VSCode`](https://github.com/Microsoft/vscode)) or contain sensitive infomations

Declare list of config you want to symlink in `arr` in [`symlink.sh`](symlink.sh), or simple symlink all `.config`
```
declare -a arr=( "*" )
```

## Zsh
Plugins
+ [powerlevel9k](https://github.com/bhilburn/powerlevel9k) (*[zsh-theme-powerlevel9k](https://www.archlinux.org/packages/community/any/zsh-theme-powerlevel9k/)*)
+ [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) ([zsh-autosuggestions](https://www.archlinux.org/packages/community/any/zsh-autosuggestions/))
+ [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) ([zsh-syntax-highlighting](https://www.archlinux.org/packages/community/any/zsh-syntax-highlighting/))

For completion, I only picked what I need from [zsh-completions](https://github.com/zsh-users/zsh-completions)

For config files, I picked up from various sources (*[Arch wiki](https://wiki.archlinux.org/index.php/Zsh)*, *[oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)*, *[zsh-lover](https://grml.org/zsh/zsh-lovers.html)*, *[Github](https://github.com/search?q=dotfiles+zsh)*, ..)
