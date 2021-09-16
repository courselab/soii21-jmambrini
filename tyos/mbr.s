	.file	"mbr.c"
	.code16gcc
	.text
	.section	.rodata
	.align 4
.LC0:
	.string	"I wish... (too small a program for anything else)."
	.text
	.globl	help
	.type	help, @function
help:
.LFB0:
	.cfi_startproc
	movl	$.LC0, %ecx
	call	print
	movl	$nl, %ecx
	call	print
#APP
# 31 "mbr.c" 1
	ret
# 0 "" 2
#NO_APP
	nop
	ud2
	.cfi_endproc
.LFE0:
	.size	help, .-help
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
	subl	$24, %esp
#APP
# 40 "mbr.c" 1
			mov	$0x04, %ah                 ;		int 	$0x1a                       ;		mov	%ch, -11(%ebp)                 ;		mov	%cl, -12(%ebp)                 ;		mov	%dh, -10(%ebp)                 ;		mov	%dl, -9(%ebp)                 ;
# 0 "" 2
#NO_APP
	movzbl	-11(%ebp), %eax
	sarb	$4, %al
	addl	$48, %eax
	movb	%al, -23(%ebp)
	movzbl	-11(%ebp), %eax
	andl	$15, %eax
	addl	$48, %eax
	movb	%al, -22(%ebp)
	movzbl	-12(%ebp), %eax
	sarb	$4, %al
	addl	$48, %eax
	movb	%al, -21(%ebp)
	movzbl	-12(%ebp), %eax
	andl	$15, %eax
	addl	$48, %eax
	movb	%al, -20(%ebp)
	movb	$45, -19(%ebp)
	movzbl	-10(%ebp), %eax
	sarb	$4, %al
	addl	$48, %eax
	movb	%al, -18(%ebp)
	movzbl	-10(%ebp), %eax
	andl	$15, %eax
	addl	$48, %eax
	movb	%al, -17(%ebp)
	movb	$45, -16(%ebp)
	movzbl	-9(%ebp), %eax
	sarb	$4, %al
	addl	$48, %eax
	movb	%al, -15(%ebp)
	movzbl	-9(%ebp), %eax
	andl	$15, %eax
	addl	$48, %eax
	movb	%al, -14(%ebp)
	movb	$0, -13(%ebp)
	leal	-23(%ebp), %eax
	movl	%eax, %ecx
	call	print
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
	subl	$24, %esp
#APP
# 74 "mbr.c" 1
			mov	$0x02, %ah                 ;		int 	$0x1a                       ;		mov	%ch, -11(%ebp)                 ;		mov	%cl, -10(%ebp)                 ;		mov	%dh, -9(%ebp)                 ;
# 0 "" 2
#NO_APP
	movzbl	-11(%ebp), %eax
	sarb	$4, %al
	addl	$48, %eax
	movb	%al, -20(%ebp)
	movzbl	-11(%ebp), %eax
	andl	$15, %eax
	addl	$48, %eax
	movb	%al, -19(%ebp)
	movb	$58, -18(%ebp)
	movzbl	-10(%ebp), %eax
	sarb	$4, %al
	addl	$48, %eax
	movb	%al, -17(%ebp)
	movzbl	-10(%ebp), %eax
	andl	$15, %eax
	addl	$48, %eax
	movb	%al, -16(%ebp)
	movb	$58, -15(%ebp)
	movzbl	-9(%ebp), %eax
	sarb	$4, %al
	addl	$48, %eax
	movb	%al, -14(%ebp)
	movzbl	-9(%ebp), %eax
	andl	$15, %eax
	addl	$48, %eax
	movb	%al, -13(%ebp)
	movb	$0, -12(%ebp)
	leal	-20(%ebp), %eax
	movl	%eax, %ecx
	call	print
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
	.globl	read
	.type	read, @function
read:
.LFB3:
	.cfi_startproc
	movl	%ecx, %edx
	movl	%edx, %ebx
#APP
# 112 "mbr.c" 1
	   mov $0x0, %si               ;loop130:                         ;   movw $0X0, %ax              ;   int $0x16                    ;   movb %al, %es:(%bx, %si) ;   inc %si                     ;   cmp $0xd, %al               ;   mov   $0x0e, %ah            ;   int $0x10                    ;   jne loop130                   ; mov $0x0e, %ah                ; mov $0x0a, %al                ;   int $0x10                    ;   movb $0x0, -1(%bx, %si)    ;   ret                           
# 0 "" 2
#NO_APP
	nop
	ud2
	.cfi_endproc
.LFE3:
	.size	read, .-read
	.globl	compare
	.type	compare, @function
compare:
.LFB4:
	.cfi_startproc
	movl	%ecx, %ebx
	movl	%edx, %edi
	movl	%ebx, %esi
#APP
# 147 "mbr.c" 1
	    mov $2, %cx   ;    mov $0x1, %ax     ;    cld                ;    repe  cmpsb        ;    jecxz  equal       ;    mov $0x0, %ax     ;equal:                 ;    ret                ;
# 0 "" 2
#NO_APP
	movl	$0, %eax
	ud2
	.cfi_endproc
.LFE4:
	.size	compare, .-compare
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
