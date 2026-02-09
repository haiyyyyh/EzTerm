	.file	"ezterm.cpp"
	.text
	.p2align 4
	.type	_ZL11__sig_winchi, @function
_ZL11__sig_winchi:
.LFB1593:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	leaq	_ZL11__sig_winchi(%rip), %rsi
	movl	$28, %edi
	call	signal@PLT
	movb	$1, _ZL21__winsize_is_change__(%rip)
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE1593:
	.size	_ZL11__sig_winchi, .-_ZL11__sig_winchi
	.section	.text._ZNSt6vectorI5colorSaIS0_EED2Ev,"axG",@progbits,_ZNSt6vectorI5colorSaIS0_EED5Ev,comdat
	.align 2
	.p2align 4
	.weak	_ZNSt6vectorI5colorSaIS0_EED2Ev
	.type	_ZNSt6vectorI5colorSaIS0_EED2Ev, @function
_ZNSt6vectorI5colorSaIS0_EED2Ev:
.LFB1748:
	.cfi_startproc
	movq	%rdi, %rax
	movq	(%rdi), %rdi
	testq	%rdi, %rdi
	je	.L4
	movq	16(%rax), %rsi
	subq	%rdi, %rsi
	jmp	_ZdlPvm@PLT
	.p2align 4,,10
	.p2align 3
.L4:
	ret
	.cfi_endproc
.LFE1748:
	.size	_ZNSt6vectorI5colorSaIS0_EED2Ev, .-_ZNSt6vectorI5colorSaIS0_EED2Ev
	.weak	_ZNSt6vectorI5colorSaIS0_EED1Ev
	.set	_ZNSt6vectorI5colorSaIS0_EED1Ev,_ZNSt6vectorI5colorSaIS0_EED2Ev
	.text
	.p2align 4
	.type	_ZL5__putPKcz, @function
_ZL5__putPKcz:
.LFB1621:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$256, %rsp
	.cfi_def_cfa_offset 288
	movq	%rsi, 88(%rsp)
	movq	%rdx, 96(%rsp)
	movq	%rcx, 104(%rsp)
	movq	%r8, 112(%rsp)
	movq	%r9, 120(%rsp)
	testb	%al, %al
	je	.L7
	movaps	%xmm0, 128(%rsp)
	movaps	%xmm1, 144(%rsp)
	movaps	%xmm2, 160(%rsp)
	movaps	%xmm3, 176(%rsp)
	movaps	%xmm4, 192(%rsp)
	movaps	%xmm5, 208(%rsp)
	movaps	%xmm6, 224(%rsp)
	movaps	%xmm7, 240(%rsp)
.L7:
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	leaq	32(%rsp), %rbx
	movq	%rdi, %rdx
	leaq	8(%rsp), %rcx
	leaq	288(%rsp), %rax
	movl	$31, %esi
	movq	%rbx, %rdi
	movl	$8, 8(%rsp)
	movq	%rax, 16(%rsp)
	leaq	80(%rsp), %rax
	movl	$48, 12(%rsp)
	movq	%rax, 24(%rsp)
	call	vsnprintf@PLT
	movslq	%eax, %rbp
	testq	%rbp, %rbp
	je	.L6
	movl	_ZL18__obuf_write_idx__(%rip), %edx
	addq	%rbx, %rbp
	leaq	_ZL14__out_buffer__(%rip), %r12
.L13:
	cmpl	$8191, %edx
	jle	.L9
	movl	$8192, %edx
	movq	%r12, %rsi
	movl	$1, %edi
	call	write@PLT
	movzbl	(%rbx), %eax
	movl	$1, _ZL18__obuf_write_idx__(%rip)
	movb	%al, (%r12)
	leaq	1(%rbx), %rax
	cmpq	%rax, %rbp
	je	.L6
	movzbl	1(%rbx), %eax
	addq	$2, %rbx
	movl	$2, _ZL18__obuf_write_idx__(%rip)
	movb	%al, 1(%r12)
	cmpq	%rbx, %rbp
	je	.L6
	movl	$2, %edx
.L9:
	movzbl	(%rbx), %eax
	movslq	%edx, %rcx
	cmpl	$8160, %edx
	jle	.L14
	cmpb	$27, %al
	je	.L11
.L14:
	addl	$1, %edx
	addq	$1, %rbx
	movb	%al, (%r12,%rcx)
	movl	%edx, _ZL18__obuf_write_idx__(%rip)
	cmpq	%rbx, %rbp
	jne	.L13
