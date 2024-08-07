
_counter:

;MyProject.c,15 :: 		void counter(signed char count){
;MyProject.c,17 :: 		char left= count/10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       FARG_counter_count+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_S+0
	MOVF       R0+0, 0
	MOVWF      FLOC__counter+0
	MOVLW      10
	MOVWF      R4+0
	MOVF       FARG_counter_count+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
;MyProject.c,20 :: 		Lsd=0;    //transistor on
	BCF        PORTA+0, 1
;MyProject.c,21 :: 		Msd=0;    //transistor on
	BCF        PORTA+0, 0
;MyProject.c,22 :: 		Lsd2=0;    //transistor on
	BCF        PORTA+0, 3
;MyProject.c,23 :: 		Msd2=0;    //transistor on
	BCF        PORTA+0, 2
;MyProject.c,24 :: 		display=right;
	MOVF       R0+0, 0
	MOVWF      PORTD+0
;MyProject.c,25 :: 		display2=left;
	MOVF       FLOC__counter+0, 0
	MOVWF      PORTB+0
;MyProject.c,26 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_counter0:
	DECFSZ     R13+0, 1
	GOTO       L_counter0
	DECFSZ     R12+0, 1
	GOTO       L_counter0
	DECFSZ     R11+0, 1
	GOTO       L_counter0
	NOP
	NOP
;MyProject.c,28 :: 		}
L_end_counter:
	RETURN
; end of _counter

_main:

