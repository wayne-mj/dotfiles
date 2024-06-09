#!/bin/sh
# Download and install various development tools

if [ ! -e ".devtools" ]; then
 echo Ensuring system is up to date ...
 sudo apt update && sudo apt upgrade -y

 PKG="wget curl gpg apt-transport-https git neofetch ca-certificates htop build-essential cmake keepassxc tmux neovim lxterminal"
 ## dotnet-sdk-6.0 dotnet-sdk-7.0
 MSPKG="code dotnet-sdk-8.0 azure-cli"

 echo Adding the following packages:
 echo $PKG

 # Install required packages and dependencies   
 sudo apt install -y $PKG && touch .success

 # If the install was successful
 if [ -e .success ]; then

  # Add the Microsoft repository key and install the packages
  echo Adding Microsoft key
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
  [ -e packages.microsoft.gpg ] && {
   sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg

   echo Downloading repository package
   wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
   [ -e packages-microsoft-prod.deb ] && sudo dpkg -i packages-microsoft-prod.deb

   echo Adding Repository for VS Code
   sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] \
   https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'

   echo Updating repositories
   sudo apt update

   echo Installing Dotnet 6.0 SDK, VS Code and Azure CLI
   sudo apt install -y $MSPKG

   rm packages-microsoft-prod.deb packages.microsoft.gpg
  }

  # Install Github CLI and its dependencies
  echo Install Github CLI
  type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
  && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] \
  https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && sudo apt update \
  && sudo apt install gh -y

  # Install AWS Cli and tidy up
  echo Install AWS Cli
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  [ -e awscliv2.zip ] && {
   unzip awscliv2.zip 
   sudo ./aws/install
   rm -rf aws
   rm awscliv2.zip
  }
  
  # Install Node Version Manager (nvm) from its repository
  echo "Install Node Version Manager"
  owner="nvm-sh"
  repo="nvm"
  # Get the latest release tag using the GitHub API
  latest_release_tag=$(curl -s "https://api.github.com/repos/$owner/$repo/releases/latest" | grep -oP '"tag_name": "\K[^"]+')
  if [ ! -z "$latest_release_tag" ]; then
    install_sh_url="https://raw.githubusercontent.com/$owner/$repo/$latest_release_tag/install.sh"
    curl -o- "$install_sh_url" | bash
  fi

  # Append NeoFetch to bashrc for bragging rights
  echo Adding NeoFetch to bashrc
  echo "[ -x /usr/bin/neofetch ] && /usr/bin/neofetch" >> ~/.bashrc
  
  echo Completed ...
  touch .devtools
  rm .success
 else
 echo Install of $PKG was unsuccessful.
 fi
else
 echo Process has alredy been run.
 echo Delete the file: ~/.devtools to run again.
fi
