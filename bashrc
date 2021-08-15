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

#
# Aliases
#

# Dotfiles-specific, you can remove if you don't manage your dotfiles
# -- Obsolete
#alias dotfiles="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME" # Execute git commands inside of the dotfiles repo
# Push the changes to the 3 mirrors I use, this is only specific to me and won't work if you don't own my ssh private key. And I hope you don't.
alias dotfiles-push="git push --mirror git@github.com:ByJumperX4/dotfiles && git push --mirror git@gitlab.com:By_JumperX4/dotfiles"
# Update all the files, must run this before commiting anything
#alias dotfiles-update="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME add ~/{README.md,.{emacs,bashrc,xinitrc,Xresources},.config/qt{5,6}ct/colors/greenie-dark.conf,.icons/oomox-greenie-dark,.themes/oomox-greenie-dark,.local/bin/{autokernel,decompressall,ffmpeg-{mkv,mp4,webm}tomp3,gemacs,laz,screenshot,steam},.emacs.d/elpa,.config/{Element/config.json,rofi,htop,neofetch,fish,i3}}"
# End of dotfiles-specific aliases

# Coloration in commands, replace some commands with themselves but with arguments to enable colors

alias ip="ip -c"
alias grep="grep --color"

# ls related aliases

alias ls="ls -ah --color" # List all the files in an human-readable way with coloration.
alias l="ls -ahl --color" # Same as above, but instead display one file per line in a detailed way.


# Non-categorized aliases

alias vi="emacs" # Replace the vi command with emacs.
alias clr="clear" # Use "clr" to clear the terminal, this is shorter.
alias x="exit" # Use "x" to exit, this is shorter.
alias newtor="sudo systemctl restart tor" # Restart tor to get a new tor circuit

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
