#!/usr/bin/env bash

if [ "$EUID" -eq 0 ]; then
  echo "Please do no run this as root, but as your pleb self."
  exit 1
fi

PKG="wget curl gpg apt-transport-https git ca-certificates htop build-essential cmake tmux neovim lxterminal"
echo "Adding the following packages:"
echo $PKG

sudo apt update
# Install required packages and dependencies   
sudo apt install -y $PKG && touch .success

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

### Installing Brave Browser
echo "Installing Brave Browser"
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
sudo curl -fsSLo /etc/apt/sources.list.d/brave-browser-release.sources https://brave-browser-apt-release.s3.brave.com/brave-browser.sources
sudo apt update
sudo apt install -y brave-browser

### VS Code
echo "Installing VS Code"
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -D -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/microsoft.gpg
rm -f microsoft.gpg

echo Downloading repository package
wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
[ -e packages-microsoft-prod.deb ] && sudo dpkg -i packages-microsoft-prod.deb

echo Adding Repository for VS Code
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] \
https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt update
sudo apt install -y code # or code-insiders

