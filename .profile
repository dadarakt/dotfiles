# Some settings for color
if [ -e /usr/share/terminfo/x/xterm-256color ]; then
        export TERM='xterm-256color'
else
        export TERM='xterm-color'
fi
GREP_OPTIONS='--color=auto'

# Path
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export MANPATH=/opt/local/share/man:$MANPATH

# Shortcuts and helpers
alias lm="ls -la --block-size=M"
