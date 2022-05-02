if [ -z "$INTELLIJ_ENVIRONMENT_READER" ]; then

### Custom ###

# Used for other settings you might not want to commit
[ -f ~/.extra ] && source ~/.extra

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export EDITOR=nvim
export PATH="$HOME/bin:$PATH"

setopt HIST_IGNORE_SPACE
setopt HIST_NO_FUNCTIONS

export TERM="xterm-256color"
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export GSD_SITES="nxmac.com ebay.com facebook.com amazon.com"
# Ruby
# hint: make sure the path matches `ruby --version`
export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/3.0.3/bin:$PATH"

# Completions
autoload -U compinit
zmodload zsh/complist
compinit d ~/.ache/zsh/zcompdump-$ZSH_VERSION
_comp_options+=(globdots)
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with lsd when completingcd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd -F --tree --depth 2 --color=always --icon=always {2} | head -200'
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'

# Autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=238'
export ZSH_AUTOSUGGEST_HISTORY_IGNORE='chflags hidden *'
export ZSH_AUTOSUGGEST_HISTORY_IGNORE='git add *'
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
# ignore suggestions for 50 characters or over
export ZSH_AUTOSUGGEST_HISTORY_IGNORE="?(#c50,)"

# fzf
export FZF_DEFAULT_COMMAND='fd --hidden' 
export FZF_DEFAULT_OPTS='--color'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"
export FZF_ALT_C_OPTS="$FZF_ALT_C_OPTS_BASE
--preview 'lsd -F --tree --depth 2 --color=always --icon=always {} | head -200'
"

# Colors
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
LIME_YELLOW=$(tput setaf 190)
YELLOW=$(tput setaf 3)
POWDER_BLUE=$(tput setaf 153)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BRIGHT=$(tput bold)
END=$(tput sgr0)
BLINK=$(tput blink)
REVERSE=$(tput smso)
UNDERLINE=$(tput smul)

THEME="material"

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# export LS_COLORS="$(vivid -m 8-bit generate snazzy)"

export BAT_THEME="base16"

# you-should-use
export YSU_IGNORED_ALIASES=("e" "v" "g")
export YSU_HARDCORE=1

### Functions ###

# Open man pages in Man Page Profile
function man {
    open x-man-page://$@;
}

# Homebrew
# Delete (one or multiple) selected application(s)
# mnemonic [B]rew [C]lean [P]ackages (e.g. uninstall)
bcp() {
    local uninst=$(brew leaves | fzf -m)

    if [[ $uninst ]]; then
        for prog in $(echo $uninst);
        do; brew uninstall $prog; done;
    fi
}

uninstall() {
    local token
    token=$(brew list --casks | fzf-tmux --query="$1" +m --preview 'brew info {}')

    if [ "x$token" != "x" ]
    then
        echo "(U)ninstall or open the (h)omepae of $token"
        read input
        if [ $input = "u" ] || [ $input = "U" ]; then
            brew uninstall --cask $token
        fi
        if [ $input = "h" ] || [ $token = "h" ]; then
            brew home $token
        fi
    fi
}

install() {
    echo Must learn to use tmux first! 
}

mkcdir ()
{
    mkdir -p -- "$1" &&
       cd -P -- "$1"
}

rga-fzf() {
	RG_PREFIX="rga --files-with-matches"
	local file
	file="$(
		FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
			fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
				--phony -q "$1" \
				--bind "change:reload:$RG_PREFIX {q}" \
				--preview-window="70%:wrap"
	)" &&
	echo "opening $file" &&
	open "$file"
}

# Replace date with gdate
if [[ $(uname) -eq Darwin ]]; then
    date() { gdate "$@" }
fi

### Oh My Zsh ###

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# # Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# Change default Oh My Zsh custom directory so that they may be stored in dotfiles repo
ZSH_CUSTOM=$HOME/.oh-my-zsh-custom


# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
custom_plugins=(autoupdate fzf-tab you-should-use zsh-autosuggestions zsh-vi-mode)
plugins=(git fzf $custom_plugins)

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"

export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/2.7.0/bin:$PATH"

# Clone the repositories of plugins that don't exit
# [[ ! -d $ZSH_CUSTOM/plugins/ ]] 

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH="/Users/elijahgray/.oh-my-zsh/custom/plugins/git-fuzzy/bin:$PATH"

zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh && enable-fzf-tab')

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# Keeps theme separate from profile
### NOTE: Must execute zsh again because of a problem with zsh-vi-mode not working
# wait to see if issue is resolved: https://github.com/jeffreytse/zsh-vi-mode/issues/169
# last accessed: 5/1/2022
alias ayu_colors="export LS_COLORS=\"$(vivid -m 8-bit generate ayu)\""
alias snazzy_colors="export LS_COLORS=\"$(vivid -m 8-bit generate snazzy)\""
 alias loading_github_theme...="base16_github; rm ~/.base16_theme; export ZSH_THEME=flazz; ayu_colors; source $ZSH/oh-my-zsh.sh; clear; exec zsh -l"
 alias loading_material_theme...="base16_material; rm ~/.base16_theme; export ZSH_THEME=powerlevel10k/powerlevel10k; snazzy_colors; source $ZSH/oh-my-zsh.sh; clear; exec zsh -l"
 alias loading_basic_theme...="[[ -f ~/.base16_theme ]] && rm ~/.base16_theme; ayu_colors; source $ZSH/oh-my-zsh.sh; clear; exec zsh -l"
fi

