	.file	"tyos.c"
	.code16gcc
	.text
	.section	.rodata
	.align 4
.LC0:
	.string	"Welcome! The commands are: date, time, quit and help!\n\n"
.LC1:
	.string	">"
.LC2:
	.string	"help"
.LC3:
	.string	"date"
.LC4:
	.string	"time"
.LC5:
	.string	"quit"
	.align 4
.LC6:
	.string	"Actually, I can't close the program with this function... You'll need to click on the X."
.LC7:
	.string	" command not found"
	.text
	.globl	shell
	.type	shell, @function
shell:
.LFB0:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$24, %esp
	call	clear
	movl	$.LC0, %ecx
	call	print
.L7:
	movl	$.LC1, %ecx
	call	print
	leal	-11(%ebp), %eax
	movl	%eax, %ecx
	call	read
	leal	-11(%ebp), %eax
	movl	$.LC2, %edx
	movl	%eax, %ecx
	call	compare
	testl	%eax, %eax
	je	.L2
	call	help
	jmp	.L7
.L2:
	leal	-11(%ebp), %eax
	movl	$.LC3, %edx
	movl	%eax, %ecx
	call	compare
	testl	%eax, %eax
	je	.L4
	call	date
	jmp	.L7
.L4:
	leal	-11(%ebp), %eax
	movl	$.LC4, %edx
	movl	%eax, %ecx
	call	compare
	testl	%eax, %eax
	je	.L5
	call	time
	jmp	.L7
.L5:
	leal	-11(%ebp), %eax
	movl	$.LC5, %edx
	movl	%eax, %ecx
	call	compare
	testl	%eax, %eax
	je	.L6
	movl	$.LC6, %ecx
	call	print
	movl	$nl, %ecx
	call	print
	jmp	.L7
.L6:
	leal	-11(%ebp), %eax
	movl	%eax, %ecx
	call	print
	movl	$.LC7, %ecx
	call	print
	movl	$nl, %ecx
	call	print
	jmp	.L7
	.cfi_endproc
.LFE0:
	.size	shell, .-shell
	.section	.rodata
.LC8:
	.string	"System halted"
	.text
	.globl	halt
	.type	halt, @function
halt:
.LFB1:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$8, %esp
	movl	$.LC8, %ecx
	call	print
	movl	$nl, %ecx
	call	print
#APP
# 67 "tyos.c" 1
	loop96:           ;        hlt       ;        jmp loop96;
# 0 "" 2
#NO_APP
	nop
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
.LFE1:
	.size	halt, .-halt
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
