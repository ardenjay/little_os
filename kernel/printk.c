typedef char *va_list;

#define ALIGN_INT(n) 	((sizeof(n) + sizeof(int) - 1) & ~(sizeof(int) - 1))
#define va_start(va, v) (va = (va_list)&v + ALIGN_INT(v))
#define va_arg(va, t) 	(*(t*)((va += ALIGN_INT(t)) - ALIGN_INT(t)))
#define va_end(va) 		(va = (va_list)0)

extern void puts_buffer(const char *s);

int minprintf(char *buf, const char *fmt, va_list args)
{
	char *str = buf;

	for (; *fmt; fmt++) {
		if (*fmt == '%')
			continue;

		switch (*fmt) {
		case 'c':
			*str++ = (unsigned char) va_arg(args, int);
			break;
		case 's': {
			char *s;
			for (s = va_arg(args, char *); *s; s++)
                *str++ = *s;
			break;
		}
		default:
			break;
		}
	}
	*str = '\0';
	return 0;
}

void printk(const char *fmt, ...)
{
	int i;
	va_list args;
	char printbuffer[100];

	va_start(args, fmt);
	i = minprintf(printbuffer, fmt, args);
	va_end(args);

	puts_buffer(printbuffer);
}

void test_vparameter(int i, ...) {
	int c;
	va_list argv;

	va_start(argv, i);
	while (i--) {
		c = va_arg(argv, int);
	}
	va_end(argv);
}