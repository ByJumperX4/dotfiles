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
if ! [ "$PATH" = "$HOME/.local/bin:$HOME/bin:" ]
then
    PATH="/usr/local/bin:/usr/sbin:/sbin:/usr/local/sbin:$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# Disable ctrl + s

stty -ixon

# Variables

export EDITOR=vim
export PAGER=less
export PATH=$PATH:~/.local/bin:$GOPATH/bin
export MAKEFLAGS='-j20 -l20'

# Alias

alias ls="ls -ah --color=auto"
alias l="ls -l"
alias xephinit="Xephyr -br -ac -noreset -screen 2000x1000 :1 & sleep 2 ; DISPLAY=:1 sh ~/.xinitrc"
alias x="exit"
alias clr="clear"
alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias dotfiles-push='dotfiles push && dotfiles push --mirror git@github.com:ByJumperX4/dotfiles && dotfiles push --mirror git@gitlab.com:By_JumperX4/dotfiles'
alias rrm='/bin/rm'

# for git.gnous.eu if ssh is disabled temporarly

alias gnous-nossh-dotfiles-push='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME push --mirror https://git.gnous.eu/By_JumperX4/dotfiles.git && dotfiles push --mirror git@github.com:ByJumperX4/dotfiles && dotfiles push --mirror git@gitlab.com:By_JumperX4/dotfiles'


alias dotfiles-update='dotfiles add ~/{README.md,.{vimrc,bashrc,blerc},.vim,.config/{htop,neofetch,awesome,alacritty},.local/bin/{mzk,steam,youtube-local},src/dwm/{config.h,patches.h}}'
alias grep='grep --color=auto $@'
alias egrep='egrep --color=auto $@'
alias fgrep='fgrep --color=auto $@'

alias brl-icon-cache='for i in $(find /usr/share/icons/ -maxdepth 1 -type d); do sudo rm -f $i/.icon-theme.cache; sudo gtk-update-icon-cache -t -i $i; done

for i in $(find ~/.icons -maxdepth 1 -type d); do sudo rm -f $i/.icon-theme.cache; sudo gtk-update-icon-cache -t -i $i; done'

# Functions

newtor() {
    command sudo systemctl restart tor privoxy
}

rm() {
case "$1" in
    -rf)
    shift
    command mv --force -v $* /trash/
    ;;
    $*)
    command mv -v $* /trash/$*$RANDOM
esac
}

fuck() {
    command sudo $(fc -ln -1)
}

dotfiles() {
    command git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

 traceroute4ever() {
    command traceroute -4 1.1.1.1 && traceroute -4 8.8.8.8 && traceroute4ever
}

#p() {
#case "$1" in
#    i|in|install)
#        shift
#        command doas emerge -av $*
#    ;;
#    s|se|search)
#        shift
#        command eix $*
#    ;;
#    r|rm|remove)
#        shift
#        command doas emerge -avC $*
#    ;;
#    arm|autoremove)
#        shift
#        command doas emerge -avc $*
#    ;;
#    u|up|update|upgrade)
#        shift
#        command doas emerge -avuDN @selected @world $*
#    ;;
#    sync|sc)
#        shift
#        command doas eix-sync
#    ;;
#    if|info)
#        shift
#        command equery m $* && equery u $*
#    ;;
#    ne|news)
#        shift
#        command eselect news read
#    ;;
#    lu|list-updates)
#        shift
#        command eix -u $*
#    ;;
#    l|list)
#       shift
#       command eix -I $*
#    ;;
#    h|help|v|version|-h|--help|-v|--version|$*)
#        command echo "
#The holy p function v1.3
#Part of By_JumperX4's zshrc
#-------------------------
#
#Made for use with gentoo or gentoo-based distros that have emerge, eix, eselect and equery available.
#
#Usage:
#
#p h / help / -h / --help / v / version / -v / --version # show this message
#
#p i / in / install <package(s) name(s)> # install package(s)
#
#p s / se / search <keyword(s)> # search for package(s)
#
#p r / rm / remove <package(s)> # remove package(s)
#
#p arm / autoremove <package(s) / nothing> # remove orphans or a package and the orphans that are created by its deletion
#
#p u / up / update / upgrade <package(s) / nothing> # updates the whole system or some packages
#
#p sc / sync # synchronize repositories and overlays
#
#p if / info <package(s)> # get informations about package(s)
#
#p ne / news # reads the news
#
#p lu / list-updates # list available updates
#
#p l / list <keyword(s) / nothing> # list all installed packages or search for some
#        "
#    ;;
#esac
#}

3mp4tomp3() {
    for f in *.mp4; do ffmpeg -i "$f" "mp3/${f%.*}.mp3"; done
}

# Start X11

if [ "$(tty)" = "/dev/tty1" ]; then
        startx
fi

# ble.sh syntax highlighting & autocompletion (https://github.com/akinomyoga/ble.sh)

. ~/.local/share/blesh/ble.sh

# disable ble.sh if running in a tty

if [ "$(echo $(tty)|rev|cut -c2-|rev)" = "/dev/tty" ]; then
        ble-detach
fi

