	.file	"tyos.c"
	.code16gcc
	.text
	.section	.rodata
.LC0:
	.string	"System halted"
	.text
	.globl	halt
	.type	halt, @function
halt:
.LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	movl	$.LC0, %ecx
	call	print
	movl	$nl, %ecx
	call	print
#APP
# 27 "tyos.c" 1
	loop15:           ;        hlt       ;        jmp loop15;
# 0 "" 2
#NO_APP
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE0:
	.size	halt, .-halt
	.globl	date
	.type	date, @function
date:
.LFB1:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
#APP
# 38 "tyos.c" 1
	  mov     $0x04, %ah  ;  int     $0x1a        ;  mov     $0x0e, %ah  ;  mov     %ch, %al   ;  shr     $4, %al     ;  add     $48, %al    ;  int     $0x10        ;  mov     %ch, %al   ;  and     $15, %al    ;  add     $48, %al    ;  int     $0x10        ;  mov     %cl, %al   ;  shr     $4, %al     ;  add     $48, %al    ;  int     $0x10        ;  mov     %cl, %al   ;  and     $15, %al    ;  add     $48, %al    ;  int     $0x10        ;  mov     $45, %al    ;  int     $0x10        ;  mov     %dh, %al   ;  shr     $4, %al     ;  add     $48, %al    ;  int     $0x10        ;  mov     %dh, %al   ;  and     $15, %al    ;  add     $48, %al    ;  int     $0x10        ;  mov     $45, %al    ;  int     $0x10        ;  mov     %cl, %al   ;  shr     $4, %al     ;  add     $48, %al    ;  int     $0x10        ;  mov     %cl, %al   ;  and     $15, %al    ;  add     $48, %al    ;  int     $0x10        ;
# 0 "" 2
#NO_APP
	movl	$nl, %ecx
	call	print
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1:
	.size	date, .-date
	.globl	time
	.type	time, @function
time:
.LFB2:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
#APP
# 88 "tyos.c" 1
	  mov     $0x04, %ah  ;  int     $0x1a        ;  mov     $0x0e, %ah  ;  mov     %ch, %al   ;  shr     $4, %al     ;  add     $48, %al    ;  int     $0x10        ;  mov     %ch, %al   ;  and     $15, %al    ;  add     $48, %al    ;  int     $0x10        ;  mov     $58, %al    ;  int     $0x10        ;  mov     %cl, %al   ;  shr     $4, %al     ;  add     $48, %al    ;  int     $0x10        ;  mov     %cl, %al   ;  and     $15, %al    ;  add     $48, %al    ;  int     $0x10        ;  mov     $58, %al    ;  int     $0x10        ;  mov     %dh, %al   ;  shr     $4, %al     ;  add     $48, %al    ;  int     $0x10        ;  mov     %dh, %al   ;  and     $15, %al    ;  add     $48, %al    ;  int     $0x10        ;
# 0 "" 2
#NO_APP
	movl	$nl, %ecx
	call	print
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE2:
	.size	time, .-time
	.section	.rodata
.LC1:
	.string	">"
.LC2:
	.string	"help"
.LC3:
	.string	"time"
.LC4:
	.string	"date"
.LC5:
	.string	"quit"
.LC6:
	.string	"Sorry..."
.LC7:
	.string	" command not found"
	.text
	.globl	main_stage2
	.type	main_stage2, @function
main_stage2:
.LFB3:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	call	clear
.L10:
	movl	$.LC1, %ecx
	call	print
	leal	-13(%ebp), %eax
	movl	%eax, %ecx
	call	read
	leal	-13(%ebp), %eax
	movl	$.LC2, %edx
	movl	%eax, %ecx
	call	compare
	testl	%eax, %eax
	je	.L5
	call	help
	jmp	.L10
.L5:
	leal	-13(%ebp), %eax
	movl	$.LC3, %edx
	movl	%eax, %ecx
	call	compare
	testl	%eax, %eax
	je	.L7
	call	time
	jmp	.L10
.L7:
	leal	-13(%ebp), %eax
	movl	$.LC4, %edx
	movl	%eax, %ecx
	call	compare
	testl	%eax, %eax
	je	.L8
	call	date
	jmp	.L10
.L8:
	leal	-13(%ebp), %eax
	movl	$.LC5, %edx
	movl	%eax, %ecx
	call	compare
	testl	%eax, %eax
	je	.L9
	movl	$.LC6, %ecx
	call	print
	movl	$nl, %ecx
	call	print
	jmp	.L10
.L9:
	leal	-13(%ebp), %eax
	movl	%eax, %ecx
	call	print
	movl	$.LC7, %ecx
	call	print
	movl	$nl, %ecx
	call	print
	jmp	.L10
	.cfi_endproc
.LFE3:
	.size	main_stage2, .-main_stage2
	.globl	compare
	.type	compare, @function
compare:
.LFB4:
	.cfi_startproc
	movl	%ecx, %ebx
	movl	%edx, %edi
	movl	%ebx, %esi
#APP
# 165 "tyos.c" 1
	    mov $4, %cx   ;    mov $0x1, %ax     ;    cld                ;    repe  cmpsb        ;    jecxz  equal       ;    mov $0x0, %ax     ;equal:                 ;    ret                ;
# 0 "" 2
#NO_APP
	movl	$0, %eax
	ud2
	.cfi_endproc
.LFE4:
	.size	compare, .-compare
	.section	.rodata
	.align 4
.LC8:
	.string	"I wish... (too small a program for anything else)."
	.text
	.globl	help
	.type	help, @function
help:
.LFB5:
	.cfi_startproc
	movl	$.LC8, %ecx
	call	print
	movl	$nl, %ecx
	call	print
#APP
# 189 "tyos.c" 1
	ret
# 0 "" 2
#NO_APP
	nop
	ud2
	.cfi_endproc
.LFE5:
	.size	help, .-help
	.globl	read
	.type	read, @function
read:
.LFB6:
	.cfi_startproc
	movl	%ecx, %edx
	movl	%edx, %ebx
#APP
# 196 "tyos.c" 1
	   mov $0x0, %si               ;loop177:                         ;   movw $0X0, %ax              ;   int $0x16                    ;   movb %al, %es:(%bx, %si) ;   inc %si                     ;   cmp $0xd, %al               ;   mov   $0x0e, %ah            ;   int $0x10                    ;   jne loop177                   ; mov $0x0e, %ah                ; mov $0x0a, %al                ;   int $0x10                    ;   movb $0x0, -1(%bx, %si)    ;   ret                           
# 0 "" 2
#NO_APP
	nop
	ud2
	.cfi_endproc
.LFE6:
	.size	read, .-read
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
