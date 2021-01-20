#include <stdint.h>
#include <versatilepb.h>

void irq_handler() {
	/* echo the received character + 1 */
	UART0_DR = UART0_DR + 1;
}