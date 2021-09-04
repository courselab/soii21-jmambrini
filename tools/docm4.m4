dnl  doc.m4 - Macros for document source files
dnl    
dnl  Copyright (c) 2021 - Monaco F. J. <monaco@usp.br>
dnl
dnl  This file is part of SYSeg. 
dnl
dnl  SYSeg is free software: you can redistribute it and/or modify
dnl  it under the terms of the GNU General Public License as published by
dnl  the Free Software Foundation, either version 3 of the License, or
dnl  (at your option) any later version.
dnl
dnl  SYSeg is distributed in the hope that it will be useful,
dnl  but WITHOUT ANY WARRANTY; without even the implied warranty of
dnl  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
dnl  GNU General Public License for more details.
dnl
dnl  You should have received a copy of the GNU General Public License
dnl  along with .  If not, see <http://www.gnu.org/licenses/>.
dnl
dnl
divert(-1)

changequote(`[',`]')

define([DOCM4_PROJECT],[SYSeg])
define([DOCM4_REPOSITORY],[http://gitlab.com/monaco/syseg])
define([DOCM4_YEAR],[2001])
define([DOCM4_AUTHOR],[Monaco F. J.])
define([DOCM4_EMAIL]),[<monaco@usp.br>])
define([DOCM4_LICENSE],[GNU General Public License vr.3])
define([DOCM4_LICENSE_SHORT],[GNU GPL vr.3])

define([DOCM4_DEPS],TOOL_PATH/docm4.m4 TOOL_PATH/bintools.m4)]

dnl A short head notice that can be used in the README file
dnl describing the contents of a directory.

define(DOCM4_DIR_NOTICE,
[
 The contents of this directory are part of DOCM4_PROJECT,
 copyright (c) DOCM4_YEAR DOCM4_AUTHOR DOCM4_AUTHOR
 DOCM4_PROJECT is Free Software distributed under DOCM4_LICENSE_SHORT.
 Further information: DOCM4_REPOSITORY
])

dnl Copyright notice for Makefiles
dnl
dnl Arguments:
dnl
dnl  $1  file name
dnl  $2  one-line brief description

