set number
export EDITOR=nvim
export PATH="$HOME/bin:$PATH"
source $HOME/.aliases

setopt HIST_IGNORE_SPACE
setopt HIST_NO_FUNCTIONS

# Enable italics
export TERM="xterm-256color"

# Ruby
export PATH=/usr/local/opt/ruby/bin:$PATH
export GEM_HOME=/usr/local/opt/ruby/lib/ruby/gems/3.0.2
export GEM_PATH=/usr/local/opt/ruby/lib/ruby/gems/3.0.2

# python
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
# Add binary directory for PyCharm
# https://www.jetbrains.com/help/pycharm/pipenv.html?keymap=secondary_macos
export PATH="$PATH:/Users/elijahgray/Library/Python/3.9/bin"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

### Functions ###

function man {
    open x-man-page://$@ ;
}

mkcdir ()
{
    mkdir -p -- "$1" && cd -P -- "$1"
}

# Install (one or multiple) selected application(s)
# using "brew search" as source input
# mnemonic [B]rew [I]nstall [P]ackages
bip() {
    local inst=$(brew search "$@" | fzf -m)

    if [[ $inst ]]; then
        for prog in $(echo $inst);
        do; brew install $prog; done;
    fi
}

# Delete (one or multiple) selected application(s)
# mnemonic [B]rew [C]lean [P]ackages (e.g. uninstall)
bcp() {
    local uninst=$(brew leaves | fzf -m)

    if [[ $uninst ]]; then
        for prog in $(echo $uninst);
        do; brew uninstall $prog; done;
    fi
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
export ZSH_AUTOSUGGEST_HISTORY_IGNORE='chflags hidden *'
export ZSH_AUTOSUGGEST_HISTORY_IGNORE='git add *'
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

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
# the silver searcher
# export FZF_DEFAULT_COMMAND='rg --files --hidden -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# fzf git
export PATH="/Users/elijahgray/git-fuzzy/bin:$PATH"

# fzf tab completion
source ~/fzf-tab/fzf-tab.plugin.zsh
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'

rga-fzf() {
	RG_PREFIX="rga --files-with-matches"
	local file
    echo $RG_PREFIX
	file="$(
		FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
			fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
				--phony -q "$1" \
				--bind "change:reload:$RG_PREFIX {q}" \
				--preview-window="70%:wrap"
	)" &&
	echo "opening $file" &&
	xdg-open "$file"
}

# Fixes zsh-vi-mode and fzf keybinding conflicts
zvm_after_init_commands+=('[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh')

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
    eval "$("$BASE16_SHELL/profile_helper.sh")"

# Bat theme
export BAT_THEME="base16"

# vivid colors
export LS_COLORS="$(vivid -m 8-bit generate material)"
