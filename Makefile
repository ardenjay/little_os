CC = arm-linux-gnueabi-gcc
AS = arm-linux-gnueabi-as
LD = arm-linux-gnueabi-ld
OBJCOPY = arm-none-eabi-objcopy

CFLAGS = -g
ASFLAGS = -g
LDFLAGS = -Tlinker.lds

OBJS = init.o start.o boot.o abnormal.o

%.o : %.c
	$(CC) $(CFLAGS) -c $< -o $@

%.o : %.s
	$(AS) $(ASFLAGS) $< -o $@

little_os.elf: $(OBJS)
	$(LD) -static -nostartfiles -nostdlib $(LDFLAGS) $? -o $@
	$(OBJCOPY) -O binary $@ little_os.bin

clean:
	rm *.o
	rm little_os*
