;Created by : Logan Stark
;Date :
;
;
#include <p18F452.inc>
	org		0x00
	goto	start
	org		0x08
	retfie
	org		0x18
	retfie
;variables and data locations
count	equ	d'16'
counter	equ	0x20
watch	equ	0x21
temp	equ	0x22

;main program
;first move all letters into proper file locations
start		lfsr	0,0x200
			movlw	count
			movwf	counter
			movlw	a'd'
			call	letteradd
			movlw	a'C'
			call 	letteradd
			movlw	a'Z'
			call	letteradd
			movlw	a's'
			call	letteradd
			movlw	a'e'
			call	letteradd
			movlw	a'm'
			call	letteradd
			movlw	a'W'
			call	letteradd
			movlw	a'J'
			call	letteradd
			movlw	a'g'
			call	letteradd
			movlw	a'p'
			call	letteradd
			movlw	a'Q'
			call	letteradd
			movlw	a'l'
			call	letteradd
			movlw	a'X'
			call	letteradd
			movlw	a'n'
			call	letteradd
			movlw	a'O'
			call	letteradd
			movlw	a't'
			call	letteradd
;this portion of the program makes all ascii lowercase
begin		lfsr	0,0x200
			lfsr	1,0x210
			movlw	count
			movwf	counter
here		movlw	0x60
			cpfsgt	INDF0
			call 	swapcase
			movff	INDF0,INDF1
cont		incf	FSR0L
			incf	FSR1L
			decf	counter
			bnz		here
;this portion of the program sorts the ascii alphabetically
restart		lfsr	0,0x210
			lfsr	1,0x211
			clrf	watch
			movlw	count
			movwf	counter
next		movf	INDF0, W
			cpfsgt	INDF1
			call	swap
			incf	FSR0L
			incf	FSR1L
			decf	counter
			bnz		next
			movf	watch, w
			bnz		restart
			bra		$

;this determines if locations need swapped
swap		movff	INDF1, temp
			movwf	INDF1
			movff	temp, INDF0
			clrf	temp
			setf	watch
			return
			

;loading ASCII characters-------------
letteradd	movwf	POSTINC0
			decf	counter
			bz		begin
			return
;swapping all ascii to lowercase------
swapcase	movf	INDF0,W
			addlw	0x20
			movwf	INDF1
			goto	cont			
			end