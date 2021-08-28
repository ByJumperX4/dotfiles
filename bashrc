#!/bin/bash
# Please don't use /bin/bash in your scripts, make POSIX shell scripts
#        __            __          
#       / /  ___ ____ / /  ________
#    _ / _ \/ _ `(_-</ _ \/ __/ __/  Made by:
#   (_)_.__/\_,_/___/_//_/_/  \__/ By_JumperX4
#                           

# Source global definitions

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#
# Prompt
#

export PS1="\[\033[38;5;10m\]\[\033[48;5;0m\]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;2m\]\w\[$(tput sgr0)\]\[\033[38;5;7m\]>\[$(tput sgr0)\] \[$(tput sgr0)\]"

#
# Variables
#

export PATH="$PATH:$HOME/.local/bin" # Use the system's default path, then add some other places for extra commands.
export SYSTEMD_PAGER="" # I don't want systemd to open logs in less, let me pipe to it manually if I want that behavior.
export EDITOR="emacs" # Emacs is my favorite text editor, some prefers to use another text editor.
export PAGER=less # I use less as pager, it works.
export MAKEFLAGS='-j20' # I have 24 threads on my dual-xeon setup, adapt to your machine's specs.
export QT_QPA_PLATFORMTHEME=qt5ct # QT5 Theme.
export TERMINAL=xterm # I use XTerm, let i3 be aware of that

# Options/modes

set -o posix # I want my bash to be posix compliant
set -o emacs # Emacs is my favourite text editor

#
# Aliases
#

# Coloration in commands, replace some commands with themselves but with arguments to enable colors

alias ip="ip -c"
alias grep="grep --color"

# ls related aliases

alias ls="ls -ah --color" # List all the files in an human-readable way with coloration.
alias l="ls -ahl --color" # Same as above, but instead display one file per line in a detailed way.


# Non-categorized aliases

alias vi="emacs" # Replace the vi command with emacs.
alias dvi="doas emacs" # Set dvi to emacs as root.
alias clr="clear" # Use "clr" to clear the terminal, this is shorter.
alias x="exit" # Use "x" to exit, this is shorter.
alias newtor="doas systemctl restart tor" # Restart tor to get a new tor circuit

#
# Autostart
#

# Run X11 if in the first TTY. Supports GNU/Linux, FreeBSD and OpenBSD. Not tested on others.
# If it's not the first TTY, display a cow saying a fortune cookie.

if [ "$(tty)" = "/dev/tty1" ] || [ "$(tty)" =  "/dev/ttyv0" ] || [ "$(tty)" = "/dev/ttyC0" ]; then
    startx
fi

# Display a cow saying a fortune cookie
fortune | cowsay

# End.
