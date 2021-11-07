#!/bin/sh

function echo_ok { echo -e '\033[1;32m'"$1"'\033[0m'; }
function echo_warn { echo -e '\033[1;33m'"$1"'\033[0m'; }
function echo_error  { echo -e '\033[1;31mERROR: '"$1"'\033[0m'; }

echo_ok "Install starting. You may be asked for your password (for sudo)."

xcode-select -p || exit "XCode must be installed! (use the app store)"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/

brew install mas

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
echo ".cfg" >> .gitignore
git clone --bare https://github.com/neovrnaz/dotfiles.git $HOME/.cfg
config checkout
config config --local status.showUntrackedFiles no
rm README.md

brew bundle install

gem install mdl

sudo ln -s /Applications/MacVim.app/Contents/bin/mvim /usr/local/bin/mvim

open https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent 
open https://www.jetbrains.com/help/idea/create-ssh-configurations.html
osascript -e "tell application \"Safari\"
    make new document
    set URL of document 1 to \"topsites://\"
    activate
end tell"
open https://kinesis-ergo.com/download/advantage2-smartset-app-for-mac/
open https://www.kensington.com/software/kensingtonworks/
open http://wordherd.com/keyboards/
open https://nxmac.com/ia-writer/
open https://nxmac.com/flxp/

echo_ok "Success!"
echo "Further Instructions:"
echo "  - Run :Plugin install in Vim"
