.equ DISALBE_IRQ,	0x80
.equ DISALBE_FIQ,	0x40
.equ SYS_MOD,		0x1f
.equ IRQ_MOD,		0x12
.equ FIQ_MOD,		0x11
.equ SVC_MOD,		0x13
.equ ABT_MOD,		0x17
.equ UND_MOD,		0x1b

// From versatilepb.c in qemu, SDRAM at address 0
.equ MEM_SIZE,		0x8000000				// 128M
.equ DDR_START,		0x0
.equ _SVC_STACK,	(DDR_START+MEM_SIZE-4)
.equ _IRQ_STACK,	(_SVC_STACK-0x400)		// 1K
.equ _FIQ_STACK,	(_IRQ_STACK-0x400)
.equ _ABT_STACK,	(_FIQ_STACK-0x400)
.equ _UND_STACK,	(_ABT_STACK-0x400)
.equ _SYS_STACK,	(_UND_STACK-0x400)

.text
.code 32
.global __vector_reset

.extern plat_boot
.extern __bss_start__
.extern __bss_end__

__vector_reset:
	msr cpsr_c, #(DISALBE_IRQ|DISALBE_FIQ|SVC_MOD)
	ldr sp, =_SVC_STACK

	msr cpsr_c, #(DISALBE_IRQ|DISALBE_FIQ|IRQ_MOD)
	ldr sp, =_IRQ_STACK

	msr cpsr_c, #(DISALBE_IRQ|DISALBE_FIQ|FIQ_MOD)
	ldr sp, =_FIQ_STACK

	msr cpsr_c, #(DISALBE_IRQ|DISALBE_FIQ|ABT_MOD)
	ldr sp, =_ABT_STACK

	msr cpsr_c, #(DISALBE_IRQ|DISALBE_FIQ|UND_MOD)
	ldr sp, =_UND_STACK

	msr cpsr_c, #(DISALBE_IRQ|DISALBE_FIQ|SYS_MOD)
	ldr sp, =_SYS_STACK

_clear_bss:
	ldr r1, _bss_start_
	ldr r3, _bss_end_
	mov r2, #0x0
1:
	cmp r1, r3
	beq _main
	str r2, [r1], #0x4
	b 1b
_main:
	bl copy_vectors
	bl enable_irq
	b plat_boot

_bss_start_:	.word   __bss_start__
_bss_end_:		.word   __bss_end__

.end
