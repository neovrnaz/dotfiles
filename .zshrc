if [ -z "$INTELLIJ_ENVIRONMENT_READER" ]; then

### Oh My Zsh ###

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# # Disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 7
zstyle ':omz:update' mode reminder

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load?
# Add wisely, as too many plugins slow down shell startup.
#
# Don't sort because order matters
plugins=(
    autoupdate
    git
    textmate
    fzf
    fzf-tab
    you-should-use
    zsh-autosuggestions
    vi-mode
    zsh-syntax-highlighting
    rga-fzf
    xmanpage
    apply-theme
    config
    help
    enable-completions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

VI_MODE_SET_CURSOR=true

# Update custom zsh plugins automatically
export UPDATE_ZSH_DAYS=7

# Used for other settings you might not want to commit
[ -f ~/.extra ] && source ~/.extra

setopt HIST_IGNORE_SPACE
setopt HIST_NO_FUNCTIONS

# ruby (make sure the path matches `ruby --version`)
# autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=238'
export ZSH_AUTOSUGGEST_HISTORY_IGNORE='chflags hidden *'
export ZSH_AUTOSUGGEST_HISTORY_IGNORE='git add *'
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
# ignore suggestions for 50 characters or over
export ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c50,)" fzf

# ruby (make sure the path matches `ruby --version`)
# autosuggestions
# ignore suggestions for 50 characters or over
export ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c50,)" fzf
export FZF_DEFAULT_COMMAND='fd . --hidden ' 
# export FZF_DEFAULT_OPTS=''
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}' "
export FZF_CTRL_R_OPTS="--color "
export FZF_ALT_C_OPTS="$FZF_ALT_C_OPTS_BASE --preview 'exa --tree --level 2 --color=always --icons {} | head -200'"

# you-should-use
export YSU_IGNORED_ALIASES=("e" "v" "g")
export YSU_HARDCORE=1

# read more files in more programs
export LESSOPEN='| lessfilter-fzf %s'

# colors
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
LIME_YELLOW=$(tput setaf 190)
POWDER_BLUE=$(tput setaf 153)
BRIGHT=$(tput bold)
END=$(tput sgr0)
BLINK=$(tput blink)
REVERSE=$(tput smso)
UNDERLINE=$(tput smul)

# to customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh 

[[ -v THEME ]] && apply_theme_$THEME

enable-fzf-tab
enable-completions

fi
