# dwm version 
VERSION = 6.2-rolling

# Customize below to fit your system

# paths
# Install in ~/.local to not install anything to the system
PREFIX = ~/.local
MANPREFIX = ~/.local/share/man

X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib

# Xinerama, comment if you don't want it
XINERAMALIBS  = -lXinerama
XINERAMAFLAGS = -DXINERAMA

# freetype
FREETYPELIBS = -lfontconfig -lXft
FREETYPEINC = ${X11INC}/freetype2

# includes and libs
INCS = -I${X11INC} -I${FREETYPEINC}
LIBS = -L${X11LIB} -lX11 ${XINERAMALIBS} ${FREETYPELIBS}

# flags
 # Stuff you can change
  # compiler and linker
  CC = clang
  LD = /usr/bin/ld.gold

# Security / hardening flags (requires clang)
HARDENED_CFLAGS = -D_FORTIFY_SOURCE=2 -fstack-protector-strong -fPIE
HARDENED_LDFLAGS = -Wl,-z,now -Wl,-z,relro -pie -fsanitize=safe-stack -fsanitize-cfi-cross-dso -s
OPTIMIZATION_CLFAGS = -O3 -march=native -static
OPTIMIZATION_LDFAGS = -O3 -march=native
CPPFLAGS = -D_DEFAULT_SOURCE -D_BSD_SOURCE -D_POSIX_C_SOURCE=2 -DVERSION=\"${VERSION}\" ${XINERAMAFLAGS} ${OPTIMIZATION_CLFAGS} ${HARDENED_CFLAGS}
CFLAGS   = -std=c99 -pedantic -Wall -Wno-deprecated-declarations -Os ${INCS} ${CPPFLAGS} 
LDFLAGS  = ${LIBS} ${OPTIMIZATION_LDFAGS} ${HARDENED_LDFLAGS}

