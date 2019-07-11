# group subtitle group with ()
# -r to toggle --regexp-extended options
sudo sed -ri 's/.*Exec=code-oss(.*)/Exec=code-oss --extensions-dir .local\/share\/vscode-oss\/extensions \1/g' /usr/share/applications/code-oss.desktop
echo -e "\033[0;32mDONE!\033[0m"
