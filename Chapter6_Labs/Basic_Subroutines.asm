		#include <p18f452.inc>
		
		org		0x00
		goto	START

		Xhi 	EQU	0x11
		Xlo		EQU	0x10
		Yhi		EQU	0x21
		Ylo		EQU	0x20
		RESULT	EQU	0x30
		
START	
		CALL	LOAD
		CALL	COMPHI
		BRA		$

;------load x and y values
LOAD	MOVLW	0x01
		MOVWF	Xlo
		MOVLW	0x10
		MOVWF	Xhi
		MOVLW	0x02
		MOVWF	Ylo
		MOVLW	0x20
		MOVWF	Yhi

;------are high bytes equal
COMPHI	MOVF	Xhi, W
		CPFSEQ	Yhi
		GOTO	LEQ				;NO
		GOTO	COMPLO			;YES

;------are low bytes equal
COMPLO	MOVF	Xlo, W
		CPFSEQ	Ylo
		GOTO	LOBYTE			;NO
		GOTO	AREQU			;YES

;------test low byte
LOBYTE	MOVF	Xlo, W
		CPFSLT	Ylo
		CALL	XISLO			;NO
		CALL	XISHI			;YES

;------test high byte
LEQ		MOVF	Xhi, W
		CPFSLT	Yhi
		CALL	XISLO			;NO
		CALL	XISHI			;YES

;------X < Y
XISLO	MOVLW	0x02
		MOVWF	RESULT
		GOTO	EXIT

;------X > Y
XISHI	MOVLW	0x01
		MOVWF	RESULT
		GOTO	EXIT

;------X = Y
AREQU	MOVLW	0x00
		MOVWF 	RESULT
		GOTO	EXIT
		
;------this is the end
EXIT
END