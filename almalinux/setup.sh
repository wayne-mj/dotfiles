#!/usr/bin/env bash

### Add Flathub/Flatpak
if [ -x /usr/bin/flatpak ]; then
  /usr/bin/flatpak remote-add --if-not-exists flathub \
  https://dl.flathub.org/repo/flathub.flatpakrepo
fi

### Add Extra packages for Enterprise linux
sudo dnf install epel-release -y

### Adding Brave Browser repository
# sudo dnf config-manager addrepo --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
# sudo dnf install brave-browser

### Adding support for VS Code
# sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
# echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
# dnf check-update
# sudo dnf install code # or code-insiders
