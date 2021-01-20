export CC = arm-linux-gnueabi-gcc
export AS = arm-linux-gnueabi-as
export LD = arm-linux-gnueabi-ld
OBJCOPY = arm-linux-gnueabi-objcopy

export CFLAGS = -g -I.
ASFLAGS = -g
LDFLAGS = -Tlinker.lds

OBJS = init.o start.o boot.o abnormal.o machine/machine.o

all: machine.o little_os.elf

little_os.elf: $(OBJS)
	$(LD) -static -nostartfiles -nostdlib $(LDFLAGS) $? -o $@
	$(OBJCOPY) -O binary $@ little_os.bin

machine.o:
	make -C machine

%.o : %.c
	$(CC) $(CFLAGS) -c $< -o $@

%.o : %.s
	$(AS) $(ASFLAGS) $< -o $@

clean:
	@find . -name '*.o' -delete
	@rm -f little_os*