# dmenu version
VERSION = 5.0-rolling

# paths
PREFIX = ~/.local
MANPREFIX = $(PREFIX)/share/man

X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib

# Xinerama, comment if you don't want it
XINERAMALIBS  = -lXinerama
XINERAMAFLAGS = -DXINERAMA

# freetype
FREETYPELIBS = -lfontconfig -lXft
FREETYPEINC = /usr/include/freetype2
# OpenBSD (uncomment)
#FREETYPEINC = $(X11INC)/freetype2

# includes and libs
INCS = -I$(X11INC) -I$(FREETYPEINC)
LIBS = -L$(X11LIB) -lX11 $(XINERAMALIBS) $(FREETYPELIBS)

# flags
CPPFLAGS = -D_DEFAULT_SOURCE -D_BSD_SOURCE -D_XOPEN_SOURCE=700 -D_POSIX_C_SOURCE=200809L -DVERSION=\"$(VERSION)\" $(XINERAMAFLAGS) -D_FORTIFY_SOURCE=2 -O3 -fPIE -fplt -flto -fstack-protector-all -fvisibility=hidden -fsanitize=cfi -fsanitize=cfi-cast-strict -fcomplete-member-pointers -fsanitize-cfi-cross-dso
CFLAGS   = -std=c99 -pedantic -Wall -Os $(INCS) $(CPPFLAGS) 
LDFLAGS  = $(LIBS) -fuse-ld=lld -O3 -fpie -pie -fPIE -fplt -flto -fstack-protector-all -fvisibility=hidden -fuse-ld=gold -Wl,-z,now -fsanitize=safe-stack,cfi,cfi-cast-strict -Wl,--strip-all -fsanitize-cfi-cross-dso


# compiler and linker
CC = clang
