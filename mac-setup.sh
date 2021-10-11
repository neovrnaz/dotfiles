#!/bin/sh
# Purpose: A shell script to automate macOS setup
# Usage: ./install.sh
# --------------------------------------------------------------------------------

# Install Command-line tools
xcode-select --install

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/

# ==== Set up dotfiles =====
# Define alias for current scope
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
# Adds .cfg to .gitignore to avoid any issues while cloning
echo ".cfg" >> .gitignore
# Clone dotfiles
git clone --bare https://github.com/neovrnaz/dotfiles.git $HOME/.cfg
# Add config files to $HOME
config checkout
# Hide untracked files
config config --local status.showUntrackedFiles no
# Remove README
rm README.md

# Install Brewfile
brew bundle install

# Install markdownlint
gem install mdl

# Link MacVim with Terminal
sudo ln -s /Applications/MacVim.app/Contents/bin/mvim /usr/local/bin/mvim

# Copy and move keyboard la:yout
sudo cp /Users/elijahgray/Library/Mobile\ Documents/com~apple~CloudDocs/Downloads/My\ Layout.keylayout /Library/Keyboard\ Layouts/

# Copy and move terminal theme
cp /Users/elijahgray/Library/Mobile\ Documents/com~apple~CloudDocs/Downloads/Material\ Theme.terminal /Users/elijahgray/Downloads 

# ==== Safari ====
# Open instructions to generate an SSH key
osascript /Users/elijahgray/Library/Mobile\ Documents/com~apple~ScriptEditor2/Documents/New\ Window.scpt https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent https://www.jetbrains.com/help/idea/create-ssh-configurations.html
# Open webpages that need to be installed manually
open https://kinesis-ergo.com/download/advantage2-smartset-app-for-mac/
open https://www.kensington.com/software/kensingtonworks/
open https://nxmac.com/ia-writer/
open https://nxmac.com/flxp/
