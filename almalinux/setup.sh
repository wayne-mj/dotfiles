#!/usr/bin/env bash

### Add Flathub/Flatpak
echo "Adding Flatpak"
if [ -x /usr/bin/flatpak ]; then
  /usr/bin/flatpak remote-add --if-not-exists flathub \
  https://dl.flathub.org/repo/flathub.flatpakrepo
fi

### Enable CRB
echo "Enabling CRB repository"
sudo dnf config-manager --enable crb

### Add Extra packages for Enterprise linux
echo "Adding extra packages"
sudo dnf install epel-release -y

### Install Node Version Manager (nvm) from its repository
echo "Install Node Version Manager"
owner="nvm-sh"
repo="nvm"
# Get the latest release tag using the GitHub API
latest_release_tag=$(curl -s "https://api.github.com/repos/$owner/$repo/releases/latest" | grep -oP '"tag_name": "\K[^"]+')
if [ ! -z "$latest_release_tag" ]; then
  install_sh_url="https://raw.githubusercontent.com/$owner/$repo/$latest_release_tag/install.sh"
  curl -o- "$install_sh_url" | bash
fi

### Adding Brave Browser repository
echo "Installing Brave Browser"
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo dnf install brave-browser -y

### Adding support for VS Code
echo "Installing VS Code"
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
dnf check-update
sudo dnf install code -y # or code-insiders

### Adding Anaconda to manage Python
# Import our GPG public key
# rpm --import https://repo.anaconda.com/pkgs/misc/gpgkeys/anaconda.asc

# # Add the Anaconda repository
# cat <<EOF > /etc/yum.repos.d/conda.repo
# [conda]
# name=Conda
# baseurl=https://repo.anaconda.com/pkgs/misc/rpmrepo/conda
# enabled=1
# gpgcheck=1
# gpgkey=https://repo.anaconda.com/pkgs/misc/gpgkeys/anaconda.asc
# EOF

# ### Installing Conda
# sudo dnf install conda -y

