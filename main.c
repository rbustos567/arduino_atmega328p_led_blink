/***************************************************************************
* main.c:
*      Copyright (c) 2020 Ricardo Bustos
*
*    Arduino Atmega328p blinking led is a free
*    software: you can redistribute it and/or modify it under the terms
*    of the GNU Lesser General Public License as published by the Free
*    Software Foundation, either version 3 of the License, or
*    (at your option) any later version.
*
*    Arduino Atmega328p blinking led is distributed
*    in the hope that it will be useful, but WITHOUT ANY WARRANTY;
*    without even the implied warranty of MERCHANTABILITY or FITNESS
*    FOR A PARTICULAR PURPOSE.
*    See the GNU Lesser General Public License for more details.
*
****************************************************************************/


#include <util/delay.h>
#include <avr/io.h>

#define LED PORTB5

int main(void) {
    
    DDRB |= (1 << LED);
  
    for(;;) {
        PORTB |= (1 << LED);
        _delay_ms(2000); // Every 2 seconds
        PORTB &= (0 << LED);
        _delay_ms(2000);
    }

    return 0;
}
