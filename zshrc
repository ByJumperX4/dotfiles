#!/usr/bin/env zsh

#
# System stuff
#

# Source defaults

if [ -f /etc/profile ] ; then
    source /etc/profile # System-wide defaults
fi
if [ -f $HOME/.profile ] ; then
    source $HOME/.profile # User-defined defaults
fi

# Auto-adjust zsh configuration depending on detected stuff

#
# Prompt
#

# Set prompt

if ! [ $(whoami) = "root" ]; then
    PROMPT="%B%F{yellow}$ %f%b%B%F{red}%~%f%b%F{red}> %f"
else
    PROMPT="%F{red}# %f%b%B%F{red}%~%f%b%F{red}> %f"
fi
    RPROMPT="%B%F{red}[%f%b%B%F{yellow}%?%f%b%B%F{red}]%f%b"

#
# Tweaks
#

# Define variables

if [ "$(echo $PATH | grep 'sbin')" = "" ]; then
    PATH=/sbin:/usr/sbin:/usr/local/sbin:$PATH # Add system-related binaries
fi
if [ "$(echo $PATH | grep '\.local/bin')" = "" ] ; then
    PATH=$PATH:$HOME/.local/bin
fi
if [ "$(echo $PATH | grep '\.cargo/bin')" = "" ] ; then
    PATH=$PATH:$HOME/.cargo/bin
fi
if [ -d /usr/lib/jvm ]; then
    for f in $(ls /usr/lib/jvm); do
	PATH=$PATH:/usr/lib/jvm/$f/bin
    done
fi

EDITOR="" # Define the text editor (first clear anything)
if [ $(command -v emacs) ]; then # (detect the text editor to use)
    EDITOR="emacs -nw"
elif [ $(command -v mg) ]; then
    EDITOR="mg"
elif [ $(command -v micro) ]; then
    EDITOR="micro"
elif [ $(command -v edit) ]; then
    EDITOR="edit"
elif [ $(command -v nvi) ]; then
    EDITOR="nvi"
elif [ $(command -v neovim) ]; then
    EDITOR="neovim"
elif [ $(command -v vim) ]; then
    EDITOR="vim"
elif [ $(command -v nano) ]; then
    EDITOR="nano"
elif [ $(command -v vi) ]; then
    EDITOR="vi"
fi

HISTFILE=$HOME/.histfile # History file
HISTSIZE=1000 # History file size
SAVEHIST=1000 # Number of lines to save
PAGER=less # I use less as pager, it just works.
QT_QPA_PLATFORMTHEME=qt5ct # QT5 Theme engine.
TERMINAL=xterm-256color # I use XTerm, let whatever needs that variable be aware of that.

case "$(uname -s)" in
    FreeBSD|OpenBSD)
	cpunum=$(sysctl -n hw.ncpu)
	;;
    Linux)
	cpunum=$(nproc)
	;;
esac	  
case "$cpunum" in
    1|2)
	MAKEFLAGS="-j $cpunum"
	;;
    3|4|5)
	MAKEFLAGS="-j $((cpunum-1))"
	;;
    6|7)
	MAKEFLAGS="-j $((cpunum-2))"
	;;
    7|8|9|10|11)
	MAKEFLAGS="-j $((cpunum-3))"
	;;
    *)
	MAKEFLAGS="-j $((cpunum-cpunum/8))"
esac

# Export variables

export EDITOR
export PAGER
export PATH
export MAKEFLAGS
# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-R

export QT_QPA_PLATFORMTHEME
export TERMINAL

# Set options/modes

set -o emacs # Emacs is my favourite text editor
setopt autocd # Do not require "cd" to change directory
setopt extendedglob # Extended globbing (regular expressions with *)

# Completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':compinstall' filename '$HOME/.zshrc'
zstyle ':completion:*' rehash true                              # Automatically find new exacutables in path

# Load stuff
autoload -Uz compinit colors zcalc
compinit
colors

# Keybindings

bindkey -e
bindkey '^[[7~' beginning-of-line                       # Home key
bindkey '^[[H' beginning-of-line                        # Home key
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line        # [Home] - Go to beginning of line
fi
bindkey '^[[8~' end-of-line                             # End key
bindkey '^[[F' end-of-line                              # End key
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}" end-of-line               # [End] - Go to end of line
fi
bindkey '^[[2~' overwrite-mode                          # Insert key
bindkey '^[[3~' delete-char                             # Delete key
bindkey '^[[C'  forward-char                            # Right key
bindkey '^[[D'  backward-char                           # Left key
bindkey '^[[5~' history-beginning-search-backward       # Page up key
bindkey '^[[6~' history-beginning-search-forward        # Page down key

#
# Aliases
#

# Replacements

alias ls="ls -ah --color=auto"      # ls with color, all files displayed and human readable output

# Shortcuts

alias e="$EDITOR"       # 'e' becomes a link to the editor
alias de="doas $EDITOR" # 'de' runs the editor as root using doas
alias x="exit"          # 'x' exits the shell
alias clr="clear"       # 'clr' clears the buffer
alias l="ls -l"         # 'l' lists in long listing format

#
# Autostart
#

# Run X11 if in the first TTY. Supports GNU/Linux, FreeBSD and OpenBSD. Not tested on others

if [ "$(tty)" = "/dev/tty1" ] || [ "$(tty)" =  "/dev/ttyv0" ] || [ "$(tty)" = "/dev/ttyC0" ]; then
    dbus-launch startx -- -nolisten tcp
fi


# Display a fortune cookie told by a cow

fortune | cowsay

# End.
