export CC = arm-none-eabi-gcc
export AS = arm-none-eabi-as
export LD = arm-none-eabi-ld
OBJCOPY = arm-none-eabi-objcopy

export CFLAGS = -g3 -I. -I./include/
ASFLAGS = -g
LDFLAGS = -Tlinker.lds

OBJS = init.o start.o boot.o abnormal.o machine/machine.o printk.o

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