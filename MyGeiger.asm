
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;MyGeiger.mbas,306 :: 		sub procedure interrupt()             ' Interrupt Settings
;MyGeiger.mbas,307 :: 		if (TMR0IF_bit = 1) then
	BTFSS      TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
	GOTO       L__interrupt2
;MyGeiger.mbas,309 :: 		if (buzzer_counter = 4) then
	MOVF       _buzzer_counter+0, 0
	XORLW      4
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt5
;MyGeiger.mbas,310 :: 		PORTB.3 = 0
	BCF        PORTB+0, 3
;MyGeiger.mbas,311 :: 		buzzer_counter = 0
	CLRF       _buzzer_counter+0
;MyGeiger.mbas,312 :: 		buzzer_started = 0
	BCF        _buzzer_started+0, BitPos(_buzzer_started+0)
	GOTO       L__interrupt6
;MyGeiger.mbas,313 :: 		else
L__interrupt5:
;MyGeiger.mbas,314 :: 		if buzzer_started = 1 then
	BTFSS      _buzzer_started+0, BitPos(_buzzer_started+0)
	GOTO       L__interrupt8
;MyGeiger.mbas,315 :: 		PORTB.3 = not PORTB.3
	MOVLW      8
	XORWF      PORTB+0, 1
L__interrupt8:
;MyGeiger.mbas,317 :: 		inc (buzzer_counter)
	INCF       _buzzer_counter+0, 1
;MyGeiger.mbas,318 :: 		end if
L__interrupt6:
;MyGeiger.mbas,319 :: 		TMR0 = 0xD2
	MOVLW      210
	MOVWF      TMR0+0
;MyGeiger.mbas,320 :: 		TMR0IF_bit = 0
	BCF        TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
L__interrupt2:
;MyGeiger.mbas,323 :: 		if (TMR1IF_bit = 1) then             ' Test Timer1 interrupt flag
	BTFSS      TMR1IF_bit+0, BitPos(TMR1IF_bit+0)
	GOTO       L__interrupt11
;MyGeiger.mbas,325 :: 		diode = 0
	BCF        RA1_bit+0, BitPos(RA1_bit+0)
;MyGeiger.mbas,326 :: 		voltage_period = 1
	BSF        _voltage_period+0, BitPos(_voltage_period+0)
;MyGeiger.mbas,327 :: 		if(button_period = 4) then         ' check buttons every 250ms
	MOVF       _button_period+0, 0
	XORLW      4
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt14
;MyGeiger.mbas,328 :: 		klavisha = 1
	BSF        _klavisha+0, BitPos(_klavisha+0)
	GOTO       L__interrupt15
;MyGeiger.mbas,329 :: 		else
L__interrupt14:
;MyGeiger.mbas,330 :: 		inc(button_period)
	INCF       _button_period+0, 1
;MyGeiger.mbas,331 :: 		end if
L__interrupt15:
;MyGeiger.mbas,333 :: 		if(sek_counter = 19) then
	MOVF       _sek_counter+0, 0
	XORLW      19
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt17
;MyGeiger.mbas,334 :: 		sek_counter = 0
	CLRF       _sek_counter+0
;MyGeiger.mbas,335 :: 		sek_cnt = cnt_s
	MOVF       _cnt_s+0, 0
	MOVWF      _sek_cnt+0
	MOVF       _cnt_s+1, 0
	MOVWF      _sek_cnt+1
;MyGeiger.mbas,336 :: 		cnt_s = 0
	CLRF       _cnt_s+0
	CLRF       _cnt_s+1
;MyGeiger.mbas,337 :: 		sek_over = 1
	BSF        _sek_over+0, BitPos(_sek_over+0)
	GOTO       L__interrupt18
;MyGeiger.mbas,338 :: 		else
L__interrupt17:
;MyGeiger.mbas,339 :: 		inc(sek_counter)
	INCF       _sek_counter+0, 1
;MyGeiger.mbas,340 :: 		end if
L__interrupt18:
;MyGeiger.mbas,342 :: 		if(timer_cnt = m_period) then      ' When time elapsed
	MOVF       _timer_cnt+0, 0
	XORWF      _m_period+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt20
;MyGeiger.mbas,343 :: 		counts = cnt                     ' Store result in counts
	MOVF       _cnt+0, 0
	MOVWF      _counts+0
	MOVF       _cnt+1, 0
	MOVWF      _counts+1
;MyGeiger.mbas,344 :: 		cnt = 0                          ' Reset counter
	CLRF       _cnt+0
	CLRF       _cnt+1
;MyGeiger.mbas,345 :: 		timer_cnt = 0                    ' Reset timer_cnt
	CLRF       _timer_cnt+0
;MyGeiger.mbas,346 :: 		cpm_read_done = 1                ' Set flag = 1
	BSF        _cpm_read_done+0, BitPos(_cpm_read_done+0)
	GOTO       L__interrupt21
;MyGeiger.mbas,347 :: 		else
L__interrupt20:
;MyGeiger.mbas,348 :: 		inc(timer_cnt)                   ' Increment timer_cnt if not elapsed 10 second
	INCF       _timer_cnt+0, 1
;MyGeiger.mbas,349 :: 		end if
L__interrupt21:
;MyGeiger.mbas,351 :: 		TMR1H = 0xE7                       ' First write higher byte to TMR1 0xCF2C
	MOVLW      231
	MOVWF      TMR1H+0
;MyGeiger.mbas,352 :: 		TMR1L = 0x96                       ' Write lower byte to TMR1
	MOVLW      150
	MOVWF      TMR1L+0
;MyGeiger.mbas,353 :: 		TMR1IF_bit = 0                     ' Clear Timer1 interrupt flag
	BCF        TMR1IF_bit+0, BitPos(TMR1IF_bit+0)
L__interrupt11:
;MyGeiger.mbas,357 :: 		if(INTF_bit) then                    ' Test RB0/INT interrupt flag
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L__interrupt23
;MyGeiger.mbas,358 :: 		cnt = cnt + 1                      ' Count interrupts on RB0/INT pin
	INCF       _cnt+0, 1
	BTFSC      STATUS+0, 2
	INCF       _cnt+1, 1
;MyGeiger.mbas,359 :: 		cnt_s = cnt_s + 1
	INCF       _cnt_s+0, 1
	BTFSC      STATUS+0, 2
	INCF       _cnt_s+1, 1
;MyGeiger.mbas,361 :: 		if sound = 1 then
	BTFSS      _sound+0, BitPos(_sound+0)
	GOTO       L__interrupt26
;MyGeiger.mbas,362 :: 		buzzer_started = 1
	BSF        _buzzer_started+0, BitPos(_buzzer_started+0)
;MyGeiger.mbas,363 :: 		buzzer_counter = 0
	CLRF       _buzzer_counter+0
;MyGeiger.mbas,364 :: 		PORTB.3 = 1
	BSF        PORTB+0, 3
;MyGeiger.mbas,365 :: 		TMR0 = 0xD2
	MOVLW      210
	MOVWF      TMR0+0
;MyGeiger.mbas,366 :: 		TMR0IE_bit = 1
	BSF        TMR0IE_bit+0, BitPos(TMR0IE_bit+0)
L__interrupt26:
;MyGeiger.mbas,369 :: 		PORTB.1 = 1                        ' Generate Interrupt for external MCU
	BSF        PORTB+0, 1
;MyGeiger.mbas,370 :: 		nop
	NOP
;MyGeiger.mbas,371 :: 		PORTB.1 = 0
	BCF        PORTB+0, 1
;MyGeiger.mbas,372 :: 		event = 1
	BSF        _event+0, BitPos(_event+0)
;MyGeiger.mbas,373 :: 		INTF_bit = 0                       ' Clear RB0/INT interrupt flag
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
L__interrupt23:
;MyGeiger.mbas,377 :: 		end sub
L_end_interrupt:
L__interrupt417:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_NOK_init:

;MyGeiger.mbas,380 :: 		sub procedure NOK_init()
;MyGeiger.mbas,382 :: 		ddata = 0
	BCF        PORTC+0, 1
;MyGeiger.mbas,383 :: 		SPI1_Write (0x21)
	MOVLW      33
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,384 :: 		SPI1_Write (0xBF)      'C5    0xBF if display are too dark
	MOVLW      191
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,385 :: 		SPI1_Write (0x06)
	MOVLW      6
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,386 :: 		SPI1_Write (0x13)
	MOVLW      19
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,387 :: 		SPI1_Write (0x20)
	MOVLW      32
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,388 :: 		SPI1_Write (0x0C)
	MOVLW      12
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,389 :: 		ddata = 1
	BSF        PORTC+0, 1
;MyGeiger.mbas,391 :: 		end sub
L_end_NOK_init:
	RETURN
; end of _NOK_init

_NOK_clear:

;MyGeiger.mbas,393 :: 		sub procedure NOK_clear()
;MyGeiger.mbas,394 :: 		ddata = 1
	BSF        PORTC+0, 1
;MyGeiger.mbas,395 :: 		for nn = 0 to 503
	CLRF       _nn+0
	CLRF       _nn+1
L__NOK_clear31:
;MyGeiger.mbas,396 :: 		SPI1_Write (0x00)
	CLRF       FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,397 :: 		next nn
	MOVF       _nn+1, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__NOK_clear420
	MOVLW      247
	XORWF      _nn+0, 0
L__NOK_clear420:
	BTFSC      STATUS+0, 2
	GOTO       L__NOK_clear34
	INCF       _nn+0, 1
	BTFSC      STATUS+0, 2
	INCF       _nn+1, 1
	GOTO       L__NOK_clear31
L__NOK_clear34:
;MyGeiger.mbas,400 :: 		end sub
L_end_NOK_clear:
	RETURN
; end of _NOK_clear

_NOK_goto:

;MyGeiger.mbas,402 :: 		sub procedure NOK_goto(Dim x,y as byte)
;MyGeiger.mbas,404 :: 		SetBit(x,7)
	BSF        FARG_NOK_goto_x+0, 7
;MyGeiger.mbas,405 :: 		SetBit(y,6)
	BSF        FARG_NOK_goto_y+0, 6
;MyGeiger.mbas,406 :: 		ddata = 0
	BCF        PORTC+0, 1
;MyGeiger.mbas,407 :: 		SPI1_Write (y)
	MOVF       FARG_NOK_goto_y+0, 0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,408 :: 		SPI1_Write (x)
	MOVF       FARG_NOK_goto_x+0, 0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,409 :: 		ddata = 1
	BSF        PORTC+0, 1
;MyGeiger.mbas,411 :: 		end sub
L_end_NOK_goto:
	RETURN
; end of _NOK_goto

_NOK_Chr:

;MyGeiger.mbas,414 :: 		Dim l, m as Byte
;MyGeiger.mbas,416 :: 		For l = 1 to 5
	MOVLW      1
	MOVWF      NOK_Chr_l+0
L__NOK_Chr38:
;MyGeiger.mbas,417 :: 		m = (symlcd - 32)
	MOVLW      32
	SUBWF      FARG_NOK_Chr_symlcd+0, 0
	MOVWF      R0+0
;MyGeiger.mbas,418 :: 		m = m * 5
	MOVLW      5
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
;MyGeiger.mbas,419 :: 		m = m + l
	MOVF       NOK_Chr_l+0, 0
	ADDWF      R0+0, 1
;MyGeiger.mbas,420 :: 		m = m - 1
	DECF       R0+0, 1