define(DOCM4_HASH_HEAD_NOTICE,
[changecom(,)dnl
#   $1 - $2
#
#   Copyright (c) DOCM4_YEAR - DOCM4_AUTHOR DOCM4_EMAIL
#
#   This file is part of DOCM4_PROJECT.
#
#   DOCM4_PROJECT is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
changecom([#],[])
])

dnl Copyright notice for shell scripts that use # as comment mark.
dnl
dnl Arguments:
dnl
dnl  $1  full path to the shell
dnl  $2  file name
dnl  $3  one-line brief description

define(DOCM4_SHELL_HEAD_NOTICE,
#!$1
#
[DOCM4_HASH_HEAD_NOTICE($2,$3)]
)

define(DOCM4_FILE_NOTICE,
[
 This file is a derivative part of DOCM4_PROJECT,
 copyright (c) DOCM4_YEAR DOCM4_AUTHOR DOCM4_AUTHOR
 DOCM4_PROJECT is Free Software distributed under GNU GPL vr3.
 Further information: DOCM4_REPOSITORY
])

define(DOCM4_HASH_FILE_NOTICE,
[changecom(,)dnl
## This file is a derivative worl of DOCM4_PROJECT,
## copyright (c) DOCM4_YEAR DOCM4_AUTHOR DOCM4_AUTHOR.
## DOCM4_PROJECT is Free Software distributed under GNU GPL vr3.
## Further information: DOCM4_REPOSITORY
changecom([#],)
])

define([DOCM4_MAKE_BINTOOLS],
[changecom(,)dnl
# ------------------------------------------------------------
# The following excerpt of code was copied from MakeBintools,
# part of DOCM4_PROJECT, Copyright DOCM4_YEAR DOCM4_AUTHOR.
# MakeBintools is a collection of handy 'GNU make' rules for
# inspecting and comparing the contents of source and object files.
# Further information: DOCM4_REPOSITORY

include(bintools.m4)
changecom([#],)dnl

# End of MakeBintools.
# -------------------------------------------------------------
])

define([DOCM4_UPDATE_AUTHOR_INFO],
[
  Please, *do not* forget to

    - fill in file AUTHORS with the pertinent information
    - edit heading comments in all source files with your data

  Open Source literacy time:

  Remember: authorship and copyright of your source code should be
  assigned to you, the author, not to DOCM4_PROJECT. Nevertheless,
  being it a derivative work, credits are due to DOCM4_PROJECT
  author --- therefore, make sure the proper attribution is
  included along with the copyright notice. Also, bear in mind
  that the DOCM4_PROJECT's licence requires that your derivative
  work to be distributed under not-less restrictive terms --- if
  in doubt, conserve the same license.

  One way to claim copyright and attribute credits is adding the
  following notice at the top of every source file of your work
  (e.g. if keeping the original DOCM4_PROJECT license):

     Copyright (c) <CURRENT-YEAR>, <YOUR-NAME> 

     This piece of software is a derivative work of DOCM4_PROJECT,
     by DOCM4_AUTHOR. DOCM4_PROJECT is distributed under the license
     <DOCM4_LICENSE_SHORT>, and is available at <DOCM4_REPOSITORY>.

    This file is part of <YOUR-WORK>.

    <YOUR-WORK> is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
   
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
   
    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
])



##
## Bintools documentation
##
define([DOCM4_MAKE_BINTOOLS_DOC],
[
 Conveniency rules from MakeBintools

 The following excerpt of code was copied from MakeBintools,
 part of DOCM4_PROJECT, Copyright DOCM4_YEAR DOCM4_AUTHOR.
 MakeBintools is a collection of handy 'GNU make' rules for
 inspecting and comparing the contents of source and object files.
 Further information: DOCM4_REPOSITORY


 BUILD INSTRUCTIONS
 

 * For buiding and inspecting, use

   make					     Build the default target.

   make foo				     Build foo.

   make diss IMG=foo 			     Disassemble foo.

   	     	     			     Optionally,

					        ASM  = intel | att  (default)
						BIT  =    16 | 32   (default)

   make dump IMG=foo			     Show the raw contents of foo.
   
   make      			             Build everything (or make all)

   make clean			             Undo make all

   make diff foo bar baz		     Show graphical diff between files

   	     	     			     ASM and BIT variables apply


  * If any example involves the manipulation of a bootable image, use
  

   make run IMG=foo	             	     Test foo (MBR) in the emulator

   make run-fd IMG=foo  		     Test foo (floppy) in the emulator

   make iso IMG=foo	             	     build an iso9660 image with foo

   make stick IMG=foo STICK=/dev/sdX         make a bootable USB stick


   SHORTCUTS

   make foo/diss			     disassemble .text as 32-bit AT&T
   make foo/d				     same as foo/diss  (also bellow)

   make foo/diss intel|att		     disassemble as 32-bit Intel or AT&T
   make foo/diss 16|32			     disassemble as 16-bit or 32-bit
   make foo/diss intel|att 16|32	     disassemble as Intel|AT&T 16|32 bit
   make foo/diss 16|32 intel|att	     disassemble as Intel|AT&T 16|32 bit

   make foo/i16	       			     disassemble as Intel 16-bit
   make foo/a16 or foo/16  		     disassemble as AT&T  16-bit
   make foo/a32	of foo/32 or foo/a     	     disassemble as AT&T  32-bit
   make foo/i32	          or foo/i	     disassemble as Intel 32-bit

   		   			     In all disassembly rules, a
					     trailing '*' means disassemble all
					     sections, e.g. foo/d* foo/16* ...

   make foo/dump			     show raw contents in hexadecimal

   make foo/run				     test foo (mbr) with the emulator
   make foo/fd				     test foo (floppy) with the emulator

 FILE NAMES

 Some examples allow alternative build recipes which can be selected
 by passing the command-line variable ALT=<number> to 'make'. See bellow. 

 File names:

     eg-00.ext		contain the main examples;
     egx-00.ext		contain auxiliary extra examples.

 File extensions:

     hex		ASCII file containing values
     			in hexadecimal representation;

     asm		manually written assembly code in
     			Intel ASM format;

     S			manually written assembly code
     			in AT&T Gas format;

     s			assembly code in AT&T Gas format
     			generated by the compiler (GCC);

     o			object code produced by the assembler;

     bin		binary file generated by the
     			compiler /linker;

     ld			linker script.



 NOTE ON BOOTING THE REAL HARDWARE

    If any example involves booting from a USB stick, mind following note.

    Unfortunately, not all BIOSes  handle USB boot devices in the same
    way (welcome to system level). Some are likely to emulate it as a floppy
    disk and rely on the original IBM PC boot method we are exploring here.
    If so, you should be able to prepare your stick using 'make stick'
    with the command line variable IMG=foo.bin. Otherwise, if your computer's
    BIOS emulates your USP stick as a CD-ROM, you should be better served
    by passing it the variable IMG=foo.iso.  


 WORDS OF WISDOM

    If you plan to boot the examples in the physical hardware, check which
    device represents your USB stick. You may use, for instance lsblk utility.
    Your devices should possibly list as /dev/sdX, with X being a, b, c etc.

    If you have only one storage device, say your HD, it may appear as
    /dev/sda, and when you plug your USB stick, it'll take the next
    available letter and appears as /dev/sdb.  You should be required
    administrative privileges (sudo) to write directly into your device.

    Be careful: you're entering system-level. 

    If you misspell your stick as /dev/hda, you may end up grieving in
    pitiful misery and hopeless regrets... do not lower your guard.

    Note: in some systems, storage device may also appear as /dev/mmcblk;
    e.g. /dev/mmcblk0p1 is the first partition of the device mmcklk0.

  --- End of MakeBintools
])

##
## Have a good coding
##
define([DOCM4_CLOSING_WORDS],
[
 Happy hacking! 
 
                                  
])

##
## Update Makefile from Makefile.m4
##
define([UPDATE_MAKEFILE],
[
# Update Makefile from Makefile.m4 if needed, and then invoke make again.
# If the source is from a pack-distribution, the lack of Makefile.m4
# inhibits the updating. 

ifndef UPDATED
$(MAKECMDGOALS) : Makefile

Makefile_deps = Makefile.m4 DOCM4_DEPS

Makefile : $(shell if test -f Makefile.m4; then echo $(Makefile_deps); fi);
	@if ! test -f .dist; then\
	  cd .. && make;\
	  make -f Makefile clean;\
	  make -f Makefile UPDATED=1 $(MAKECMDGOAL);\
	fi

endif
])

##
## Programing exercise directions with pack
##
define([DOCM4_PACK_DIRECTIONS],
[
 Directions for the exercise
 ------------------------------

 Under this directory, invoke the make rule

   make pack

 This should create a tarball containing the project files.
 Copy it to your own project tree and uncompress the tarball.

 To complete the programming exercise, proceed as indicated
 in both this file and in the example source code.

 If applicable, please edit either the supplied build scripts.

DOCM4_UPDATE_AUTHOR_INFO

])

##
##
##
define([DOCM4_RELEVANT_RULES],
[changecom(,)
###########################################################
##
## These are the rules of interest in this set of examples.
##
changecom([#],)
])

##
## Create pack-distribution (subprojects).
##
define([DOCM4_PACK],
[changecom(,)
# Self-contained pack distribution.
#
# make pack     creates a tarball with the essential files, which can be
#      		distributed independently of the rest of this project.
#
# A pack distribution contain all the items necessary to build and run the
# relevant piece of software. It's useful,a for instance, to bundle
# self-contained subsections of DOCM4_PROJECT meant to be delivered as
# programming exercise assignments or illustrative source code examples.
#		
# In order to select which files should be included in the pack, list them
# in the appropriate variables
# 
# PACK_FILES_C    = C files (source, headers, linker scripts)
# PACK_FILES_MAKE = Makefiles
# PACK_FILES_TEXT = Text files (e.g. README)
# PACK_FILES_SH   = Shell scripts (standard /bin/sh)
#
# Except by text files, all other files will have their heading comment
# (the very first comment found in the file) replaced by a corresponding
# standard comments containing boilerplate copyright notice and licensing
# information, with blank fields to be filled in by the pack user.
# Attribution to DOCM4_PROJECT is also included for convenience.

TARNAME=$1-$2

changecom([#],)

pack:
	@if ! test -f .dist; then\
	  make do_pack;\
	 else\
	  echo "This is a distribution pack already. Nothing to be done.";\
	fi

do_pack:
	rm -rf $(TARNAME)
	mkdir $(TARNAME)
	(cd .. && make clean && make)
	for i in $(PACK_FILES_C); do\
	  cp TOOL_PATH/c-head-pack.c $(TARNAME)/$$i ;\
	  TOOL_PATH/stripcomment -c $$i >> $(TARNAME)/$$i;\
	done
	for i in $(PACK_FILES_MAKE); do\
	  cp TOOL_PATH/Makefile-head-pack $(TARNAME)/$$i ;\
	  TOOL_PATH/stripcomment -h $$i >> $(TARNAME)/$$i;\
	done
	cp $(PACK_FILES_TEXT) $(TARNAME)
	touch $(TARNAME)/.dist
	tar zcvf $(TARNAME).tar.gz $(TARNAME)

clean-pack:
	rm -f $(TARNAME).tar.gz
	rm -rf $(TARNAME)

.PHONY: pack do_pack clean-pack

])


divert(0)dnl
