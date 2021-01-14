#include <stdint.h>
#include <versatilepb.h>

typedef void (*init_func)(void);

void print_uart0(void) {
	const char *s = "hello world\n";
    while (*s != '\0' ) { 
        UART0_DR = (unsigned int )(*s);
        s++;
    }   
}

static init_func init[] = {
	print_uart0,
	0,
};

void copy_vectors(void) {
	extern uint32_t vectors_start;
	extern uint32_t vectors_end;
	uint32_t *vectors_src = &vectors_start;
	uint32_t *vectors_dst = (uint32_t *)0;

	while(vectors_src < &vectors_end)
		*vectors_dst++ = *vectors_src++;
}

void irq_handler() {
	/* echo the received character + 1 */
	UART0_DR = UART0_DR + 1;
}

void enable_irq(void) {
	asm volatile (
		"mrs r4, cpsr\n\t"
		"bic r4, r4, #0x80\n\t"
		"msr cpsr, r4\n\t"
		::: "r4"
	);
}

void common_irq_handler(void) {
	irq_handler();
}

void plat_boot(void) {
	int i;

	for (i = 0; init[i]; i++)
		init[i]();

	/* enable UART0 IRQ */
	VIC_INTENABLE = 1<<12;

	/* enable RXIM interrupt */
	UART0_IMSC = 1<<4;

	while (1)
		;
}