;MyGeiger.mbas,421 :: 		SPI1_Write(fontlookup1[m])
	MOVLW      0
	MOVWF      R0+1
	MOVLW      _fontlookup1+0
	ADDWF      R0+0, 1
	MOVLW      hi_addr(_fontlookup1+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      R0+1, 1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,422 :: 		Next l
	MOVF       NOK_Chr_l+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L__NOK_Chr41
	INCF       NOK_Chr_l+0, 1
	GOTO       L__NOK_Chr38
L__NOK_Chr41:
;MyGeiger.mbas,423 :: 		SPI1_Write(0x00)          ' Space between characters
	CLRF       FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,425 :: 		end sub
L_end_NOK_Chr:
	RETURN
; end of _NOK_Chr

_NOK_Out:

;MyGeiger.mbas,427 :: 		Dim v as byte
;MyGeiger.mbas,429 :: 		NOK_goto(x,y)
	MOVF       FARG_NOK_Out_x+0, 0
	MOVWF      FARG_NOK_goto_x+0
	MOVF       FARG_NOK_Out_y+0, 0
	MOVWF      FARG_NOK_goto_y+0
	CALL       _NOK_goto+0
;MyGeiger.mbas,430 :: 		For v = 0 to length(sentance)-1
	CLRF       NOK_Out_v+0
L__NOK_Out43:
	MOVF       FARG_NOK_Out_sentance+0, 0
	MOVWF      FARG_Length_Text+0
	CALL       _Length+0
	MOVLW      1
	SUBWF      R0+0, 0
	MOVWF      FLOC__NOK_Out+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      R0+1, 0
	MOVWF      FLOC__NOK_Out+1
	MOVLW      0
	SUBWF      FLOC__NOK_Out+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__NOK_Out424
	MOVF       NOK_Out_v+0, 0
	SUBWF      FLOC__NOK_Out+0, 0
L__NOK_Out424:
	BTFSS      STATUS+0, 0
	GOTO       L__NOK_Out47
;MyGeiger.mbas,431 :: 		NOK_Chr(sentance[v])
	MOVF       NOK_Out_v+0, 0
	ADDWF      FARG_NOK_Out_sentance+0, 0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      FARG_NOK_Chr_symlcd+0
	CALL       _NOK_Chr+0
;MyGeiger.mbas,432 :: 		Next v
	MOVLW      0
	XORWF      FLOC__NOK_Out+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__NOK_Out425
	MOVF       FLOC__NOK_Out+0, 0
	XORWF      NOK_Out_v+0, 0
L__NOK_Out425:
	BTFSC      STATUS+0, 2
	GOTO       L__NOK_Out47
	INCF       NOK_Out_v+0, 1
	GOTO       L__NOK_Out43
L__NOK_Out47:
;MyGeiger.mbas,433 :: 		End Sub
L_end_NOK_Out:
	RETURN
; end of _NOK_Out

_NOK_Chr_Big:

;MyGeiger.mbas,436 :: 		dim hh as byte
;MyGeiger.mbas,438 :: 		NOK_goto (px, py)
	MOVF       FARG_NOK_Chr_Big_px+0, 0
	MOVWF      FARG_NOK_goto_x+0
	MOVF       FARG_NOK_Chr_Big_py+0, 0
	MOVWF      FARG_NOK_goto_y+0
	CALL       _NOK_goto+0
;MyGeiger.mbas,439 :: 		py = py + 1
	INCF       FARG_NOK_Chr_Big_py+0, 1
;MyGeiger.mbas,440 :: 		digit = 48+digit
	MOVF       FARG_NOK_Chr_Big_digit+0, 0
	ADDLW      48
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      FARG_NOK_Chr_Big_digit+0
;MyGeiger.mbas,441 :: 		if digit = "0" then
	MOVF       R1+0, 0
	XORLW      48
	BTFSS      STATUS+0, 2
	GOTO       L__NOK_Chr_Big50
;MyGeiger.mbas,442 :: 		for hh = 0 to 11
	CLRF       NOK_Chr_Big_hh+0
L__NOK_Chr_Big53:
;MyGeiger.mbas,443 :: 		SPI1_Write (Zero[hh])
	MOVF       NOK_Chr_Big_hh+0, 0
	ADDLW      _Zero+0
	MOVWF      R0+0
	MOVLW      hi_addr(_Zero+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,444 :: 		next hh
	MOVF       NOK_Chr_Big_hh+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L__NOK_Chr_Big56
	INCF       NOK_Chr_Big_hh+0, 1
	GOTO       L__NOK_Chr_Big53
L__NOK_Chr_Big56:
;MyGeiger.mbas,445 :: 		NOK_goto (px, py)
	MOVF       FARG_NOK_Chr_Big_px+0, 0
	MOVWF      FARG_NOK_goto_x+0
	MOVF       FARG_NOK_Chr_Big_py+0, 0
	MOVWF      FARG_NOK_goto_y+0
	CALL       _NOK_goto+0
;MyGeiger.mbas,446 :: 		for hh = 12 to 23
	MOVLW      12
	MOVWF      NOK_Chr_Big_hh+0
L__NOK_Chr_Big58:
;MyGeiger.mbas,447 :: 		SPI1_Write (Zero[hh])
	MOVF       NOK_Chr_Big_hh+0, 0
	ADDLW      _Zero+0
	MOVWF      R0+0
	MOVLW      hi_addr(_Zero+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,448 :: 		next hh
	MOVF       NOK_Chr_Big_hh+0, 0
	XORLW      23
	BTFSC      STATUS+0, 2
	GOTO       L__NOK_Chr_Big61
	INCF       NOK_Chr_Big_hh+0, 1
	GOTO       L__NOK_Chr_Big58
L__NOK_Chr_Big61:
L__NOK_Chr_Big50:
;MyGeiger.mbas,451 :: 		if digit = "1" then
	MOVF       FARG_NOK_Chr_Big_digit+0, 0
	XORLW      49
	BTFSS      STATUS+0, 2
	GOTO       L__NOK_Chr_Big63
;MyGeiger.mbas,452 :: 		for hh = 0 to 11
	CLRF       NOK_Chr_Big_hh+0
L__NOK_Chr_Big66:
;MyGeiger.mbas,453 :: 		SPI1_Write (One[hh])
	MOVF       NOK_Chr_Big_hh+0, 0
	ADDLW      _One+0
	MOVWF      R0+0
	MOVLW      hi_addr(_One+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,454 :: 		next hh
	MOVF       NOK_Chr_Big_hh+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L__NOK_Chr_Big69
	INCF       NOK_Chr_Big_hh+0, 1
	GOTO       L__NOK_Chr_Big66
L__NOK_Chr_Big69:
;MyGeiger.mbas,455 :: 		NOK_goto (px, py)
	MOVF       FARG_NOK_Chr_Big_px+0, 0
	MOVWF      FARG_NOK_goto_x+0
	MOVF       FARG_NOK_Chr_Big_py+0, 0
	MOVWF      FARG_NOK_goto_y+0
	CALL       _NOK_goto+0
;MyGeiger.mbas,456 :: 		for hh = 12 to 23
	MOVLW      12
	MOVWF      NOK_Chr_Big_hh+0
L__NOK_Chr_Big71:
;MyGeiger.mbas,457 :: 		SPI1_Write (One[hh])
	MOVF       NOK_Chr_Big_hh+0, 0
	ADDLW      _One+0
	MOVWF      R0+0
	MOVLW      hi_addr(_One+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,458 :: 		next hh
	MOVF       NOK_Chr_Big_hh+0, 0
	XORLW      23
	BTFSC      STATUS+0, 2
	GOTO       L__NOK_Chr_Big74
	INCF       NOK_Chr_Big_hh+0, 1
	GOTO       L__NOK_Chr_Big71
L__NOK_Chr_Big74:
L__NOK_Chr_Big63:
;MyGeiger.mbas,461 :: 		if digit = "2" then
	MOVF       FARG_NOK_Chr_Big_digit+0, 0
	XORLW      50
	BTFSS      STATUS+0, 2
	GOTO       L__NOK_Chr_Big76
;MyGeiger.mbas,462 :: 		for hh = 0 to 11
	CLRF       NOK_Chr_Big_hh+0
L__NOK_Chr_Big79:
;MyGeiger.mbas,463 :: 		SPI1_Write (Two[hh])
	MOVF       NOK_Chr_Big_hh+0, 0
	ADDLW      _Two+0
	MOVWF      R0+0
	MOVLW      hi_addr(_Two+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,464 :: 		next hh
	MOVF       NOK_Chr_Big_hh+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L__NOK_Chr_Big82
	INCF       NOK_Chr_Big_hh+0, 1
	GOTO       L__NOK_Chr_Big79
L__NOK_Chr_Big82:
;MyGeiger.mbas,465 :: 		NOK_goto (px, py)
	MOVF       FARG_NOK_Chr_Big_px+0, 0
	MOVWF      FARG_NOK_goto_x+0
	MOVF       FARG_NOK_Chr_Big_py+0, 0
	MOVWF      FARG_NOK_goto_y+0
	CALL       _NOK_goto+0
;MyGeiger.mbas,466 :: 		for hh = 12 to 23
	MOVLW      12
	MOVWF      NOK_Chr_Big_hh+0
L__NOK_Chr_Big84:
;MyGeiger.mbas,467 :: 		SPI1_Write (Two[hh])
	MOVF       NOK_Chr_Big_hh+0, 0
	ADDLW      _Two+0
	MOVWF      R0+0
	MOVLW      hi_addr(_Two+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,468 :: 		next hh
	MOVF       NOK_Chr_Big_hh+0, 0
	XORLW      23
	BTFSC      STATUS+0, 2
	GOTO       L__NOK_Chr_Big87
	INCF       NOK_Chr_Big_hh+0, 1
	GOTO       L__NOK_Chr_Big84
L__NOK_Chr_Big87:
L__NOK_Chr_Big76:
;MyGeiger.mbas,471 :: 		if digit = "3" then
	MOVF       FARG_NOK_Chr_Big_digit+0, 0
	XORLW      51
	BTFSS      STATUS+0, 2
	GOTO       L__NOK_Chr_Big89
;MyGeiger.mbas,472 :: 		for hh = 0 to 11
	CLRF       NOK_Chr_Big_hh+0
L__NOK_Chr_Big92:
;MyGeiger.mbas,473 :: 		SPI1_Write (Thre[hh])
	MOVF       NOK_Chr_Big_hh+0, 0
	ADDLW      _Thre+0
	MOVWF      R0+0
	MOVLW      hi_addr(_Thre+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,474 :: 		next hh
	MOVF       NOK_Chr_Big_hh+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L__NOK_Chr_Big95
	INCF       NOK_Chr_Big_hh+0, 1
	GOTO       L__NOK_Chr_Big92
L__NOK_Chr_Big95:
;MyGeiger.mbas,475 :: 		NOK_goto (px, py)
	MOVF       FARG_NOK_Chr_Big_px+0, 0
	MOVWF      FARG_NOK_goto_x+0
	MOVF       FARG_NOK_Chr_Big_py+0, 0
	MOVWF      FARG_NOK_goto_y+0
	CALL       _NOK_goto+0
;MyGeiger.mbas,476 :: 		for hh = 12 to 23
	MOVLW      12
	MOVWF      NOK_Chr_Big_hh+0
L__NOK_Chr_Big97:
;MyGeiger.mbas,477 :: 		SPI1_Write (Thre[hh])
	MOVF       NOK_Chr_Big_hh+0, 0
	ADDLW      _Thre+0
	MOVWF      R0+0
	MOVLW      hi_addr(_Thre+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,478 :: 		next hh
	MOVF       NOK_Chr_Big_hh+0, 0
	XORLW      23
	BTFSC      STATUS+0, 2
	GOTO       L__NOK_Chr_Big100
	INCF       NOK_Chr_Big_hh+0, 1
	GOTO       L__NOK_Chr_Big97
L__NOK_Chr_Big100:
L__NOK_Chr_Big89:
;MyGeiger.mbas,481 :: 		if digit = "4" then
	MOVF       FARG_NOK_Chr_Big_digit+0, 0
	XORLW      52
	BTFSS      STATUS+0, 2
	GOTO       L__NOK_Chr_Big102
;MyGeiger.mbas,482 :: 		for hh = 0 to 11
	CLRF       NOK_Chr_Big_hh+0
L__NOK_Chr_Big105:
;MyGeiger.mbas,483 :: 		SPI1_Write (Four[hh])
	MOVF       NOK_Chr_Big_hh+0, 0
	ADDLW      _Four+0
	MOVWF      R0+0
	MOVLW      hi_addr(_Four+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,484 :: 		next hh
	MOVF       NOK_Chr_Big_hh+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L__NOK_Chr_Big108
	INCF       NOK_Chr_Big_hh+0, 1
	GOTO       L__NOK_Chr_Big105
L__NOK_Chr_Big108:
;MyGeiger.mbas,485 :: 		NOK_goto (px, py)
	MOVF       FARG_NOK_Chr_Big_px+0, 0
	MOVWF      FARG_NOK_goto_x+0
	MOVF       FARG_NOK_Chr_Big_py+0, 0
	MOVWF      FARG_NOK_goto_y+0
	CALL       _NOK_goto+0
;MyGeiger.mbas,486 :: 		for hh = 12 to 23
	MOVLW      12
	MOVWF      NOK_Chr_Big_hh+0
L__NOK_Chr_Big110:
;MyGeiger.mbas,487 :: 		SPI1_Write (Four[hh])
	MOVF       NOK_Chr_Big_hh+0, 0
	ADDLW      _Four+0
	MOVWF      R0+0
	MOVLW      hi_addr(_Four+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,488 :: 		next hh
	MOVF       NOK_Chr_Big_hh+0, 0
	XORLW      23
	BTFSC      STATUS+0, 2
	GOTO       L__NOK_Chr_Big113
	INCF       NOK_Chr_Big_hh+0, 1
	GOTO       L__NOK_Chr_Big110
L__NOK_Chr_Big113:
L__NOK_Chr_Big102:
;MyGeiger.mbas,491 :: 		if digit = "5" then
	MOVF       FARG_NOK_Chr_Big_digit+0, 0
	XORLW      53
	BTFSS      STATUS+0, 2
	GOTO       L__NOK_Chr_Big115
;MyGeiger.mbas,492 :: 		for hh = 0 to 11
	CLRF       NOK_Chr_Big_hh+0
L__NOK_Chr_Big118:
;MyGeiger.mbas,493 :: 		SPI1_Write (Five[hh])
	MOVF       NOK_Chr_Big_hh+0, 0
	ADDLW      _Five+0
	MOVWF      R0+0
	MOVLW      hi_addr(_Five+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,494 :: 		next hh
	MOVF       NOK_Chr_Big_hh+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L__NOK_Chr_Big121
	INCF       NOK_Chr_Big_hh+0, 1
	GOTO       L__NOK_Chr_Big118
L__NOK_Chr_Big121:
;MyGeiger.mbas,495 :: 		NOK_goto (px, py)
	MOVF       FARG_NOK_Chr_Big_px+0, 0
	MOVWF      FARG_NOK_goto_x+0
	MOVF       FARG_NOK_Chr_Big_py+0, 0
	MOVWF      FARG_NOK_goto_y+0
	CALL       _NOK_goto+0
;MyGeiger.mbas,496 :: 		for hh = 12 to 23
	MOVLW      12
	MOVWF      NOK_Chr_Big_hh+0
L__NOK_Chr_Big123:
;MyGeiger.mbas,497 :: 		SPI1_Write (Five[hh])
	MOVF       NOK_Chr_Big_hh+0, 0
	ADDLW      _Five+0
	MOVWF      R0+0
	MOVLW      hi_addr(_Five+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,498 :: 		next hh
	MOVF       NOK_Chr_Big_hh+0, 0
	XORLW      23
	BTFSC      STATUS+0, 2
	GOTO       L__NOK_Chr_Big126
	INCF       NOK_Chr_Big_hh+0, 1
	GOTO       L__NOK_Chr_Big123
L__NOK_Chr_Big126:
L__NOK_Chr_Big115:
;MyGeiger.mbas,501 :: 		if digit = "6" then
	MOVF       FARG_NOK_Chr_Big_digit+0, 0
	XORLW      54
	BTFSS      STATUS+0, 2
	GOTO       L__NOK_Chr_Big128
;MyGeiger.mbas,502 :: 		for hh = 0 to 11
	CLRF       NOK_Chr_Big_hh+0
L__NOK_Chr_Big131:
;MyGeiger.mbas,503 :: 		SPI1_Write (Six[hh])
	MOVF       NOK_Chr_Big_hh+0, 0
	ADDLW      _Six+0
	MOVWF      R0+0
	MOVLW      hi_addr(_Six+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,504 :: 		next hh
	MOVF       NOK_Chr_Big_hh+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L__NOK_Chr_Big134
	INCF       NOK_Chr_Big_hh+0, 1
	GOTO       L__NOK_Chr_Big131
L__NOK_Chr_Big134:
;MyGeiger.mbas,505 :: 		NOK_goto (px, py)
	MOVF       FARG_NOK_Chr_Big_px+0, 0
	MOVWF      FARG_NOK_goto_x+0
	MOVF       FARG_NOK_Chr_Big_py+0, 0
	MOVWF      FARG_NOK_goto_y+0
	CALL       _NOK_goto+0
;MyGeiger.mbas,506 :: 		for hh = 12 to 23
	MOVLW      12
	MOVWF      NOK_Chr_Big_hh+0
L__NOK_Chr_Big136:
;MyGeiger.mbas,507 :: 		SPI1_Write (Six[hh])
	MOVF       NOK_Chr_Big_hh+0, 0
	ADDLW      _Six+0
	MOVWF      R0+0
	MOVLW      hi_addr(_Six+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,508 :: 		next hh
	MOVF       NOK_Chr_Big_hh+0, 0
	XORLW      23
	BTFSC      STATUS+0, 2
	GOTO       L__NOK_Chr_Big139
	INCF       NOK_Chr_Big_hh+0, 1
	GOTO       L__NOK_Chr_Big136
L__NOK_Chr_Big139:
L__NOK_Chr_Big128:
;MyGeiger.mbas,511 :: 		if digit = "7" then
	MOVF       FARG_NOK_Chr_Big_digit+0, 0
	XORLW      55
	BTFSS      STATUS+0, 2
	GOTO       L__NOK_Chr_Big141
;MyGeiger.mbas,512 :: 		for hh = 0 to 11
	CLRF       NOK_Chr_Big_hh+0
L__NOK_Chr_Big144:
;MyGeiger.mbas,513 :: 		SPI1_Write (Seven[hh])
	MOVF       NOK_Chr_Big_hh+0, 0
	ADDLW      _Seven+0
	MOVWF      R0+0
	MOVLW      hi_addr(_Seven+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,514 :: 		next hh
	MOVF       NOK_Chr_Big_hh+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L__NOK_Chr_Big147
	INCF       NOK_Chr_Big_hh+0, 1
	GOTO       L__NOK_Chr_Big144
L__NOK_Chr_Big147:
;MyGeiger.mbas,515 :: 		NOK_goto (px, py)
	MOVF       FARG_NOK_Chr_Big_px+0, 0
	MOVWF      FARG_NOK_goto_x+0
	MOVF       FARG_NOK_Chr_Big_py+0, 0
	MOVWF      FARG_NOK_goto_y+0
	CALL       _NOK_goto+0
;MyGeiger.mbas,516 :: 		for hh = 12 to 23
	MOVLW      12
	MOVWF      NOK_Chr_Big_hh+0
L__NOK_Chr_Big149:
;MyGeiger.mbas,517 :: 		SPI1_Write (Seven[hh])
	MOVF       NOK_Chr_Big_hh+0, 0
	ADDLW      _Seven+0
	MOVWF      R0+0
	MOVLW      hi_addr(_Seven+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,518 :: 		next hh
	MOVF       NOK_Chr_Big_hh+0, 0
	XORLW      23
	BTFSC      STATUS+0, 2
	GOTO       L__NOK_Chr_Big152
	INCF       NOK_Chr_Big_hh+0, 1
	GOTO       L__NOK_Chr_Big149
L__NOK_Chr_Big152:
L__NOK_Chr_Big141:
;MyGeiger.mbas,521 :: 		if digit = "8" then
	MOVF       FARG_NOK_Chr_Big_digit+0, 0
	XORLW      56
	BTFSS      STATUS+0, 2
	GOTO       L__NOK_Chr_Big154
;MyGeiger.mbas,522 :: 		for hh = 0 to 11
	CLRF       NOK_Chr_Big_hh+0
L__NOK_Chr_Big157:
;MyGeiger.mbas,523 :: 		SPI1_Write (Eight[hh])
	MOVF       NOK_Chr_Big_hh+0, 0
	ADDLW      _Eight+0
	MOVWF      R0+0
	MOVLW      hi_addr(_Eight+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,524 :: 		next hh
	MOVF       NOK_Chr_Big_hh+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L__NOK_Chr_Big160
	INCF       NOK_Chr_Big_hh+0, 1
	GOTO       L__NOK_Chr_Big157
L__NOK_Chr_Big160:
;MyGeiger.mbas,525 :: 		NOK_goto (px, py)
	MOVF       FARG_NOK_Chr_Big_px+0, 0
	MOVWF      FARG_NOK_goto_x+0
	MOVF       FARG_NOK_Chr_Big_py+0, 0
	MOVWF      FARG_NOK_goto_y+0
	CALL       _NOK_goto+0
;MyGeiger.mbas,526 :: 		for hh = 12 to 23
	MOVLW      12
	MOVWF      NOK_Chr_Big_hh+0
L__NOK_Chr_Big162:
;MyGeiger.mbas,527 :: 		SPI1_Write (Eight[hh])
	MOVF       NOK_Chr_Big_hh+0, 0
	ADDLW      _Eight+0
	MOVWF      R0+0
	MOVLW      hi_addr(_Eight+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,528 :: 		next hh
	MOVF       NOK_Chr_Big_hh+0, 0
	XORLW      23
	BTFSC      STATUS+0, 2
	GOTO       L__NOK_Chr_Big165
	INCF       NOK_Chr_Big_hh+0, 1
	GOTO       L__NOK_Chr_Big162
L__NOK_Chr_Big165:
L__NOK_Chr_Big154:
;MyGeiger.mbas,531 :: 		if digit = "9" then
	MOVF       FARG_NOK_Chr_Big_digit+0, 0
	XORLW      57
	BTFSS      STATUS+0, 2
	GOTO       L__NOK_Chr_Big167
;MyGeiger.mbas,532 :: 		for hh = 0 to 11
	CLRF       NOK_Chr_Big_hh+0
L__NOK_Chr_Big170:
;MyGeiger.mbas,533 :: 		SPI1_Write (Nine[hh])
	MOVF       NOK_Chr_Big_hh+0, 0
	ADDLW      _Nine+0
	MOVWF      R0+0
	MOVLW      hi_addr(_Nine+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,534 :: 		next hh
	MOVF       NOK_Chr_Big_hh+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L__NOK_Chr_Big173
	INCF       NOK_Chr_Big_hh+0, 1
	GOTO       L__NOK_Chr_Big170
L__NOK_Chr_Big173:
;MyGeiger.mbas,535 :: 		NOK_goto (px, py)
	MOVF       FARG_NOK_Chr_Big_px+0, 0
	MOVWF      FARG_NOK_goto_x+0
	MOVF       FARG_NOK_Chr_Big_py+0, 0
	MOVWF      FARG_NOK_goto_y+0
	CALL       _NOK_goto+0
;MyGeiger.mbas,536 :: 		for hh = 12 to 23
	MOVLW      12
	MOVWF      NOK_Chr_Big_hh+0
L__NOK_Chr_Big175:
;MyGeiger.mbas,537 :: 		SPI1_Write (Nine[hh])
	MOVF       NOK_Chr_Big_hh+0, 0
	ADDLW      _Nine+0
	MOVWF      R0+0
	MOVLW      hi_addr(_Nine+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,538 :: 		next hh
	MOVF       NOK_Chr_Big_hh+0, 0
	XORLW      23
	BTFSC      STATUS+0, 2
	GOTO       L__NOK_Chr_Big178
	INCF       NOK_Chr_Big_hh+0, 1
	GOTO       L__NOK_Chr_Big175
L__NOK_Chr_Big178:
L__NOK_Chr_Big167:
;MyGeiger.mbas,541 :: 		end sub
L_end_NOK_Chr_Big:
	RETURN
; end of _NOK_Chr_Big

_calibration:

;MyGeiger.mbas,545 :: 		sub procedure calibration()
;MyGeiger.mbas,547 :: 		TMR1IE_bit = 0
	BCF        TMR1IE_bit+0, BitPos(TMR1IE_bit+0)
;MyGeiger.mbas,548 :: 		TMR0IE_bit = 0
	BCF        TMR0IE_bit+0, BitPos(TMR0IE_bit+0)
;MyGeiger.mbas,549 :: 		INTE_bit = 0
	BCF        INTE_bit+0, BitPos(INTE_bit+0)
;MyGeiger.mbas,550 :: 		PORTB.3 = 0
	BCF        PORTB+0, 3
;MyGeiger.mbas,551 :: 		alert = 0
	BCF        RB2_bit+0, BitPos(RB2_bit+0)
;MyGeiger.mbas,552 :: 		light = 1
	BSF        RA5_bit+0, BitPos(RA5_bit+0)
;MyGeiger.mbas,553 :: 		diode = 0
	BCF        RA1_bit+0, BitPos(RA1_bit+0)
;MyGeiger.mbas,555 :: 		bbb = BAT_START         ' first start PWM duty cycle app 25%
	MOVF       _BAT_START+0, 0
	MOVWF      _bbb+0
;MyGeiger.mbas,556 :: 		PR2       = 249         ' Set PWM at 4KHz
	MOVLW      249
	MOVWF      PR2+0
;MyGeiger.mbas,557 :: 		CCPR1L    = bbb         ' Set PWM Duty-Cycle
	MOVF       _BAT_START+0, 0
	MOVWF      CCPR1L+0
;MyGeiger.mbas,558 :: 		CCP1CON   = %00001100   ' Mode select = PWM
	MOVLW      12
	MOVWF      CCP1CON+0
;MyGeiger.mbas,559 :: 		T2CON     = %00000100   ' Timer2 ON prescale
	MOVLW      4
	MOVWF      T2CON+0
;MyGeiger.mbas,561 :: 		NOK_clear()
	CALL       _NOK_clear+0
;MyGeiger.mbas,562 :: 		NOK_goto (30, 4)
	MOVLW      30
	MOVWF      FARG_NOK_goto_x+0
	MOVLW      4
	MOVWF      FARG_NOK_goto_y+0
	CALL       _NOK_goto+0
;MyGeiger.mbas,563 :: 		for nn = 0 to 22
	CLRF       _nn+0
	CLRF       _nn+1
L__calibration181:
;MyGeiger.mbas,564 :: 		SPI1_Write (calib_label[nn])
	MOVF       _nn+0, 0
	ADDLW      _calib_label+0
	MOVWF      R0+0
	MOVLW      hi_addr(_calib_label+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _nn+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,565 :: 		next nn
	MOVLW      0
	XORWF      _nn+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration428
	MOVLW      22
	XORWF      _nn+0, 0
L__calibration428:
	BTFSC      STATUS+0, 2
	GOTO       L__calibration184
	INCF       _nn+0, 1
	BTFSC      STATUS+0, 2
	INCF       _nn+1, 1
	GOTO       L__calibration181
L__calibration184:
;MyGeiger.mbas,568 :: 		NOK_Out(0, 0, "*   0.0      *")
	CLRF       FARG_NOK_Out_x+0
	CLRF       FARG_NOK_Out_y+0
	MOVLW      42
	MOVWF      ?LocalText_calibration+0
	MOVLW      32
	MOVWF      ?LocalText_calibration+1
	MOVLW      32
	MOVWF      ?LocalText_calibration+2
	MOVLW      32
	MOVWF      ?LocalText_calibration+3
	MOVLW      48
	MOVWF      ?LocalText_calibration+4
	MOVLW      46
	MOVWF      ?LocalText_calibration+5
	MOVLW      48
	MOVWF      ?LocalText_calibration+6
	MOVLW      32
	MOVWF      ?LocalText_calibration+7
	MOVLW      32
	MOVWF      ?LocalText_calibration+8
	MOVLW      32
	MOVWF      ?LocalText_calibration+9
	MOVLW      32
	MOVWF      ?LocalText_calibration+10
	MOVLW      32
	MOVWF      ?LocalText_calibration+11
	MOVLW      32
	MOVWF      ?LocalText_calibration+12
	MOVLW      42
	MOVWF      ?LocalText_calibration+13
	CLRF       ?LocalText_calibration+14
	MOVLW      ?LocalText_calibration+0
	MOVWF      FARG_NOK_Out_sentance+0
	CALL       _NOK_Out+0
;MyGeiger.mbas,570 :: 		ch = (CF div 100) mod 10
	MOVLW      100
	MOVWF      R4+0
	CLRF       R4+1
	MOVF       _CF+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	CALL       _Div_16x16_U+0
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Div_16x16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _ch+0
	MOVF       R0+1, 0
	MOVWF      _ch+1
;MyGeiger.mbas,571 :: 		NOK_goto(42, 0)
	MOVLW      42
	MOVWF      FARG_NOK_goto_x+0
	CLRF       FARG_NOK_goto_y+0
	CALL       _NOK_goto+0
;MyGeiger.mbas,572 :: 		NOK_Chr (48+ch)
	MOVF       _ch+0, 0
	ADDLW      48
	MOVWF      FARG_NOK_Chr_symlcd+0
	CALL       _NOK_Chr+0
;MyGeiger.mbas,573 :: 		ch = (CF div 10) mod 10
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	MOVF       _CF+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	CALL       _Div_16x16_U+0
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Div_16x16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _ch+0
	MOVF       R0+1, 0
	MOVWF      _ch+1
;MyGeiger.mbas,574 :: 		NOK_Chr (48+ch)
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_NOK_Chr_symlcd+0
	CALL       _NOK_Chr+0
;MyGeiger.mbas,575 :: 		ch = CF mod 10
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	MOVF       _CF+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	CALL       _Div_16x16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _ch+0
	MOVF       R0+1, 0
	MOVWF      _ch+1
;MyGeiger.mbas,576 :: 		NOK_Chr (48+ch)
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_NOK_Chr_symlcd+0
	CALL       _NOK_Chr+0
;MyGeiger.mbas,580 :: 		while (1)
L__calibration187:
;MyGeiger.mbas,581 :: 		if Button (PORTB, 7, 150, 1) then
	MOVLW      PORTB+0
	MOVWF      FARG_Button_port+0
	MOVLW      7
	MOVWF      FARG_Button_pin+0
	MOVLW      150
	MOVWF      FARG_Button_time+0
	MOVLW      1
	MOVWF      FARG_Button_activeState+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L__calibration192
;MyGeiger.mbas,582 :: 		inc (CF)
	INCF       _CF+0, 1
;MyGeiger.mbas,583 :: 		if CF> 0xFA then
	MOVF       _CF+0, 0
	SUBLW      250
	BTFSC      STATUS+0, 0
	GOTO       L__calibration195
;MyGeiger.mbas,584 :: 		dec (CF)
	DECF       _CF+0, 1
L__calibration195:
;MyGeiger.mbas,586 :: 		ch = (CF div 100) mod 10
	MOVLW      100
	MOVWF      R4+0
	CLRF       R4+1
	MOVF       _CF+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	CALL       _Div_16x16_U+0
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Div_16x16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _ch+0
	MOVF       R0+1, 0
	MOVWF      _ch+1
;MyGeiger.mbas,587 :: 		NOK_goto(42, 0)
	MOVLW      42
	MOVWF      FARG_NOK_goto_x+0
	CLRF       FARG_NOK_goto_y+0
	CALL       _NOK_goto+0
;MyGeiger.mbas,588 :: 		NOK_Chr (48+ch)
	MOVF       _ch+0, 0
	ADDLW      48
	MOVWF      FARG_NOK_Chr_symlcd+0
	CALL       _NOK_Chr+0
;MyGeiger.mbas,589 :: 		ch = (CF div 10) mod 10
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	MOVF       _CF+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	CALL       _Div_16x16_U+0
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Div_16x16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _ch+0
	MOVF       R0+1, 0
	MOVWF      _ch+1
;MyGeiger.mbas,590 :: 		NOK_Chr (48+ch)
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_NOK_Chr_symlcd+0
	CALL       _NOK_Chr+0
;MyGeiger.mbas,591 :: 		ch = CF mod 10
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	MOVF       _CF+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	CALL       _Div_16x16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _ch+0
	MOVF       R0+1, 0
	MOVWF      _ch+1
;MyGeiger.mbas,592 :: 		NOK_Chr (48+ch)
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_NOK_Chr_symlcd+0
	CALL       _NOK_Chr+0
L__calibration192:
;MyGeiger.mbas,596 :: 		if Button (PORTB, 6, 150, 1) then
	MOVLW      PORTB+0
	MOVWF      FARG_Button_port+0
	MOVLW      6
	MOVWF      FARG_Button_pin+0
	MOVLW      150
	MOVWF      FARG_Button_time+0
	MOVLW      1
	MOVWF      FARG_Button_activeState+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L__calibration198
;MyGeiger.mbas,597 :: 		dec (CF)
	DECF       _CF+0, 1
;MyGeiger.mbas,598 :: 		if CF<0x01 then
	MOVLW      1
	SUBWF      _CF+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L__calibration201
;MyGeiger.mbas,599 :: 		inc (CF)
	INCF       _CF+0, 1
L__calibration201:
;MyGeiger.mbas,601 :: 		ch = (CF div 100) mod 10
	MOVLW      100
	MOVWF      R4+0
	CLRF       R4+1
	MOVF       _CF+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	CALL       _Div_16x16_U+0
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Div_16x16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _ch+0
	MOVF       R0+1, 0
	MOVWF      _ch+1
;MyGeiger.mbas,602 :: 		NOK_goto(42, 0)
	MOVLW      42
	MOVWF      FARG_NOK_goto_x+0
	CLRF       FARG_NOK_goto_y+0
	CALL       _NOK_goto+0
;MyGeiger.mbas,603 :: 		NOK_Chr (48+ch)
	MOVF       _ch+0, 0
	ADDLW      48
	MOVWF      FARG_NOK_Chr_symlcd+0
	CALL       _NOK_Chr+0
;MyGeiger.mbas,604 :: 		ch = (CF div 10) mod 10
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	MOVF       _CF+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	CALL       _Div_16x16_U+0
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CALL       _Div_16x16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _ch+0
	MOVF       R0+1, 0
	MOVWF      _ch+1
;MyGeiger.mbas,605 :: 		NOK_Chr (48+ch)
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_NOK_Chr_symlcd+0
	CALL       _NOK_Chr+0
;MyGeiger.mbas,606 :: 		ch = CF mod 10
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	MOVF       _CF+0, 0
	MOVWF      R0+0
	CLRF       R0+1
	CALL       _Div_16x16_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      _ch+0
	MOVF       R0+1, 0
	MOVWF      _ch+1
;MyGeiger.mbas,607 :: 		NOK_Chr (48+ch)
	MOVF       R0+0, 0
	ADDLW      48
	MOVWF      FARG_NOK_Chr_symlcd+0
	CALL       _NOK_Chr+0
L__calibration198:
;MyGeiger.mbas,611 :: 		if Button (PORTB, 5, 150, 1) then         'ok
	MOVLW      PORTB+0
	MOVWF      FARG_Button_port+0
	MOVLW      5
	MOVWF      FARG_Button_pin+0
	MOVLW      150
	MOVWF      FARG_Button_time+0
	MOVLW      1
	MOVWF      FARG_Button_activeState+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L__calibration204
;MyGeiger.mbas,612 :: 		EEPROM_Write (0x01, CF)
	MOVLW      1
	MOVWF      FARG_EEPROM_Write_address+0
	MOVF       _CF+0, 0
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;MyGeiger.mbas,613 :: 		goto bat_select
	GOTO       L__calibration_bat_select
L__calibration204:
;MyGeiger.mbas,615 :: 		wend
	GOTO       L__calibration187
;MyGeiger.mbas,618 :: 		bat_select:
L__calibration_bat_select:
;MyGeiger.mbas,619 :: 		NOK_goto (30, 5)
	MOVLW      30
	MOVWF      FARG_NOK_goto_x+0
	MOVLW      5
	MOVWF      FARG_NOK_goto_y+0
	CALL       _NOK_goto+0
;MyGeiger.mbas,620 :: 		for nn = 0 to 28
	CLRF       _nn+0
	CLRF       _nn+1
L__calibration208:
;MyGeiger.mbas,621 :: 		SPI1_Write (lipo[nn])
	MOVF       _nn+0, 0
	ADDLW      _lipo+0
	MOVWF      R0+0
	MOVLW      hi_addr(_lipo+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _nn+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,622 :: 		next nn
	MOVLW      0
	XORWF      _nn+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__calibration429
	MOVLW      28
	XORWF      _nn+0, 0
L__calibration429:
	BTFSC      STATUS+0, 2
	GOTO       L__calibration211
	INCF       _nn+0, 1
	BTFSC      STATUS+0, 2
	INCF       _nn+1, 1
	GOTO       L__calibration208
L__calibration211:
;MyGeiger.mbas,623 :: 		if Button (PORTB, 7, 150, 1) then    'YES there is LIPO
	MOVLW      PORTB+0
	MOVWF      FARG_Button_port+0
	MOVLW      7
	MOVWF      FARG_Button_pin+0
	MOVLW      150
	MOVWF      FARG_Button_time+0
	MOVLW      1
	MOVWF      FARG_Button_activeState+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L__calibration213
;MyGeiger.mbas,624 :: 		EEPROM_write (0x00, 0x00)
	CLRF       FARG_EEPROM_Write_address+0
	CLRF       FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;MyGeiger.mbas,625 :: 		goto exit_calibration
	GOTO       L__calibration_exit_calibration
L__calibration213:
;MyGeiger.mbas,627 :: 		if Button (PORTB, 6, 150, 1) then    ' NO, there is Ni-MH
	MOVLW      PORTB+0
	MOVWF      FARG_Button_port+0
	MOVLW      6
	MOVWF      FARG_Button_pin+0
	MOVLW      150
	MOVWF      FARG_Button_time+0
	MOVLW      1
	MOVWF      FARG_Button_activeState+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L__calibration217
;MyGeiger.mbas,628 :: 		EEPROM_write (0x00, 0x01)
	CLRF       FARG_EEPROM_Write_address+0
	MOVLW      1
	MOVWF      FARG_EEPROM_Write_data_+0
	CALL       _EEPROM_Write+0
;MyGeiger.mbas,629 :: 		goto exit_calibration
	GOTO       L__calibration_exit_calibration
L__calibration217:
;MyGeiger.mbas,631 :: 		goto bat_select
	GOTO       L__calibration_bat_select
;MyGeiger.mbas,633 :: 		exit_calibration:
L__calibration_exit_calibration:
;MyGeiger.mbas,635 :: 		NOK_clear()
	CALL       _NOK_clear+0
;MyGeiger.mbas,636 :: 		counts = 0
	CLRF       _counts+0
	CLRF       _counts+1
;MyGeiger.mbas,637 :: 		cpm = 0
	CLRF       _cpm+0
	CLRF       _cpm+1
	CLRF       _cpm+2
	CLRF       _cpm+3
;MyGeiger.mbas,638 :: 		dose = 0
	CLRF       _dose+0
	CLRF       _dose+1
	CLRF       _dose+2
	CLRF       _dose+3
;MyGeiger.mbas,639 :: 		timer_cnt = 0
	CLRF       _timer_cnt+0
;MyGeiger.mbas,640 :: 		cpm_read_done = 0
	BCF        _cpm_read_done+0, BitPos(_cpm_read_done+0)
;MyGeiger.mbas,641 :: 		TMR0 = 0xD2
	MOVLW      210
	MOVWF      TMR0+0
;MyGeiger.mbas,642 :: 		TMR1H = 0xE7                         ' First write higher byte to TMR1
	MOVLW      231
	MOVWF      TMR1H+0
;MyGeiger.mbas,643 :: 		TMR1L = 0x96                         ' Write lower byte to TMR1
	MOVLW      150
	MOVWF      TMR1L+0
;MyGeiger.mbas,644 :: 		TMR1IF_bit = 0
	BCF        TMR1IF_bit+0, BitPos(TMR1IF_bit+0)
;MyGeiger.mbas,645 :: 		TMR0IF_bit = 0
	BCF        TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
;MyGeiger.mbas,646 :: 		TMR1IE_bit = 1
	BSF        TMR1IE_bit+0, BitPos(TMR1IE_bit+0)
;MyGeiger.mbas,647 :: 		TMR0IE_bit = 1
	BSF        TMR0IE_bit+0, BitPos(TMR0IE_bit+0)
;MyGeiger.mbas,648 :: 		INTE_bit   = 1
	BSF        INTE_bit+0, BitPos(INTE_bit+0)
;MyGeiger.mbas,649 :: 		end sub
L_end_calibration:
	RETURN
; end of _calibration

_signalization:

;MyGeiger.mbas,659 :: 		dim txt1 as char[5]
;MyGeiger.mbas,661 :: 		NOK_clear()
	CALL       _NOK_clear+0
;MyGeiger.mbas,662 :: 		NOK_goto (13, 0)
	MOVLW      13
	MOVWF      FARG_NOK_goto_x+0
	CLRF       FARG_NOK_goto_y+0
	CALL       _NOK_goto+0
;MyGeiger.mbas,663 :: 		for nn = 0 to 57
	CLRF       _nn+0
	CLRF       _nn+1
L__signalization221:
;MyGeiger.mbas,664 :: 		SPI1_Write (AAA[nn])
	MOVF       _nn+0, 0
	ADDLW      signalization_AAA+0
	MOVWF      R0+0
	MOVLW      hi_addr(signalization_AAA+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _nn+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,665 :: 		next nn
	MOVLW      0
	XORWF      _nn+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__signalization431
	MOVLW      57
	XORWF      _nn+0, 0
L__signalization431:
	BTFSC      STATUS+0, 2
	GOTO       L__signalization224
	INCF       _nn+0, 1
	BTFSC      STATUS+0, 2
	INCF       _nn+1, 1
	GOTO       L__signalization221
L__signalization224:
;MyGeiger.mbas,666 :: 		NOK_Out(0, 2, "     600      ")
	CLRF       FARG_NOK_Out_x+0
	MOVLW      2
	MOVWF      FARG_NOK_Out_y+0
	MOVLW      32
	MOVWF      ?LocalText_signalization+0
	MOVLW      32
	MOVWF      ?LocalText_signalization+1
	MOVLW      32
	MOVWF      ?LocalText_signalization+2
	MOVLW      32
	MOVWF      ?LocalText_signalization+3
	MOVLW      32
	MOVWF      ?LocalText_signalization+4
	MOVLW      54
	MOVWF      ?LocalText_signalization+5
	MOVLW      48
	MOVWF      ?LocalText_signalization+6
	MOVLW      48
	MOVWF      ?LocalText_signalization+7
	MOVLW      32
	MOVWF      ?LocalText_signalization+8
	MOVLW      32
	MOVWF      ?LocalText_signalization+9
	MOVLW      32
	MOVWF      ?LocalText_signalization+10
	MOVLW      32
	MOVWF      ?LocalText_signalization+11
	MOVLW      32
	MOVWF      ?LocalText_signalization+12
	MOVLW      32
	MOVWF      ?LocalText_signalization+13
	CLRF       ?LocalText_signalization+14
	MOVLW      ?LocalText_signalization+0
	MOVWF      FARG_NOK_Out_sentance+0
	CALL       _NOK_Out+0
;MyGeiger.mbas,667 :: 		ALARM = 600
	MOVLW      88
	MOVWF      _ALARM+0
	MOVLW      2
	MOVWF      _ALARM+1
;MyGeiger.mbas,669 :: 		for zzz = 0 to 30000
	CLRF       signalization_zzz+0
	CLRF       signalization_zzz+1
L__signalization226:
;MyGeiger.mbas,670 :: 		if Button (PORTB, 7, 50, 1) then
	MOVLW      PORTB+0
	MOVWF      FARG_Button_port+0
	MOVLW      7
	MOVWF      FARG_Button_pin+0
	MOVLW      50
	MOVWF      FARG_Button_time+0
	MOVLW      1
	MOVWF      FARG_Button_activeState+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L__signalization231
;MyGeiger.mbas,671 :: 		goto CHANGE
	GOTO       L__signalization_change
L__signalization231:
;MyGeiger.mbas,673 :: 		next zzz
	MOVF       signalization_zzz+1, 0
	XORLW      117
	BTFSS      STATUS+0, 2
	GOTO       L__signalization432
	MOVLW      48
	XORWF      signalization_zzz+0, 0
L__signalization432:
	BTFSC      STATUS+0, 2
	GOTO       L__signalization229
	INCF       signalization_zzz+0, 1
	BTFSC      STATUS+0, 2
	INCF       signalization_zzz+1, 1
	GOTO       L__signalization226
L__signalization229:
;MyGeiger.mbas,674 :: 		goto CHANGE2
	GOTO       L__signalization_change2
;MyGeiger.mbas,676 :: 		CHANGE:
L__signalization_change:
;MyGeiger.mbas,677 :: 		NOK_goto (30, 4)
	MOVLW      30
	MOVWF      FARG_NOK_goto_x+0
	MOVLW      4
	MOVWF      FARG_NOK_goto_y+0
	CALL       _NOK_goto+0
;MyGeiger.mbas,678 :: 		for nn = 0 to 22
	CLRF       _nn+0
	CLRF       _nn+1
L__signalization236:
;MyGeiger.mbas,679 :: 		SPI1_Write (calib_label[nn])
	MOVF       _nn+0, 0
	ADDLW      _calib_label+0
	MOVWF      R0+0
	MOVLW      hi_addr(_calib_label+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _nn+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,680 :: 		next nn
	MOVLW      0
	XORWF      _nn+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__signalization433
	MOVLW      22
	XORWF      _nn+0, 0
L__signalization433:
	BTFSC      STATUS+0, 2
	GOTO       L__signalization239
	INCF       _nn+0, 1
	BTFSC      STATUS+0, 2
	INCF       _nn+1, 1
	GOTO       L__signalization236
L__signalization239:
;MyGeiger.mbas,681 :: 		while (1)
L__signalization241:
;MyGeiger.mbas,682 :: 		if Button (PORTB, 7, 150, 1) then
	MOVLW      PORTB+0
	MOVWF      FARG_Button_port+0
	MOVLW      7
	MOVWF      FARG_Button_pin+0
	MOVLW      150
	MOVWF      FARG_Button_time+0
	MOVLW      1
	MOVWF      FARG_Button_activeState+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L__signalization246
;MyGeiger.mbas,683 :: 		ALARM = ALARM + 10
	MOVLW      10
	ADDWF      _ALARM+0, 0
	MOVWF      R1+0
	MOVF       _ALARM+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R1+1
	MOVF       R1+0, 0
	MOVWF      _ALARM+0
	MOVF       R1+1, 0
	MOVWF      _ALARM+1
;MyGeiger.mbas,684 :: 		if ALARM>5000 then
	MOVF       R1+1, 0
	SUBLW      19
	BTFSS      STATUS+0, 2
	GOTO       L__signalization434
	MOVF       R1+0, 0
	SUBLW      136
L__signalization434:
	BTFSC      STATUS+0, 0
	GOTO       L__signalization249
;MyGeiger.mbas,685 :: 		ALARM = 5000
	MOVLW      136
	MOVWF      _ALARM+0
	MOVLW      19
	MOVWF      _ALARM+1
L__signalization249:
;MyGeiger.mbas,687 :: 		WordToStr (ALARM, txt1)
	MOVF       _ALARM+0, 0
	MOVWF      FARG_WordToStr_input+0
	MOVF       _ALARM+1, 0
	MOVWF      FARG_WordToStr_input+1
	MOVLW      signalization_txt1+0
	MOVWF      FARG_WordToStr_output+0
	CALL       _WordToStr+0
;MyGeiger.mbas,688 :: 		ltrim (txt1)
	MOVLW      signalization_txt1+0
	MOVWF      FARG_ltrim_astring+0
	CALL       _ltrim+0
;MyGeiger.mbas,689 :: 		NOK_Out (0, 2, "*            *")
	CLRF       FARG_NOK_Out_x+0
	MOVLW      2
	MOVWF      FARG_NOK_Out_y+0
	MOVLW      42
	MOVWF      ?LocalText_signalization+0
	MOVLW      32
	MOVWF      ?LocalText_signalization+1
	MOVLW      32
	MOVWF      ?LocalText_signalization+2
	MOVLW      32
	MOVWF      ?LocalText_signalization+3
	MOVLW      32
	MOVWF      ?LocalText_signalization+4
	MOVLW      32
	MOVWF      ?LocalText_signalization+5
	MOVLW      32
	MOVWF      ?LocalText_signalization+6
	MOVLW      32
	MOVWF      ?LocalText_signalization+7
	MOVLW      32
	MOVWF      ?LocalText_signalization+8
	MOVLW      32
	MOVWF      ?LocalText_signalization+9
	MOVLW      32
	MOVWF      ?LocalText_signalization+10
	MOVLW      32
	MOVWF      ?LocalText_signalization+11
	MOVLW      32
	MOVWF      ?LocalText_signalization+12
	MOVLW      42
	MOVWF      ?LocalText_signalization+13
	CLRF       ?LocalText_signalization+14
	MOVLW      ?LocalText_signalization+0
	MOVWF      FARG_NOK_Out_sentance+0
	CALL       _NOK_Out+0
;MyGeiger.mbas,690 :: 		NOK_Out (30, 2, txt1)
	MOVLW      30
	MOVWF      FARG_NOK_Out_x+0
	MOVLW      2
	MOVWF      FARG_NOK_Out_y+0
	MOVLW      signalization_txt1+0
	MOVWF      FARG_NOK_Out_sentance+0
	CALL       _NOK_Out+0
L__signalization246:
;MyGeiger.mbas,693 :: 		if Button (PORTB, 6, 150, 1) then
	MOVLW      PORTB+0
	MOVWF      FARG_Button_port+0
	MOVLW      6
	MOVWF      FARG_Button_pin+0
	MOVLW      150
	MOVWF      FARG_Button_time+0
	MOVLW      1
	MOVWF      FARG_Button_activeState+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L__signalization252
;MyGeiger.mbas,694 :: 		ALARM = ALARM - 10
	MOVLW      10
	SUBWF      _ALARM+0, 0
	MOVWF      R1+0
	MOVLW      0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _ALARM+1, 0
	MOVWF      R1+1
	MOVF       R1+0, 0
	MOVWF      _ALARM+0
	MOVF       R1+1, 0
	MOVWF      _ALARM+1
;MyGeiger.mbas,695 :: 		if ALARM<60 then
	MOVLW      0
	SUBWF      R1+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__signalization435
	MOVLW      60
	SUBWF      R1+0, 0
L__signalization435:
	BTFSC      STATUS+0, 0
	GOTO       L__signalization255
;MyGeiger.mbas,696 :: 		ALARM = 60
	MOVLW      60
	MOVWF      _ALARM+0
	CLRF       _ALARM+1
L__signalization255:
;MyGeiger.mbas,698 :: 		WordToStr (ALARM, txt1)
	MOVF       _ALARM+0, 0
	MOVWF      FARG_WordToStr_input+0
	MOVF       _ALARM+1, 0
	MOVWF      FARG_WordToStr_input+1
	MOVLW      signalization_txt1+0
	MOVWF      FARG_WordToStr_output+0
	CALL       _WordToStr+0
;MyGeiger.mbas,699 :: 		ltrim(txt1)
	MOVLW      signalization_txt1+0
	MOVWF      FARG_ltrim_astring+0
	CALL       _ltrim+0
;MyGeiger.mbas,700 :: 		NOK_Out (0, 2, "*            *")
	CLRF       FARG_NOK_Out_x+0
	MOVLW      2
	MOVWF      FARG_NOK_Out_y+0
	MOVLW      42
	MOVWF      ?LocalText_signalization+0
	MOVLW      32
	MOVWF      ?LocalText_signalization+1
	MOVLW      32
	MOVWF      ?LocalText_signalization+2
	MOVLW      32
	MOVWF      ?LocalText_signalization+3
	MOVLW      32
	MOVWF      ?LocalText_signalization+4
	MOVLW      32
	MOVWF      ?LocalText_signalization+5
	MOVLW      32
	MOVWF      ?LocalText_signalization+6
	MOVLW      32
	MOVWF      ?LocalText_signalization+7
	MOVLW      32
	MOVWF      ?LocalText_signalization+8
	MOVLW      32
	MOVWF      ?LocalText_signalization+9
	MOVLW      32
	MOVWF      ?LocalText_signalization+10
	MOVLW      32
	MOVWF      ?LocalText_signalization+11
	MOVLW      32
	MOVWF      ?LocalText_signalization+12
	MOVLW      42
	MOVWF      ?LocalText_signalization+13
	CLRF       ?LocalText_signalization+14
	MOVLW      ?LocalText_signalization+0
	MOVWF      FARG_NOK_Out_sentance+0
	CALL       _NOK_Out+0
;MyGeiger.mbas,701 :: 		NOK_Out (30, 2, txt1)
	MOVLW      30
	MOVWF      FARG_NOK_Out_x+0
	MOVLW      2
	MOVWF      FARG_NOK_Out_y+0
	MOVLW      signalization_txt1+0
	MOVWF      FARG_NOK_Out_sentance+0
	CALL       _NOK_Out+0
L__signalization252:
;MyGeiger.mbas,705 :: 		if Button (PORTB, 5, 150, 1) then
	MOVLW      PORTB+0
	MOVWF      FARG_Button_port+0
	MOVLW      5
	MOVWF      FARG_Button_pin+0
	MOVLW      150
	MOVWF      FARG_Button_time+0
	MOVLW      1
	MOVWF      FARG_Button_activeState+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L__signalization258
;MyGeiger.mbas,706 :: 		goto CHANGE2
	GOTO       L__signalization_change2
L__signalization258:
;MyGeiger.mbas,708 :: 		wend
	GOTO       L__signalization241
;MyGeiger.mbas,709 :: 		CHANGE2:
L__signalization_change2:
;MyGeiger.mbas,710 :: 		ALARM = ALARM / 60
	MOVLW      60
	MOVWF      R4+0
	CLRF       R4+1
	MOVF       _ALARM+0, 0
	MOVWF      R0+0
	MOVF       _ALARM+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_U+0
	MOVF       R0+0, 0
	MOVWF      _ALARM+0
	MOVF       R0+1, 0
	MOVWF      _ALARM+1
;MyGeiger.mbas,711 :: 		NOK_clear()
	CALL       _NOK_clear+0
;MyGeiger.mbas,712 :: 		end sub
L_end_signalization:
	RETURN
; end of _signalization

_dosextract:

;MyGeiger.mbas,715 :: 		sub procedure dosextract()
;MyGeiger.mbas,716 :: 		if dose < 100000 then
	MOVLW      0
	SUBWF      _dose+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__dosextract437
	MOVLW      1
	SUBWF      _dose+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__dosextract437
	MOVLW      134
	SUBWF      _dose+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__dosextract437
	MOVLW      160
	SUBWF      _dose+0, 0
L__dosextract437:
	BTFSC      STATUS+0, 0
	GOTO       L__dosextract262
;MyGeiger.mbas,717 :: 		NOK_OUT(54,3,",")
	MOVLW      54
	MOVWF      FARG_NOK_Out_x+0
	MOVLW      3
	MOVWF      FARG_NOK_Out_y+0
	MOVLW      44
	MOVWF      ?LocalText_dosextract+0
	CLRF       ?LocalText_dosextract+1
	MOVLW      ?LocalText_dosextract+0
	MOVWF      FARG_NOK_Out_sentance+0
	CALL       _NOK_Out+0
;MyGeiger.mbas,718 :: 		ch = (dose div 10000)
	MOVLW      16
	MOVWF      R4+0
	MOVLW      39
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       _dose+0, 0
	MOVWF      R0+0
	MOVF       _dose+1, 0
	MOVWF      R0+1
	MOVF       _dose+2, 0
	MOVWF      R0+2
	MOVF       _dose+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      _ch+0
	MOVF       R0+1, 0
	MOVWF      _ch+1
;MyGeiger.mbas,719 :: 		NOK_Chr_Big(5, 2, ch)
	MOVLW      5
	MOVWF      FARG_NOK_Chr_Big_px+0
	MOVLW      2
	MOVWF      FARG_NOK_Chr_Big_py+0
	MOVF       R0+0, 0
	MOVWF      FARG_NOK_Chr_Big_digit+0
	CALL       _NOK_Chr_Big+0
;MyGeiger.mbas,720 :: 		NOK_goto (17, 2)
	MOVLW      17
	MOVWF      FARG_NOK_goto_x+0
	MOVLW      2
	MOVWF      FARG_NOK_goto_y+0
	CALL       _NOK_goto+0
;MyGeiger.mbas,721 :: 		for hh = 0 to 11
	CLRF       _hh+0
L__dosextract265:
;MyGeiger.mbas,722 :: 		SPI1_Write (KK[hh])
	MOVF       _hh+0, 0
	ADDLW      _KK+0
	MOVWF      R0+0
	MOVLW      hi_addr(_KK+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,723 :: 		next hh
	MOVF       _hh+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L__dosextract268
	INCF       _hh+0, 1
	GOTO       L__dosextract265
L__dosextract268:
;MyGeiger.mbas,724 :: 		NOK_goto (17, 3)
	MOVLW      17
	MOVWF      FARG_NOK_goto_x+0
	MOVLW      3
	MOVWF      FARG_NOK_goto_y+0
	CALL       _NOK_goto+0
;MyGeiger.mbas,725 :: 		for hh = 12 to 23
	MOVLW      12
	MOVWF      _hh+0
L__dosextract270:
;MyGeiger.mbas,726 :: 		SPI1_Write (KK[hh])
	MOVF       _hh+0, 0
	ADDLW      _KK+0
	MOVWF      R0+0
	MOVLW      hi_addr(_KK+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,727 :: 		next hh
	MOVF       _hh+0, 0
	XORLW      23
	BTFSC      STATUS+0, 2
	GOTO       L__dosextract273
	INCF       _hh+0, 1
	GOTO       L__dosextract270
L__dosextract273:
;MyGeiger.mbas,728 :: 		NOK_out(17,3,")")
	MOVLW      17
	MOVWF      FARG_NOK_Out_x+0
	MOVLW      3
	MOVWF      FARG_NOK_Out_y+0
	MOVLW      41
	MOVWF      ?LocalText_dosextract+0
	CLRF       ?LocalText_dosextract+1
	MOVLW      ?LocalText_dosextract+0
	MOVWF      FARG_NOK_Out_sentance+0
	CALL       _NOK_Out+0
;MyGeiger.mbas,729 :: 		ch = (dose div 1000) mod 10
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       _dose+0, 0
	MOVWF      R0+0
	MOVF       _dose+1, 0
	MOVWF      R0+1
	MOVF       _dose+2, 0
	MOVWF      R0+2
	MOVF       _dose+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_U+0
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R8+2, 0
	MOVWF      R0+2
	MOVF       R8+3, 0
	MOVWF      R0+3
	MOVF       R0+0, 0
	MOVWF      _ch+0
	MOVF       R0+1, 0
	MOVWF      _ch+1
;MyGeiger.mbas,730 :: 		NOK_Chr_Big(22, 2, ch)
	MOVLW      22
	MOVWF      FARG_NOK_Chr_Big_px+0
	MOVLW      2
	MOVWF      FARG_NOK_Chr_Big_py+0
	MOVF       R0+0, 0
	MOVWF      FARG_NOK_Chr_Big_digit+0
	CALL       _NOK_Chr_Big+0
;MyGeiger.mbas,731 :: 		ch = (dose div 100) mod 10
	MOVLW      100
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       _dose+0, 0
	MOVWF      R0+0
	MOVF       _dose+1, 0
	MOVWF      R0+1
	MOVF       _dose+2, 0
	MOVWF      R0+2
	MOVF       _dose+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_U+0
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R8+2, 0
	MOVWF      R0+2
	MOVF       R8+3, 0
	MOVWF      R0+3
	MOVF       R0+0, 0
	MOVWF      _ch+0
	MOVF       R0+1, 0
	MOVWF      _ch+1
;MyGeiger.mbas,732 :: 		NOK_Chr_Big (34, 2, ch)
	MOVLW      34
	MOVWF      FARG_NOK_Chr_Big_px+0
	MOVLW      2
	MOVWF      FARG_NOK_Chr_Big_py+0
	MOVF       R0+0, 0
	MOVWF      FARG_NOK_Chr_Big_digit+0
	CALL       _NOK_Chr_Big+0
	GOTO       L__dosextract263
;MyGeiger.mbas,733 :: 		else
L__dosextract262:
;MyGeiger.mbas,734 :: 		if dose < 1000000 then
	MOVLW      0
	SUBWF      _dose+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__dosextract438
	MOVLW      15
	SUBWF      _dose+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__dosextract438
	MOVLW      66
	SUBWF      _dose+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__dosextract438
	MOVLW      64
	SUBWF      _dose+0, 0
L__dosextract438:
	BTFSC      STATUS+0, 0
	GOTO       L__dosextract275
;MyGeiger.mbas,735 :: 		NOK_OUT(54,3,",")
	MOVLW      54
	MOVWF      FARG_NOK_Out_x+0
	MOVLW      3
	MOVWF      FARG_NOK_Out_y+0
	MOVLW      44
	MOVWF      ?LocalText_dosextract+0
	CLRF       ?LocalText_dosextract+1
	MOVLW      ?LocalText_dosextract+0
	MOVWF      FARG_NOK_Out_sentance+0
	CALL       _NOK_Out+0
;MyGeiger.mbas,737 :: 		ch = (dose div 100000)
	MOVLW      160
	MOVWF      R4+0
	MOVLW      134
	MOVWF      R4+1
	MOVLW      1
	MOVWF      R4+2
	MOVLW      0
	MOVWF      R4+3
	MOVF       _dose+0, 0
	MOVWF      R0+0
	MOVF       _dose+1, 0
	MOVWF      R0+1
	MOVF       _dose+2, 0
	MOVWF      R0+2
	MOVF       _dose+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      _ch+0
	MOVF       R0+1, 0
	MOVWF      _ch+1
;MyGeiger.mbas,738 :: 		NOK_Chr_Big(5, 2, ch)
	MOVLW      5
	MOVWF      FARG_NOK_Chr_Big_px+0
	MOVLW      2
	MOVWF      FARG_NOK_Chr_Big_py+0
	MOVF       R0+0, 0
	MOVWF      FARG_NOK_Chr_Big_digit+0
	CALL       _NOK_Chr_Big+0
;MyGeiger.mbas,739 :: 		ch = (dose div 10000) mod 10
	MOVLW      16
	MOVWF      R4+0
	MOVLW      39
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       _dose+0, 0
	MOVWF      R0+0
	MOVF       _dose+1, 0
	MOVWF      R0+1
	MOVF       _dose+2, 0
	MOVWF      R0+2
	MOVF       _dose+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_U+0
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R8+2, 0
	MOVWF      R0+2
	MOVF       R8+3, 0
	MOVWF      R0+3
	MOVF       R0+0, 0
	MOVWF      _ch+0
	MOVF       R0+1, 0
	MOVWF      _ch+1
;MyGeiger.mbas,740 :: 		NOK_Chr_Big (17, 2, ch)
	MOVLW      17
	MOVWF      FARG_NOK_Chr_Big_px+0
	MOVLW      2
	MOVWF      FARG_NOK_Chr_Big_py+0
	MOVF       R0+0, 0
	MOVWF      FARG_NOK_Chr_Big_digit+0
	CALL       _NOK_Chr_Big+0
;MyGeiger.mbas,741 :: 		NOK_goto (29, 2)
	MOVLW      29
	MOVWF      FARG_NOK_goto_x+0
	MOVLW      2
	MOVWF      FARG_NOK_goto_y+0
	CALL       _NOK_goto+0
;MyGeiger.mbas,742 :: 		for hh = 0 to 11
	CLRF       _hh+0
L__dosextract278:
;MyGeiger.mbas,743 :: 		SPI1_Write (KK[hh])
	MOVF       _hh+0, 0
	ADDLW      _KK+0
	MOVWF      R0+0
	MOVLW      hi_addr(_KK+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,744 :: 		next hh
	MOVF       _hh+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L__dosextract281
	INCF       _hh+0, 1
	GOTO       L__dosextract278
L__dosextract281:
;MyGeiger.mbas,745 :: 		NOK_goto (29, 3)
	MOVLW      29
	MOVWF      FARG_NOK_goto_x+0
	MOVLW      3
	MOVWF      FARG_NOK_goto_y+0
	CALL       _NOK_goto+0
;MyGeiger.mbas,746 :: 		for hh = 12 to 23
	MOVLW      12
	MOVWF      _hh+0
L__dosextract283:
;MyGeiger.mbas,747 :: 		SPI1_Write (KK[hh])
	MOVF       _hh+0, 0
	ADDLW      _KK+0
	MOVWF      R0+0
	MOVLW      hi_addr(_KK+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,748 :: 		next hh
	MOVF       _hh+0, 0
	XORLW      23
	BTFSC      STATUS+0, 2
	GOTO       L__dosextract286
	INCF       _hh+0, 1
	GOTO       L__dosextract283
L__dosextract286:
;MyGeiger.mbas,749 :: 		NOK_Out (29, 3, ")")
	MOVLW      29
	MOVWF      FARG_NOK_Out_x+0
	MOVLW      3
	MOVWF      FARG_NOK_Out_y+0
	MOVLW      41
	MOVWF      ?LocalText_dosextract+0
	CLRF       ?LocalText_dosextract+1
	MOVLW      ?LocalText_dosextract+0
	MOVWF      FARG_NOK_Out_sentance+0
	CALL       _NOK_Out+0
;MyGeiger.mbas,750 :: 		ch = (dose div 1000) mod 10
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	CLRF       R4+2
	CLRF       R4+3
	MOVF       _dose+0, 0
	MOVWF      R0+0
	MOVF       _dose+1, 0
	MOVWF      R0+1
	MOVF       _dose+2, 0
	MOVWF      R0+2
	MOVF       _dose+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_U+0
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R8+2, 0
	MOVWF      R0+2
	MOVF       R8+3, 0
	MOVWF      R0+3
	MOVF       R0+0, 0
	MOVWF      _ch+0
	MOVF       R0+1, 0
	MOVWF      _ch+1
;MyGeiger.mbas,751 :: 		NOK_Chr_Big (34, 2, ch)
	MOVLW      34
	MOVWF      FARG_NOK_Chr_Big_px+0
	MOVLW      2
	MOVWF      FARG_NOK_Chr_Big_py+0
	MOVF       R0+0, 0
	MOVWF      FARG_NOK_Chr_Big_digit+0
	CALL       _NOK_Chr_Big+0
	GOTO       L__dosextract276
;MyGeiger.mbas,752 :: 		else
L__dosextract275:
;MyGeiger.mbas,753 :: 		NOK_OUT(54,3,"+")
	MOVLW      54
	MOVWF      FARG_NOK_Out_x+0
	MOVLW      3
	MOVWF      FARG_NOK_Out_y+0
	MOVLW      43
	MOVWF      ?LocalText_dosextract+0
	CLRF       ?LocalText_dosextract+1
	MOVLW      ?LocalText_dosextract+0
	MOVWF      FARG_NOK_Out_sentance+0
	CALL       _NOK_Out+0
;MyGeiger.mbas,754 :: 		ch = (dose div 10000000)
	MOVLW      128
	MOVWF      R4+0
	MOVLW      150
	MOVWF      R4+1
	MOVLW      152
	MOVWF      R4+2
	MOVLW      0
	MOVWF      R4+3
	MOVF       _dose+0, 0
	MOVWF      R0+0
	MOVF       _dose+1, 0
	MOVWF      R0+1
	MOVF       _dose+2, 0
	MOVWF      R0+2
	MOVF       _dose+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      _ch+0
	MOVF       R0+1, 0
	MOVWF      _ch+1
;MyGeiger.mbas,755 :: 		NOK_Chr_Big (5, 2, ch)
	MOVLW      5
	MOVWF      FARG_NOK_Chr_Big_px+0
	MOVLW      2
	MOVWF      FARG_NOK_Chr_Big_py+0
	MOVF       R0+0, 0
	MOVWF      FARG_NOK_Chr_Big_digit+0
	CALL       _NOK_Chr_Big+0
;MyGeiger.mbas,756 :: 		NOK_goto (17, 2)
	MOVLW      17
	MOVWF      FARG_NOK_goto_x+0
	MOVLW      2
	MOVWF      FARG_NOK_goto_y+0
	CALL       _NOK_goto+0
;MyGeiger.mbas,757 :: 		for hh = 0 to 11
	CLRF       _hh+0
L__dosextract288:
;MyGeiger.mbas,758 :: 		SPI1_Write (KK[hh])
	MOVF       _hh+0, 0
	ADDLW      _KK+0
	MOVWF      R0+0
	MOVLW      hi_addr(_KK+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,759 :: 		next hh
	MOVF       _hh+0, 0
	XORLW      11
	BTFSC      STATUS+0, 2
	GOTO       L__dosextract291
	INCF       _hh+0, 1
	GOTO       L__dosextract288
L__dosextract291:
;MyGeiger.mbas,760 :: 		NOK_goto (17, 3)
	MOVLW      17
	MOVWF      FARG_NOK_goto_x+0
	MOVLW      3
	MOVWF      FARG_NOK_goto_y+0
	CALL       _NOK_goto+0
;MyGeiger.mbas,761 :: 		for hh = 12 to 23
	MOVLW      12
	MOVWF      _hh+0
L__dosextract293:
;MyGeiger.mbas,762 :: 		SPI1_Write (KK[hh])
	MOVF       _hh+0, 0
	ADDLW      _KK+0
	MOVWF      R0+0
	MOVLW      hi_addr(_KK+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,763 :: 		next hh
	MOVF       _hh+0, 0
	XORLW      23
	BTFSC      STATUS+0, 2
	GOTO       L__dosextract296
	INCF       _hh+0, 1
	GOTO       L__dosextract293
L__dosextract296:
;MyGeiger.mbas,764 :: 		NOK_Out (17, 3, ")")
	MOVLW      17
	MOVWF      FARG_NOK_Out_x+0
	MOVLW      3
	MOVWF      FARG_NOK_Out_y+0
	MOVLW      41
	MOVWF      ?LocalText_dosextract+0
	CLRF       ?LocalText_dosextract+1
	MOVLW      ?LocalText_dosextract+0
	MOVWF      FARG_NOK_Out_sentance+0
	CALL       _NOK_Out+0
;MyGeiger.mbas,765 :: 		ch = (dose div 1000000) mod 10
	MOVLW      64
	MOVWF      R4+0
	MOVLW      66
	MOVWF      R4+1
	MOVLW      15
	MOVWF      R4+2
	MOVLW      0
	MOVWF      R4+3
	MOVF       _dose+0, 0
	MOVWF      R0+0
	MOVF       _dose+1, 0
	MOVWF      R0+1
	MOVF       _dose+2, 0
	MOVWF      R0+2
	MOVF       _dose+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_U+0
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R8+2, 0
	MOVWF      R0+2
	MOVF       R8+3, 0
	MOVWF      R0+3
	MOVF       R0+0, 0
	MOVWF      _ch+0
	MOVF       R0+1, 0
	MOVWF      _ch+1
;MyGeiger.mbas,766 :: 		NOK_Chr_Big (22, 2, ch)
	MOVLW      22
	MOVWF      FARG_NOK_Chr_Big_px+0
	MOVLW      2
	MOVWF      FARG_NOK_Chr_Big_py+0
	MOVF       R0+0, 0
	MOVWF      FARG_NOK_Chr_Big_digit+0
	CALL       _NOK_Chr_Big+0
;MyGeiger.mbas,767 :: 		ch = (dose div 100000) mod 10
	MOVLW      160
	MOVWF      R4+0
	MOVLW      134
	MOVWF      R4+1
	MOVLW      1
	MOVWF      R4+2
	MOVLW      0
	MOVWF      R4+3
	MOVF       _dose+0, 0
	MOVWF      R0+0
	MOVF       _dose+1, 0
	MOVWF      R0+1
	MOVF       _dose+2, 0
	MOVWF      R0+2
	MOVF       _dose+3, 0
	MOVWF      R0+3
	CALL       _Div_32x32_U+0
	MOVLW      10
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Div_32x32_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R8+2, 0
	MOVWF      R0+2
	MOVF       R8+3, 0
	MOVWF      R0+3
	MOVF       R0+0, 0
	MOVWF      _ch+0
	MOVF       R0+1, 0
	MOVWF      _ch+1
;MyGeiger.mbas,768 :: 		NOK_Chr_Big (34, 2, ch)
	MOVLW      34
	MOVWF      FARG_NOK_Chr_Big_px+0
	MOVLW      2
	MOVWF      FARG_NOK_Chr_Big_py+0
	MOVF       R0+0, 0
	MOVWF      FARG_NOK_Chr_Big_digit+0
	CALL       _NOK_Chr_Big+0
;MyGeiger.mbas,773 :: 		end if
L__dosextract276:
;MyGeiger.mbas,774 :: 		end if
L__dosextract263:
;MyGeiger.mbas,776 :: 		end sub
L_end_dosextract:
	RETURN
; end of _dosextract

_main:

;MyGeiger.mbas,780 :: 		main:
;MyGeiger.mbas,783 :: 		m_period = 59                            ' start with 3 seconds period
	MOVLW      59
	MOVWF      _m_period+0
;MyGeiger.mbas,784 :: 		sekunds = 3
	MOVLW      3
	MOVWF      _sekunds+0
;MyGeiger.mbas,785 :: 		sek_over = 0
	BCF        _sek_over+0, BitPos(_sek_over+0)
;MyGeiger.mbas,786 :: 		sek_counter = 0
	CLRF       _sek_counter+0
;MyGeiger.mbas,787 :: 		sek_cnt = 0
	CLRF       _sek_cnt+0
	CLRF       _sek_cnt+1
;MyGeiger.mbas,788 :: 		alert = 0
	BCF        RB2_bit+0, BitPos(RB2_bit+0)
;MyGeiger.mbas,789 :: 		sound = 1
	BSF        _sound+0, BitPos(_sound+0)
;MyGeiger.mbas,790 :: 		diode = 0
	BCF        RA1_bit+0, BitPos(RA1_bit+0)
;MyGeiger.mbas,791 :: 		light = 1
	BSF        RA5_bit+0, BitPos(RA5_bit+0)
;MyGeiger.mbas,792 :: 		counts = 0
	CLRF       _counts+0
	CLRF       _counts+1
;MyGeiger.mbas,793 :: 		cpm = 0
	CLRF       _cpm+0
	CLRF       _cpm+1
	CLRF       _cpm+2
	CLRF       _cpm+3
;MyGeiger.mbas,794 :: 		timer_cnt = 0
	CLRF       _timer_cnt+0
;MyGeiger.mbas,795 :: 		cpm_read_done = 0
	BCF        _cpm_read_done+0, BitPos(_cpm_read_done+0)
;MyGeiger.mbas,796 :: 		ALARM = 10
	MOVLW      10
	MOVWF      _ALARM+0
	CLRF       _ALARM+1
;MyGeiger.mbas,797 :: 		n = 0
	CLRF       _n+0
;MyGeiger.mbas,798 :: 		cnt_s = 0
	CLRF       _cnt_s+0
	CLRF       _cnt_s+1
;MyGeiger.mbas,799 :: 		cnt   = 0
	CLRF       _cnt+0
	CLRF       _cnt+1
;MyGeiger.mbas,800 :: 		voltage_period = 0
	BCF        _voltage_period+0, BitPos(_voltage_period+0)
;MyGeiger.mbas,801 :: 		button_period = 0
	CLRF       _button_period+0
;MyGeiger.mbas,802 :: 		buzzer_counter = 0
	CLRF       _buzzer_counter+0
;MyGeiger.mbas,803 :: 		buzzer_started = 0
	BCF        _buzzer_started+0, BitPos(_buzzer_started+0)
;MyGeiger.mbas,806 :: 		CMCON = 0x07
	MOVLW      7
	MOVWF      CMCON+0
;MyGeiger.mbas,807 :: 		TRISB = %11100001
	MOVLW      225
	MOVWF      TRISB+0
;MyGeiger.mbas,808 :: 		PORTB = %00000001
	MOVLW      1
	MOVWF      PORTB+0
;MyGeiger.mbas,809 :: 		TRISC = %00000000
	CLRF       TRISC+0
;MyGeiger.mbas,811 :: 		CF = EEPROM_Read (0x01)
	MOVLW      1
	MOVWF      FARG_EEPROM_Read_address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _CF+0
;MyGeiger.mbas,812 :: 		BAT_TYPE = EEPROM_Read (0x00)
	CLRF       FARG_EEPROM_Read_address+0
	CALL       _EEPROM_Read+0
	MOVF       R0+0, 0
	MOVWF      _BAT_TYPE+0
;MyGeiger.mbas,814 :: 		OPTION_REG = %10000000
	MOVLW      128
	MOVWF      OPTION_REG+0
;MyGeiger.mbas,815 :: 		INTCON = %00000000
	CLRF       INTCON+0
;MyGeiger.mbas,817 :: 		PIE1 = %00000000
	CLRF       PIE1+0
;MyGeiger.mbas,818 :: 		PIE2 = %00000000
	CLRF       PIE2+0
;MyGeiger.mbas,819 :: 		PIR1 = %00000000
	CLRF       PIR1+0
;MyGeiger.mbas,820 :: 		PIR2 = %00000000
	CLRF       PIR2+0
;MyGeiger.mbas,821 :: 		TRISA.0 = 1
	BSF        TRISA+0, 0
;MyGeiger.mbas,822 :: 		TRISA.2 = 1
	BSF        TRISA+0, 2
;MyGeiger.mbas,823 :: 		TRISA.3 = 1
	BSF        TRISA+0, 3
;MyGeiger.mbas,824 :: 		TRISA.4 = 0
	BCF        TRISA+0, 4
;MyGeiger.mbas,825 :: 		TRISA.5 = 0
	BCF        TRISA+0, 5
;MyGeiger.mbas,826 :: 		TRISA.1 = 0
	BCF        TRISA+0, 1
;MyGeiger.mbas,844 :: 		if BAT_TYPE = 0x01 then   ' Ni-MH type      DEFAULT
	MOVF       R0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__main299
;MyGeiger.mbas,845 :: 		BAT_START = 0x3C                '3C    60 (was 57)
	MOVLW      60
	MOVWF      _BAT_START+0
;MyGeiger.mbas,846 :: 		BAT_25 = 0x4E                   '4E    78 (was 75)
	MOVLW      78
	MOVWF      _BAT_25+0
;MyGeiger.mbas,847 :: 		BAT_50 = 0x44                   '44    68 (was 65)
	MOVLW      68
	MOVWF      _BAT_50+0
;MyGeiger.mbas,848 :: 		BAT_100= 0x3F                   '3F    63 (was 60)
	MOVLW      63
	MOVWF      _BAT_100+0
	GOTO       L__main300
;MyGeiger.mbas,849 :: 		else                    'LIPO type
L__main299:
;MyGeiger.mbas,850 :: 		BAT_START = 0x53                '53     83 (was 80)
	MOVLW      83
	MOVWF      _BAT_START+0
;MyGeiger.mbas,851 :: 		BAT_25 = 0x70                   '70      112 (was 110)
	MOVLW      112
	MOVWF      _BAT_25+0
;MyGeiger.mbas,852 :: 		BAT_50 = 0x65                   '65      101 (was 98)
	MOVLW      101
	MOVWF      _BAT_50+0
;MyGeiger.mbas,853 :: 		BAT_100= 0x55                   '55       85 (was 82)
	MOVLW      85
	MOVWF      _BAT_100+0
;MyGeiger.mbas,854 :: 		end if
L__main300:
;MyGeiger.mbas,858 :: 		bbb = BAT_START             ' first start PWM duty cycle app 25%
	MOVF       _BAT_START+0, 0
	MOVWF      _bbb+0
;MyGeiger.mbas,860 :: 		ADCON1 = %10001111          'Vref +1.24V    %10001111
	MOVLW      143
	MOVWF      ADCON1+0
;MyGeiger.mbas,861 :: 		ADCON0 = %00000001
	MOVLW      1
	MOVWF      ADCON0+0
;MyGeiger.mbas,863 :: 		PR2       = 249         ' Set PWM at 4KHz
	MOVLW      249
	MOVWF      PR2+0
;MyGeiger.mbas,864 :: 		CCPR1L    = bbb         ' Set PWM Duty-Cycle
	MOVF       _BAT_START+0, 0
	MOVWF      CCPR1L+0
;MyGeiger.mbas,865 :: 		CCP1CON   = %00001100   ' Mode select = PWM
	MOVLW      12
	MOVWF      CCP1CON+0
;MyGeiger.mbas,866 :: 		T2CON     = %00000100   ' Timer2 ON prescale
	MOVLW      4
	MOVWF      T2CON+0
;MyGeiger.mbas,869 :: 		SPI1_init()
	CALL       _SPI1_init+0
;MyGeiger.mbas,870 :: 		delay_ms(20)
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L__main301:
	DECFSZ     R13+0, 1
	GOTO       L__main301
	DECFSZ     R12+0, 1
	GOTO       L__main301
	NOP
;MyGeiger.mbas,873 :: 		rreset = 1
	BSF        PORTC+0, 0
;MyGeiger.mbas,874 :: 		ddata = 1
	BSF        PORTC+0, 1
;MyGeiger.mbas,876 :: 		NOK_Init()
	CALL       _NOK_init+0
;MyGeiger.mbas,878 :: 		delay_ms(20)
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L__main302:
	DECFSZ     R13+0, 1
	GOTO       L__main302
	DECFSZ     R12+0, 1
	GOTO       L__main302
	NOP
;MyGeiger.mbas,879 :: 		NOK_clear()
	CALL       _NOK_clear+0
;MyGeiger.mbas,880 :: 		NOK_goto (0,0)
	CLRF       FARG_NOK_goto_x+0
	CLRF       FARG_NOK_goto_y+0
	CALL       _NOK_goto+0
;MyGeiger.mbas,882 :: 		for nn = 0 to 503
	CLRF       _nn+0
	CLRF       _nn+1
L__main304:
;MyGeiger.mbas,883 :: 		SPI1_Write (logo[nn])
	MOVF       _nn+0, 0
	ADDLW      _logo+0
	MOVWF      R0+0
	MOVLW      hi_addr(_logo+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _nn+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,884 :: 		next nn
	MOVF       _nn+1, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L__main440
	MOVLW      247
	XORWF      _nn+0, 0
L__main440:
	BTFSC      STATUS+0, 2
	GOTO       L__main307
	INCF       _nn+0, 1
	BTFSC      STATUS+0, 2
	INCF       _nn+1, 1
	GOTO       L__main304
L__main307:
;MyGeiger.mbas,887 :: 		UART1_Init(2400)
	MOVLW      103
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;MyGeiger.mbas,888 :: 		delay_ms(1000)
	MOVLW      6
	MOVWF      R11+0
	MOVLW      19
	MOVWF      R12+0
	MOVLW      173
	MOVWF      R13+0
L__main308:
	DECFSZ     R13+0, 1
	GOTO       L__main308
	DECFSZ     R12+0, 1
	GOTO       L__main308
	DECFSZ     R11+0, 1
	GOTO       L__main308
	NOP
	NOP
;MyGeiger.mbas,895 :: 		signalization()
	CALL       _signalization+0
;MyGeiger.mbas,900 :: 		cpm = 0
	CLRF       _cpm+0
	CLRF       _cpm+1
	CLRF       _cpm+2
	CLRF       _cpm+3
;MyGeiger.mbas,901 :: 		timer_cnt = 0
	CLRF       _timer_cnt+0
;MyGeiger.mbas,902 :: 		cpm_read_done = 0
	BCF        _cpm_read_done+0, BitPos(_cpm_read_done+0)
;MyGeiger.mbas,904 :: 		TMR1H = 0xE7                         ' First write higher byte to TMR1
	MOVLW      231
	MOVWF      TMR1H+0
;MyGeiger.mbas,905 :: 		TMR1L = 0x96                         ' Write lower byte to TMR1
	MOVLW      150
	MOVWF      TMR1L+0
;MyGeiger.mbas,906 :: 		T1CON = 0x35                         ' Timer1 prescaler settings
	MOVLW      53
	MOVWF      T1CON+0
;MyGeiger.mbas,907 :: 		PIE1 = %00000001
	MOVLW      1
	MOVWF      PIE1+0
;MyGeiger.mbas,908 :: 		TMR1IE_bit = 1                       ' Enable Timer1 overflow interrupt
	BSF        TMR1IE_bit+0, BitPos(TMR1IE_bit+0)
;MyGeiger.mbas,909 :: 		TMR1IF_bit = 0
	BCF        TMR1IF_bit+0, BitPos(TMR1IF_bit+0)
;MyGeiger.mbas,910 :: 		INTEDG_bit = 0                       ' Interrupt on RB0/INT pin is edge triggered, setting it on low edge
	BCF        INTEDG_bit+0, BitPos(INTEDG_bit+0)
;MyGeiger.mbas,911 :: 		TMR0IF_bit = 0
	BCF        TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
;MyGeiger.mbas,914 :: 		for xx = 0 to 5
	CLRF       _xx+0
L__main312:
;MyGeiger.mbas,915 :: 		CX[xx] = 0
	MOVF       _xx+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _CX+0
	MOVWF      FSR
	CLRF       INDF+0
	INCF       FSR, 1
	CLRF       INDF+0
	INCF       FSR, 1
	CLRF       INDF+0
	INCF       FSR, 1
	CLRF       INDF+0
;MyGeiger.mbas,916 :: 		next xx
	MOVF       _xx+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L__main315
	INCF       _xx+0, 1
	GOTO       L__main312
L__main315:
;MyGeiger.mbas,920 :: 		PRINT_LABELS:
L__main_print_labels:
;MyGeiger.mbas,922 :: 		NOK_goto (60, 3)
	MOVLW      60
	MOVWF      FARG_NOK_goto_x+0
	MOVLW      3
	MOVWF      FARG_NOK_goto_y+0
	CALL       _NOK_goto+0
;MyGeiger.mbas,924 :: 		for nn = 0 to 22
	CLRF       _nn+0
	CLRF       _nn+1
L__main318:
;MyGeiger.mbas,925 :: 		SPI1_Write (uSv_label[nn])
	MOVF       _nn+0, 0
	ADDLW      _uSv_label+0
	MOVWF      R0+0
	MOVLW      hi_addr(_uSv_label+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _nn+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,926 :: 		next nn
	MOVLW      0
	XORWF      _nn+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main441
	MOVLW      22
	XORWF      _nn+0, 0
L__main441:
	BTFSC      STATUS+0, 2
	GOTO       L__main321
	INCF       _nn+0, 1
	BTFSC      STATUS+0, 2
	INCF       _nn+1, 1
	GOTO       L__main318
L__main321:
;MyGeiger.mbas,929 :: 		NOK_goto (0, 5)
	CLRF       FARG_NOK_goto_x+0
	MOVLW      5
	MOVWF      FARG_NOK_goto_y+0
	CALL       _NOK_goto+0
;MyGeiger.mbas,930 :: 		for nn = 0 to 22
	CLRF       _nn+0
	CLRF       _nn+1
L__main323:
;MyGeiger.mbas,931 :: 		SPI1_Write (cpm_label[nn])
	MOVF       _nn+0, 0
	ADDLW      _cpm_label+0
	MOVWF      R0+0
	MOVLW      hi_addr(_cpm_label+0)
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      _nn+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_SPI1_write_data_+0
	CALL       _SPI1_write+0
;MyGeiger.mbas,932 :: 		next nn
	MOVLW      0
	XORWF      _nn+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main442
	MOVLW      22
	XORWF      _nn+0, 0
L__main442:
	BTFSC      STATUS+0, 2
	GOTO       L__main326
	INCF       _nn+0, 1
	BTFSC      STATUS+0, 2
	INCF       _nn+1, 1
	GOTO       L__main323
L__main326:
;MyGeiger.mbas,933 :: 		NOK_OUT (78, 0, "!")
	MOVLW      78
	MOVWF      FARG_NOK_Out_x+0
	CLRF       FARG_NOK_Out_y+0
	MOVLW      33
	MOVWF      ?LocalText_main+0
	CLRF       ?LocalText_main+1
	MOVLW      ?LocalText_main+0
	MOVWF      FARG_NOK_Out_sentance+0
	CALL       _NOK_Out+0
;MyGeiger.mbas,934 :: 		NOK_OUT (40, 0, "(")
	MOVLW      40
	MOVWF      FARG_NOK_Out_x+0
	CLRF       FARG_NOK_Out_y+0
	MOVLW      40
	MOVWF      ?LocalText_main+0
	CLRF       ?LocalText_main+1
	MOVLW      ?LocalText_main+0
	MOVWF      FARG_NOK_Out_sentance+0
	CALL       _NOK_Out+0
;MyGeiger.mbas,937 :: 		INTCON = %11010000                        ' Set GIE, PIE, INTE (0xD0)
	MOVLW      208
	MOVWF      INTCON+0
;MyGeiger.mbas,938 :: 		cpm_read_done = 0
	BCF        _cpm_read_done+0, BitPos(_cpm_read_done+0)
;MyGeiger.mbas,939 :: 		counts = 0
	CLRF       _counts+0
	CLRF       _counts+1
;MyGeiger.mbas,940 :: 		xx=0
	CLRF       _xx+0
;MyGeiger.mbas,944 :: 		while(1)
L__main328:
;MyGeiger.mbas,946 :: 		if voltage_period = 1 then              'correct HV every 50ms
	BTFSS      _voltage_period+0, BitPos(_voltage_period+0)
	GOTO       L__main333
;MyGeiger.mbas,947 :: 		adc_rd = ADC_Read(0)
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _adc_rd+0
	MOVF       R0+1, 0
	MOVWF      _adc_rd+1
;MyGeiger.mbas,949 :: 		if adc_rd > 168 then             '338 for 1.25V ; 168 for 2.50V
	MOVLW      128
	MOVWF      R2+0
	MOVLW      128
	XORWF      R0+1, 0
	SUBWF      R2+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main443
	MOVF       R0+0, 0
	SUBLW      168
L__main443:
	BTFSC      STATUS+0, 0
	GOTO       L__main336
;MyGeiger.mbas,950 :: 		dec (bbb)
	DECF       _bbb+0, 1
;MyGeiger.mbas,951 :: 		if bbb < 24 then
	MOVLW      24
	SUBWF      _bbb+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L__main339
;MyGeiger.mbas,952 :: 		bbb = 24
	MOVLW      24
	MOVWF      _bbb+0
L__main339:
;MyGeiger.mbas,955 :: 		CCPR1L = bbb
	MOVF       _bbb+0, 0
	MOVWF      CCPR1L+0
;MyGeiger.mbas,956 :: 		CCP1CON   = %00001100
	MOVLW      12
	MOVWF      CCP1CON+0
;MyGeiger.mbas,957 :: 		T2CON     = %00000100
	MOVLW      4
	MOVWF      T2CON+0
L__main336:
;MyGeiger.mbas,961 :: 		if adc_rd < 161 then          '326 for 1.25V ; 161 for 2.50V
	MOVLW      128
	XORWF      _adc_rd+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main444
	MOVLW      161
	SUBWF      _adc_rd+0, 0
L__main444:
	BTFSC      STATUS+0, 0
	GOTO       L__main342
;MyGeiger.mbas,962 :: 		inc (bbb)
	INCF       _bbb+0, 1
;MyGeiger.mbas,963 :: 		if bbb > 127 then
	MOVF       _bbb+0, 0
	SUBLW      127
	BTFSC      STATUS+0, 0
	GOTO       L__main345
;MyGeiger.mbas,964 :: 		bbb = 127
	MOVLW      127
	MOVWF      _bbb+0
L__main345:
;MyGeiger.mbas,967 :: 		CCPR1L = bbb
	MOVF       _bbb+0, 0
	MOVWF      CCPR1L+0
;MyGeiger.mbas,968 :: 		CCP1CON   = %00001100
	MOVLW      12
	MOVWF      CCP1CON+0
;MyGeiger.mbas,969 :: 		T2CON     = %00000100
	MOVLW      4
	MOVWF      T2CON+0
L__main342:
;MyGeiger.mbas,972 :: 		voltage_period = 0
	BCF        _voltage_period+0, BitPos(_voltage_period+0)
L__main333:
;MyGeiger.mbas,975 :: 		if (klavisha = 1) then          ' check if buttons pressed
	BTFSS      _klavisha+0, BitPos(_klavisha+0)
	GOTO       L__main348
;MyGeiger.mbas,976 :: 		if PORTB.5 = 1 then
	BTFSS      PORTB+0, 5
	GOTO       L__main351
;MyGeiger.mbas,977 :: 		delay_ms(100)
	MOVLW      130
	MOVWF      R12+0
	MOVLW      221
	MOVWF      R13+0
L__main353:
	DECFSZ     R13+0, 1
	GOTO       L__main353
	DECFSZ     R12+0, 1
	GOTO       L__main353
	NOP
	NOP
;MyGeiger.mbas,978 :: 		if PORTB.5 = 1 then
	BTFSS      PORTB+0, 5
	GOTO       L__main355
;MyGeiger.mbas,979 :: 		light = not light
	MOVLW
	XORWF      RA5_bit+0, 1
L__main355:
;MyGeiger.mbas,980 :: 		end if
L__main351:
;MyGeiger.mbas,984 :: 		if PORTB.7 = 1 then
	BTFSS      PORTB+0, 7
	GOTO       L__main358
;MyGeiger.mbas,985 :: 		sound = not sound
	MOVLW
	XORWF      _sound+0, 1
;MyGeiger.mbas,986 :: 		if sound  = 1 then
	BTFSS      _sound+0, BitPos(_sound+0)
	GOTO       L__main361
;MyGeiger.mbas,987 :: 		NOK_OUT (40, 0, "(")
	MOVLW      40
	MOVWF      FARG_NOK_Out_x+0
	CLRF       FARG_NOK_Out_y+0
	MOVLW      40
	MOVWF      ?LocalText_main+0
	CLRF       ?LocalText_main+1
	MOVLW      ?LocalText_main+0
	MOVWF      FARG_NOK_Out_sentance+0
	CALL       _NOK_Out+0
	GOTO       L__main362
;MyGeiger.mbas,988 :: 		else
L__main361:
;MyGeiger.mbas,989 :: 		NOK_OUT (40, 0, " ")
	MOVLW      40
	MOVWF      FARG_NOK_Out_x+0
	CLRF       FARG_NOK_Out_y+0
	MOVLW      32
	MOVWF      ?LocalText_main+0
	CLRF       ?LocalText_main+1
	MOVLW      ?LocalText_main+0
	MOVWF      FARG_NOK_Out_sentance+0
	CALL       _NOK_Out+0
;MyGeiger.mbas,990 :: 		end if
L__main362:
L__main358:
;MyGeiger.mbas,993 :: 		klavisha = 0
	BCF        _klavisha+0, BitPos(_klavisha+0)
L__main348:
;MyGeiger.mbas,997 :: 		if event = 1 then
	BTFSS      _event+0, BitPos(_event+0)
	GOTO       L__main364
;MyGeiger.mbas,999 :: 		diode = 1
	BSF        RA1_bit+0, BitPos(RA1_bit+0)
;MyGeiger.mbas,1003 :: 		event = 0       ' reset event flag
	BCF        _event+0, BitPos(_event+0)
L__main364:
;MyGeiger.mbas,1007 :: 		if sek_over = 1 then
	BTFSS      _sek_over+0, BitPos(_sek_over+0)
	GOTO       L__main367
;MyGeiger.mbas,1009 :: 		TMR1IE_bit = 0
	BCF        TMR1IE_bit+0, BitPos(TMR1IE_bit+0)
;MyGeiger.mbas,1010 :: 		if sek_cnt > ALARM then
	MOVF       _sek_cnt+1, 0
	SUBWF      _ALARM+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main445
	MOVF       _sek_cnt+0, 0
	SUBWF      _ALARM+0, 0
L__main445:
	BTFSC      STATUS+0, 0
	GOTO       L__main370
;MyGeiger.mbas,1011 :: 		alert = 1
	BSF        RB2_bit+0, BitPos(RB2_bit+0)
;MyGeiger.mbas,1012 :: 		light = 1
	BSF        RA5_bit+0, BitPos(RA5_bit+0)
	GOTO       L__main371
;MyGeiger.mbas,1013 :: 		else
L__main370:
;MyGeiger.mbas,1014 :: 		alert = 0
	BCF        RB2_bit+0, BitPos(RB2_bit+0)
;MyGeiger.mbas,1016 :: 		end if
L__main371:
;MyGeiger.mbas,1018 :: 		NOK_Out (0,4, "              ")
	CLRF       FARG_NOK_Out_x+0
	MOVLW      4
	MOVWF      FARG_NOK_Out_y+0
	MOVLW      32
	MOVWF      ?LocalText_main+0
	MOVLW      32
	MOVWF      ?LocalText_main+1
	MOVLW      32
	MOVWF      ?LocalText_main+2
	MOVLW      32
	MOVWF      ?LocalText_main+3
	MOVLW      32
	MOVWF      ?LocalText_main+4
	MOVLW      32
	MOVWF      ?LocalText_main+5
	MOVLW      32
	MOVWF      ?LocalText_main+6
	MOVLW      32
	MOVWF      ?LocalText_main+7
	MOVLW      32
	MOVWF      ?LocalText_main+8
	MOVLW      32
	MOVWF      ?LocalText_main+9
	MOVLW      32
	MOVWF      ?LocalText_main+10
	MOVLW      32
	MOVWF      ?LocalText_main+11
	MOVLW      32
	MOVWF      ?LocalText_main+12
	MOVLW      32
	MOVWF      ?LocalText_main+13
	CLRF       ?LocalText_main+14
	MOVLW      ?LocalText_main+0
	MOVWF      FARG_NOK_Out_sentance+0
	CALL       _NOK_Out+0
;MyGeiger.mbas,1021 :: 		ByteToStr (sekunds, sekunds_txt)
	MOVF       _sekunds+0, 0
	MOVWF      FARG_ByteToStr_input+0
	MOVLW      _sekunds_txt+0
	MOVWF      FARG_ByteToStr_output+0
	CALL       _ByteToStr+0
;MyGeiger.mbas,1022 :: 		ltrim (sekunds_txt)
	MOVLW      _sekunds_txt+0
	MOVWF      FARG_ltrim_astring+0
	CALL       _ltrim+0
;MyGeiger.mbas,1023 :: 		NOK_OUT (0, 0, "     ")
	CLRF       FARG_NOK_Out_x+0
	CLRF       FARG_NOK_Out_y+0
	MOVLW      32
	MOVWF      ?LocalText_main+0
	MOVLW      32
	MOVWF      ?LocalText_main+1
	MOVLW      32
	MOVWF      ?LocalText_main+2
	MOVLW      32
	MOVWF      ?LocalText_main+3
	MOVLW      32
	MOVWF      ?LocalText_main+4
	CLRF       ?LocalText_main+5
	MOVLW      ?LocalText_main+0
	MOVWF      FARG_NOK_Out_sentance+0
	CALL       _NOK_Out+0
;MyGeiger.mbas,1024 :: 		NOK_OUT (0, 0, sekunds_txt)
	CLRF       FARG_NOK_Out_x+0
	CLRF       FARG_NOK_Out_y+0
	MOVLW      _sekunds_txt+0
	MOVWF      FARG_NOK_Out_sentance+0
	CALL       _NOK_Out+0
;MyGeiger.mbas,1025 :: 		NOK_goto(0, 4)
	CLRF       FARG_NOK_goto_x+0
	MOVLW      4
	MOVWF      FARG_NOK_goto_y+0
	CALL       _NOK_goto+0
;MyGeiger.mbas,1026 :: 		if sek_cnt>13 then sek_cnt = 13
	MOVF       _sek_cnt+1, 0
	SUBLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main446
	MOVF       _sek_cnt+0, 0
	SUBLW      13
L__main446:
	BTFSC      STATUS+0, 0
	GOTO       L__main373
	MOVLW      13
	MOVWF      _sek_cnt+0
	CLRF       _sek_cnt+1
L__main373:
;MyGeiger.mbas,1028 :: 		for scale_c = 0 to sek_cnt
	CLRF       _scale_c+0
L__main375:
	MOVLW      0
	SUBWF      _sek_cnt+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main447
	MOVF       _scale_c+0, 0
	SUBWF      _sek_cnt+0, 0
L__main447:
	BTFSS      STATUS+0, 0
	GOTO       L__main379
;MyGeiger.mbas,1029 :: 		NOK_Chr ("#")
	MOVLW      35
	MOVWF      FARG_NOK_Chr_symlcd+0
	CALL       _NOK_Chr+0
;MyGeiger.mbas,1030 :: 		next scale_c
	MOVLW      0
	XORWF      _sek_cnt+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main448
	MOVF       _sek_cnt+0, 0
	XORWF      _scale_c+0, 0
L__main448:
	BTFSC      STATUS+0, 2
	GOTO       L__main379
	INCF       _scale_c+0, 1
	GOTO       L__main375
L__main379:
;MyGeiger.mbas,1032 :: 		adc_rd = ADC_Read(0)
	CLRF       FARG_ADC_Read_channel+0
	CALL       _ADC_Read+0
	MOVF       R0+0, 0
	MOVWF      _adc_rd+0
	MOVF       R0+1, 0
	MOVWF      _adc_rd+1
;MyGeiger.mbas,1034 :: 		tlong = adc_rd * 2.45             '1.21 for 1.25V ; 2.44 for 2.5V
	CALL       _Int2Double+0
	MOVLW      205
	MOVWF      R4+0
	MOVLW      204
	MOVWF      R4+1
	MOVLW      28
	MOVWF      R4+2
	MOVLW      128
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	CALL       _Double2Int+0
	MOVF       R0+0, 0
	MOVWF      _tlong+0
	MOVF       R0+1, 0
	MOVWF      _tlong+1
;MyGeiger.mbas,1035 :: 		IntToStr (tlong, Dispv)
	MOVF       R0+0, 0
	MOVWF      FARG_IntToStr_input+0
	MOVF       R0+1, 0
	MOVWF      FARG_IntToStr_input+1
	MOVLW      _DispV+0
	MOVWF      FARG_IntToStr_output+0
	CALL       _IntToStr+0
;MyGeiger.mbas,1036 :: 		ltrim (Dispv)
	MOVLW      _DispV+0
	MOVWF      FARG_ltrim_astring+0
	CALL       _ltrim+0
;MyGeiger.mbas,1037 :: 		NOK_Out (60, 0, Dispv)
	MOVLW      60
	MOVWF      FARG_NOK_Out_x+0
	CLRF       FARG_NOK_Out_y+0
	MOVLW      _DispV+0
	MOVWF      FARG_NOK_Out_sentance+0
	CALL       _NOK_Out+0
;MyGeiger.mbas,1043 :: 		sekunds = sekunds - 1
	DECF       _sekunds+0, 1
;MyGeiger.mbas,1044 :: 		sek_over = 0
	BCF        _sek_over+0, BitPos(_sek_over+0)
;MyGeiger.mbas,1045 :: 		TMR1IE_bit = 1
	BSF        TMR1IE_bit+0, BitPos(TMR1IE_bit+0)
L__main367:
;MyGeiger.mbas,1050 :: 		if cpm_read_done = 1 then           ' When interrupt occur
	BTFSS      _cpm_read_done+0, BitPos(_cpm_read_done+0)
	GOTO       L__main381
;MyGeiger.mbas,1051 :: 		TMR1IE_bit = 0                      ' Disable interrupts
	BCF        TMR1IE_bit+0, BitPos(TMR1IE_bit+0)
;MyGeiger.mbas,1054 :: 		if n = 0 then                   'jjjjj
	MOVF       _n+0, 0
	XORLW      0
	BTFSS      STATUS+0, 2
	GOTO       L__main384
;MyGeiger.mbas,1055 :: 		n = 1
	MOVLW      1
	MOVWF      _n+0
;MyGeiger.mbas,1056 :: 		m_period = 199
	MOVLW      199
	MOVWF      _m_period+0
;MyGeiger.mbas,1057 :: 		sekunds = 10
	MOVLW      10
	MOVWF      _sekunds+0
;MyGeiger.mbas,1058 :: 		cpm = sek_cnt
	MOVF       _sek_cnt+0, 0
	MOVWF      _cpm+0
	MOVF       _sek_cnt+1, 0
	MOVWF      _cpm+1
	CLRF       _cpm+2
	CLRF       _cpm+3
;MyGeiger.mbas,1059 :: 		goto DD
	GOTO       L__main_dd
;MyGeiger.mbas,1060 :: 		else
L__main384:
;MyGeiger.mbas,1062 :: 		CX[xx] = counts
	MOVF       _xx+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _CX+0
	MOVWF      FSR
	MOVF       _counts+0, 0
	MOVWF      INDF+0
	MOVF       _counts+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
	INCF       FSR, 1
	CLRF       INDF+0
	INCF       FSR, 1
	CLRF       INDF+0
;MyGeiger.mbas,1063 :: 		xx = xx + 1
	INCF       _xx+0, 1
;MyGeiger.mbas,1064 :: 		if xx>5 then
	MOVF       _xx+0, 0
	SUBLW      5
	BTFSC      STATUS+0, 0
	GOTO       L__main388
;MyGeiger.mbas,1065 :: 		xx=0
	CLRF       _xx+0
L__main388:
;MyGeiger.mbas,1067 :: 		old_cpm = cpm
	MOVF       _cpm+0, 0
	MOVWF      _old_cpm+0
	MOVF       _cpm+1, 0
	MOVWF      _old_cpm+1
	MOVF       _cpm+2, 0
	MOVWF      _old_cpm+2
	MOVF       _cpm+3, 0
	MOVWF      _old_cpm+3
;MyGeiger.mbas,1068 :: 		cpm = CX[0] + CX[1] + CX[2] + CX[3] + CX[4] + CX[5]
	MOVF       _CX+0, 0
	MOVWF      R0+0
	MOVF       _CX+1, 0
	MOVWF      R0+1
	MOVF       _CX+2, 0
	MOVWF      R0+2
	MOVF       _CX+3, 0
	MOVWF      R0+3
	MOVF       _CX+4, 0
	ADDWF      R0+0, 1
	MOVF       _CX+5, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _CX+5, 0
	ADDWF      R0+1, 1
	MOVF       _CX+6, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _CX+6, 0
	ADDWF      R0+2, 1
	MOVF       _CX+7, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _CX+7, 0
	ADDWF      R0+3, 1
	MOVF       _CX+8, 0
	ADDWF      R0+0, 1
	MOVF       _CX+9, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _CX+9, 0
	ADDWF      R0+1, 1
	MOVF       _CX+10, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _CX+10, 0
	ADDWF      R0+2, 1
	MOVF       _CX+11, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _CX+11, 0
	ADDWF      R0+3, 1
	MOVF       _CX+12, 0
	ADDWF      R0+0, 1
	MOVF       _CX+13, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _CX+13, 0
	ADDWF      R0+1, 1
	MOVF       _CX+14, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _CX+14, 0
	ADDWF      R0+2, 1
	MOVF       _CX+15, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _CX+15, 0
	ADDWF      R0+3, 1
	MOVF       _CX+16, 0
	ADDWF      R0+0, 1
	MOVF       _CX+17, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _CX+17, 0
	ADDWF      R0+1, 1
	MOVF       _CX+18, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _CX+18, 0
	ADDWF      R0+2, 1
	MOVF       _CX+19, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _CX+19, 0
	ADDWF      R0+3, 1
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	MOVF       _CX+20, 0
	ADDWF      R4+0, 1
	MOVF       _CX+21, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _CX+21, 0
	ADDWF      R4+1, 1
	MOVF       _CX+22, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _CX+22, 0
	ADDWF      R4+2, 1
	MOVF       _CX+23, 0
	BTFSC      STATUS+0, 0
	INCFSZ     _CX+23, 0
	ADDWF      R4+3, 1
	MOVF       R4+0, 0
	MOVWF      _cpm+0
	MOVF       R4+1, 0
	MOVWF      _cpm+1
	MOVF       R4+2, 0
	MOVWF      _cpm+2
	MOVF       R4+3, 0
	MOVWF      _cpm+3
;MyGeiger.mbas,1070 :: 		if old_cpm >= cpm then
	MOVF       R4+3, 0
	SUBWF      _old_cpm+3, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main449
	MOVF       R4+2, 0
	SUBWF      _old_cpm+2, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main449
	MOVF       R4+1, 0
	SUBWF      _old_cpm+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main449
	MOVF       R4+0, 0
	SUBWF      _old_cpm+0, 0
L__main449:
	BTFSS      STATUS+0, 0
	GOTO       L__main391
;MyGeiger.mbas,1071 :: 		parid_cpm = old_cpm - cpm
	MOVF       _cpm+0, 0
	SUBWF      _old_cpm+0, 0
	MOVWF      _parid_cpm+0
	MOVF       _cpm+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _old_cpm+1, 0
	MOVWF      _parid_cpm+1
	GOTO       L__main392
;MyGeiger.mbas,1072 :: 		else
L__main391:
;MyGeiger.mbas,1073 :: 		parid_cpm = cpm - old_cpm
	MOVF       _old_cpm+0, 0
	SUBWF      _cpm+0, 0
	MOVWF      _parid_cpm+0
	MOVF       _old_cpm+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	SUBWF      _cpm+1, 0
	MOVWF      _parid_cpm+1
;MyGeiger.mbas,1074 :: 		end if
L__main392:
;MyGeiger.mbas,1076 :: 		if parid_cpm >=50 then
	MOVLW      0
	SUBWF      _parid_cpm+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main450
	MOVLW      50
	SUBWF      _parid_cpm+0, 0
L__main450:
	BTFSS      STATUS+0, 0
	GOTO       L__main394
;MyGeiger.mbas,1077 :: 		cpm = counts * 6
	MOVF       _counts+0, 0
	MOVWF      R0+0
	MOVF       _counts+1, 0
	MOVWF      R0+1
	CLRF       R0+2
	CLRF       R0+3
	MOVLW      6
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      _cpm+0
	MOVF       R0+1, 0
	MOVWF      _cpm+1
	MOVF       R0+2, 0
	MOVWF      _cpm+2
	MOVF       R0+3, 0
	MOVWF      _cpm+3
;MyGeiger.mbas,1078 :: 		for xx = 0 to 5
	CLRF       _xx+0
L__main397:
;MyGeiger.mbas,1079 :: 		CX[xx] = counts
	MOVF       _xx+0, 0
	MOVWF      R0+0
	RLF        R0+0, 1
	BCF        R0+0, 0
	RLF        R0+0, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      _CX+0
	MOVWF      FSR
	MOVF       _counts+0, 0
	MOVWF      INDF+0
	MOVF       _counts+1, 0
	INCF       FSR, 1
	MOVWF      INDF+0
	INCF       FSR, 1
	CLRF       INDF+0
	INCF       FSR, 1
	CLRF       INDF+0
;MyGeiger.mbas,1080 :: 		next xx
	MOVF       _xx+0, 0
	XORLW      5
	BTFSC      STATUS+0, 2
	GOTO       L__main400
	INCF       _xx+0, 1
	GOTO       L__main397
L__main400:
;MyGeiger.mbas,1081 :: 		xx = 0
	CLRF       _xx+0
L__main394:
;MyGeiger.mbas,1085 :: 		DD:
L__main_dd:
;MyGeiger.mbas,1086 :: 		dose = cpm * CF                  ' Convert CPM to uSv/h (cpm * conversion factor  = uSv/h);
	MOVF       _cpm+0, 0
	MOVWF      R0+0
	MOVF       _cpm+1, 0
	MOVWF      R0+1
	MOVF       _cpm+2, 0
	MOVWF      R0+2
	MOVF       _cpm+3, 0
	MOVWF      R0+3
	MOVF       _CF+0, 0
	MOVWF      R4+0
	CLRF       R4+1
	CLRF       R4+2
	CLRF       R4+3
	CALL       _Mul_32x32_U+0
	MOVF       R0+0, 0
	MOVWF      _dose+0
	MOVF       R0+1, 0
	MOVWF      _dose+1
	MOVF       R0+2, 0
	MOVWF      _dose+2
	MOVF       R0+3, 0
	MOVWF      _dose+3
;MyGeiger.mbas,1087 :: 		LongWordToStr (cpm, CPM_Display)
	MOVF       _cpm+0, 0
	MOVWF      FARG_LongWordToStr_input+0
	MOVF       _cpm+1, 0
	MOVWF      FARG_LongWordToStr_input+1
	MOVF       _cpm+2, 0
	MOVWF      FARG_LongWordToStr_input+2
	MOVF       _cpm+3, 0
	MOVWF      FARG_LongWordToStr_input+3
	MOVLW      _CPM_Display+0
	MOVWF      FARG_LongWordToStr_output+0
	CALL       _LongWordToStr+0
;MyGeiger.mbas,1088 :: 		ltrim (CPM_Display)
	MOVLW      _CPM_Display+0
	MOVWF      FARG_ltrim_astring+0
	CALL       _ltrim+0
;MyGeiger.mbas,1089 :: 		UART1_Write_Text(CPM_Display)
	MOVLW      _CPM_Display+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;MyGeiger.mbas,1090 :: 		UART1_Write_Text(" ")
	MOVLW      32
	MOVWF      ?LocalText_main+0
	CLRF       ?LocalText_main+1
	MOVLW      ?LocalText_main+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;MyGeiger.mbas,1091 :: 		NOK_Out (24, 5, "          ")
	MOVLW      24
	MOVWF      FARG_NOK_Out_x+0
	MOVLW      5
	MOVWF      FARG_NOK_Out_y+0
	MOVLW      32
	MOVWF      ?LocalText_main+0
	MOVLW      32
	MOVWF      ?LocalText_main+1
	MOVLW      32
	MOVWF      ?LocalText_main+2
	MOVLW      32
	MOVWF      ?LocalText_main+3
	MOVLW      32
	MOVWF      ?LocalText_main+4
	MOVLW      32
	MOVWF      ?LocalText_main+5
	MOVLW      32
	MOVWF      ?LocalText_main+6
	MOVLW      32
	MOVWF      ?LocalText_main+7
	MOVLW      32
	MOVWF      ?LocalText_main+8
	MOVLW      32
	MOVWF      ?LocalText_main+9
	CLRF       ?LocalText_main+10
	MOVLW      ?LocalText_main+0
	MOVWF      FARG_NOK_Out_sentance+0
	CALL       _NOK_Out+0
;MyGeiger.mbas,1092 :: 		NOK_out (24, 5, CPM_Display)
	MOVLW      24
	MOVWF      FARG_NOK_Out_x+0
	MOVLW      5
	MOVWF      FARG_NOK_Out_y+0
	MOVLW      _CPM_Display+0
	MOVWF      FARG_NOK_Out_sentance+0
	CALL       _NOK_Out+0
;MyGeiger.mbas,1093 :: 		dosextract()
	CALL       _dosextract+0
;MyGeiger.mbas,1094 :: 		m_period = 199
	MOVLW      199
	MOVWF      _m_period+0
;MyGeiger.mbas,1095 :: 		sekunds = 10
	MOVLW      10
	MOVWF      _sekunds+0
;MyGeiger.mbas,1097 :: 		if alert = 0 then
	BTFSC      RB2_bit+0, BitPos(RB2_bit+0)
	GOTO       L__main402
;MyGeiger.mbas,1098 :: 		light = 0
	BCF        RA5_bit+0, BitPos(RA5_bit+0)
L__main402:
;MyGeiger.mbas,1105 :: 		if bbb <= BAT_100 then
	MOVF       _bbb+0, 0
	SUBWF      _BAT_100+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L__main405
;MyGeiger.mbas,1106 :: 		NOK_OUT(50,0,"&")        'BATT 100%
	MOVLW      50
	MOVWF      FARG_NOK_Out_x+0
	CLRF       FARG_NOK_Out_y+0
	MOVLW      38
	MOVWF      ?LocalText_main+0
	CLRF       ?LocalText_main+1
	MOVLW      ?LocalText_main+0
	MOVWF      FARG_NOK_Out_sentance+0
	CALL       _NOK_Out+0
	GOTO       L__main406
;MyGeiger.mbas,1107 :: 		else
L__main405:
;MyGeiger.mbas,1108 :: 		if bbb > BAT_50 then
	MOVF       _bbb+0, 0
	SUBWF      _BAT_50+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L__main408
;MyGeiger.mbas,1109 :: 		NOK_OUT(50,0,"%")     'BATT 50%
	MOVLW      50
	MOVWF      FARG_NOK_Out_x+0
	CLRF       FARG_NOK_Out_y+0
	MOVLW      37
	MOVWF      ?LocalText_main+0
	CLRF       ?LocalText_main+1
	MOVLW      ?LocalText_main+0
	MOVWF      FARG_NOK_Out_sentance+0
	CALL       _NOK_Out+0
	GOTO       L__main409
;MyGeiger.mbas,1110 :: 		else
L__main408:
;MyGeiger.mbas,1111 :: 		NOK_OUT(50,0,"'")      'BATT 75%
	MOVLW      50
	MOVWF      FARG_NOK_Out_x+0
	CLRF       FARG_NOK_Out_y+0
	MOVLW      39
	MOVWF      ?LocalText_main+0
	CLRF       ?LocalText_main+1
	MOVLW      ?LocalText_main+0
	MOVWF      FARG_NOK_Out_sentance+0
	CALL       _NOK_Out+0
;MyGeiger.mbas,1112 :: 		end if
L__main409:
;MyGeiger.mbas,1113 :: 		end if
L__main406:
;MyGeiger.mbas,1115 :: 		if bbb >= BAT_25 then      'BATT 25%
	MOVF       _BAT_25+0, 0
	SUBWF      _bbb+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L__main411
;MyGeiger.mbas,1116 :: 		NOK_OUT(50,0,"-")
	MOVLW      50
	MOVWF      FARG_NOK_Out_x+0
	CLRF       FARG_NOK_Out_y+0
	MOVLW      45
	MOVWF      ?LocalText_main+0
	CLRF       ?LocalText_main+1
	MOVLW      ?LocalText_main+0
	MOVWF      FARG_NOK_Out_sentance+0
	CALL       _NOK_Out+0
L__main411:
;MyGeiger.mbas,1121 :: 		if Button (PORTB, 6, 50, 1) then calibration
	MOVLW      PORTB+0
	MOVWF      FARG_Button_port+0
	MOVLW      6
	MOVWF      FARG_Button_pin+0
	MOVLW      50
	MOVWF      FARG_Button_time+0
	MOVLW      1
	MOVWF      FARG_Button_activeState+0
	CALL       _Button+0
	MOVF       R0+0, 0
	BTFSC      STATUS+0, 2
	GOTO       L__main414
	CALL       _calibration+0
;MyGeiger.mbas,1122 :: 		m_period = 199
	MOVLW      199
	MOVWF      _m_period+0
;MyGeiger.mbas,1123 :: 		sekunds = 10
	MOVLW      10
	MOVWF      _sekunds+0
;MyGeiger.mbas,1124 :: 		goto PRINT_LABELS
	GOTO       L__main_print_labels
L__main414:
;MyGeiger.mbas,1126 :: 		cpm_read_done = 0                ' Set flag = 0
	BCF        _cpm_read_done+0, BitPos(_cpm_read_done+0)
;MyGeiger.mbas,1127 :: 		TMR1IE_bit = 1                      ' Enable interrupts
	BSF        TMR1IE_bit+0, BitPos(TMR1IE_bit+0)
L__main381:
;MyGeiger.mbas,1131 :: 		wend
	GOTO       L__main328
L_end_main:
	GOTO       $+0
; end of _main
