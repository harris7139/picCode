;Chapter 6 Example Problem 15
		#include <p18f452.inc>
		
		org		0x00
		goto	START

		COUNT	EQU	0x10
		
START	MOVLW	0x20
		MOVWF	COUNT
		LFSR	0, 0x50
		MOVLW	0xFF
B1		MOVWF	INDF0
		INCF	FSR0L, F
		DECF	COUNT, F
		BNZ		B1
		BRA		$
END