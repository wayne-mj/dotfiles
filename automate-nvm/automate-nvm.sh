#!/bin/bash
# Automate the installation of NodeJS Version Manager (nvm)

owner="nvm-sh"
repo="nvm"

# Get the latest release tag using the GitHub API
if [ -e /usb/bin/gh ]; then
    latest_release_tag=$(gh release list --repo $owner/$repo --limit 1 | awk  ' { print $1 } ')
else
    latest_release_tag=$(curl -s "https://api.github.com/repos/$owner/$repo/releases/latest" | grep -oP '"tag_name": "\K[^"]+')
fi

if [ -z "$latest_release_tag" ]; then
    echo "Failed to retrieve the latest release tag."
    exit 1
fi

# Construct the raw content URL for the install.sh file
install_sh_url="https://raw.githubusercontent.com/$owner/$repo/$latest_release_tag/install.sh"

# Download the latest install.sh script
curl -Lo install-$latest_release_tag.sh "$install_sh_url"

# Make the script executable (if needed)
chmod +x install-$latest_release_tag.sh

echo "Latest NodeJS Version Manager installer downloaded."
echo " "
echo " *** Always inspect the script before running it! ***"
echo " "
echo "Run the following command to install:"
echo "  ./install-$latest_release_tag.sh"