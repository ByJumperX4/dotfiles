#        __            __          
#       / /  ___ ____ / /  ________
#    _ / _ \/ _ `(_-</ _ \/ __/ __/  Made by:
#   (_)_.__/\_,_/___/_//_/_/  \__/ By_JumperX4
#                           

# Prompt

export PS1="\[$(tput bold)\]\[\033[38;5;11m\]\[\033[48;5;235m\]\\$\[$(tput sgr0)\]\[\033[48;5;234m\] \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;10m\]\w\[$(tput sgr0)\]\[\033[38;5;255m\]>\[$(tput sgr0)\] \[$(tput sgr0)\]"

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="/usr/local/bin:/usr/sbin:/sbin:/usr/local/sbin:$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Disable ctrl + s

stty -ixon

# Aliases
stop="doas poweroff"
reboot="doas reboot"

# Variables

export EDITOR=vim
export PAGER=less
export PATH=$PATH:~/.local/bin:$GOPATH/bin
export MAKEFLAGS='-j20 -l20'

# Start X

if [[ "$(tty)" == "/dev/tty1" ]]; then
        startx
	echo "Won't start fish, as tty1 as been detected"
else
	fish
	exit
fi

