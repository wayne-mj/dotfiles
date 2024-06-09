## Dotfiles for my development environment

### About

These are the shell scripts that I use to setup my Linux environments for development.

### automate-nvm

This shell script checks for the latest version of the NodeJS Version Manager installer on Github and will download the installation script allowing me to run it to either install nvm or update the current installation.

It uses either curl or Github CLI to perform the check of the release.  It will only use the Github CLI if it is installed, otherwise it will default to curl.

### devtools

Requiring the same list of packages on each install of Linux whether it was a physical, or virtual, or WSL got tedious typing out each time.  To automate this installation process I wrote this script to include the required Debian packages, while including the additional following ones:

- Microsoft .Net SDKs
- Azure CLI
- AWS CLI
- Github CLI
- NodeJS Version Manager
- VS Code and NeoVim.

### tailwindcss-blazor

Originally written for .Net 7, this script installs tailwindcss into a Blazor WASM project, creates the configuration files, adds the css files, modifies the index.html to use the new css file, and creates a startup script to wrap the tailwindcss cli to make is easier to run.

Limited testing has been done with .Net 6 and 8 - it does do the modifications and configurations, it does run locally, but I have not attempted a live deployment with .Net 6 or .Net 8 as yet.