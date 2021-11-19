set number
export EDITOR=nvim
export PATH="$HOME/bin:$PATH"
source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
source $HOME/.aliases

setopt HIST_IGNORE_SPACE
setopt HIST_NO_FUNCTIONS

# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Ruby
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/3.0.0/bin:$PATH"

# Python
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
# Add binary directory for PyCharm
# https://www.jetbrains.com/help/pycharm/pipenv.html?keymap=secondary_macos
export PATH="$PATH:/Users/elijahgray/Library/Python/3.9/bin"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

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

# Vi Mode
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

# Syntax Highlighting
source /Users/elijahgray/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=238'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Append a command directly
zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')
