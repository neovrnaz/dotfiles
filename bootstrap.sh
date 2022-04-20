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

echo_ok() { echo -e "${GREEN}$1""${END}"; }
echo_warn() { echo -e "${YELLOW}$1""${END}"; }
echo_err() { echo -e "${RED}$1""${END}"; }
echo_install() { echo -e "${BLUE}$1""${END}"; }
err() {
    echo_err "ERROR: $1"
    awk 'NR>L-4 && NR<L+4 { printf "%-5d%3s%s\n", NR, (NR==L?">>>":""),$0 }' L=$1 $0
    echo "${END}"
}

_exists() {
    command -v "$1" >/dev/null
}

var_is_set() {
    declare -p "$1" &>/dev/null
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

prompt_yn() {
    local yn
    while true; do
        read -pr "$1 " yn
        case $yn in
        [Yy]*) return 0 ;;
        [Nn]*) return 1 ;;
        *) echo "Please answer with yes or no" ;;
        esac
    done
}

confirm_git_user() {
    if ! var_is_set GIT_COMMITTER_NAME || ! var_is_set GIT_COMMITTER_EMAIL; then
        if prompt_yn "Git env variables not found. Is it okay if we set them now?"; then
            read -r -p "Please enter git config user.name:" GIT_COMMITTER_NAME
            read -r -p "Great! Now, please enter git config user.email:" GIT_COMMITTER_EMAIL
        else
            exit
        fi
    fi
}

set_gitconfig() {
    if [[ -f .gitconfig ]]; then
        echo_warn ".gitconfig already exists!"
        prompt_yn "Would you like to continue with the current .gitconfig?" || exit
    fi
    echo_ok "Creating .gitconfig"
    git config --global user.name "$GIT_COMMITTER_NAME"
    git config --global user.email "$GIT_COMMITTER_EMAIL"
}

install_cli_tools() {
    _exists xcode-select && return
    echo_install "Installing Xcode Command Line tools..."
    xcode-select --install
    echo_ok "Success! Xcode Command Line tools installed!"
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
    } >~/.ssh/config

    pbcopy <~/.ssh/id_ed25519.pub
    echo "id_rsa.pub has been copied to clipboard"
    echo "Please add it to GitHub "
    open https://github.com/account/ssh
    read -r -p "Press [Enter] key after this..."

    # Remove .gitconfig that was created using gitconfig --global
    rm .gitconfig
}

function config {
    /usr/bin/git --git-dir="$HOME"/.cfg/ --work-tree="$HOME" "$@"
}

install_dotfiles() {
    echo_install "Copying dotfiles from GitHub"
    git clone --bare git@github.com:"$GIT_AUTHOR_NAME"/dotfiles.git "$HOME"/.cfg
    mkdir -p .config-backup
    config checkout
    if [ $? = 0 ]; then
        echo "Checked out config."
    else
        echo "Backing up pre-existing dot files."
        config checkout 2>&1 | grep -E "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
    fi
    config checkout
    config config status.showUntrackedFiles no
    rm README.md
    echo_ok "Dotfiles installed!"
}

install_homebrew() {
    _exists brew && return
    echo "Installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "Installing mas"
    brew install mas
    echo "Installing Brewfile"
    brew bundle install
    brew cleanup
}

install_packages() {
    if prompt_yn "Want to install packages (npm and gem)?"; then
        echo_install "Installing packages"
        gem install bundler
        npm install -g tldr
        echo_ok "Packages installed!"
    else
        echo_warn "Skipping..."
        return
    fi
}

setup_theme() {
    if var_is_set THEME; then
        if prompt_yn "Would you like to set up base16_theme? as base16_$THEME?"; then
            echo "Setting up theme for Terminal and NeoVim"
            git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
            base16_"$THEME"
        else
            echo_warn "Skipping..."
            return
        fi
    else
        return
    fi
}

write_defaults() {
    if prompt_yn "Do you want to write defaults with .macos?"; then
        echo_install "Writing defaults..."
        ./.macos
    else
        echo_warn "Skipping..."
        return
    fi
}

install_omz() {
    _exists omz && return
    if prompt_yn "Would you like to install Oh My Zsh?"; then
        echo "Backing up .zshrc"
        cp .zshrc .zshrc.orig
        echo "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        rm .zshrc
        mv .zshrc.orig .zshrc
    else
        echo "skipping..."
        return
    fi
}

install_nvim_plugins() {
    if prompt_yn "Would you like to install nvim plugins?"; then
        echo "Installing nvim Plugins"
        nvim +PlugInstall +qall
        ./bin/coc_extensions
    else
        echo "Skipping..."
        return
    fi
}

open_manual_downloads() {

    if var_is_set MANUAL_DOWNLOADS; then
        if prompt_yn "Manual download urls were found. Would you like to open these in a browser?"; then
            for i in "${MANUAL_DOWNLOADS[@]}"; do
                open --url "$i"
            done
        else
            echo "Skipping..."
            return
        fi
    fi
}

on_finish() {
    echo
    echo "${BLUE}Hooray!"
    echo
    echo "${LIME_YELLOW}       __      __  _____ __"
    echo "${GREEN}  ____/ /___  / /_/ __(_) /__  _____"
    echo "${RED} / __  / __ \/ __/ /_/ / / _ \/ ___/"
    echo "${POWDER_BLUE}/ /_/ / /_/ / /_/ __/ / /  __(__  )"
    echo "${BLUE}\__,_/\____/\__/_/ /_/_/\___/____/"
    echo "${BLUE}                                   ...was installed successfully!${END}"
    echo
}

main() {
    on_start "$@"
    confirm_git_user "$@"
    set_gitconfig "$@"
    install_cli_tools "$@"
    generate_ssh_key "$@"
    install_dotfiles "$@"
    install_homebrew "$@"
    setup_theme "$@"
    install_packages "$@"
    write_defaults "$@"
    install_omz "$@"
    install_nvim_plugins "$@"
    extra_download_urls "$@"
    on_finish "$@"
}
main "$@"
