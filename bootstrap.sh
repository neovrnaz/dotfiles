#!/bin/bash

set -e
set -o

trap 'err $LINENO' SIGTERM

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
LIME_YELLOW=$(tput setaf 190)
YELLOW=$(tput setaf 3)
POWDER_BLUE=$(tput setaf 153)
BLUE=$(tput setaf 4)
END=$(tput sgr0)

echo_ok() { echo -e "${BLUE}$1""${END}"; }
echo_warn() { echo -e "${YELLOW}$1""${END}"; }
err() {
    echo "${RED}ERROR: $1"
    echo_error "ERROR: $1"
    awk 'NR>L-4 && NR<L+4 { printf "%-5d%3s%s\n", NR, (NR==L?">>>":""),$0 }' L=$1 $0
    echo "${END}"
}

exists() {
    command -v "$1" > /dev/null 2>&1
}

cd "$HOME"

on_start() {
    echo
    echo "${LIME_YELLOW}       __      __  _____ __"         
    echo "${GREEN}  ____/ /___  / /_/ __(_) /__  _____"
    echo "${RED} / __  / __ \/ __/ /_/ / / _ \/ ___/"
    echo "${POWDER_BLUE}/ /_/ / /_/ / /_/ __/ / /  __(__  )" 
    echo "${BLUE}\__,_/\____/\__/_/ /_/_/\___/____/${END}"
    echo
    echo "${BLUE} This script will help you set up your Mac"
    echo
    echo "Requirements:"
    echo "- Add 'Terminal' to Accessibility settings"
    echo "- Sign in to iCloud"
    echo "- Run this script using 'caffeinate -i ./bootstrap.sh'"
    echo "- Have .extra file containing variables for git "
    read -r -p "Press [Enter] key after this..."
}

[[ -f ~/.extra ]] && source .extra || echo "No ~/.extra was found"

prompt_yn() {
    local yn
    while true; do
        read -pr "$1 " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            *) echo "Please answer with yes or no";;
        esac
    done
}

install_cli_tools() {
    if test "$(xcode-select -p)"; then
        if prompt_yn "Command Line Tools not found. Would you like to install them now?"; then
            echo_ok "Installing Xcode Command Line tools..."
            xcode-select --install
            echo_ok "Success! Xcode Command Line tools installed!"
        else
            exit

        fi
    fi
}

generate_ssh_key() {

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
}

function config {
    /usr/bin/git --git-dir="$HOME"/.cfg/ --work-tree="$HOME" "$@"
}

install_dotfiles() {
    echo_ok "Copying dotfiles from GitHub"
    git clone --bare git@github.com:$GIT_AUTHOR_NAME/dotfiles.git "$HOME"/.cfg
    mkdir -p .config-backup
    config checkout
    if [ $? = 0 ]; then
        echo "Checked out config.";
    else
        echo "Backing up pre-existing dot files.";
        config checkout 2>&1 | grep -E "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
    fi;
    config checkout
    config config status.showUntrackedFiles no
    rm README.md
    echo_ok "Dotfiles installed!"
}

install_homebrew() {
    if ! exists brew; then
        if prompt_yn "Homebrew not installed. Would you like to install it now?"; then
            echo "Installing homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            echo "Installing mas"
            brew install mas
            echo "Installing Brewfile"
            brew bundle install
            brew cleanup
        else
            exit;
        fi
    fi
}

install_packages() {
    if prompt_yn "Would you like to install gem and npm packages?"; then
        echo "Installing packages"
        gem install bundler
        npm install -g tldr
        echo_ok "Packages installed!"
    else
        echo_ok "Skipping..."
        return
        return
    fi
}

setup_theme() {
    if prompt_yn "Would you like to setup base16_theme?"; then
        echo "Setting up theme for Terminal and NeoVim"
        git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
        base16_"$THEME"
    else 
        echo_ok "Skipping..."
        return
    fi
}

write_defaults() {
    if prompt_yn "Do you want to write defaults with .macos?"; then
        echo "Setting some Mac settings..."
        ./.macos
    else
        echo_ok "Skipping..."
        return
    fi
}

install_omz() {
    if test "$(omz)"; then
        if prompt_yn "Oh My Zsh isn't installed. Would you like to install it?"; then
            echo "Backing up .zshrc"
            cp .zshrc .zshrc.orig
            echo "Installing Oh My Zsh..."
            sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
            rm .zshrc
            mv .zshrc.orig .zshrc
        else
            echo_ok "Skipping..."
            return
        fi
    fi
}

install_nvim_plugins() {
    if prompt_yn "Would you like to install nvim plugins?"; then
        echo "Installing nvim Plugins"
        nvim +PlugInstall +qall
        ./bin/coc_extensions
    else 
        echo_ok "Skipping..."
        return
    fi
}

extra_download_urls() {
    local manual_downloads=(
        https://kinesis-ergo.com/download/advantage2-smartset-app-for-mac/
        https://www.kensington.com/software/kensingtonworks/
        https://nxmac.com/main/lingon-x/
        https://nxmac.com/main/launchpad-manager/
        https://nxmac.com/main/marked/
    )
    if prompt_yn "Would you like to open url's to apps that need to be installed manually?"; then
        for i in "${manual_downloads[@]}"
        do
            open --url "$i"
        done
    else
        echo_ok "Skipping"
        return
    fi
}

on_finish() {
    echo
    echo "${BLUE}Horray!"
    echo 
    echo "${LIME_YELLOW}       __      __  _____ __"         
    echo "${GREEN}  ____/ /___  / /_/ __(_) /__  _____"
    echo "${RED} / __  / __ \/ __/ /_/ / / _ \/ ___/"
    echo "${POWDER_BLUE}/ /_/ / /_/ / /_/ __/ / /  __(__  )" 
    echo "${BLUE}\__,_/\____/\__/_/ /_/_/\___/____/"
    echo "${BLUE}                                   ...were installed successfully!${END}" 
    echo 
}

main() {
    on_start "$@"
    install_cli_tools "$@"
    generate_ssh_key "$@"
    install_dotfiles "$@"
    install_homebrew "$@"
    setup_theme "$@"
    install_packages "$@"
    write_defaults "$@"
    install_omz "$@"
    install_nvim_plugins "$@"
    on_finish "$@"
    extra_download_urls "$@"
}
main "$@"
