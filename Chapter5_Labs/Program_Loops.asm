#include <p18f452.inc>

		org		0x00
		goto	START
		
		COUNTREG	EQU 0x10		;Memory location to store counter value
		CNTVAL		EQU d'32'		;Counter value - we are moving 32 bits
START	MOVLW		CNTVAL			;Move counter value to WREG
		MOVWF		COUNTREG		;Move counter value from WREG to mem location
		LFSR		0, 0x020		;load pointer. FSR0 = 0x020, RAM address
		LFSR		1, 0x320		;load pointer. FSR1 = 0x320, RAM address
B3		MOVF		POSTINC0, W		;copy RAM to WREG and increment FSR0
		ADDLW		0x10			;add 0x10 to the literal in the WREG
		MOVWF		POSTINC1		;copy WREG to RAM and increment FSR1
		DECF		COUNTREG, F		;decrement the counter
		BNZ			B3				;loop until counter = 0

END

