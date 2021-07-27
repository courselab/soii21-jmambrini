include(docm4.m4)
 TyOS - Tiny Operating System
 ==============================================
DOCM4_DIR_NOTICE

 Overview
 ------------------------------

 TyOS is a really (really!) simple operating system prototype demonstrating
 the two stage loading. First stage, the boot loader, fits entirely within
 the 512-byte master boot record of a USB stick. It is meant to be loaded
 through legacy BIOS boot method and execute in real mode on any x86 platform.
 Upon loading, stage1 loads the second stage right after the boot loader.
 The second stage does nothig, except by printing a welcome message.
 Everyting runs in x86 real-mode (we're not going 32bit yet).

 Challenge
 ------------------------------

 1) Build and execute TinyOS under a x86 emulator (e.g. qemu).

 2) Copy the program to a USB stick and boot it with BIOS legacy mode.

 3) Implement some functionality in the file tyos.c.

    Contrary to syseg/try/mbr example, the second stage can be arbitrarily
    large. You can build something really cool here.

DOCM4_PACK_DIRECTIONS

DOCM4_CLOSING_WORDS


 APPENDIX A
 ------------------------------
 
DOCM4_MAKE_BINTOOLS_DOC

 
