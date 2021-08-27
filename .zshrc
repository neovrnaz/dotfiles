source $HOME/.aliases

autoload -Uz vcs_info
precmd() { vcs_info }

# git on the command line
zstyle ':vcs_info:git:*' formats 'On branch %b '

# Command prompt directory
setopt PROMPT_SUBST
PROMPT='${PWD/#$HOME/~} ${vcs_info_msg_0_}> '
export PATH="/usr/local/sbin:$PATH"

# Add yarn install location to $PATH
# https://classic.yarnpkg.com/en/docs/cli/global/
export PATH="$(yarn global bin):$PATH"

# Add yarn to $PATH
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Add homebrew ruby to $PATH
export PATH="/usr/local/opt/ruby/bin:$PATH"

# Add ruby and gems path to shell
export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/3.0.0/bin:$PATH"

# Python
# Delete if not using python
# Used by pyenv
# Source: https://github.com/pyenv/pyenv#installation
eval "$(pyenv init -)"

# Combine mkdir and cd
# Source: https://unix.stackexchange.com/a/125386/404021
mkcdir ()
{
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}

# Used for dotfiles repo
# Source: https://www.atlassian.com/git/tutorials/dotfiles 
alias config='/usr/bin/git --git-dir=/Users/elijahgray/.cfg/ --work-tree=/Users/elijahgray'
