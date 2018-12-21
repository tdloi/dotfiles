#!/bin/bash

# Modify application desktop file to add some run parameter to its Exec
echo -e "\033[0;31mWARNING: This script required to run under sudo to modify file under /usr/share\033[0m"

sudo sed -i 's/.*Exec=termite.*/Exec=termite -e tmux/' /usr/share/applications/termite.desktop
echo -e "\033[0;32mEDITED: termite => termite -e tmux\033[0m"

sudo sed -i 's/.*Exec=anki %f.*/Exec=anki %f -b Dropbox\/.anki/' /usr/share/applications/anki.desktop
echo -e "\033[0;32mEDITED: anki %f => anki %f -b Dropbox/.anki\033[0m"
