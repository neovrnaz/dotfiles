# Enviornment variables that need to be available for other programs, and should be invoked for all zsh shells

# Editor
# sets editor for programs (including git)
export VISUAL=nvim
export EDITOR="$VISUAL"

# PATH
[[ -d $HOME/.local/bin ]] && export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/3.0.3/bin:$PATH"

export TERM="xterm-256color"

