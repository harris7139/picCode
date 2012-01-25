		#include <p18f452.inc>
		ORG	0x00
		GOTO	START

		CNTVAL	EQU	0x04
		CNTER	EQU	0x10
;------Main Program
START	CALL	WRITE
		CALL	ADD
B3		BRA		$
;------Write values to 20H-23H
WRITE	MOVLW	CNTVAL
		MOVWF	CNTER
		LFSR	0, 0x20
B1		MOVLW	0x25
		MOVWF	POSTINC0
		DECF	CNTER
		BNZ		B1
;------Add locations and store in 60H
ADD		MOVLW	CNTVAL
		MOVWF	CNTER
		LFSR	0, 0x20
		CLRF	0x60
B2		MOVF	POSTINC0, W
		ADDWF	0x60
		DECF	CNTER
		BNZ		B2
		BRA		B3
END
		
		