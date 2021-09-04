##   Makefike - Handcrafted make script for syseg/tools
##
##   Copyright (c) 2021 - Monaco F. J. <monaco@usp.br>
##
##   This file is part of SYSeg.
##
##   SYSeg is free software: you can redistribute it and/or modify
##   it under the terms of the GNU General Public License as published by
##   the Free Software Foundation, either version 3 of the License, or
##   (at your option) any later version.
##
##   This program is distributed in the hope that it will be useful,
##   but WITHOUT ANY WARRANTY; without even the implied warranty of
##   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##   GNU General Public License for more details.
##
##   You should have received a copy of the GNU General Public License
##   along with this program.  If not, see <http://www.gnu.org/licenses/>.

##
## Configuration
##


# Inform your preferred graphical diff tool e.g meld, kdiff3 etc.

DIFF_TOOL=meld


##
## You probably don't need to change beyond this line
##

ifndef ASM
ifeq (,$(findstring intel, $(MAKECMDGOALS)))
ASM_SYNTAX = att
else
ASM_SYNTAX = intel
endif
else
ASM_SYNTAX= $(ASM)
endif

ifndef BIT
ifeq (,$(findstring 16, $(MAKECMDGOALS)))
ASM_MACHINE = i386
else
ASM_MACHINE = i8086
endif
else

ifeq ($(BIT),16)
ASM_MACHINE = i386
else
ASM_MACHINE = i8086
endif

endif

intel att 16 32: 
	@echo > /dev/null

diss:  $(IMG)
	@objdump -f $< > /dev/null 2>&1; \
	if [ $$? -eq 1 ]  ; then \
	  objdump -M $(ASM_SYNTAX) -b binary -m $(ASM_MACHINE) -D $< ; \
	else \
	  objdump -M $(ASM_SYNTAX) -m $(ASM_MACHINE) -d $< ; \
	fi

%/diss : %
	make --quiet diss IMG=$< $(filter 16 32 intel att, $(MAKECMDGOALS))

%/i16 %/16i : %
	make --quiet $</diss intel 16
%/i32 %/32i : %
	make --quiet $</diss intel 32
%/a16 %/16 : %
	make --quiet $</diss att 16
%/a32 %/32: %
	make --quiet $</diss att 32

%/run : %
	make run IMG=$<


dump: $(IMG)
	hexdump -C $<


%/dump : %
	make --quiet dump IMG=$< 


MISSING_DIFF_TOOL="Can't find $(DIFF_TOOL); please edit syseg/tools/makefile.utils"

objdiff bindiff : $(wordlist 2, 4, $(MAKECMDGOALS))
	if  test -z $(which $(DIFF_TOOL)); then echo $(MISSING_DIFF_TOOL); exit 1; fi
	if test $(words $^) -lt 3 ; then\
	  bash -c "$(DIFF_TOOL) <(make $(wordlist 1,1,$^)/diss) <(make $(wordlist 2,2,$^)/diss)";\
	else\
	  bash -c "$(DIFF_TOOL) <(make $(wordlist 1,1,$^)/diss) <(make $(wordlist 2,2,$^)/diss) <(make $(wordlist 3,3,$^)/diss)";\
	fi

srcdiff : $(wordlist 2, 4, $(MAKECMDGOALS))
	if  test -z $(which $(DIFF_TOOL)); then echo $(MISSING_DIFF_TOOL); exit 1; fi
	if test $(words $^) -lt 3 ; then\
	  bash -c "$(DIFF_TOOL) $(wordlist 1,1,$^) $(wordlist 2,2,$^)";\
	else\
	  bash -c "$(DIFF_TOOL) $(wordlist 1,1,$^) $(wordlist 2,2,$^) $(wordlist 3,3,$^)";\
	fi

diff : $(word 2, $(MAKECMDGOALS))
	@echo $(wordlist 2, 4, $(MAKECMDGOALS))
	@EXT=$(suffix $<);\
	case $$EXT in \
	.bin | .o)\
		make --quiet objdiff $(wordlist 2, 4, $(MAKECMDGOALS))\
		;;\
	.asm | .S.| .s | .i | .c | .h | .hex)\
		make --quiet srcdiff $(wordlist 2, 4, $(MAKECMDGOALS))\
		;;\
	*)\
		echo "I don't know how to compare filetype $$EXT"\
		;;\
	esac

run: $(IMG)
	qemu-system-i386 -drive format=raw,file=$< -net none


##
## Create bootable USP stick if BIOS needs it
##

%.iso : %.img
	xorriso -as mkisofs -b $< -o $@ -isohybrid-mbr $< -no-emul-boot -boot-load-size 4 ./

%.img : %.bin
	dd if=/dev/zero of=$@ bs=1024 count=1440
	dd if=$< of=$@ seek=0 conv=notrunc

run-iso: $(IMG)
	qemu-system-i386 -drive format=raw,file=$(IMG) -net none

stick: $(IMG)
	@if test -z "$(STICK)"; then \
	echo "*** ATTENTION: make IMG=foo.bin SITCK=/dev/X"; exit 1; fi 
	dd if=$< of=$(STICK)

.PHONY: clean clean-extra intel att 16 32 diss /diss /i16 /i32 /a16 /a32
