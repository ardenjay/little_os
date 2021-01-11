#define UART0 ((volatile unsigned int *)(0x101f1000))
typedef void (*init_func)(void);

void print_uart0(void) {
	const char *s = "hello world\n";
    while (*s != '\0' ) { 
        *UART0 = (unsigned int )(*s);
        s++;
    }   
}

static init_func init[] = {
	print_uart0,
	0,
};

void plat_boot(void) {
	int i;

	for (i = 0; init[i]; i++)
		init[i]();

	while (1)
		;
}
