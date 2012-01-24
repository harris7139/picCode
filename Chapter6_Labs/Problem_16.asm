;Chapter 6 Example Problem 16
		#include <p18f452.inc>
		
		org	0x00
		goto	START
		
		CNT EQU	0x10
		
START	MOVLW	0x0A
		MOVWF	CNT
		LFSR	0, 0x40
		LFSR	1, 0x70
B1		MOVF	POSTINC0, W
		MOVWF	POSTINC1
		DECF	CNT, F
		BNZ		B1
END