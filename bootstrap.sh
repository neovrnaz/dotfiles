#!/bin/bash

set -o nounset    # error when referencing undefined variable
set -o errexit    # exit when command fails

echo_ok() { echo -e '\033[1;32m'"$1"'\033[0m'; }
echo_warn() { echo -e '\033[1;33m'"$1"'\033[0m'; }
echo_error()  { echo -e '\033[1;31mERROR: '"$1"'\033[0m'; }

cd $HOME || { echo_error "cd $HOME failed"; exit 155; }

echo "Requirements:"
echo "- add 'Terminal' to Accessibility settings"
echo "- sign into iCloud"
echo "- run this script using 'caffeinate -i ./bootstrap'"
echo "- have .extra file containing variables for git "
read -r -p "Press [Enter] key after this..."

if [[ -z "$GIT_COMMITTER_NAME" || -f .extra ]]; then
   echo "Please make sure that ~/.extra exists with Git environment variables" 1>&2
   exit 1
fi;
source .extra

mkdir -p .cache/zsh

if test ! "$(xcode-select -p)"; then
    echo_ok "Installing Xcode Command Line tools"
    xcode-select --install
    echo "Success! Xcode Command Line tools installed!"
fi;

echo "Creating an SSH key for you..."

mkdir -p ~/.ssh

# id_ed25519 is the same as id_rsa
ssh-keygen -t ed25519 -C "$GIT_AUTHOR_EMAIL"

# Add SSH key to Keychain
ssh-add --apple-use-keychain ~/.ssh/id_ed25519

# Configure ssh-agent to always use Keychain
echo "Creating ~/.ssh/config"
{
    echo 'Host *'
    echo '  UseKeychain yes'
    echo '  AddKeysToAgent yes'
    echo '  IdentityFile ~/.ssh/id_ed25519'
} > ~/.ssh/config

pbcopy < ~/.ssh/id_ed25519.pub
echo "id_rsa.pub has been copied to clipboard"
echo "Please add it to Github "
open https://github.com/account/ssh
read -r -p "Press [Enter] key after this..."

# Remove .gitconfig that was created using gitconfig --global
rm .gitconfig

echo_ok "Beginning Installation..."

echo "Copying dotfiles from GitHub"
git clone --bare git@github.com:$GIT_AUTHOR_NAME/dotfiles.git "$HOME"/.cfg
function config {
    /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}
mkdir -p .config-backup
config checkout
if [ $? = 0 ]; then
    echo "Checked out config.";
else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no
rm README.md

if test ! "$(which brew)"; then
    echo "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
echo "Installing mas"
brew install mas
echo "Installing brewfile"
brew bundle install
brew cleanup

echo "Installing packages"
gem install bundler
npm install -g tldr

echo "Setting up theme for Terminal and NeoVim"
git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
base16_$THEME

echo "Setting some Mac settings..."
./.macos

if test "$(omz)"; then
    echo "Backing up .zshrc"
    cp .zshrc .zshrc.orig
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    rm .zshrc
    mv .zshrc.orig .zshrc
fi

echo "Installing nvim Plugins"
nvim +PlugInstall +qall
./bin/coc_extensions


echo_ok "Done!"
echo "Further Instructions:"
echo "  - In Launchpad, replace \'App Store\' for \'Jetbrains Toolbox\'"

manual_downloads=(
    https://kinesis-ergo.com/download/advantage2-smartset-app-for-mac/
    https://www.kensington.com/software/kensingtonworks/
    https://nxmac.com/main/lingon-x/
    https://nxmac.com/main/launchpad-manager/
    https://nxmac.com/main/marked/
)

read -r -p "[Enter] to open manual downloads"
for i in "${manual_downloads[@]}"
do
    open --url "$i"
done
