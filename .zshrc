set number
export EDITOR=nvim
export PATH="$HOME/bin:$PATH"
source $HOME/.aliases
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# man 2 select
export MANPAER="nvim +Man!"

export FZF_DEFAULT_COMMAND="fd --type f"
export FZF_CTRL_T_COMMAND="fd --type f"
export FZF_ALT_C_COMMAND="fd --type f"

setopt HIST_IGNORE_SPACE
setopt HIST_NO_FUNCTIONS

# Enable italics
export TERM="xterm-256color"

# Ruby
export PATH=/usr/local/opt/ruby/bin:$PATH
export GEM_HOME=/usr/local/opt/ruby/lib/ruby/gems/3.0.2
export GEM_PATH=/usr/local/opt/ruby/lib/ruby/gems/3.0.2

# Python
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
# Add binary directory for PyCharm
# https://www.jetbrains.com/help/pycharm/pipenv.html?keymap=secondary_macos
export PATH="$PATH:/Users/elijahgray/Library/Python/3.9/bin"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

### Functions ###
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

# Syntax Highlighting
source /Users/elijahgray/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=238'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Enable Powerlevel10k instant prompt
source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

# fzf
export FZF_DEFAULT_OPTS='--color'
export FZF_DEFAULT_COMMAND="fd --exclude={Music,.git,.idea,node_modules,build,tmp} --type f"
# fzf git
export PATH="/Users/elijahgray/git-fuzzy/bin:$PATH"

# Fixes zsh-vi-mode and fzf keybinding conflicts
zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Bat theme
export BAT_THEME="material"

# vivid colors
export LS_COLORS="$(vivid -m 8-bit generate material)"
