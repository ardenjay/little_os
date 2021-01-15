.global __vector_reset
.global __vector_undefined
.global __vector_swi
.global __vector_prefetch_abort
.global __vector_data_abort
.global __vector_reserved
.global __vector_irq
.global __vector_fiq

.text
.code 32

__vector_undefined:
	nop
__vector_swi:
	nop
__vector_prefetch_abort:
	nop
__vector_data_abort:
	nop
__vector_reserved:
	nop
__vector_irq:
	sub lr, lr, #4
	stmfd sp!, {r0-r3, lr}
	bl common_irq_handler
	ldmfd sp!, {r0-r3, pc}^
__vector_fiq:
	nop
