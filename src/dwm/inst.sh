#!/bin/sh

# Try to be agnostic to where we're being started from, chdir to where
# the script is.
mydir="`dirname "$myname"`"
test -d "$mydir" && cd "$mydir"

# If ${PWD} results in a zero length string, we can try something else...
if [ ! "${PWD}" ]; then
        # "hacking around some braindamage"
        PWD="`pwd`"
        echo "This system has a messed up shell.\n"
	return 1
fi

dwmsourcedir=$(pwd)

# Installing additionnal programs before dwm, kinda like dependencies

for f in $(ls others-programs); do
    echo "Entering "$dwmsourcedir/others-programs/$f
    cd $dwmsourcedir/others-programs/$f
    make clean
    echo "Installing "$f
    make install -j $(nproc)
    echo "Cleaning "$f "source"
    make clean
    echo "Exiting "$dwmsourcedir/others-programs/$f", going to "$dwmsourcedir
    cd $dwmsourcedir
done

echo "Copying scripts from "$dwmsourcedir/scripts" to ~/.local/bin"
chmod +x $dwmsourcedir/scripts/*
cp -v $dwmsourcedir/scripts/* ~/.local/bin/

# Installing dwm

echo "Building dwm"
make clean all
echo "Installing dwm"
make install -j $(nproc)
echo "Cleaning dwm source"
make clean
echo ""
echo "--- DONE ---"
