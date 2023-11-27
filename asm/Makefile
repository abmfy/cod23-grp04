BUILD_DIR = .
ARM_SOURCES = $(wildcard *.s)
TARGETS = $(addprefix $(BUILD_DIR)/,$(notdir $(ARM_SOURCES:.s=.bin)))
all: $(TARGETS)
%.elf: %.s
	riscv64-unknown-elf-gcc $< -march=rv32i -mabi=ilp32 -static -fno-pic -fno-builtin -nostdlib  -nostdinc -g -o $@ -Wl,-Ttext,0x0
%.bin: %.elf
	riscv64-unknown-elf-objcopy -j .text -O binary -S $< $@
