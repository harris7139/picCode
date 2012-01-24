		#include <p18f452.inc>
		
		org		0x00
		goto	START

		Xhi 	EQU	0x11
		Xlo		EQU	0x10
		Yhi		EQU	0x21
		Ylo		EQU	0x20
		RESULT	EQU	0x30
		
START	MOVLW	0x02
		MOVWF	Xlo
		MOVLW	0x20
		MOVWF	Xhi
		
		MOVLW	0x02
		MOVWF	Ylo
		MOVLW	0x20
		MOVWF	Yhi
		CALL	COMPHI


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
		GOTO	THEEND

;------X > Y
XISHI	MOVLW	0x01
		MOVWF	RESULT
		GOTO	THEEND

;------X = Y
AREQU	MOVLW	0x00
		MOVWF 	RESULT
		GOTO	THEEND
		
;------this is the end
THEEND
END