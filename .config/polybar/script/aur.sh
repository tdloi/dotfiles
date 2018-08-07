#!/bin/sh

AUR_JSON="https://aur.archlinux.org/rpc/?v=5&type=info&arg[]="
update=0
for package in $(pacman -Qqm); do
    aur_version=$(curl -s "$AUR_JSON$package" | jq '.results[0].Version' | sed 's/"//g')
    package_version=$(pacman -Q $package | awk '{print $2}')
    if [ "$package_version" != "$aur_version" ]; then
        ((update++))
        # notify-send -t 5000 "$package $package_version is available"
    fi
done
echo $update