.L6:
	movq	72(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L21
	addq	$256, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L11:
	.cfi_restore_state
	movq	%rcx, %rdx
	movq	%r12, %rsi
	movl	$1, %edi
	addq	$1, %rbx
	call	write@PLT
	movzbl	-1(%rbx), %eax
	movl	$1, _ZL18__obuf_write_idx__(%rip)
	movb	%al, (%r12)
	cmpq	%rbx, %rbp
	je	.L6
	movzbl	(%rbx), %eax
	movl	$1, %edx
	movl	$1, %ecx
	jmp	.L14
.L21:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE1621:
	.size	_ZL5__putPKcz, .-_ZL5__putPKcz
	.p2align 4
	.globl	_Z17set_input_timeouti
	.type	_Z17set_input_timeouti, @function
_Z17set_input_timeouti:
.LFB1592:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	subq	$144, %rsp
	.cfi_def_cfa_offset 160
	movq	%fs:40, %rbx
	movq	%rbx, 136(%rsp)
	movl	%edi, %ebx
	movq	%rsp, %rsi
	xorl	%edi, %edi
	call	tcgetattr@PLT
	cmpl	$-1, %eax
	je	.L22
	cmpl	$-1, %ebx
	je	.L26
	movl	$41, %edx
	movl	%ebx, %eax
	mulb	%dl
	xorl	%edx, %edx
	shrw	$12, %ax
.L24:
	movdqa	(%rsp), %xmm0
	xorl	%esi, %esi
	xorl	%edi, %edi
	movaps	%xmm0, 64(%rsp)
	movdqa	16(%rsp), %xmm0
	movaps	%xmm0, 80(%rsp)
	movdqa	32(%rsp), %xmm0
	movb	%dl, 87(%rsp)
	leaq	64(%rsp), %rdx
	movaps	%xmm0, 96(%rsp)
	movdqu	44(%rsp), %xmm0
	movb	%al, 86(%rsp)
	movups	%xmm0, 108(%rsp)
	call	tcsetattr@PLT
	cmpl	$-1, %eax
	sete	%al
	movzbl	%al, %eax
	negl	%eax
.L22:
	movq	136(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L31
	addq	$144, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L26:
	.cfi_restore_state
	movl	$1, %edx
	xorl	%eax, %eax
	jmp	.L24
.L31:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE1592:
	.size	_Z17set_input_timeouti, .-_Z17set_input_timeouti
	.p2align 4
	.globl	_Z9getsize_yv
	.type	_Z9getsize_yv, @function
_Z9getsize_yv:
.LFB1598:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	cmpb	$0, _ZL21__winsize_is_change__(%rip)
	je	.L33
	movb	$0, _ZL21__winsize_is_change__(%rip)
.L33:
	movq	%rsp, %rdx
	movl	$21523, %esi
	xorl	%edi, %edi
	xorl	%eax, %eax
	call	ioctl@PLT
	movzwl	(%rsp), %eax
	movq	8(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L36
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L36:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE1598:
	.size	_Z9getsize_yv, .-_Z9getsize_yv
	.p2align 4
	.globl	_Z9getsize_xv
	.type	_Z9getsize_xv, @function
_Z9getsize_xv:
.LFB1599:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	cmpb	$0, _ZL21__winsize_is_change__(%rip)
	je	.L38
	movb	$0, _ZL21__winsize_is_change__(%rip)
.L38:
	movq	%rsp, %rdx
	movl	$21523, %esi
	xorl	%edi, %edi
	xorl	%eax, %eax
	call	ioctl@PLT
	movzwl	2(%rsp), %eax
	movq	8(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L41
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L41:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE1599:
	.size	_Z9getsize_xv, .-_Z9getsize_xv
	.p2align 4
	.globl	_Z13size_ischangev
	.type	_Z13size_ischangev, @function
_Z13size_ischangev:
.LFB1600:
	.cfi_startproc
	movzbl	_ZL21__winsize_is_change__(%rip), %eax
	testb	%al, %al
	jne	.L47
	ret
	.p2align 4,,10
	.p2align 3
.L47:
	movb	$0, _ZL21__winsize_is_change__(%rip)
	ret
	.cfi_endproc
.LFE1600:
	.size	_Z13size_ischangev, .-_Z13size_ischangev
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"\033[%d;%dR"
	.text
	.p2align 4
	.globl	_Z11curs_get_yxRiS_
	.type	_Z11curs_get_yxRiS_, @function
_Z11curs_get_yxRiS_:
.LFB1601:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movl	$4, %edx
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rdi, %rbp
	movl	$1, %edi
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$64, %rsp
	.cfi_def_cfa_offset 96
	movq	%fs:40, %r12
	movq	%r12, 56(%rsp)
	movq	%rsi, %r12
	leaq	11(%rsp), %rsi
	movl	$1849056027, 11(%rsp)
	movb	$0, 15(%rsp)
	call	write@PLT
	pxor	%xmm0, %xmm0
	xorl	%edi, %edi
	movl	$29, %edx
	leaq	16(%rsp), %rsi
	movaps	%xmm0, 16(%rsp)
	movups	%xmm0, 30(%rsp)
	call	read@PLT
	xorl	%eax, %eax
	movq	%rbp, %rdx
	leaq	16(%rsp), %rdi
	movq	%r12, %rcx
	leaq	.LC0(%rip), %rsi
	call	__isoc23_sscanf@PLT
	movq	56(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L51
	addq	$64, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.L51:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE1601:
	.size	_Z11curs_get_yxRiS_, .-_Z11curs_get_yxRiS_
	.section	.rodata.str1.1
.LC1:
	.string	"\033[?25l"
.LC2:
	.string	"\033[?25h"
	.text
	.p2align 4
	.globl	_Z11curser_hideb
	.type	_Z11curser_hideb, @function
_Z11curser_hideb:
.LFB1602:
	.cfi_startproc
	testb	%dil, %dil
	je	.L53
	leaq	.LC1(%rip), %rdi
	xorl	%eax, %eax
	jmp	_ZL5__putPKcz
	.p2align 4,,10
	.p2align 3
.L53:
	leaq	.LC2(%rip), %rdi
	xorl	%eax, %eax
	jmp	_ZL5__putPKcz
	.cfi_endproc
.LFE1602:
	.size	_Z11curser_hideb, .-_Z11curser_hideb
	.section	.rodata.str1.1
.LC3:
	.string	"\033[%d q"
	.text
	.p2align 4
	.globl	_Z16curser_set_styles
	.type	_Z16curser_set_styles, @function
_Z16curser_set_styles:
.LFB1603:
	.cfi_startproc
	movswl	%di, %esi
	xorl	%eax, %eax
	leaq	.LC3(%rip), %rdi
	jmp	_ZL5__putPKcz
	.cfi_endproc
.LFE1603:
	.size	_Z16curser_set_styles, .-_Z16curser_set_styles
	.section	.rodata.str1.1
.LC4:
	.string	"\033[%d;%dH"
	.text
	.p2align 4
	.globl	_Z10curs_mv_yxii
	.type	_Z10curs_mv_yxii, @function
_Z10curs_mv_yxii:
.LFB1604:
	.cfi_startproc
	movl	%esi, %edx
	xorl	%eax, %eax
	movl	%edi, %esi
	leaq	.LC4(%rip), %rdi
	jmp	_ZL5__putPKcz
	.cfi_endproc
.LFE1604:
	.size	_Z10curs_mv_yxii, .-_Z10curs_mv_yxii
	.section	.rodata.str1.1
.LC5:
	.string	"\033[%dA"
	.text
	.p2align 4
	.globl	_Z10curs_mv_upi
	.type	_Z10curs_mv_upi, @function
_Z10curs_mv_upi:
.LFB1605:
	.cfi_startproc
	movl	%edi, %esi
	xorl	%eax, %eax
	leaq	.LC5(%rip), %rdi
	jmp	_ZL5__putPKcz
	.cfi_endproc
.LFE1605:
	.size	_Z10curs_mv_upi, .-_Z10curs_mv_upi
	.section	.rodata.str1.1
.LC6:
	.string	"\033[%dB"
	.text
	.p2align 4
	.globl	_Z12curs_mv_downi
	.type	_Z12curs_mv_downi, @function
_Z12curs_mv_downi:
.LFB1606:
	.cfi_startproc
	movl	%edi, %esi
	xorl	%eax, %eax
	leaq	.LC6(%rip), %rdi
	jmp	_ZL5__putPKcz
	.cfi_endproc
.LFE1606:
	.size	_Z12curs_mv_downi, .-_Z12curs_mv_downi
	.section	.rodata.str1.1
.LC7:
	.string	"\033[%dC"
	.text
	.p2align 4
	.globl	_Z13curs_mv_righti
	.type	_Z13curs_mv_righti, @function
_Z13curs_mv_righti:
.LFB1607:
	.cfi_startproc
	movl	%edi, %esi
	xorl	%eax, %eax
	leaq	.LC7(%rip), %rdi
	jmp	_ZL5__putPKcz
	.cfi_endproc
.LFE1607:
	.size	_Z13curs_mv_righti, .-_Z13curs_mv_righti
	.section	.rodata.str1.1
.LC8:
	.string	"\033[%dD"
	.text
	.p2align 4
	.globl	_Z12curs_mv_lefti
	.type	_Z12curs_mv_lefti, @function
_Z12curs_mv_lefti:
.LFB1608:
	.cfi_startproc
	movl	%edi, %esi
	xorl	%eax, %eax
	leaq	.LC8(%rip), %rdi
	jmp	_ZL5__putPKcz
	.cfi_endproc
.LFE1608:
	.size	_Z12curs_mv_lefti, .-_Z12curs_mv_lefti
	.section	.rodata.str1.1
.LC9:
	.base64	"GzcA"
	.text
	.p2align 4
	.globl	_Z12curs_yx_savev
	.type	_Z12curs_yx_savev, @function
_Z12curs_yx_savev:
.LFB1609:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	leaq	.LC9(%rip), %rdi
	xorl	%eax, %eax
	call	_ZL5__putPKcz
	movb	$1, _ZL24__curs_position_is_saved(%rip)
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE1609:
	.size	_Z12curs_yx_savev, .-_Z12curs_yx_savev
	.section	.rodata.str1.1
.LC10:
	.base64	"GzgA"
	.text
	.p2align 4
	.globl	_Z15curs_yx_restorev
	.type	_Z15curs_yx_restorev, @function
_Z15curs_yx_restorev:
.LFB1610:
	.cfi_startproc
	cmpb	$0, _ZL24__curs_position_is_saved(%rip)
	jne	.L68
	ret
	.p2align 4,,10
	.p2align 3
.L68:
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	leaq	.LC10(%rip), %rdi
	xorl	%eax, %eax
	call	_ZL5__putPKcz
	movb	$0, _ZL24__curs_position_is_saved(%rip)
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE1610:
	.size	_Z15curs_yx_restorev, .-_Z15curs_yx_restorev
	.section	.rodata.str1.1
.LC11:
	.string	"\033[?24h"
	.text
	.p2align 4
	.globl	_Z11screen_savev
	.type	_Z11screen_savev, @function
_Z11screen_savev:
.LFB1611:
	.cfi_startproc
	leaq	.LC11(%rip), %rdi
	xorl	%eax, %eax
	jmp	_ZL5__putPKcz
	.cfi_endproc
.LFE1611:
	.size	_Z11screen_savev, .-_Z11screen_savev
	.section	.rodata.str1.1
.LC12:
	.string	"\033[?24l"
	.text
	.p2align 4
	.globl	_Z14screen_restorev
	.type	_Z14screen_restorev, @function
_Z14screen_restorev:
.LFB1612:
	.cfi_startproc
	leaq	.LC12(%rip), %rdi
	xorl	%eax, %eax
	jmp	_ZL5__putPKcz
	.cfi_endproc
.LFE1612:
	.size	_Z14screen_restorev, .-_Z14screen_restorev
	.section	.rodata.str1.1
.LC13:
	.string	"\033[2J"
	.text
	.p2align 4
	.globl	_Z16screen_clear_allv
	.type	_Z16screen_clear_allv, @function
_Z16screen_clear_allv:
.LFB1613:
	.cfi_startproc
	leaq	.LC13(%rip), %rdi
	xorl	%eax, %eax
	jmp	_ZL5__putPKcz
	.cfi_endproc
.LFE1613:
	.size	_Z16screen_clear_allv, .-_Z16screen_clear_allv
	.section	.rodata.str1.1
.LC14:
	.string	"\033[0J"
	.text
	.p2align 4
	.globl	_Z19screen_clear_to_botv
	.type	_Z19screen_clear_to_botv, @function
_Z19screen_clear_to_botv:
.LFB1614:
	.cfi_startproc
	leaq	.LC14(%rip), %rdi
	xorl	%eax, %eax
	jmp	_ZL5__putPKcz
	.cfi_endproc
.LFE1614:
	.size	_Z19screen_clear_to_botv, .-_Z19screen_clear_to_botv
	.section	.rodata.str1.1
.LC15:
	.string	"\033[1J"
	.text
	.p2align 4
	.globl	_Z19screen_clear_to_topv
	.type	_Z19screen_clear_to_topv, @function
_Z19screen_clear_to_topv:
.LFB1615:
	.cfi_startproc
	leaq	.LC15(%rip), %rdi
	xorl	%eax, %eax
	jmp	_ZL5__putPKcz
	.cfi_endproc
.LFE1615:
	.size	_Z19screen_clear_to_topv, .-_Z19screen_clear_to_topv
	.section	.rodata.str1.1
.LC16:
	.string	"\033[2K"
	.text
	.p2align 4
	.globl	_Z14line_clear_allv
	.type	_Z14line_clear_allv, @function
_Z14line_clear_allv:
.LFB1616:
	.cfi_startproc
	leaq	.LC16(%rip), %rdi
	xorl	%eax, %eax
	jmp	_ZL5__putPKcz
	.cfi_endproc
.LFE1616:
	.size	_Z14line_clear_allv, .-_Z14line_clear_allv
	.section	.rodata.str1.1
.LC17:
	.string	"\033[1K"
	.text
	.p2align 4
	.globl	_Z19line_clear_to_startv
	.type	_Z19line_clear_to_startv, @function
_Z19line_clear_to_startv:
.LFB1617:
	.cfi_startproc
	leaq	.LC17(%rip), %rdi
	xorl	%eax, %eax
	jmp	_ZL5__putPKcz
	.cfi_endproc
.LFE1617:
	.size	_Z19line_clear_to_startv, .-_Z19line_clear_to_startv
	.section	.rodata.str1.1
.LC18:
	.string	"\033[0K"
	.text
	.p2align 4
	.globl	_Z17line_clear_to_endv
	.type	_Z17line_clear_to_endv, @function
_Z17line_clear_to_endv:
.LFB1618:
	.cfi_startproc
	leaq	.LC18(%rip), %rdi
	xorl	%eax, %eax
	jmp	_ZL5__putPKcz
	.cfi_endproc
.LFE1618:
	.size	_Z17line_clear_to_endv, .-_Z17line_clear_to_endv
	.p2align 4
	.globl	_Z7refreshv
	.type	_Z7refreshv, @function
_Z7refreshv:
.LFB1620:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movslq	_ZL18__obuf_write_idx__(%rip), %rdx
	leaq	_ZL14__out_buffer__(%rip), %rsi
	movl	$1, %edi
	call	write@PLT
	movl	$0, _ZL18__obuf_write_idx__(%rip)
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE1620:
	.size	_Z7refreshv, .-_Z7refreshv
	.section	.rodata.str1.1
.LC20:
	.string	"\033[?1049h"
.LC21:
	.base64	"G1s/MWgbPQA="
.LC22:
	.string	"\033[H"
	.text
	.p2align 4
	.globl	_Z7initwinv
	.type	_Z7initwinv, @function
_Z7initwinv:
.LFB1595:
	.cfi_startproc
	subq	$88, %rsp
	.cfi_def_cfa_offset 96
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	cmpb	$0, _ZL15__term_isinit__(%rip)
	je	.L89
.L80:
	xorl	%eax, %eax
.L79:
	movq	72(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L90
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L89:
	.cfi_restore_state
	xorl	%edi, %edi
	leaq	_ZL16__old_termattr__(%rip), %rsi
	call	tcgetattr@PLT
	cmpl	$-1, %eax
	je	.L83
	movdqa	_ZL16__old_termattr__(%rip), %xmm0
	movl	$256, %eax
	leaq	.LC20(%rip), %rdi
	movaps	%xmm0, (%rsp)
	movdqa	16+_ZL16__old_termattr__(%rip), %xmm0
	andl	$-12, 12(%rsp)
	movaps	%xmm0, 16(%rsp)
	movdqa	32+_ZL16__old_termattr__(%rip), %xmm0
	movw	%ax, 22(%rsp)
	xorl	%eax, %eax
	movaps	%xmm0, 32(%rsp)
	movdqu	44+_ZL16__old_termattr__(%rip), %xmm0
	movups	%xmm0, 44(%rsp)
	call	_ZL5__putPKcz
	xorl	%eax, %eax
	leaq	.LC1(%rip), %rdi
	call	_ZL5__putPKcz
	xorl	%eax, %eax
	leaq	.LC21(%rip), %rdi
	call	_ZL5__putPKcz
	leaq	.LC22(%rip), %rdi
	xorl	%eax, %eax
	call	_ZL5__putPKcz
	xorl	%esi, %esi
	xorl	%edi, %edi
	movq	%rsp, %rdx
	call	tcsetattr@PLT
	cmpl	$-1, %eax
	je	.L83
	leaq	_ZL11__sig_winchi(%rip), %rsi
	movl	$28, %edi
	call	signal@PLT
	movb	$0, _ZL21__winsize_is_change__(%rip)
	movb	$1, _ZL15__term_isinit__(%rip)
	call	_Z7refreshv@PLT
	jmp	.L80
	.p2align 4,,10
	.p2align 3
.L83:
	movl	$-1, %eax
	jmp	.L79
.L90:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE1595:
	.size	_Z7initwinv, .-_Z7initwinv
	.section	.rodata.str1.1
.LC23:
	.string	"\033[?1049l"
.LC24:
	.base64	"G1s/MWwbPgA="
.LC25:
	.string	"\033[0m"
.LC26:
	.string	"\033[?1000l"
.LC27:
	.string	"\033[?1002l"
.LC28:
	.string	"\033[?1003l"
.LC29:
	.string	"\033[?1006l"
	.text
	.p2align 4
	.globl	_Z6endwinv
	.type	_Z6endwinv, @function
_Z6endwinv:
.LFB1596:
	.cfi_startproc
	cmpb	$0, _ZL15__term_isinit__(%rip)
	jne	.L96
	ret
	.p2align 4,,10
	.p2align 3
.L96:
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	leaq	.LC23(%rip), %rdi
	xorl	%eax, %eax
	call	_ZL5__putPKcz
	leaq	.LC2(%rip), %rdi
	xorl	%eax, %eax
	call	_ZL5__putPKcz
	leaq	.LC24(%rip), %rdi
	xorl	%eax, %eax
	call	_ZL5__putPKcz
	leaq	.LC25(%rip), %rdi
	xorl	%eax, %eax
	call	_ZL5__putPKcz
	leaq	.LC26(%rip), %rdi
	xorl	%eax, %eax
	call	_ZL5__putPKcz
	leaq	.LC27(%rip), %rdi
	xorl	%eax, %eax
	call	_ZL5__putPKcz
	leaq	.LC28(%rip), %rdi
	xorl	%eax, %eax
	call	_ZL5__putPKcz
	leaq	.LC29(%rip), %rdi
	xorl	%eax, %eax
	call	_ZL5__putPKcz
	leaq	_ZL16__old_termattr__(%rip), %rdx
	xorl	%esi, %esi
	xorl	%edi, %edi
	call	tcsetattr@PLT
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	jmp	_Z7refreshv@PLT
	.cfi_endproc
.LFE1596:
	.size	_Z6endwinv, .-_Z6endwinv
	.p2align 4
	.globl	_Z8printstrPKcz
	.type	_Z8printstrPKcz, @function
_Z8printstrPKcz:
.LFB1622:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$4320, %rsp
	.cfi_def_cfa_offset 4352
	movq	%rsi, 4152(%rsp)
	movq	%rdx, 4160(%rsp)
	movq	%rcx, 4168(%rsp)
	movq	%r8, 4176(%rsp)
	movq	%r9, 4184(%rsp)
	testb	%al, %al
	je	.L98
	movaps	%xmm0, 4192(%rsp)
	movaps	%xmm1, 4208(%rsp)
	movaps	%xmm2, 4224(%rsp)
	movaps	%xmm3, 4240(%rsp)
	movaps	%xmm4, 4256(%rsp)
	movaps	%xmm5, 4272(%rsp)
	movaps	%xmm6, 4288(%rsp)
	movaps	%xmm7, 4304(%rsp)
.L98:
	movq	%fs:40, %rax
	movq	%rax, 4136(%rsp)
	xorl	%eax, %eax
	leaq	32(%rsp), %rbx
	movq	%rdi, %rdx
	leaq	8(%rsp), %rcx
	leaq	4352(%rsp), %rax
	movl	$4096, %esi
	movq	%rbx, %rdi
	movl	$8, 8(%rsp)
	movq	%rax, 16(%rsp)
	leaq	4144(%rsp), %rax
	movl	$48, 12(%rsp)
	movq	%rax, 24(%rsp)
	call	vsnprintf@PLT
	movslq	%eax, %rbp
	testq	%rbp, %rbp
	je	.L97
	movl	_ZL18__obuf_write_idx__(%rip), %edx
	addq	%rbx, %rbp
	leaq	_ZL14__out_buffer__(%rip), %r12
.L104:
	cmpl	$8191, %edx
	jle	.L100
	movl	$8192, %edx
	movq	%r12, %rsi
	movl	$1, %edi
	call	write@PLT
	movzbl	(%rbx), %eax
	movl	$1, _ZL18__obuf_write_idx__(%rip)
	movb	%al, (%r12)
	leaq	1(%rbx), %rax
	cmpq	%rax, %rbp
	je	.L97
	movzbl	1(%rbx), %eax
	addq	$2, %rbx
	movl	$2, _ZL18__obuf_write_idx__(%rip)
	movb	%al, 1(%r12)
	cmpq	%rbx, %rbp
	je	.L97
	movl	$2, %edx
.L100:
	movzbl	(%rbx), %eax
	movslq	%edx, %rcx
	cmpl	$8160, %edx
	jle	.L105
	cmpb	$27, %al
	je	.L102
.L105:
	addl	$1, %edx
	addq	$1, %rbx
	movb	%al, (%r12,%rcx)
	movl	%edx, _ZL18__obuf_write_idx__(%rip)
	cmpq	%rbx, %rbp
	jne	.L104
.L97:
	movq	4136(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L112
	addq	$4320, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L102:
	.cfi_restore_state
	movq	%rcx, %rdx
	movq	%r12, %rsi
	movl	$1, %edi
	addq	$1, %rbx
	call	write@PLT
	movzbl	-1(%rbx), %eax
	movl	$1, _ZL18__obuf_write_idx__(%rip)
	movb	%al, (%r12)
	cmpq	%rbx, %rbp
	je	.L97
	movzbl	(%rbx), %eax
	movl	$1, %edx
	movl	$1, %ecx
	jmp	.L105
.L112:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE1622:
	.size	_Z8printstrPKcz, .-_Z8printstrPKcz
	.p2align 4
	.globl	_Z8printstriiPKcz
	.type	_Z8printstriiPKcz, @function
_Z8printstriiPKcz:
.LFB1623:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rdx, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$4320, %rsp
	.cfi_def_cfa_offset 4352
	movq	%rcx, 4168(%rsp)
	movq	%r8, 4176(%rsp)
	movq	%r9, 4184(%rsp)
	testb	%al, %al
	je	.L114
	movaps	%xmm0, 4192(%rsp)
	movaps	%xmm1, 4208(%rsp)
	movaps	%xmm2, 4224(%rsp)
	movaps	%xmm3, 4240(%rsp)
	movaps	%xmm4, 4256(%rsp)
	movaps	%xmm5, 4272(%rsp)
	movaps	%xmm6, 4288(%rsp)
	movaps	%xmm7, 4304(%rsp)
.L114:
	movq	%fs:40, %rax
	movq	%rax, 4136(%rsp)
	xorl	%eax, %eax
	movl	%esi, %edx
	movl	%edi, %esi
	leaq	.LC4(%rip), %rdi
	leaq	32(%rsp), %rbx
	call	_ZL5__putPKcz
	movq	%rbp, %rdx
	leaq	8(%rsp), %rcx
	movq	%rbx, %rdi
	leaq	4352(%rsp), %rax
	movl	$4096, %esi
	movl	$24, 8(%rsp)
	movq	%rax, 16(%rsp)
	leaq	4144(%rsp), %rax
	movl	$48, 12(%rsp)
	movq	%rax, 24(%rsp)
	call	vsnprintf@PLT
	movslq	%eax, %rbp
	testq	%rbp, %rbp
	je	.L113
	movl	_ZL18__obuf_write_idx__(%rip), %edx
	addq	%rbx, %rbp
	leaq	_ZL14__out_buffer__(%rip), %r12
.L120:
	cmpl	$8191, %edx
	jle	.L116
	movl	$8192, %edx
	movq	%r12, %rsi
	movl	$1, %edi
	call	write@PLT
	movzbl	(%rbx), %eax
	movl	$1, _ZL18__obuf_write_idx__(%rip)
	movb	%al, (%r12)
	leaq	1(%rbx), %rax
	cmpq	%rax, %rbp
	je	.L113
	movzbl	1(%rbx), %eax
	addq	$2, %rbx
	movl	$2, _ZL18__obuf_write_idx__(%rip)
	movb	%al, 1(%r12)
	cmpq	%rbx, %rbp
	je	.L113
	movl	$2, %edx
.L116:
	movzbl	(%rbx), %eax
	movslq	%edx, %rcx
	cmpl	$8160, %edx
	jle	.L121
	cmpb	$27, %al
	je	.L118
.L121:
	addl	$1, %edx
	addq	$1, %rbx
	movb	%al, (%r12,%rcx)
	movl	%edx, _ZL18__obuf_write_idx__(%rip)
	cmpq	%rbx, %rbp
	jne	.L120
.L113:
	movq	4136(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L128
	addq	$4320, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L118:
	.cfi_restore_state
	movq	%rcx, %rdx
	movq	%r12, %rsi
	movl	$1, %edi
	addq	$1, %rbx
	call	write@PLT
	movzbl	-1(%rbx), %eax
	movl	$1, _ZL18__obuf_write_idx__(%rip)
	movb	%al, (%r12)
	cmpq	%rbx, %rbp
	je	.L113
	movzbl	(%rbx), %eax
	movl	$1, %edx
	movl	$1, %ecx
	jmp	.L121
.L128:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE1623:
	.size	_Z8printstriiPKcz, .-_Z8printstriiPKcz
	.p2align 4
	.globl	_Z6addstrPKcz
	.type	_Z6addstrPKcz, @function
_Z6addstrPKcz:
.LFB1624:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$4320, %rsp
	.cfi_def_cfa_offset 4352
	movq	%rsi, 4152(%rsp)
	movq	%rdx, 4160(%rsp)
	movq	%rcx, 4168(%rsp)
	movq	%r8, 4176(%rsp)
	movq	%r9, 4184(%rsp)
	testb	%al, %al
	je	.L130
	movaps	%xmm0, 4192(%rsp)
	movaps	%xmm1, 4208(%rsp)
	movaps	%xmm2, 4224(%rsp)
	movaps	%xmm3, 4240(%rsp)
	movaps	%xmm4, 4256(%rsp)
	movaps	%xmm5, 4272(%rsp)
	movaps	%xmm6, 4288(%rsp)
	movaps	%xmm7, 4304(%rsp)
.L130:
	movq	%fs:40, %rax
	movq	%rax, 4136(%rsp)
	xorl	%eax, %eax
	leaq	32(%rsp), %rbx
	movq	%rdi, %rdx
	leaq	8(%rsp), %rcx
	leaq	4352(%rsp), %rax
	movq	%rbx, %rdi
	movl	$4096, %esi
	movl	$8, 8(%rsp)
	movq	%rax, 16(%rsp)
	leaq	4144(%rsp), %rax
	movl	$48, 12(%rsp)
	movq	%rax, 24(%rsp)
	call	vsnprintf@PLT
	leaq	.LC9(%rip), %rdi
	movslq	%eax, %rbp
	xorl	%eax, %eax
	call	_ZL5__putPKcz
	testq	%rbp, %rbp
	je	.L133
	movl	_ZL18__obuf_write_idx__(%rip), %eax
	addq	%rbx, %rbp
	leaq	_ZL14__out_buffer__(%rip), %r12
.L136:
	cmpl	$8191, %eax
	jle	.L132
	movl	$8192, %edx
	movq	%r12, %rsi
	movl	$1, %edi
	call	write@PLT
	movzbl	(%rbx), %eax
	movl	$1, _ZL18__obuf_write_idx__(%rip)
	movb	%al, (%r12)
	leaq	1(%rbx), %rax
	cmpq	%rax, %rbp
	je	.L133
	movzbl	1(%rbx), %eax
	addq	$2, %rbx
	movl	$2, _ZL18__obuf_write_idx__(%rip)
	movb	%al, 1(%r12)
	cmpq	%rbx, %rbp
	je	.L133
	movl	$2, %eax
.L132:
	movzbl	(%rbx), %edx
	movslq	%eax, %rcx
	cmpl	$8160, %eax
	jle	.L137
	cmpb	$27, %dl
	je	.L134
.L137:
	addl	$1, %eax
	addq	$1, %rbx
	movb	%dl, (%r12,%rcx)
	movl	%eax, _ZL18__obuf_write_idx__(%rip)
	cmpq	%rbx, %rbp
	jne	.L136
.L133:
	xorl	%eax, %eax
	leaq	.LC10(%rip), %rdi
	call	_ZL5__putPKcz
	movq	4136(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L145
	addq	$4320, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L134:
	.cfi_restore_state
	movq	%rcx, %rdx
	movq	%r12, %rsi
	movl	$1, %edi
	addq	$1, %rbx
	call	write@PLT
	movzbl	-1(%rbx), %eax
	movl	$1, _ZL18__obuf_write_idx__(%rip)
	movb	%al, (%r12)
	cmpq	%rbx, %rbp
	je	.L133
	movzbl	(%rbx), %edx
	movl	$1, %eax
	movl	$1, %ecx
	jmp	.L137
.L145:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE1624:
	.size	_Z6addstrPKcz, .-_Z6addstrPKcz
	.p2align 4
	.globl	_Z6addstriiPKcz
	.type	_Z6addstriiPKcz, @function
_Z6addstriiPKcz:
.LFB1625:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rdx, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	subq	$4320, %rsp
	.cfi_def_cfa_offset 4352
	movq	%rcx, 4168(%rsp)
	movq	%r8, 4176(%rsp)
	movq	%r9, 4184(%rsp)
	testb	%al, %al
	je	.L147
	movaps	%xmm0, 4192(%rsp)
	movaps	%xmm1, 4208(%rsp)
	movaps	%xmm2, 4224(%rsp)
	movaps	%xmm3, 4240(%rsp)
	movaps	%xmm4, 4256(%rsp)
	movaps	%xmm5, 4272(%rsp)
	movaps	%xmm6, 4288(%rsp)
	movaps	%xmm7, 4304(%rsp)
.L147:
	movq	%fs:40, %rax
	movq	%rax, 4136(%rsp)
	xorl	%eax, %eax
	movl	%esi, %edx
	movl	%edi, %esi
	leaq	.LC4(%rip), %rdi
	leaq	32(%rsp), %rbx
	call	_ZL5__putPKcz
	movq	%rbp, %rdx
	movq	%rbx, %rdi
	leaq	8(%rsp), %rcx
	leaq	4352(%rsp), %rax
	movl	$4096, %esi
	movl	$24, 8(%rsp)
	movq	%rax, 16(%rsp)
	leaq	4144(%rsp), %rax
	movl	$48, 12(%rsp)
	movq	%rax, 24(%rsp)
	call	vsnprintf@PLT
	leaq	.LC9(%rip), %rdi
	movslq	%eax, %rbp
	xorl	%eax, %eax
	call	_ZL5__putPKcz
	testq	%rbp, %rbp
	je	.L150
	movl	_ZL18__obuf_write_idx__(%rip), %eax
	addq	%rbx, %rbp
	leaq	_ZL14__out_buffer__(%rip), %r12
.L153:
	cmpl	$8191, %eax
	jle	.L149
	movl	$8192, %edx
	movq	%r12, %rsi
	movl	$1, %edi
	call	write@PLT
	movzbl	(%rbx), %eax
	movl	$1, _ZL18__obuf_write_idx__(%rip)
	movb	%al, (%r12)
	leaq	1(%rbx), %rax
	cmpq	%rax, %rbp
	je	.L150
	movzbl	1(%rbx), %eax
	addq	$2, %rbx
	movl	$2, _ZL18__obuf_write_idx__(%rip)
	movb	%al, 1(%r12)
	cmpq	%rbx, %rbp
	je	.L150
	movl	$2, %eax
.L149:
	movzbl	(%rbx), %edx
	movslq	%eax, %rcx
	cmpl	$8160, %eax
	jle	.L154
	cmpb	$27, %dl
	je	.L151
.L154:
	addl	$1, %eax
	addq	$1, %rbx
	movb	%dl, (%r12,%rcx)
	movl	%eax, _ZL18__obuf_write_idx__(%rip)
	cmpq	%rbx, %rbp
	jne	.L153
.L150:
	xorl	%eax, %eax
	leaq	.LC10(%rip), %rdi
	call	_ZL5__putPKcz
	movq	4136(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L162
	addq	$4320, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L151:
	.cfi_restore_state
	movq	%rcx, %rdx
	movq	%r12, %rsi
	movl	$1, %edi
	addq	$1, %rbx
	call	write@PLT
	movzbl	-1(%rbx), %eax
	movl	$1, _ZL18__obuf_write_idx__(%rip)
	movb	%al, (%r12)
	cmpq	%rbx, %rbp
	je	.L150
	movzbl	(%rbx), %edx
	movl	$1, %eax
	movl	$1, %ecx
	jmp	.L154
.L162:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE1625:
	.size	_Z6addstriiPKcz, .-_Z6addstriiPKcz
	.p2align 4
	.globl	_Z6getkeyv
	.type	_Z6getkeyv, @function
_Z6getkeyv:
.LFB1626:
	.cfi_startproc
	subq	$72, %rsp
	.cfi_def_cfa_offset 80
	xorl	%edi, %edi
	movl	$14, %edx
	movq	%fs:40, %rsi
	movq	%rsi, 56(%rsp)
	leaq	26(%rsp), %rsi
	call	read@PLT
	cmpq	$-1, %rax
	je	.L164
	movb	$0, 26(%rsp,%rax)
.L165:
	movq	26(%rsp), %rax
	movq	%rax, 41(%rsp)
	movq	33(%rsp), %rax
	movq	%rax, 48(%rsp)
	movzbl	50(%rsp), %edx
	movzbl	49(%rsp), %eax
	movzbl	54(%rsp), %ecx
	salq	$8, %rdx
	movq	41(%rsp), %rsi
	orq	%rax, %rdx
	movzbl	51(%rsp), %eax
	salq	$40, %rcx
	salq	$16, %rax
	orq	%rdx, %rax
	movzbl	52(%rsp), %edx
	salq	$24, %rdx
	orq	%rax, %rdx
	movzbl	53(%rsp), %eax
	salq	$32, %rax
	orq	%rdx, %rax
	movzbl	55(%rsp), %edx
	orq	%rax, %rcx
	salq	$48, %rdx
	orq	%rcx, %rdx
	movq	56(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L168
	movq	%rsi, %rax
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L164:
	.cfi_restore_state
	movb	$0, 26(%rsp)
	jmp	.L165
.L168:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE1626:
	.size	_Z6getkeyv, .-_Z6getkeyv
	.p2align 4
	.globl	_ZeqRK5ezkeyc
	.type	_ZeqRK5ezkeyc, @function
_ZeqRK5ezkeyc:
.LFB1627:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movl	%esi, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%rdi, %rbx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	call	strlen@PLT
	cmpq	$1, %rax
	jne	.L172
	cmpb	%bpl, (%rbx)
	sete	%al
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L172:
	.cfi_restore_state
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE1627:
	.size	_ZeqRK5ezkeyc, .-_ZeqRK5ezkeyc
	.p2align 4
	.globl	_ZeqRK5ezkeyPKc
	.type	_ZeqRK5ezkeyPKc, @function
_ZeqRK5ezkeyPKc:
.LFB1628:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rdi, %rbx
	call	strlen@PLT
	movq	%rbp, %rdi
	movq	%rax, %r12
	call	strlen@PLT
	cmpq	%rax, %r12
	movl	$0, %eax
	jne	.L174
	movzbl	(%rbx), %edx
	testb	%dl, %dl
	je	.L178
	xorl	%eax, %eax
	jmp	.L176
	.p2align 5
	.p2align 4,,10
	.p2align 3
.L182:
	addq	$1, %rax
	movzbl	(%rbx,%rax), %edx
	testb	%dl, %dl
	je	.L178
.L176:
	cmpb	%dl, 0(%rbp,%rax)
	je	.L182
	xorl	%eax, %eax
.L174:
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L178:
	.cfi_restore_state
	popq	%rbx
	.cfi_def_cfa_offset 24
	movl	$1, %eax
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE1628:
	.size	_ZeqRK5ezkeyPKc, .-_ZeqRK5ezkeyPKc
	.section	.rodata.str1.1
.LC30:
	.string	"\033[?%dh"
.LC31:
	.string	"\033[?1006h"
	.text
	.p2align 4
	.globl	_Z9use_mousebs
	.type	_Z9use_mousebs, @function
_Z9use_mousebs:
.LFB1629:
	.cfi_startproc
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	testb	%dil, %dil
	je	.L186
	movswl	%si, %esi
	leaq	.LC30(%rip), %rdi
	xorl	%eax, %eax
	call	_ZL5__putPKcz
	leaq	.LC31(%rip), %rdi
	xorl	%eax, %eax
	call	_ZL5__putPKcz
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	_Z7refreshv@PLT
	.p2align 4,,10
	.p2align 3
.L186:
	.cfi_restore_state
	leaq	.LC26(%rip), %rdi
	xorl	%eax, %eax
	call	_ZL5__putPKcz
	leaq	.LC27(%rip), %rdi
	xorl	%eax, %eax
	call	_ZL5__putPKcz
	leaq	.LC28(%rip), %rdi
	xorl	%eax, %eax
	call	_ZL5__putPKcz
	leaq	.LC29(%rip), %rdi
	xorl	%eax, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	jmp	_ZL5__putPKcz
	.cfi_endproc
.LFE1629:
	.size	_Z9use_mousebs, .-_Z9use_mousebs
	.section	.rodata.str1.1
.LC32:
	.string	"\033[<%d;%d;%d%c"
	.text
	.p2align 4
	.globl	_Z15get_mouse_stateR5ezkeyRiS1_
	.type	_Z15get_mouse_stateR5ezkeyRiS1_, @function
_Z15get_mouse_stateR5ezkeyRiS1_:
.LFB1630:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%rdx, %rcx
	xorl	%eax, %eax
	movq	%fs:40, %r8
	movq	%r8, 8(%rsp)
	movq	%rsi, %r8
	movl	$-1, (%rsi)
	leaq	3(%rsp), %r9
	leaq	.LC32(%rip), %rsi
	movl	$-1, (%rdx)
	leaq	4(%rsp), %rdx
	movl	$-1, 4(%rsp)
	call	__isoc23_sscanf@PLT
	movl	4(%rsp), %eax
	cmpb	$109, 3(%rsp)
	leal	3(%rax), %edx
	cmove	%edx, %eax
	movq	8(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L191
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L191:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE1630:
	.size	_Z15get_mouse_stateR5ezkeyRiS1_, .-_Z15get_mouse_stateR5ezkeyRiS1_
	.section	.rodata.str1.1
.LC33:
	.string	"vector::_M_realloc_append"
	.section	.text.unlikely,"ax",@progbits
.LCOLDB34:
	.text
.LHOTB34:
	.p2align 4
	.globl	_Z14init_usr_colorsss
	.type	_Z14init_usr_colorsss, @function
_Z14init_usr_colorsss:
.LFB1653:
	.cfi_startproc
	movl	%esi, %eax
	movl	%edx, %ecx
	movq	16+_ZL18__usr_color_list__(%rip), %rsi
	movq	8+_ZL18__usr_color_list__(%rip), %rdx
	movq	_ZL18__usr_color_list__(%rip), %r8
	cmpq	%rsi, %rdx
	je	.L193
	movw	%ax, 2(%rdx)
	addq	$6, %rdx
	movw	%di, -6(%rdx)
	movw	%cx, -2(%rdx)
	movq	%rdx, 8+_ZL18__usr_color_list__(%rip)
	subq	%r8, %rdx
	sarq	%rdx
	imull	$-1431655765, %edx, %edx
	leal	-1(%rdx), %eax
	ret
	.p2align 4,,10
	.p2align 3
.L193:
	movq	%rdx, %r10
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	movl	%edi, %r14d
	movl	%eax, %r11d
	movabsq	$-6148914691236517205, %rax
	subq	%r8, %r10
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movq	%r10, %rdi
	sarq	%rdi
	imulq	%rax, %rdi
	subq	$56, %rsp
	.cfi_def_cfa_offset 80
	movabsq	$1537228672809129301, %rax
	cmpq	%rax, %rdi
	je	.L204
	testq	%rdi, %rdi
	movl	$1, %eax
	movl	%ecx, 44(%rsp)
	cmovne	%rdi, %rax
	movl	%r11d, 40(%rsp)
	movq	%r8, 32(%rsp)
	addq	%rdi, %rax
	movq	%r10, 24(%rsp)
	movabsq	$1537228672809129301, %rdi
	cmpq	%rdi, %rax
	movq	%rsi, 16(%rsp)
	cmova	%rdi, %rax
	movq	%rdx, 8(%rsp)
	leaq	(%rax,%rax,2), %rax
	leaq	(%rax,%rax), %rdi
	leaq	(%rax,%rax), %rbx
	call	_Znwm@PLT
	movq	8(%rsp), %rdx
	movq	32(%rsp), %r8
	movq	24(%rsp), %r10
	movl	40(%rsp), %r11d
	movq	%rax, %r9
	movl	44(%rsp), %ecx
	cmpq	%r8, %rdx
	movq	16(%rsp), %rsi
	movw	%r14w, (%rax,%r10)
	movw	%r11w, 2(%rax,%r10)
	movw	%cx, 4(%rax,%r10)
	je	.L199
	movq	%rax, %rcx
	movq	%r8, %rax
	.p2align 5
	.p2align 4
	.p2align 3
.L197:
	movl	(%rax), %edi
	addq	$6, %rax
	addq	$6, %rcx
	movl	%edi, -6(%rcx)
	movzwl	-2(%rax), %edi
	movw	%di, -2(%rcx)
	cmpq	%rax, %rdx
	jne	.L197
	subq	$6, %rdx
	subq	%r8, %rdx
	shrq	%rdx
	leaq	6(%r9,%rdx,2), %rdx
.L196:
	addq	$6, %rdx
	testq	%r8, %r8
	je	.L198
	subq	%r8, %rsi
	movq	%r8, %rdi
	movq	%r9, 16(%rsp)
	movq	%rdx, 8(%rsp)
	call	_ZdlPvm@PLT
	movq	16(%rsp), %r9
	movq	8(%rsp), %rdx
.L198:
	movq	%rdx, 8+_ZL18__usr_color_list__(%rip)
	subq	%r9, %rdx
	leaq	(%r9,%rbx), %rax
	sarq	%rdx
	movq	%rax, 16+_ZL18__usr_color_list__(%rip)
	imull	$-1431655765, %edx, %edx
	movq	%r9, _ZL18__usr_color_list__(%rip)
	addq	$56, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	leal	-1(%rdx), %eax
	ret
	.p2align 4,,10
	.p2align 3
.L199:
	.cfi_restore_state
	movq	%rax, %rdx
	jmp	.L196
	.cfi_endproc
	.section	.text.unlikely
	.cfi_startproc
	.type	_Z14init_usr_colorsss.cold, @function
_Z14init_usr_colorsss.cold:
.LFSB1653:
.L204:
	.cfi_def_cfa_offset 80
	.cfi_offset 3, -24
	.cfi_offset 14, -16
	leaq	.LC33(%rip), %rdi
	call	_ZSt20__throw_length_errorPKc@PLT
	.cfi_endproc
.LFE1653:
	.text
	.size	_Z14init_usr_colorsss, .-_Z14init_usr_colorsss
	.section	.text.unlikely
	.size	_Z14init_usr_colorsss.cold, .-_Z14init_usr_colorsss.cold
.LCOLDE34:
	.text
.LHOTE34:
	.section	.rodata.str1.1
.LC35:
	.string	"\033[%dm"
.LC36:
	.string	"\033[2%dm"
	.text
	.p2align 4
	.globl	_Z13attrset_stylesb
	.type	_Z13attrset_stylesb, @function
_Z13attrset_stylesb:
.LFB1658:
	.cfi_startproc
	testb	%sil, %sil
	je	.L209
	movswl	%di, %esi
	xorl	%eax, %eax
	leaq	.LC35(%rip), %rdi
	jmp	_ZL5__putPKcz
	.p2align 4,,10
	.p2align 3
.L209:
	movl	$2, %eax
	cmpw	%ax, %di
	cmovge	%edi, %eax
	leaq	.LC36(%rip), %rdi
	movswl	%ax, %esi
	xorl	%eax, %eax
	jmp	_ZL5__putPKcz
	.cfi_endproc
.LFE1658:
	.size	_Z13attrset_stylesb, .-_Z13attrset_stylesb
	.section	.rodata.str1.1
.LC37:
	.string	"\033[%d;%dm"
	.text
	.p2align 4
	.globl	_Z15attrset_color16ss
	.type	_Z15attrset_color16ss, @function
_Z15attrset_color16ss:
.LFB1659:
	.cfi_startproc
	movswl	%si, %edx
	xorl	%eax, %eax
	movswl	%di, %esi
	addl	$10, %edx
	leaq	.LC37(%rip), %rdi
	jmp	_ZL5__putPKcz
	.cfi_endproc
.LFE1659:
	.size	_Z15attrset_color16ss, .-_Z15attrset_color16ss
	.section	.rodata.str1.1
.LC38:
	.string	"\033[38;5;%dm"
.LC39:
	.string	"\033[48;5;%dm"
	.text
	.p2align 4
	.globl	_Z16attrset_color256ss
	.type	_Z16attrset_color256ss, @function
_Z16attrset_color256ss:
.LFB1660:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movl	%esi, %edx
	cmpw	$-1, %di
	je	.L212
	movl	%esi, 12(%rsp)
	xorl	%eax, %eax
	movswl	%di, %esi
	leaq	.LC38(%rip), %rdi
	call	_ZL5__putPKcz
	movl	12(%rsp), %edx
.L212:
	cmpw	$-1, %dx
	jne	.L215
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L215:
	.cfi_restore_state
	movswl	%dx, %esi
	leaq	.LC39(%rip), %rdi
	xorl	%eax, %eax
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	jmp	_ZL5__putPKcz
	.cfi_endproc
.LFE1660:
	.size	_Z16attrset_color256ss, .-_Z16attrset_color256ss
	.section	.rodata.str1.1
.LC40:
	.string	"\033[38;2;%d;%d;%dm"
.LC41:
	.string	"\033[48;2;%d;%d;%dm"
	.text
	.p2align 4
	.globl	_Z17attrset_color_usrii
	.type	_Z17attrset_color_usrii, @function
_Z17attrset_color_usrii:
.LFB1661:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movslq	%esi, %r8
	cmpl	$-1, %edi
	je	.L217
	movq	_ZL18__usr_color_list__(%rip), %rax
	movslq	%edi, %rdi
	movl	%r8d, 12(%rsp)
	leaq	(%rdi,%rdi,2), %rdx
	leaq	.LC40(%rip), %rdi
	leaq	(%rax,%rdx,2), %rax
	movswl	4(%rax), %ecx
	movswl	2(%rax), %edx
	movswl	(%rax), %esi
	xorl	%eax, %eax
	call	_ZL5__putPKcz
	movslq	12(%rsp), %r8
.L217:
	cmpl	$-1, %r8d
	jne	.L223
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L223:
	.cfi_restore_state
	movq	_ZL18__usr_color_list__(%rip), %rax
	leaq	(%r8,%r8,2), %rdx
	leaq	.LC41(%rip), %rdi
	leaq	(%rax,%rdx,2), %rax
	movswl	4(%rax), %ecx
	movswl	2(%rax), %edx
	movswl	(%rax), %esi
	xorl	%eax, %eax
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	jmp	_ZL5__putPKcz
	.cfi_endproc
.LFE1661:
	.size	_Z17attrset_color_usrii, .-_Z17attrset_color_usrii
	.p2align 4
	.globl	_Z24attrset_color_usr_rawRGBssssss
	.type	_Z24attrset_color_usr_rawRGBssssss, @function
_Z24attrset_color_usr_rawRGBssssss:
.LFB1662:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	cmpw	$-1, %si
	movl	%ecx, %r10d
	setne	%cl
	cmpw	$-1, %dx
	setne	%al
	testb	%al, %cl
	je	.L225
	cmpw	$-1, %di
	jne	.L240
.L225:
	cmpw	$-1, %r8w
	setne	%dl
	cmpw	$-1, %r9w
	setne	%al
	testb	%al, %dl
	je	.L224
	cmpw	$-1, %r10w
	jne	.L241
.L224:
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L241:
	.cfi_restore_state
	movswl	%r9w, %ecx
	movswl	%r8w, %edx
	movswl	%r10w, %esi
	xorl	%eax, %eax
	leaq	.LC41(%rip), %rdi
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	jmp	_ZL5__putPKcz
	.p2align 4,,10
	.p2align 3
.L240:
	.cfi_restore_state
	movswl	%dx, %ecx
	xorl	%eax, %eax
	movswl	%si, %edx
	movswl	%di, %esi
	leaq	.LC40(%rip), %rdi
	movl	%r9d, 12(%rsp)
	movl	%r8d, 8(%rsp)
	movl	%r10d, 4(%rsp)
	call	_ZL5__putPKcz
	movl	12(%rsp), %r9d
	movl	8(%rsp), %r8d
	movl	4(%rsp), %r10d
	jmp	.L225
	.cfi_endproc
.LFE1662:
	.size	_Z24attrset_color_usr_rawRGBssssss, .-_Z24attrset_color_usr_rawRGBssssss
	.p2align 4
	.globl	_Z14attr_reset_allv
	.type	_Z14attr_reset_allv, @function
_Z14attr_reset_allv:
.LFB1663:
	.cfi_startproc
	leaq	.LC25(%rip), %rdi
	xorl	%eax, %eax
	jmp	_ZL5__putPKcz
	.cfi_endproc
.LFE1663:
	.size	_Z14attr_reset_allv, .-_Z14attr_reset_allv
	.p2align 4
	.globl	_Z10new_windowiiii
	.type	_Z10new_windowiiii, @function
_Z10new_windowiiii:
.LFB1664:
	.cfi_startproc
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	movl	%esi, %r14d
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	movl	%ecx, %r13d
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	movl	%edx, %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movl	%edi, %ebx
	subq	$16, %rsp
	.cfi_def_cfa_offset 64
	call	_Z9getsize_yv@PLT
	movzwl	%ax, %ebp
	call	_Z9getsize_xv@PLT
	testl	%ebx, %ebx
	jle	.L247
	cmpl	%ebx, %ebp
	jl	.L247
	movzwl	%ax, %edx
	testl	%r14d, %r14d
	jle	.L247
	cmpl	%r14d, %edx
	jl	.L247
	leal	-1(%rbx,%r12), %eax
	cmpl	%ebp, %eax
	jg	.L247
	leal	-1(%r14,%r13), %ecx
	xorl	%eax, %eax
	cmpl	%edx, %ecx
	jg	.L243
	movd	%r14d, %xmm2
	movd	%r13d, %xmm3
	movd	%ebx, %xmm1
	movl	$24, %edi
	movd	%r12d, %xmm0
	punpckldq	%xmm2, %xmm1
	punpckldq	%xmm3, %xmm0
	punpcklqdq	%xmm1, %xmm0
	movaps	%xmm0, (%rsp)
	call	_Znwm@PLT
	movq	.LC42(%rip), %rdx
	movdqa	(%rsp), %xmm0
	movq	%rdx, 16(%rax)
	movups	%xmm0, (%rax)
.L243:
	addq	$16, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L247:
	.cfi_restore_state
	addq	$16, %rsp
	.cfi_def_cfa_offset 48
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE1664:
	.size	_Z10new_windowiiii, .-_Z10new_windowiiii
	.p2align 4
	.globl	_Z10del_windowP6WINDOW
	.type	_Z10del_windowP6WINDOW, @function
_Z10del_windowP6WINDOW:
.LFB1668:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L250
	movl	$24, %esi
	jmp	_ZdlPvm@PLT
	.p2align 4,,10
	.p2align 3
.L250:
	ret
	.cfi_endproc
.LFE1668:
	.size	_Z10del_windowP6WINDOW, .-_Z10del_windowP6WINDOW
	.p2align 4
	.globl	_Z10wgetsize_yP6WINDOW
	.type	_Z10wgetsize_yP6WINDOW, @function
_Z10wgetsize_yP6WINDOW:
.LFB1669:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L254
	movl	(%rdi), %eax
	ret
	.p2align 4,,10
	.p2align 3
.L254:
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE1669:
	.size	_Z10wgetsize_yP6WINDOW, .-_Z10wgetsize_yP6WINDOW
	.p2align 4
	.globl	_Z10wgetsize_xP6WINDOW
	.type	_Z10wgetsize_xP6WINDOW, @function
_Z10wgetsize_xP6WINDOW:
.LFB1670:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L257
	movl	4(%rdi), %eax
	ret
	.p2align 4,,10
	.p2align 3
.L257:
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE1670:
	.size	_Z10wgetsize_xP6WINDOW, .-_Z10wgetsize_xP6WINDOW
	.p2align 4
	.globl	_Z10wgetcurs_yP6WINDOW
	.type	_Z10wgetcurs_yP6WINDOW, @function
_Z10wgetcurs_yP6WINDOW:
.LFB1671:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L260
	movl	16(%rdi), %eax
	ret
	.p2align 4,,10
	.p2align 3
.L260:
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE1671:
	.size	_Z10wgetcurs_yP6WINDOW, .-_Z10wgetcurs_yP6WINDOW
	.p2align 4
	.globl	_Z10wgetcurs_xP6WINDOW
	.type	_Z10wgetcurs_xP6WINDOW, @function
_Z10wgetcurs_xP6WINDOW:
.LFB1672:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L263
	movl	20(%rdi), %eax
	ret
	.p2align 4,,10
	.p2align 3
.L263:
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE1672:
	.size	_Z10wgetcurs_xP6WINDOW, .-_Z10wgetcurs_xP6WINDOW
	.p2align 4
	.globl	_Z15wget_position_yP6WINDOW
	.type	_Z15wget_position_yP6WINDOW, @function
_Z15wget_position_yP6WINDOW:
.LFB1673:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L266
	movl	8(%rdi), %eax
	ret
	.p2align 4,,10
	.p2align 3
.L266:
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE1673:
	.size	_Z15wget_position_yP6WINDOW, .-_Z15wget_position_yP6WINDOW
	.p2align 4
	.globl	_Z15wget_position_xP6WINDOW
	.type	_Z15wget_position_xP6WINDOW, @function
_Z15wget_position_xP6WINDOW:
.LFB1674:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L269
	movl	12(%rdi), %eax
	ret
	.p2align 4,,10
	.p2align 3
.L269:
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE1674:
	.size	_Z15wget_position_xP6WINDOW, .-_Z15wget_position_xP6WINDOW
	.p2align 4
	.globl	_Z9wprintstrP6WINDOWPKcz
	.type	_Z9wprintstrP6WINDOWPKcz, @function
_Z9wprintstrP6WINDOWPKcz:
.LFB1676:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$4344, %rsp
	.cfi_def_cfa_offset 4400
	movq	%rdx, 4176(%rsp)
	movq	%rcx, 4184(%rsp)
	movq	%r8, 4192(%rsp)
	movq	%r9, 4200(%rsp)
	testb	%al, %al
	je	.L271
	movaps	%xmm0, 4208(%rsp)
	movaps	%xmm1, 4224(%rsp)
	movaps	%xmm2, 4240(%rsp)
	movaps	%xmm3, 4256(%rsp)
	movaps	%xmm4, 4272(%rsp)
	movaps	%xmm5, 4288(%rsp)
	movaps	%xmm6, 4304(%rsp)
	movaps	%xmm7, 4320(%rsp)
.L271:
	movq	%fs:40, %rax
	movq	%rax, 4152(%rsp)
	xorl	%eax, %eax
	testq	%rbx, %rbx
	je	.L270
	movl	20(%rbx), %edx
	movl	16(%rbx), %esi
	leaq	.LC4(%rip), %rdi
	addl	12(%rbx), %edx
	addl	8(%rbx), %esi
	subl	$1, %edx
	subl	$1, %esi
	call	_ZL5__putPKcz
	leaq	4400(%rsp), %rax
	movq	%rbp, %rdx
	leaq	24(%rsp), %rcx
	movq	%rax, 32(%rsp)
	leaq	4160(%rsp), %rax
	movl	$4096, %esi
	movq	%rax, 40(%rsp)
	leaq	48(%rsp), %rax
	movq	%rax, %rdi
	movl	$16, 24(%rsp)
	movl	$48, 28(%rsp)
	movq	%rax, 8(%rsp)
	call	vsnprintf@PLT
	movl	20(%rbx), %ecx
	movl	4(%rbx), %ebp
	movl	%eax, 4(%rsp)
	leal	-1(%rcx,%rax), %eax
	cltd
	idivl	%ebp
	movl	%eax, %r12d
	testl	%eax, %eax
	je	.L315
	js	.L270
	movl	$0, (%rsp)
	subl	%ecx, %ebp
	leaq	_ZL14__out_buffer__(%rip), %r14
	addl	$1, %ebp
	.p2align 4
	.p2align 3
.L292:
	movslq	%ebp, %r8
	testq	%r8, %r8
	je	.L284
	movslq	(%rsp), %rcx
	movq	8(%rsp), %rdi
	movl	_ZL18__obuf_write_idx__(%rip), %eax
	leaq	(%rdi,%rcx), %r13
	leaq	(%r8,%r13), %r15
.L285:
	cmpl	$8191, %eax
	jle	.L282
	movl	$8192, %edx
	movq	%r14, %rsi
	movl	$1, %edi
	call	write@PLT
	movzbl	0(%r13), %eax
	movl	$1, _ZL18__obuf_write_idx__(%rip)
	movb	%al, (%r14)
	leaq	1(%r13), %rax
	cmpq	%r15, %rax
	je	.L284
	movzbl	1(%r13), %eax
	addq	$2, %r13
	movl	$2, _ZL18__obuf_write_idx__(%rip)
	movb	%al, 1(%r14)
	cmpq	%r13, %r15
	je	.L284
	movl	$2, %eax
.L282:
	movzbl	0(%r13), %edx
	movslq	%eax, %rsi
	cmpl	$8160, %eax
	jle	.L286
	cmpb	$27, %dl
	je	.L316
.L286:
	addl	$1, %eax
	addq	$1, %r13
	movb	%dl, (%r14,%rsi)
	movl	%eax, _ZL18__obuf_write_idx__(%rip)
	cmpq	%r13, %r15
	jne	.L285
.L284:
	movl	16(%rbx), %eax
	movl	(%rbx), %ecx
	movl	12(%rbx), %edx
	movl	8(%rbx), %esi
	cmpl	%ecx, %eax
	jge	.L317
	addl	$1, %eax
	leaq	.LC4(%rip), %rdi
	movl	$1, 20(%rbx)
	movl	%eax, 16(%rbx)
	leal	-1(%rax,%rsi), %esi
	xorl	%eax, %eax
	subl	%ebp, 4(%rsp)
	call	_ZL5__putPKcz
	subl	$1, %r12d
	jne	.L318
	movl	4(%rsp), %eax
.L289:
	addl	%ebp, (%rsp)
	movl	%eax, %ebp
	jmp	.L292
.L317:
	addl	4(%rbx), %edx
	leal	-1(%rcx,%rsi), %esi
	leaq	.LC4(%rip), %rdi
	xorl	%eax, %eax
	subl	$1, %edx
	call	_ZL5__putPKcz
	movq	(%rbx), %rax
	movq	%rax, 16(%rbx)
.L270:
	movq	4152(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L319
	addq	$4344, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L315:
	.cfi_restore_state
	movslq	4(%rsp), %rbp
	testq	%rbp, %rbp
	je	.L270
	movq	8(%rsp), %r14
	movl	_ZL18__obuf_write_idx__(%rip), %eax
	leaq	_ZL14__out_buffer__(%rip), %rbx
	addq	%r14, %rbp
.L277:
	cmpl	$8191, %eax
	jle	.L274
	movl	$8192, %edx
	movq	%rbx, %rsi
	movl	$1, %edi
	call	write@PLT
	movzbl	(%r14), %eax
	movl	$1, _ZL18__obuf_write_idx__(%rip)
	movb	%al, (%rbx)
	leaq	1(%r14), %rax
	cmpq	%rax, %rbp
	je	.L270
	movzbl	1(%r14), %eax
	addq	$2, %r14
	movl	$2, _ZL18__obuf_write_idx__(%rip)
	movb	%al, 1(%rbx)
	cmpq	%r14, %rbp
	je	.L270
	movl	$2, %eax
.L274:
	movzbl	(%r14), %edx
	movslq	%eax, %rcx
	cmpb	$27, %dl
	jne	.L278
	cmpl	$8160, %eax
	jg	.L275
.L278:
	addl	$1, %eax
	addq	$1, %r14
	movb	%dl, (%rbx,%rcx)
	movl	%eax, _ZL18__obuf_write_idx__(%rip)
	cmpq	%rbp, %r14
	jne	.L277
	jmp	.L270
	.p2align 4,,10
	.p2align 3
.L316:
	movq	%rsi, %rdx
	movl	$1, %edi
	movq	%r14, %rsi
	addq	$1, %r13
	call	write@PLT
	movzbl	-1(%r13), %eax
	movl	$1, _ZL18__obuf_write_idx__(%rip)
	movb	%al, (%r14)
	cmpq	%r13, %r15
	je	.L284
	movzbl	0(%r13), %edx
	movl	$1, %eax
	movl	$1, %esi
	jmp	.L286
	.p2align 4,,10
	.p2align 3
.L318:
	cmpl	$-1, %r12d
	je	.L270
	movl	4(%rbx), %eax
	jmp	.L289
.L275:
	movq	%rcx, %rdx
	movq	%rbx, %rsi
	movl	$1, %edi
	addq	$1, %r14
	call	write@PLT
	movzbl	-1(%r14), %eax
	movl	$1, _ZL18__obuf_write_idx__(%rip)
	movb	%al, (%rbx)
	cmpq	%rbp, %r14
	je	.L270
	movzbl	(%r14), %edx
	movl	$1, %eax
	movl	$1, %ecx
	jmp	.L278
.L319:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE1676:
	.size	_Z9wprintstrP6WINDOWPKcz, .-_Z9wprintstrP6WINDOWPKcz
	.p2align 4
	.globl	_Z9wprintstrP6WINDOWiiPKcz
	.type	_Z9wprintstrP6WINDOWiiPKcz, @function
_Z9wprintstrP6WINDOWiiPKcz:
.LFB1677:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rcx, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$4344, %rsp
	.cfi_def_cfa_offset 4400
	movq	%r8, 4192(%rsp)
	movq	%r9, 4200(%rsp)
	testb	%al, %al
	je	.L321
	movaps	%xmm0, 4208(%rsp)
	movaps	%xmm1, 4224(%rsp)
	movaps	%xmm2, 4240(%rsp)
	movaps	%xmm3, 4256(%rsp)
	movaps	%xmm4, 4272(%rsp)
	movaps	%xmm5, 4288(%rsp)
	movaps	%xmm6, 4304(%rsp)
	movaps	%xmm7, 4320(%rsp)
.L321:
	movq	%fs:40, %rax
	movq	%rax, 4152(%rsp)
	xorl	%eax, %eax
	testq	%rbx, %rbx
	je	.L320
	movl	%esi, 16(%rbx)
	addl	8(%rbx), %esi
	leaq	.LC4(%rip), %rdi
	movl	%edx, 20(%rbx)
	addl	12(%rbx), %edx
	subl	$1, %esi
	subl	$1, %edx
	call	_ZL5__putPKcz
	leaq	4400(%rsp), %rax
	movq	%rbp, %rdx
	leaq	24(%rsp), %rcx
	movq	%rax, 32(%rsp)
	leaq	4160(%rsp), %rax
	movl	$4096, %esi
	movq	%rax, 40(%rsp)
	leaq	48(%rsp), %rax
	movq	%rax, %rdi
	movl	$32, 24(%rsp)
	movl	$48, 28(%rsp)
	movq	%rax, 8(%rsp)
	call	vsnprintf@PLT
	movl	20(%rbx), %ecx
	movl	4(%rbx), %ebp
	movl	%eax, 4(%rsp)
	leal	-1(%rcx,%rax), %eax
	cltd
	idivl	%ebp
	movl	%eax, %r12d
	testl	%eax, %eax
	je	.L365
	js	.L320
	movl	$0, (%rsp)
	subl	%ecx, %ebp
	leaq	_ZL14__out_buffer__(%rip), %r14
	addl	$1, %ebp
	.p2align 4
	.p2align 3
.L342:
	movslq	%ebp, %r8
	testq	%r8, %r8
	je	.L334
	movslq	(%rsp), %rcx
	movq	8(%rsp), %rdi
	movl	_ZL18__obuf_write_idx__(%rip), %eax
	leaq	(%rdi,%rcx), %r13
	leaq	(%r8,%r13), %r15
.L335:
	cmpl	$8191, %eax
	jle	.L332
	movl	$8192, %edx
	movq	%r14, %rsi
	movl	$1, %edi
	call	write@PLT
	movzbl	0(%r13), %eax
	movl	$1, _ZL18__obuf_write_idx__(%rip)
	movb	%al, (%r14)
	leaq	1(%r13), %rax
	cmpq	%r15, %rax
	je	.L334
	movzbl	1(%r13), %eax
	addq	$2, %r13
	movl	$2, _ZL18__obuf_write_idx__(%rip)
	movb	%al, 1(%r14)
	cmpq	%r13, %r15
	je	.L334
	movl	$2, %eax
.L332:
	movzbl	0(%r13), %edx
	movslq	%eax, %rsi
	cmpl	$8160, %eax
	jle	.L336
	cmpb	$27, %dl
	je	.L366
.L336:
	addl	$1, %eax
	addq	$1, %r13
	movb	%dl, (%r14,%rsi)
	movl	%eax, _ZL18__obuf_write_idx__(%rip)
	cmpq	%r13, %r15
	jne	.L335
.L334:
	movl	16(%rbx), %eax
	movl	(%rbx), %ecx
	movl	12(%rbx), %edx
	movl	8(%rbx), %esi
	cmpl	%ecx, %eax
	jge	.L367
	addl	$1, %eax
	leaq	.LC4(%rip), %rdi
	movl	$1, 20(%rbx)
	movl	%eax, 16(%rbx)
	leal	-1(%rax,%rsi), %esi
	xorl	%eax, %eax
	subl	%ebp, 4(%rsp)
	call	_ZL5__putPKcz
	subl	$1, %r12d
	jne	.L368
	movl	4(%rsp), %eax
.L339:
	addl	%ebp, (%rsp)
	movl	%eax, %ebp
	jmp	.L342
.L367:
	addl	4(%rbx), %edx
	leal	-1(%rcx,%rsi), %esi
	leaq	.LC4(%rip), %rdi
	xorl	%eax, %eax
	subl	$1, %edx
	call	_ZL5__putPKcz
	movq	(%rbx), %rax
	movq	%rax, 16(%rbx)
.L320:
	movq	4152(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L369
	addq	$4344, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L365:
	.cfi_restore_state
	movslq	4(%rsp), %rbp
	testq	%rbp, %rbp
	je	.L320
	movq	8(%rsp), %r14
	movl	_ZL18__obuf_write_idx__(%rip), %eax
	leaq	_ZL14__out_buffer__(%rip), %rbx
	addq	%r14, %rbp
.L327:
	cmpl	$8191, %eax
	jle	.L324
	movl	$8192, %edx
	movq	%rbx, %rsi
	movl	$1, %edi
	call	write@PLT
	movzbl	(%r14), %eax
	movl	$1, _ZL18__obuf_write_idx__(%rip)
	movb	%al, (%rbx)
	leaq	1(%r14), %rax
	cmpq	%rax, %rbp
	je	.L320
	movzbl	1(%r14), %eax
	addq	$2, %r14
	movl	$2, _ZL18__obuf_write_idx__(%rip)
	movb	%al, 1(%rbx)
	cmpq	%r14, %rbp
	je	.L320
	movl	$2, %eax
.L324:
	movzbl	(%r14), %edx
	movslq	%eax, %rcx
	cmpb	$27, %dl
	jne	.L328
	cmpl	$8160, %eax
	jg	.L325
.L328:
	addl	$1, %eax
	addq	$1, %r14
	movb	%dl, (%rbx,%rcx)
	movl	%eax, _ZL18__obuf_write_idx__(%rip)
	cmpq	%rbp, %r14
	jne	.L327
	jmp	.L320
	.p2align 4,,10
	.p2align 3
.L366:
	movq	%rsi, %rdx
	movl	$1, %edi
	movq	%r14, %rsi
	addq	$1, %r13
	call	write@PLT
	movzbl	-1(%r13), %eax
	movl	$1, _ZL18__obuf_write_idx__(%rip)
	movb	%al, (%r14)
	cmpq	%r13, %r15
	je	.L334
	movzbl	0(%r13), %edx
	movl	$1, %eax
	movl	$1, %esi
	jmp	.L336
	.p2align 4,,10
	.p2align 3
.L368:
	cmpl	$-1, %r12d
	je	.L320
	movl	4(%rbx), %eax
	jmp	.L339
.L325:
	movq	%rcx, %rdx
	movq	%rbx, %rsi
	movl	$1, %edi
	addq	$1, %r14
	call	write@PLT
	movzbl	-1(%r14), %eax
	movl	$1, _ZL18__obuf_write_idx__(%rip)
	movb	%al, (%rbx)
	cmpq	%rbp, %r14
	je	.L320
	movzbl	(%r14), %edx
	movl	$1, %eax
	movl	$1, %ecx
	jmp	.L328
.L369:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE1677:
	.size	_Z9wprintstrP6WINDOWiiPKcz, .-_Z9wprintstrP6WINDOWiiPKcz
	.p2align 4
	.globl	_Z7waddstrP6WINDOWPKcz
	.type	_Z7waddstrP6WINDOWPKcz, @function
_Z7waddstrP6WINDOWPKcz:
.LFB1678:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rsi, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$4344, %rsp
	.cfi_def_cfa_offset 4400
	movq	%rdx, 4176(%rsp)
	movq	%rcx, 4184(%rsp)
	movq	%r8, 4192(%rsp)
	movq	%r9, 4200(%rsp)
	testb	%al, %al
	je	.L371
	movaps	%xmm0, 4208(%rsp)
	movaps	%xmm1, 4224(%rsp)
	movaps	%xmm2, 4240(%rsp)
	movaps	%xmm3, 4256(%rsp)
	movaps	%xmm4, 4272(%rsp)
	movaps	%xmm5, 4288(%rsp)
	movaps	%xmm6, 4304(%rsp)
	movaps	%xmm7, 4320(%rsp)
.L371:
	movq	%fs:40, %rax
	movq	%rax, 4152(%rsp)
	xorl	%eax, %eax
	testq	%rbx, %rbx
	je	.L370
	movl	20(%rbx), %edx
	movl	16(%rbx), %esi
	leaq	.LC4(%rip), %rdi
	addl	12(%rbx), %edx
	addl	8(%rbx), %esi
	subl	$1, %edx
	subl	$1, %esi
	call	_ZL5__putPKcz
	leaq	4400(%rsp), %rax
	movq	%rbp, %rdx
	leaq	24(%rsp), %rcx
	movq	%rax, 32(%rsp)
	leaq	4160(%rsp), %rax
	movl	$4096, %esi
	movq	%rax, 40(%rsp)
	leaq	48(%rsp), %rax
	movq	%rax, %rdi
	movl	$16, 24(%rsp)
	movl	$48, 28(%rsp)
	movq	%rax, 8(%rsp)
	call	vsnprintf@PLT
	leaq	.LC9(%rip), %rdi
	movl	%eax, 4(%rsp)
	addl	20(%rbx), %eax
	subl	$1, %eax
	cltd
	idivl	4(%rbx)
	movl	%eax, %ebp
	xorl	%eax, %eax
	testl	%ebp, %ebp
	je	.L417
	call	_ZL5__putPKcz
	testl	%ebp, %ebp
	js	.L382
	movl	$0, (%rsp)
	movl	4(%rbx), %r12d
	leaq	_ZL14__out_buffer__(%rip), %r14
	subl	20(%rbx), %r12d
	addl	$1, %r12d
	.p2align 4
	.p2align 3
.L396:
	movslq	%r12d, %r8
	testq	%r8, %r8
	je	.L388
	movslq	(%rsp), %rcx
	movq	8(%rsp), %rdi
	movl	_ZL18__obuf_write_idx__(%rip), %eax
	leaq	(%rdi,%rcx), %r13
	leaq	(%r8,%r13), %r15
.L389:
	cmpl	$8191, %eax
	jle	.L386
	movl	$8192, %edx
	movq	%r14, %rsi
	movl	$1, %edi
	call	write@PLT
	movzbl	0(%r13), %eax
	movl	$1, _ZL18__obuf_write_idx__(%rip)
	movb	%al, (%r14)
	leaq	1(%r13), %rax
	cmpq	%r15, %rax
	je	.L388
	movzbl	1(%r13), %eax
	addq	$2, %r13
	movl	$2, _ZL18__obuf_write_idx__(%rip)
	movb	%al, 1(%r14)
	cmpq	%r13, %r15
	je	.L388
	movl	$2, %eax
.L386:
	movzbl	0(%r13), %edx
	movslq	%eax, %rsi
	cmpl	$8160, %eax
	jle	.L390
	cmpb	$27, %dl
	je	.L418
.L390:
	addl	$1, %eax
	addq	$1, %r13
	movb	%dl, (%r14,%rsi)
	movl	%eax, _ZL18__obuf_write_idx__(%rip)
	cmpq	%r13, %r15
	jne	.L389
.L388:
	movl	16(%rbx), %eax
	movl	(%rbx), %ecx
	movl	12(%rbx), %edx
	movl	8(%rbx), %esi
	cmpl	%ecx, %eax
	jge	.L419
	addl	$1, %eax
	movl	$1, 20(%rbx)
	leaq	.LC4(%rip), %rdi
	movl	%eax, 16(%rbx)
	leal	-1(%rax,%rsi), %esi
	xorl	%eax, %eax
	subl	%r12d, 4(%rsp)
	call	_ZL5__putPKcz
	subl	$1, %ebp
	jne	.L420
	movl	4(%rsp), %eax
.L393:
	addl	%r12d, (%rsp)
	movl	%eax, %r12d
	jmp	.L396
.L419:
	addl	4(%rbx), %edx
	leal	-1(%rcx,%rsi), %esi
	leaq	.LC4(%rip), %rdi
	xorl	%eax, %eax
	subl	$1, %edx
	call	_ZL5__putPKcz
	movq	(%rbx), %rax
	movq	%rax, 16(%rbx)
.L382:
	leaq	.LC10(%rip), %rdi
	xorl	%eax, %eax
	call	_ZL5__putPKcz
.L370:
	movq	4152(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L421
	addq	$4344, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L417:
	.cfi_restore_state
	call	_ZL5__putPKcz
	movslq	4(%rsp), %rbp
	testq	%rbp, %rbp
	je	.L382
	movq	8(%rsp), %r14
	movl	_ZL18__obuf_write_idx__(%rip), %eax
	leaq	_ZL14__out_buffer__(%rip), %rbx
	addq	%r14, %rbp
.L379:
	cmpl	$8191, %eax
	jle	.L375
	movl	$8192, %edx
	movq	%rbx, %rsi
	movl	$1, %edi
	call	write@PLT
	movzbl	(%r14), %eax
	movl	$1, _ZL18__obuf_write_idx__(%rip)
	movb	%al, (%rbx)
	leaq	1(%r14), %rax
	cmpq	%rax, %rbp
	je	.L382
	movzbl	1(%r14), %eax
	addq	$2, %r14
	movl	$2, _ZL18__obuf_write_idx__(%rip)
	movb	%al, 1(%rbx)
	cmpq	%r14, %rbp
	je	.L382
	movl	$2, %eax
.L375:
	movzbl	(%r14), %edx
	movslq	%eax, %rcx
	cmpb	$27, %dl
	jne	.L380
	cmpl	$8160, %eax
	jg	.L377
.L380:
	addl	$1, %eax
	addq	$1, %r14
	movb	%dl, (%rbx,%rcx)
	movl	%eax, _ZL18__obuf_write_idx__(%rip)
	cmpq	%r14, %rbp
	jne	.L379
	jmp	.L382
	.p2align 4,,10
	.p2align 3
.L418:
	movq	%rsi, %rdx
	movl	$1, %edi
	movq	%r14, %rsi
	addq	$1, %r13
	call	write@PLT
	movzbl	-1(%r13), %eax
	movl	$1, _ZL18__obuf_write_idx__(%rip)
	movb	%al, (%r14)
	cmpq	%r13, %r15
	je	.L388
	movzbl	0(%r13), %edx
	movl	$1, %eax
	movl	$1, %esi
	jmp	.L390
	.p2align 4,,10
	.p2align 3
.L420:
	cmpl	$-1, %ebp
	je	.L382
	movl	4(%rbx), %eax
	jmp	.L393
.L377:
	movq	%rcx, %rdx
	movq	%rbx, %rsi
	movl	$1, %edi
	addq	$1, %r14
	call	write@PLT
	movzbl	-1(%r14), %eax
	movl	$1, _ZL18__obuf_write_idx__(%rip)
	movb	%al, (%rbx)
	cmpq	%rbp, %r14
	je	.L382
	movzbl	(%r14), %edx
	movl	$1, %eax
	movl	$1, %ecx
	jmp	.L380
.L421:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE1678:
	.size	_Z7waddstrP6WINDOWPKcz, .-_Z7waddstrP6WINDOWPKcz
	.p2align 4
	.globl	_Z7waddstrP6WINDOWiiPKcz
	.type	_Z7waddstrP6WINDOWiiPKcz, @function
_Z7waddstrP6WINDOWiiPKcz:
.LFB1679:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rcx, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	subq	$4344, %rsp
	.cfi_def_cfa_offset 4400
	movq	%r8, 4192(%rsp)
	movq	%r9, 4200(%rsp)
	testb	%al, %al
	je	.L423
	movaps	%xmm0, 4208(%rsp)
	movaps	%xmm1, 4224(%rsp)
	movaps	%xmm2, 4240(%rsp)
	movaps	%xmm3, 4256(%rsp)
	movaps	%xmm4, 4272(%rsp)
	movaps	%xmm5, 4288(%rsp)
	movaps	%xmm6, 4304(%rsp)
	movaps	%xmm7, 4320(%rsp)
.L423:
	movq	%fs:40, %rax
	movq	%rax, 4152(%rsp)
	xorl	%eax, %eax
	testq	%rbx, %rbx
	je	.L422
	movl	%esi, 16(%rbx)
	addl	8(%rbx), %esi
	leaq	.LC4(%rip), %rdi
	movl	%edx, 20(%rbx)
	addl	12(%rbx), %edx
	subl	$1, %esi
	subl	$1, %edx
	call	_ZL5__putPKcz
	leaq	4400(%rsp), %rax
	movq	%rbp, %rdx
	leaq	24(%rsp), %rcx
	movq	%rax, 32(%rsp)
	leaq	4160(%rsp), %rax
	movl	$4096, %esi
	movq	%rax, 40(%rsp)
	leaq	48(%rsp), %rax
	movq	%rax, %rdi
	movl	$32, 24(%rsp)
	movl	$48, 28(%rsp)
	movq	%rax, 8(%rsp)
	call	vsnprintf@PLT
	leaq	.LC9(%rip), %rdi
	movl	%eax, 4(%rsp)
	addl	20(%rbx), %eax
	subl	$1, %eax
	cltd
	idivl	4(%rbx)
	movl	%eax, %ebp
	xorl	%eax, %eax
	testl	%ebp, %ebp
	je	.L469
	call	_ZL5__putPKcz
	testl	%ebp, %ebp
	js	.L434
	movl	$0, (%rsp)
	movl	4(%rbx), %r12d
	leaq	_ZL14__out_buffer__(%rip), %r14
	subl	20(%rbx), %r12d
	addl	$1, %r12d
	.p2align 4
	.p2align 3
.L448:
	movslq	%r12d, %r8
	testq	%r8, %r8
	je	.L440
	movslq	(%rsp), %rcx
	movq	8(%rsp), %rdi
	movl	_ZL18__obuf_write_idx__(%rip), %eax
	leaq	(%rdi,%rcx), %r13
	leaq	(%r8,%r13), %r15
.L441:
	cmpl	$8191, %eax
	jle	.L438
	movl	$8192, %edx
	movq	%r14, %rsi
	movl	$1, %edi
	call	write@PLT
	movzbl	0(%r13), %eax
	movl	$1, _ZL18__obuf_write_idx__(%rip)
	movb	%al, (%r14)
	leaq	1(%r13), %rax
	cmpq	%r15, %rax
	je	.L440
	movzbl	1(%r13), %eax
	addq	$2, %r13
	movl	$2, _ZL18__obuf_write_idx__(%rip)
	movb	%al, 1(%r14)
	cmpq	%r13, %r15
	je	.L440
	movl	$2, %eax
.L438:
	movzbl	0(%r13), %edx
	movslq	%eax, %rsi
	cmpl	$8160, %eax
	jle	.L442
	cmpb	$27, %dl
	je	.L470
.L442:
	addl	$1, %eax
	addq	$1, %r13
	movb	%dl, (%r14,%rsi)
	movl	%eax, _ZL18__obuf_write_idx__(%rip)
	cmpq	%r13, %r15
	jne	.L441
.L440:
	movl	16(%rbx), %eax
	movl	(%rbx), %ecx
	movl	12(%rbx), %edx
	movl	8(%rbx), %esi
	cmpl	%ecx, %eax
	jge	.L471
	addl	$1, %eax
	movl	$1, 20(%rbx)
	leaq	.LC4(%rip), %rdi
	movl	%eax, 16(%rbx)
	leal	-1(%rax,%rsi), %esi
	xorl	%eax, %eax
	subl	%r12d, 4(%rsp)
	call	_ZL5__putPKcz
	subl	$1, %ebp
	jne	.L472
	movl	4(%rsp), %eax
.L445:
	addl	%r12d, (%rsp)
	movl	%eax, %r12d
	jmp	.L448
.L471:
	addl	4(%rbx), %edx
	leal	-1(%rcx,%rsi), %esi
	leaq	.LC4(%rip), %rdi
	xorl	%eax, %eax
	subl	$1, %edx
	call	_ZL5__putPKcz
	movq	(%rbx), %rax
	movq	%rax, 16(%rbx)
.L434:
	leaq	.LC10(%rip), %rdi
	xorl	%eax, %eax
	call	_ZL5__putPKcz
.L422:
	movq	4152(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L473
	addq	$4344, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L469:
	.cfi_restore_state
	call	_ZL5__putPKcz
	movslq	4(%rsp), %rbp
	testq	%rbp, %rbp
	je	.L434
	movq	8(%rsp), %r14
	movl	_ZL18__obuf_write_idx__(%rip), %eax
	leaq	_ZL14__out_buffer__(%rip), %rbx
	addq	%r14, %rbp
.L431:
	cmpl	$8191, %eax
	jle	.L427
	movl	$8192, %edx
	movq	%rbx, %rsi
	movl	$1, %edi
	call	write@PLT
	movzbl	(%r14), %eax
	movl	$1, _ZL18__obuf_write_idx__(%rip)
	movb	%al, (%rbx)
	leaq	1(%r14), %rax
	cmpq	%rax, %rbp
	je	.L434
	movzbl	1(%r14), %eax
	addq	$2, %r14
	movl	$2, _ZL18__obuf_write_idx__(%rip)
	movb	%al, 1(%rbx)
	cmpq	%r14, %rbp
	je	.L434
	movl	$2, %eax
.L427:
	movzbl	(%r14), %edx
	movslq	%eax, %rcx
	cmpb	$27, %dl
	jne	.L432
	cmpl	$8160, %eax
	jg	.L429
.L432:
	addl	$1, %eax
	addq	$1, %r14
	movb	%dl, (%rbx,%rcx)
	movl	%eax, _ZL18__obuf_write_idx__(%rip)
	cmpq	%r14, %rbp
	jne	.L431
	jmp	.L434
	.p2align 4,,10
	.p2align 3
.L470:
	movq	%rsi, %rdx
	movl	$1, %edi
	movq	%r14, %rsi
	addq	$1, %r13
	call	write@PLT
	movzbl	-1(%r13), %eax
	movl	$1, _ZL18__obuf_write_idx__(%rip)
	movb	%al, (%r14)
	cmpq	%r13, %r15
	je	.L440
	movzbl	0(%r13), %edx
	movl	$1, %eax
	movl	$1, %esi
	jmp	.L442
	.p2align 4,,10
	.p2align 3
.L472:
	cmpl	$-1, %ebp
	je	.L434
	movl	4(%rbx), %eax
	jmp	.L445
.L429:
	movq	%rcx, %rdx
	movq	%rbx, %rsi
	movl	$1, %edi
	addq	$1, %r14
	call	write@PLT
	movzbl	-1(%r14), %eax
	movl	$1, _ZL18__obuf_write_idx__(%rip)
	movb	%al, (%rbx)
	cmpq	%rbp, %r14
	je	.L434
	movzbl	(%r14), %edx
	movl	$1, %eax
	movl	$1, %ecx
	jmp	.L432
.L473:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE1679:
	.size	_Z7waddstrP6WINDOWiiPKcz, .-_Z7waddstrP6WINDOWiiPKcz
	.section	.rodata.str1.1
.LC43:
	.string	"%s"
	.text
	.p2align 4
	.globl	_Z7wborderP6WINDOWPKcS2_S2_S2_S2_S2_S2_S2_
	.type	_Z7wborderP6WINDOWPKcS2_S2_S2_S2_S2_S2_S2_, @function
_Z7wborderP6WINDOWPKcS2_S2_S2_S2_S2_S2_S2_:
.LFB1680:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$40, %rsp
	.cfi_def_cfa_offset 96
	movq	96(%rsp), %rax
	movq	104(%rsp), %r14
	movq	%rax, 8(%rsp)
	movq	112(%rsp), %rax
	movq	%rax, 16(%rsp)
	testq	%rdi, %rdi
	je	.L474
	movq	%rdi, %r15
	movq	%rcx, 24(%rsp)
	movq	%r9, %r12
	movq	%r8, %rbp
	movq	%rdx, (%rsp)
	movq	%rsi, %r13
	call	_Z12curs_yx_savev@PLT
	movl	12(%r15), %edx
	movl	8(%r15), %esi
	xorl	%eax, %eax
	leaq	.LC4(%rip), %rdi
	call	_ZL5__putPKcz
	movl	4(%r15), %edx
	testl	%edx, %edx
	jle	.L476
	leaq	.LC43(%rip), %rbx
	movq	%r13, %rsi
	xorl	%eax, %eax
	xorl	%r13d, %r13d
	movq	%rbx, %rdi
	call	_ZL5__putPKcz
.L477:
	movl	4(%r15), %eax
	addl	$1, %r13d
	cmpl	%r13d, %eax
	jle	.L476
.L493:
	subl	$1, %eax
	cmpl	%r13d, %eax
	je	.L492
	movq	(%rsp), %rsi
	xorl	%eax, %eax
	movq	%rbx, %rdi
	addl	$1, %r13d
	call	_ZL5__putPKcz
	movl	4(%r15), %eax
	cmpl	%r13d, %eax
	jg	.L493
.L476:
	movl	(%r15), %esi
	cmpl	$2, %esi
	jle	.L481
	movl	$1, %r13d
	leaq	.LC43(%rip), %rbx
	.p2align 4
	.p2align 3
.L482:
	movl	8(%r15), %esi
	movl	12(%r15), %edx
	leaq	.LC4(%rip), %rdi
	xorl	%eax, %eax
	addl	%r13d, %esi
	addl	$1, %r13d
	call	_ZL5__putPKcz
	movq	%rbp, %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	_ZL5__putPKcz
	movl	4(%r15), %eax
	leaq	.LC7(%rip), %rdi
	leal	-2(%rax), %esi
	xorl	%eax, %eax
	call	_ZL5__putPKcz
	movq	%r12, %rsi
	xorl	%eax, %eax
	movq	%rbx, %rdi
	call	_ZL5__putPKcz
	movl	(%r15), %esi
	leal	-1(%rsi), %eax
	cmpl	%r13d, %eax
	jg	.L482
.L481:
	addl	8(%r15), %esi
	movl	12(%r15), %edx
	xorl	%eax, %eax
	leaq	.LC4(%rip), %rdi
	subl	$1, %esi
	call	_ZL5__putPKcz
	movl	4(%r15), %eax
	testl	%eax, %eax
	jle	.L483
	movq	8(%rsp), %rsi
	leaq	.LC43(%rip), %rbx
	xorl	%eax, %eax
	xorl	%ebp, %ebp
	movq	%rbx, %rdi
	call	_ZL5__putPKcz
.L484:
	movl	4(%r15), %eax
	addl	$1, %ebp
	cmpl	%ebp, %eax
	jle	.L483
.L495:
	subl	$1, %eax
	cmpl	%ebp, %eax
	je	.L494
	xorl	%eax, %eax
	movq	%r14, %rsi
	movq	%rbx, %rdi
	addl	$1, %ebp
	call	_ZL5__putPKcz
	movl	4(%r15), %eax
	cmpl	%ebp, %eax
	jg	.L495
.L483:
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	jmp	_Z15curs_yx_restorev@PLT
	.p2align 4,,10
	.p2align 3
.L492:
	.cfi_restore_state
	movq	24(%rsp), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	_ZL5__putPKcz
	jmp	.L477
	.p2align 4,,10
	.p2align 3
.L494:
	movq	16(%rsp), %rsi
	movq	%rbx, %rdi
	xorl	%eax, %eax
	call	_ZL5__putPKcz
	jmp	.L484
	.p2align 4,,10
	.p2align 3
.L474:
	addq	$40, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE1680:
	.size	_Z7wborderP6WINDOWPKcS2_S2_S2_S2_S2_S2_S2_, .-_Z7wborderP6WINDOWPKcS2_S2_S2_S2_S2_S2_S2_
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.type	_GLOBAL__sub_I_ezterm.cpp, @function
_GLOBAL__sub_I_ezterm.cpp:
.LFB1752:
	.cfi_startproc
	movq	_ZNSt6vectorI5colorSaIS0_EED1Ev@GOTPCREL(%rip), %rdi
	leaq	__dso_handle(%rip), %rdx
	leaq	_ZL18__usr_color_list__(%rip), %rsi
	jmp	__cxa_atexit@PLT
	.cfi_endproc
.LFE1752:
	.size	_GLOBAL__sub_I_ezterm.cpp, .-_GLOBAL__sub_I_ezterm.cpp
	.section	.init_array,"aw"
	.align 8
	.quad	_GLOBAL__sub_I_ezterm.cpp
	.local	_ZL18__usr_color_list__
	.comm	_ZL18__usr_color_list__,24,16
	.local	_ZL18__obuf_write_idx__
	.comm	_ZL18__obuf_write_idx__,4,4
	.local	_ZL14__out_buffer__
	.comm	_ZL14__out_buffer__,8192,32
	.local	_ZL24__curs_position_is_saved
	.comm	_ZL24__curs_position_is_saved,1,1
	.local	_ZL21__winsize_is_change__
	.comm	_ZL21__winsize_is_change__,1,1
	.local	_ZL15__term_isinit__
	.comm	_ZL15__term_isinit__,1,1
	.local	_ZL16__old_termattr__
	.comm	_ZL16__old_termattr__,60,32
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC42:
	.long	1
	.long	1
	.hidden	__dso_handle
	.ident	"GCC: (GNU) 15.2.1 20260103"
	.section	.note.GNU-stack,"",@progbits