;MyProject.c,33 :: 		void main() {
;MyProject.c,37 :: 		adcon1=7;
	MOVLW      7
	MOVWF      ADCON1+0
;MyProject.c,39 :: 		trisd=0;     display=0;
	CLRF       TRISD+0
	CLRF       PORTD+0
;MyProject.c,40 :: 		trisb=0;     display2=0;
	CLRF       TRISB+0
	CLRF       PORTB+0
;MyProject.c,42 :: 		trisc=0;     portc=0;  // leds are off
	CLRF       TRISC+0
	CLRF       PORTC+0
;MyProject.c,43 :: 		trisa.b0=0;  Msd=1;     //transistor off
	BCF        TRISA+0, 0
	BSF        PORTA+0, 0
;MyProject.c,44 :: 		trisa.b1=0;  Lsd=1;     //transistor off
	BCF        TRISA+0, 1
	BSF        PORTA+0, 1
;MyProject.c,45 :: 		trisa.b2=0;  Msd2=1;     //transistor off
	BCF        TRISA+0, 2
	BSF        PORTA+0, 2
;MyProject.c,46 :: 		trisa.b3=0;  Lsd2=1;
	BCF        TRISA+0, 3
	BSF        PORTA+0, 3
;MyProject.c,48 :: 		trisb.b5=1;  portb=0;  //automatic / manual switch.
	BSF        TRISB+0, 5
	CLRF       PORTB+0
;MyProject.c,49 :: 		trisb.B6=1;           //manual mode
	BSF        TRISB+0, 6
;MyProject.c,51 :: 		loop:
___main_loop:
;MyProject.c,54 :: 		if(sw1==0){
	BTFSC      PORTB+0, 5
	GOTO       L_main1
;MyProject.c,56 :: 		portb=0;
	CLRF       PORTB+0
;MyProject.c,57 :: 		portd=0;
	CLRF       PORTD+0
;MyProject.c,60 :: 		if(sw2==1 && flag== 0){
	BTFSS      PORTB+0, 6
	GOTO       L_main4
	MOVLW      0
	XORWF      _flag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main45
	MOVLW      0
	XORWF      _flag+0, 0
L__main45:
	BTFSS      STATUS+0, 2
	GOTO       L_main4
L__main42:
;MyProject.c,61 :: 		flag= 1;      // flag = true
	MOVLW      1
	MOVWF      _flag+0
	MOVLW      0
	MOVWF      _flag+1
;MyProject.c,62 :: 		for( count=3 ; count>=0 ; count--){
	MOVLW      3
	MOVWF      main_count_L0+0
L_main5:
	MOVLW      128
	XORWF      main_count_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main6
;MyProject.c,63 :: 		portc=0b00001010;   // red west & yellow south on
	MOVLW      10
	MOVWF      PORTC+0
;MyProject.c,64 :: 		left= count/10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       main_count_L0+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_S+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+0
	MOVF       FLOC__main+0, 0
	MOVWF      _left+0
;MyProject.c,65 :: 		right=count%10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       main_count_L0+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _right+0
;MyProject.c,67 :: 		Lsd=1;    //transistor off
	BSF        PORTA+0, 1
;MyProject.c,68 :: 		Msd=1;    //transistor off
	BSF        PORTA+0, 0
;MyProject.c,69 :: 		Lsd2=0;    //transistor on
	BCF        PORTA+0, 3
;MyProject.c,70 :: 		Msd2=0;    //transistor on
	BCF        PORTA+0, 2
;MyProject.c,71 :: 		display=right;
	MOVF       R0+0, 0
	MOVWF      PORTD+0
;MyProject.c,72 :: 		display2=left;
	MOVF       FLOC__main+0, 0
	MOVWF      PORTB+0
;MyProject.c,73 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main8:
	DECFSZ     R13+0, 1
	GOTO       L_main8
	DECFSZ     R12+0, 1
	GOTO       L_main8
	DECFSZ     R11+0, 1
	GOTO       L_main8
	NOP
	NOP
;MyProject.c,62 :: 		for( count=3 ; count>=0 ; count--){
	DECF       main_count_L0+0, 1
;MyProject.c,75 :: 		}
	GOTO       L_main5
L_main6:
;MyProject.c,76 :: 		portb=0;
	CLRF       PORTB+0
;MyProject.c,77 :: 		portd=0;
	CLRF       PORTD+0
;MyProject.c,78 :: 		portc=0b00100001;// green west & red south on
	MOVLW      33
	MOVWF      PORTC+0
;MyProject.c,80 :: 		}
L_main4:
;MyProject.c,82 :: 		if(sw2==1 && flag== 1){
	BTFSS      PORTB+0, 6
	GOTO       L_main11
	MOVLW      0
	XORWF      _flag+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main46
	MOVLW      1
	XORWF      _flag+0, 0
L__main46:
	BTFSS      STATUS+0, 2
	GOTO       L_main11
L__main41:
;MyProject.c,83 :: 		flag= 0;           // flag = false
	CLRF       _flag+0
	CLRF       _flag+1
;MyProject.c,84 :: 		for( count=3 ; count>=0 ; count--){
	MOVLW      3
	MOVWF      main_count_L0+0
L_main12:
	MOVLW      128
	XORWF      main_count_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main13
;MyProject.c,85 :: 		portc=0b00010001;// yellow west & red south on
	MOVLW      17
	MOVWF      PORTC+0
;MyProject.c,86 :: 		left= count/10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       main_count_L0+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_S+0
	MOVF       R0+0, 0
	MOVWF      FLOC__main+0
	MOVF       FLOC__main+0, 0
	MOVWF      _left+0
;MyProject.c,87 :: 		right=count%10;
	MOVLW      10
	MOVWF      R4+0
	MOVF       main_count_L0+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      _right+0
;MyProject.c,89 :: 		Lsd=0;    //transistor on
	BCF        PORTA+0, 1
;MyProject.c,90 :: 		Msd=0;    //transistor on
	BCF        PORTA+0, 0
;MyProject.c,91 :: 		Lsd2=1;    //transistor off
	BSF        PORTA+0, 3
;MyProject.c,92 :: 		Msd2=1;    //transistor off
	BSF        PORTA+0, 2
;MyProject.c,93 :: 		display=right;
	MOVF       R0+0, 0
	MOVWF      PORTD+0
;MyProject.c,94 :: 		display2=left;
	MOVF       FLOC__main+0, 0
	MOVWF      PORTB+0
;MyProject.c,95 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main15:
	DECFSZ     R13+0, 1
	GOTO       L_main15
	DECFSZ     R12+0, 1
	GOTO       L_main15
	DECFSZ     R11+0, 1
	GOTO       L_main15
	NOP
	NOP
;MyProject.c,84 :: 		for( count=3 ; count>=0 ; count--){
	DECF       main_count_L0+0, 1
;MyProject.c,97 :: 		}
	GOTO       L_main12
L_main13:
;MyProject.c,99 :: 		portb=0;
	CLRF       PORTB+0
;MyProject.c,100 :: 		portd=0;
	CLRF       PORTD+0
;MyProject.c,101 :: 		portc=0b00001100;// red west & green south on
	MOVLW      12
	MOVWF      PORTC+0
;MyProject.c,103 :: 		}
L_main11:
;MyProject.c,104 :: 		}
	GOTO       L_main16
L_main1:
;MyProject.c,109 :: 		for(;;){
L_main17:
;MyProject.c,113 :: 		if (sw1 == 1) {
	BTFSS      PORTB+0, 5
	GOTO       L_main20
;MyProject.c,114 :: 		for(count=23 ; count>=4 ; count--){
	MOVLW      23
	MOVWF      main_count_L0+0
L_main21:
	MOVLW      128
	XORWF      main_count_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      4
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main22
;MyProject.c,115 :: 		portc=0b00100001;      // green west & red south on
	MOVLW      33
	MOVWF      PORTC+0
;MyProject.c,116 :: 		counter(count);
	MOVF       main_count_L0+0, 0
	MOVWF      FARG_counter_count+0
	CALL       _counter+0
;MyProject.c,117 :: 		if(sw1==0) break;
	BTFSC      PORTB+0, 5
	GOTO       L_main24
	GOTO       L_main22
L_main24:
;MyProject.c,114 :: 		for(count=23 ; count>=4 ; count--){
	DECF       main_count_L0+0, 1
;MyProject.c,118 :: 		}
	GOTO       L_main21
L_main22:
;MyProject.c,119 :: 		}
L_main20:
;MyProject.c,121 :: 		if (sw1 == 1) {
	BTFSS      PORTB+0, 5
	GOTO       L_main25
;MyProject.c,122 :: 		for(count=3 ; count>=0 ; count--){
	MOVLW      3
	MOVWF      main_count_L0+0
L_main26:
	MOVLW      128
	XORWF      main_count_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main27
;MyProject.c,123 :: 		portc=0b00010001;  // yellow west & red south on
	MOVLW      17
	MOVWF      PORTC+0
;MyProject.c,124 :: 		counter(count);
	MOVF       main_count_L0+0, 0
	MOVWF      FARG_counter_count+0
	CALL       _counter+0
;MyProject.c,125 :: 		if(sw1==0) break;
	BTFSC      PORTB+0, 5
	GOTO       L_main29
	GOTO       L_main27
L_main29:
;MyProject.c,122 :: 		for(count=3 ; count>=0 ; count--){
	DECF       main_count_L0+0, 1
;MyProject.c,126 :: 		}
	GOTO       L_main26
L_main27:
;MyProject.c,127 :: 		}
L_main25:
;MyProject.c,129 :: 		if (sw1 == 1) {
	BTFSS      PORTB+0, 5
	GOTO       L_main30
;MyProject.c,130 :: 		for(count=15 ; count>=4 ; count--){
	MOVLW      15
	MOVWF      main_count_L0+0
L_main31:
	MOVLW      128
	XORWF      main_count_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      4
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main32
;MyProject.c,131 :: 		portc=0b00001100;    // red west & green south on
	MOVLW      12
	MOVWF      PORTC+0
;MyProject.c,132 :: 		counter(count);
	MOVF       main_count_L0+0, 0
	MOVWF      FARG_counter_count+0
	CALL       _counter+0
;MyProject.c,133 :: 		if(sw1==0) break;
	BTFSC      PORTB+0, 5
	GOTO       L_main34
	GOTO       L_main32
L_main34:
;MyProject.c,130 :: 		for(count=15 ; count>=4 ; count--){
	DECF       main_count_L0+0, 1
;MyProject.c,134 :: 		}
	GOTO       L_main31
L_main32:
;MyProject.c,135 :: 		}
L_main30:
;MyProject.c,137 :: 		if (sw1 == 1) {
	BTFSS      PORTB+0, 5
	GOTO       L_main35
;MyProject.c,138 :: 		for(count=3 ; count>=0 ; count--){
	MOVLW      3
	MOVWF      main_count_L0+0
L_main36:
	MOVLW      128
	XORWF      main_count_L0+0, 0
	MOVWF      R0+0
	MOVLW      128
	XORLW      0
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 0
	GOTO       L_main37
;MyProject.c,139 :: 		portc=0b00001010;  // red west & yellow south on
	MOVLW      10
	MOVWF      PORTC+0
;MyProject.c,140 :: 		counter(count);
	MOVF       main_count_L0+0, 0
	MOVWF      FARG_counter_count+0
	CALL       _counter+0
;MyProject.c,141 :: 		if(sw1==0)  break;
	BTFSC      PORTB+0, 5
	GOTO       L_main39
	GOTO       L_main37
L_main39:
;MyProject.c,138 :: 		for(count=3 ; count>=0 ; count--){
	DECF       main_count_L0+0, 1
;MyProject.c,142 :: 		}
	GOTO       L_main36
L_main37:
;MyProject.c,143 :: 		}
L_main35:
;MyProject.c,145 :: 		if(sw1==0)  break;
	BTFSC      PORTB+0, 5
	GOTO       L_main40
	GOTO       L_main18
L_main40:
;MyProject.c,147 :: 		}
	GOTO       L_main17
L_main18:
;MyProject.c,149 :: 		}
L_main16:
;MyProject.c,151 :: 		goto loop ;
	GOTO       ___main_loop
;MyProject.c,153 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
