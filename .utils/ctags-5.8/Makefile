# $Id: Makefile.in 709 2009-07-04 05:29:28Z dhiebert $
#
# Makefile for UNIX-like platforms.
#

# These are the names of the installed programs, in case you wish to change
# them.
#
CTAGS_PROG = ctags
ETAGS_PROG = etags

# Set this to the path to your shell (must run Bourne shell commands).
#
SHELL = /bin/sh

# GNU Autoconf variables. These are set by the "configure" script when it
# runs.
#
exec_prefix = ${prefix}
datarootdir = ${prefix}/share
prefix	= /home/hoysong
bindir	= ${exec_prefix}/bin
srcdir	= .
libdir	= ${exec_prefix}/lib
incdir	= ${prefix}/include
mandir	= ${datarootdir}/man
SLINK	= ln -s
STRIP	= strip
CC	= gcc
DEFS	= -DHAVE_CONFIG_H
CFLAGS	= -g -O2
LDFLAGS	= 
LIBS	= 
EXEEXT	= 
OBJEXT	= o

# If you cannot run the "configure" script to set the variables above, then
# uncomment the defines below and customize them for your environment. If
# your system does not support symbolic (soft) links, then remove the -s
# from SLINK.
#
#srcdir	= .
#bindir	= /usr/local/bin
#mandir	= /usr/local/man
#SLINK	= ln -s
#STRIP	= strip
#CC	= cc
#DEFS	= -DHAVE_CONFIG_H
#CFLAGS	= -O
#LDFLAGS=

include $(srcdir)/source.mak

#
#--- You should not need to modify anything below this line. ---#
#

.SUFFIXES:
.SUFFIXES: .c .$(OBJEXT)



INSTALL		= cp
INSTALL_PROG	= $(INSTALL)
INSTALL_DATA	= $(INSTALL)

READ_LIB = readtags.$(OBJEXT)
READ_INC = readtags.h

MANPAGE	= ctags.1

AUTO_GEN   = configure config.h.in
CONFIG_GEN = config.cache config.log config.status config.run config.h Makefile

#
# names for installed man pages
#
manext	= 1
man1dir	= $(mandir)/man1
CMAN	= $(CTAGS_PROG).$(manext)
EMAN	= $(ETAGS_PROG).$(manext)

#
# destinations for installed files
#
CTAGS_EXEC	= $(CTAGS_PROG)$(EXEEXT)
ETAGS_EXEC	= $(ETAGS_PROG)$(EXEEXT)
DEST_CTAGS	= $(bindir)/$(CTAGS_EXEC)
DEST_ETAGS	= $(bindir)/$(ETAGS_EXEC)
DEST_READ_LIB	= $(libdir)/$(READ_LIB)
DEST_READ_INC	= $(incdir)/$(READ_INC)
DEST_CMAN	= $(man1dir)/$(CMAN)
DEST_EMAN	= $(man1dir)/$(EMAN)

#
# primary rules
#
all: $(CTAGS_EXEC) $(READ_LIB)

$(CTAGS_EXEC): $(OBJECTS)
	$(CC) $(LDFLAGS) -o $@ $(OBJECTS) $(LIBS)

dctags$(EXEEXT): debug.c $(SOURCES) $(HEADERS)
	$(CC) -I. -I$(srcdir) $(DEFS) -DDEBUG -g $(LDFLAGS) -o $@ debug.c $(SOURCES)

readtags$(EXEEXT): readtags.c readtags.h
	$(CC) -DREADTAGS_MAIN -I. -I$(srcdir) $(DEFS) $(CFLAGS) $(LDFLAGS) -o $@ readtags.c

ETYPEREF_OBJS = etyperef.o keyword.o routines.o strlist.o vstring.o
etyperef$(EXEEXT): $(ETYPEREF_OBJS)
	$(CC) $(LDFLAGS) -o $@ $(ETYPEREF_OBJS)

etyperef.o: eiffel.c
	$(CC) -DTYPE_REFERENCE_TOOL -I. -I$(srcdir) $(DEFS) $(CFLAGS) -o $@ -c eiffel.c

$(OBJECTS): $(HEADERS) config.h

#
# generic install rules
#
install: install-ctags

install-strip: install

install-ctags: install-cbin install-cman
install-etags: install-ebin install-eman

$(bindir) $(man1dir) $(libdir) $(incdir):
	$(srcdir)/mkinstalldirs $@

FORCE:

#
# install the executables
#
install-bin: install-cbin install-ebin install-lib
install-cbin: $(DEST_CTAGS)
install-ebin: $(DEST_ETAGS)
install-lib: $(DEST_READ_LIB) $(DEST_READ_INC)

$(DEST_CTAGS): $(CTAGS_EXEC) $(bindir) FORCE
	$(INSTALL_PROG) $(CTAGS_EXEC) $@  &&  chmod 755 $@

$(DEST_ETAGS):
	- if [ -x $(DEST_CTAGS) ]; then \
	    cd $(bindir) && $(SLINK) $(CTAGS_EXEC) $(ETAGS_EXEC); \
	fi

#
# install the man pages
#
install-man: install-cman install-eman
install-cman: $(DEST_CMAN)
install-eman: $(DEST_EMAN)

$(DEST_CMAN): $(man1dir) $(MANPAGE) FORCE
	- $(INSTALL_DATA) $(srcdir)/$(MANPAGE) $@  &&  chmod 644 $@

$(DEST_EMAN):
	- if [ -f $(DEST_CMAN) ]; then \
	    cd $(man1dir) && $(SLINK) $(CMAN) $(EMAN); \
	fi

#
# install the library
#
$(DEST_READ_LIB): $(READ_LIB) $(libdir) FORCE
	$(INSTALL_PROG) $(READ_LIB) $@  &&  chmod 644 $@

$(DEST_READ_INC): $(READ_INC) $(incdir) FORCE
	$(INSTALL_PROG) $(READ_INC) $@  &&  chmod 644 $@


#
# rules for uninstalling
#
uninstall: uninstall-bin uninstall-lib uninstall-man

uninstall-bin:
	- rm -f $(DEST_CTAGS) $(DEST_ETAGS)

uninstall-lib:
	- rm -f $(DEST_READ_LIB) $(DEST_READ_INC)

uninstall-man:
	- rm -f $(DEST_CMAN) $(DEST_EMAN)

uninstall-ctags:
	- rm -f $(DEST_CTAGS) $(DEST_CMAN)

uninstall-etags:
	- rm -f $(DEST_ETAGS) $(DEST_EMAN)

#
# miscellaneous rules
#
tags: $(CTAGS_EXEC)
	./$(CTAGS_EXEC) $(srcdir)/*

TAGS: $(CTAGS_EXEC)
	./$(CTAGS_EXEC) -e $(srcdir)/*

clean:
	rm -f $(OBJECTS) $(CTAGS_EXEC) tags TAGS $(READ_LIB) 
	rm -f dctags$(EXEEXT) readtags$(EXEEXT)
	rm -f etyperef$(EXEEXT) etyperef.$(OBJEXT)

mostlyclean: clean

distclean: clean
	rm -f $(CONFIG_GEN)

maintainerclean: distclean
	rm -f $(AUTO_GEN)

#
# implicit rules
#
.c.$(OBJEXT):
	$(CC) -I. -I$(srcdir) $(DEFS) $(CFLAGS) -c $<

# vi:set tabstop=8:
