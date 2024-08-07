#define display portd
#define display2 portb
#define Lsd porta.b1
#define Msd porta.b0
#define Lsd2 porta.b3
#define Msd2 porta.b2
#define sw1 portb.b5
#define sw2 portb.b6

  signed char left ;
  signed char right;
  signed char count;
  int flag= 0;      //boolean flag for manual mode

void counter(signed char count){

 char left= count/10;
 char right=count%10;

 Lsd=0;    //transistor on
 Msd=0;    //transistor on
 Lsd2=0;    //transistor on
 Msd2=0;    //transistor on
 display=right;
 display2=left;
 delay_ms(1000);

}




void main() {

 signed char count;

 adcon1=7;

 trisd=0;     display=0;
 trisb=0;     display2=0;

 trisc=0;     portc=0;  // leds are off
 trisa.b0=0;  Msd=1;     //transistor off
 trisa.b1=0;  Lsd=1;     //transistor off
 trisa.b2=0;  Msd2=1;     //transistor off
 trisa.b3=0;  Lsd2=1;

 trisb.b5=1;  portb=0;  //automatic / manual switch.
 trisb.B6=1;           //manual mode

      loop:
    //manual mode

    if(sw1==0){

         portb=0;
         portd=0;


     if(sw2==1 && flag== 0){
         flag= 1;      // flag = true
         for( count=3 ; count>=0 ; count--){
         portc=0b00001010;   // red west & yellow south on
          left= count/10;
          right=count%10;

         Lsd=1;    //transistor off
         Msd=1;    //transistor off
         Lsd2=0;    //transistor on
         Msd2=0;    //transistor on
         display=right;
         display2=left;
         delay_ms(1000);

              }
         portb=0;
         portd=0;
         portc=0b00100001;// green west & red south on

         }

     if(sw2==1 && flag== 1){
         flag= 0;           // flag = false
         for( count=3 ; count>=0 ; count--){
         portc=0b00010001;// yellow west & red south on
         left= count/10;
         right=count%10;

         Lsd=0;    //transistor on
         Msd=0;    //transistor on
         Lsd2=1;    //transistor off
         Msd2=1;    //transistor off
         display=right;
         display2=left;
         delay_ms(1000);

              }

         portb=0;
         portd=0;
         portc=0b00001100;// red west & green south on

         }
         }

    //automatic mode
   else{

 for(;;){



        if (sw1 == 1) {
          for(count=23 ; count>=4 ; count--){
          portc=0b00100001;      // green west & red south on
          counter(count);
          if(sw1==0) break;
       }
       }

       if (sw1 == 1) {
         for(count=3 ; count>=0 ; count--){
         portc=0b00010001;  // yellow west & red south on
         counter(count);
        if(sw1==0) break;
          }
          }

       if (sw1 == 1) {
         for(count=15 ; count>=4 ; count--){
         portc=0b00001100;    // red west & green south on
         counter(count);
         if(sw1==0) break;
          }
          }

       if (sw1 == 1) {
         for(count=3 ; count>=0 ; count--){
         portc=0b00001010;  // red west & yellow south on
         counter(count);
         if(sw1==0)  break;
         }
         }

      if(sw1==0)  break;

      }

      }

     goto loop ;

   }