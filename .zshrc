PS1='%1~ $ '
set number
source $HOME/.aliases
export TERM=xterm-256color

setopt HIST_IGNORE_SPACE
setopt HIST_NO_FUNCTIONS

# Ruby
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/3.0.0/bin:$PATH"

# Python
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
# Add binary directory for PyCharm
# https://www.jetbrains.com/help/pycharm/pipenv.html?keymap=secondary_macos
export PATH="$PATH:/Users/elijahgray/Library/Python/3.9/bin"

# Functions
mkcdir ()
{
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}

# git on the command line
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats 'On branch %b '
# command prompt directory
setopt PROMPT_SUBST

# Tab completions
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# Syntax Highlighting
source /Users/elijahgray/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Vi Mode
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# Autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=238'

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
