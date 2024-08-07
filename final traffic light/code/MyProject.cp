#line 1 "C:/Users/sadek/Desktop/final traffic light/code/MyProject.c"









 signed char left ;
 signed char right;
 signed char count;
 int flag= 0;

void counter(signed char count){

 char left= count/10;
 char right=count%10;

  porta.b1 =0;
  porta.b0 =0;
  porta.b3 =0;
  porta.b2 =0;
  portd =right;
  portb =left;
 delay_ms(1000);

}




void main() {

 signed char count;

 adcon1=7;

 trisd=0;  portd =0;
 trisb=0;  portb =0;

 trisc=0; portc=0;
 trisa.b0=0;  porta.b0 =1;
 trisa.b1=0;  porta.b1 =1;
 trisa.b2=0;  porta.b2 =1;
 trisa.b3=0;  porta.b3 =1;

 trisb.b5=1; portb=0;
 trisb.B6=1;

 loop:


 if( portb.b5 ==0){

 portb=0;
 portd=0;


 if( portb.b6 ==1 && flag== 0){
 flag= 1;
 for( count=3 ; count>=0 ; count--){
 portc=0b00001010;
 left= count/10;
 right=count%10;

  porta.b1 =1;
  porta.b0 =1;
  porta.b3 =0;
  porta.b2 =0;
  portd =right;
  portb =left;
 delay_ms(1000);

 }
 portb=0;
 portd=0;
 portc=0b00100001;

 }

 if( portb.b6 ==1 && flag== 1){
 flag= 0;
 for( count=3 ; count>=0 ; count--){
 portc=0b00010001;
 left= count/10;
 right=count%10;

  porta.b1 =0;
  porta.b0 =0;
  porta.b3 =1;
  porta.b2 =1;
  portd =right;
  portb =left;
 delay_ms(1000);

 }

 portb=0;
 portd=0;
 portc=0b00001100;

 }
 }


 else{

 for(;;){



 if ( portb.b5  == 1) {
 for(count=23 ; count>=4 ; count--){
 portc=0b00100001;
 counter(count);
 if( portb.b5 ==0) break;
 }
 }

 if ( portb.b5  == 1) {
 for(count=3 ; count>=0 ; count--){
 portc=0b00010001;
 counter(count);
 if( portb.b5 ==0) break;
 }
 }

 if ( portb.b5  == 1) {
 for(count=15 ; count>=4 ; count--){
 portc=0b00001100;
 counter(count);
 if( portb.b5 ==0) break;
 }
 }

 if ( portb.b5  == 1) {
 for(count=3 ; count>=0 ; count--){
 portc=0b00001010;
 counter(count);
 if( portb.b5 ==0) break;
 }
 }

 if( portb.b5 ==0) break;

 }

 }

 goto loop ;

 }
