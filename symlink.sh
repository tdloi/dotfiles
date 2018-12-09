declare -a arr=(
    "alacritty/alacritty.yml"
    "cmus/rc"
    "fcitx/*"
    "mpv/*"
    "rofi/*"
    "termite/config"
    "zsh/*"
)

for i in "${arr[@]}"
do
    # Recursive symlink if symlink all file in folder
    if [[ $i =~ '*' ]]
    then
        for file in $(find ".config/${i:0:-2}" -type f -follow)
        do
            parentdir="$(dirname "$file")"
            mkdir -p $HOME/$parentdir
            ln -sf $PWD/$file $HOME/$file
        done;
    else
        parentdir="$(dirname "$i")"
        mkdir -p $XDG_CONFIG_HOME/$parentdir
        ln -sf $PWD/.config/$i $XDG_CONFIG_HOME/$i
    fi;
done;
