sudo sed -i 's/.*Exec=anki %f.*/Exec=anki %f -b Dropbox\/.anki/' /usr/share/applications/anki.desktop
echo -e "\033[0;32mDONE!\033[0m"
