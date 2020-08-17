########################################################################
# Makefile:
#      Copyright (c) 2020 Ricardo Bustos
#
#    Arduino Atmega328p blinking led is a free
#    software: you can redistribute it and/or modify it under the terms
#    of the GNU Lesser General Public License as published by the Free
#    Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    Arduino Atmega328p blinking led is distributed
#    in the hope that it will be useful, but WITHOUT ANY WARRANTY;
#    without even the implied warranty of MERCHANTABILITY or FITNESS
#    FOR A PARTICULAR PURPOSE.
#    See the GNU Lesser General Public License for more details.
#
##########################################################################

MCU = atmega328p
CLK_SPEED = 16000000

AD_MCU = m328p
PRGMR = arduino
PORT = /dev/ttyACM0
BAUDRATE = 115200

INC_DIR = ..\include

GCC = avr-gcc
OC = avr-objcopy
OD = avr-objdump
AD = avrdude
RM = rm -f

GCC_FLAGS = -c -I${INC_DIR} -DF_CPU=${CLK_SPEED} -mmcu=${MCU} -Wall -Werror -Wextra
LD_FLAGS = -mmcu=${MCU} -nostartfiles -nodefaultlibs
OC_FLAGS = -j .data -j .text -O ihex
OD_FLAGS = -DS
AD_FLAGS = -p${AD_MCU} -c${PRGMR} -P${PORT} -b${BAUDRATE}

TARGET = main
C_SRC = main.c
ASM_SRC = 
OBJS = $(C_SRC:.c=.o) $(ASM_SRC:.S=.o)

build : elf hex asm

elf : $(TARGET).elf
hex : $(TARGET).hex
asm : $(TARGET).asm

%.o :%.c
	$(GCC) $(GCC_FLAGS) -Os $< -o $@
	
%.o :%.S
	$(GCC) $(GCC_FLAGS) -Os $< -o $@

$(TARGET).elf : $(OBJS)
	$(GCC) $(LD_FLAGS) $< -o $@
	
$(TARGET).hex : $(TARGET).elf
	$(OC) $(OC_FLAGS) $< $@
	
$(TARGET).asm : $(TARGET).elf
	$(OD) $(OD_FLAGS) $< > $@
	
flash : $(TARGET).hex
	$(AD) $(AD_FLAGS) -Uflash:w:$<:i

.PHONY = clean flash
	
clean :
	$(RM) *.elf *.hex *.asm *.o 
