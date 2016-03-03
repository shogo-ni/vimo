#include <Metro.h>  //Metroのライブラリの取り込み

unsigned long Time;  //実行中のプログラムがスタートしてからの時間

const int fsrPin0 = 0;  //圧力センサ1のpin ここ頭
const int fsrPin1 = 1;  //圧力センサ2のpin 
const int fsrPin2 = 2;  //圧力センサ3のpin
const int fsrPin3 = 3;  //圧力センサ1のpin 
const int fsrPin4 = 4;  //圧力センサ2のpin
const int fsrPin5 = 5;  //圧力センサ3のpin
const int fsrPin6 = 6;  //圧力センサ1のpin 
const int fsrPin7 = 7;  //圧力センサ2のpin 
const int fsrPin8 = 8;  //圧力センサ3のpin
const int fsrPin9 = 9;  //圧力センサ1のpin 

const int fsrPin10 = 10;  //圧力センサ2のpin ここから肩
const int fsrPin11 = 11;  //圧力センサ3のpin
const int fsrPin12 = 12;  //圧力センサ1のpin 
const int fsrPin13 = 13;  //圧力センサ2のpin 
const int fsrPin14 = 14;  //圧力センサ3のpin
const int fsrPin15 = 15;  //圧力センサ3のpin

const int rLED=13;
const int gLED=12;
const int bLED=14;

//const int vibPin = 9;  //振動モータのPin
int F0;
int F1;
int F2;
int F3;
int F4;
int F5;
int F6;
int F7;
int F8;
int F9;
int F10;
int F11;
int F12;
int F13;
int F14;
int F15;

int flag;
int x;  //頭の圧力センシング値(pin0~pin3までのmax)
int y;  //右肩の圧力センシング値(pin4~pin15までのmax)
//int z;  //左肩の圧力センシング値

int a;  //-誤差値
int b;  //+誤差値
int d = 50;  //誤差範囲
long dtime ;  //振動のdelay time
long disp;  //振動の大きさ
long val;  //max値
long valplus;
long valave;
int i;


const int in1Pin = 4;  //motor+
const int in2Pin = 5;  //motor-
const int pwm1Pin = 10;  //ソレノイド1
const int pwm2Pin = 11;  //ソレノイド2

const int in3Pin = 2;
const int in4Pin = 3;
const int pwm3Pin = 8;  //ソレノイド3
const int pwm4Pin = 9;  //ソレノイド4

const int in5Pin = 15;
const int in6Pin = 16;
const int pwm5Pin = 6;  //ソレノイド3
const int pwm6Pin = 7;  //ソレノイド4

// multi thread
Metro metro1 = Metro (0);  //metro1(コンプレッサ)をdelay(0)で展開
Metro metro2 = Metro (0);  //metro2(振動モータ)をdelay(0)で展開
// Metro metro3 = Metro (0);

void setup() {
  Serial.begin(9600);
  TCCR1B &= B11111000;
  TCCR1B |= B00000101;
  pinMode(rLED,OUTPUT);
  pinMode(gLED,OUTPUT);
  pinMode(bLED,OUTPUT);
  
  pinMode(in1Pin,OUTPUT); 
  pinMode(in2Pin,OUTPUT); 
  pinMode(pwm1Pin,OUTPUT);
  pinMode(pwm2Pin,OUTPUT);
  
  pinMode(in3Pin,OUTPUT); 
  pinMode(in4Pin,OUTPUT); 
  pinMode(pwm3Pin,OUTPUT);
  pinMode(pwm4Pin,OUTPUT);
  
  pinMode(in5Pin,OUTPUT); 
  pinMode(in6Pin,OUTPUT); 
  pinMode(pwm5Pin,OUTPUT);
  pinMode(pwm6Pin,OUTPUT);
}

void loop() {
  Time = millis();
  Serial.print(Time/1000);
  Serial.print(",");

  //  圧力値取得
  F0 = analogRead(fsrPin0);
  F1 = analogRead(fsrPin1);
  F2 = analogRead(fsrPin2);
  F3 = analogRead(fsrPin3);
  F4 = analogRead(fsrPin4);
  F5 = analogRead(fsrPin5);
  F6 = analogRead(fsrPin6);
  F7 = analogRead(fsrPin7);
  F8 = analogRead(fsrPin8);
  F9 = analogRead(fsrPin9);
  F10 = analogRead(fsrPin10);
  F11 = analogRead(fsrPin11);
  F12 = analogRead(fsrPin12);
  F13 = analogRead(fsrPin13);
  F14 = analogRead(fsrPin14);
  F15 = analogRead(fsrPin15);

  // 頭の最大値を取得
  x = F0;
  if( x < F1 ) {
    x = F1;
  }
  if( x < F2 ) {
    x = F2;
  }
  if( x < F3 ) {
    x = F3;
  }
  if( x < F4 ) {
    x = F4;
  }
  if( x < F5 ) {
    x = F5;
  }  
  if( x < F6 ) {
    x = F6;
  }  
  if( x < F7 ) {
    x = F7;
  }
  
  //　肩の最大値を取得

  y = F8;
    if( x < F9 ) {
    x = F9;
  }
  if( x < F10 ) {
    x = F10;
  }  
  if( y < F11 ) {
    y = F11;
  }
  if( y < F12 ) {
    y = F12;
  }
  if( y < F13 ) {
    y = F13;
  } 
  if( x < F14 ) {
    x = F14;
  }  
  if( x < F15 ) {
    x = F15;
  }  
  
  a = x - d;
  b = x + d;
  //  val = max(y, z);
  // 圧力センサを複数用いる場合
  //val1 = max(val, sensanother1);
  //val2 = max(val1, sensanother2);

  // 読み込んだ各軸をそのまま表示する

  flag = 0;
  
  //肩・頭の最大値の比から順に　側臥位　仰臥位　伏臥位　気道確保姿勢　
  //伏臥位はいびきの有無でも判断 
  
// 側臥位　のとき　→　ポンプOFF!
  if ((0 < (x/y)) && ((x/y) < 0.35)){      
    flag = 0;
          digitalWrite(rLED, LOW);    
      // ポンプ2の停止
      digitalWrite(in1Pin,HIGH);
      digitalWrite(in2Pin,HIGH);
      
            digitalWrite(gLED, LOW);    
      // ポンプ2の停止
      digitalWrite(in3Pin,HIGH);
      digitalWrite(in4Pin,HIGH);
      
            digitalWrite(gLED, LOW);    
      // ポンプ2の停止
      digitalWrite(in5Pin,HIGH);
      digitalWrite(in6Pin,HIGH);
  }
// 仰臥位 のとき　→　ポンプON!
  else if((0.35 < (x/y)) && ((x/y) < 1.5)){
    flag = 1;
          digitalWrite(rLED, HIGH);
       // ポンプ1の動作開始
      digitalWrite(pwm1Pin,LOW);
      digitalWrite(pwm2Pin,LOW);
      digitalWrite(in1Pin,HIGH);
      digitalWrite(in2Pin,LOW);
            
          digitalWrite(gLED, HIGH);
       // ポンプ2の動作開始
      digitalWrite(pwm3Pin,LOW);
      digitalWrite(pwm4Pin,LOW);
      digitalWrite(in3Pin,HIGH);
      digitalWrite(in4Pin,LOW);
    
          digitalWrite(bLED, HIGH);
       // ポンプ2の動作開始
      digitalWrite(pwm5Pin,LOW);
      digitalWrite(pwm6Pin,LOW);
      digitalWrite(in5Pin,HIGH);
      digitalWrite(in6Pin,LOW);
  }
//  // 伏臥位 のとき　1　→　ポンプOFF!
//  else if((0.8 < (x/y)) && ((x/y) < 1.2) && flag != 1 && flag != 3){
//    flag = 2;
//          digitalWrite(rLED, LOW);    
//      // ポンプ2の停止
//      digitalWrite(in1Pin,HIGH);
//      digitalWrite(in2Pin,HIGH);
//      
//            digitalWrite(gLED, LOW);    
//      // ポンプ2の停止
//      digitalWrite(in3Pin,HIGH);
//      digitalWrite(in4Pin,HIGH);
//      
//            digitalWrite(gLED, LOW);    
//      // ポンプ2の停止
//      digitalWrite(in5Pin,HIGH);
//      digitalWrite(in6Pin,HIGH);
//  }   
//  // 伏臥位 のとき　2　→　ポンプON!  && flag != 1
//  else if((0.8 < (x/y)) && ((x/y) < 1.6) && flag == 1 && flag == 3){
//    flag = 3;
//          digitalWrite(rLED, HIGH);
//       // ポンプ1の動作開始
//      digitalWrite(pwm1Pin,LOW);
//      digitalWrite(pwm2Pin,LOW);
//      digitalWrite(in1Pin,HIGH);
//      digitalWrite(in2Pin,LOW);
//            
//          digitalWrite(gLED, HIGH);
//       // ポンプ2の動作開始
//      digitalWrite(pwm3Pin,LOW);
//      digitalWrite(pwm4Pin,LOW);
//      digitalWrite(in3Pin,HIGH);
//      digitalWrite(in4Pin,LOW);
//    
//          digitalWrite(bLED, HIGH);
//       // ポンプ2の動作開始
//      digitalWrite(pwm5Pin,LOW);
//      digitalWrite(pwm6Pin,LOW);
//      digitalWrite(in5Pin,HIGH);
//      digitalWrite(in6Pin,LOW);
//  }    
  //　気道確保姿勢まで のとき　3　→　ポンプOFF!
  else if((1.5 < (x/y)) && ((x/y) < 1.6)){
    flag = 3;
          digitalWrite(rLED, LOW);    
      // ポンプ2の停止
      digitalWrite(in1Pin,HIGH);
      digitalWrite(in2Pin,HIGH);
      
            digitalWrite(gLED, LOW);    
      // ポンプ2の停止
      digitalWrite(in3Pin,HIGH);
      digitalWrite(in4Pin,HIGH);
      
            digitalWrite(gLED, LOW);    
      // ポンプ2の停止
      digitalWrite(in5Pin,HIGH);
      digitalWrite(in6Pin,HIGH);
  }  
  else if((1.7 < (x/y))){
    flag = 4;
       digitalWrite(rLED, HIGH);
   // ポンプ2の解放
      digitalWrite(in1Pin,LOW); 
      digitalWrite(in2Pin, HIGH);  
      analogWrite(pwm1Pin,255);
      analogWrite(pwm2Pin,255);
      
         digitalWrite(gLED, HIGH);
   // ポンプ2の解放
      digitalWrite(in3Pin,LOW); 
      digitalWrite(in4Pin, HIGH);  
      analogWrite(pwm3Pin,255);
      analogWrite(pwm4Pin,255);
      
         digitalWrite(bLED, HIGH);
   // ポンプ2の解放
      digitalWrite(in5Pin,LOW); 
      digitalWrite(in6Pin, HIGH);  
      analogWrite(pwm5Pin,255);
      analogWrite(pwm6Pin,255);
  }
  
  
// サンプリング周波数
  delay(100);
  
//  Serial.print(Rtc.hours(),HEX);
//  Serial.print(":");
//  Serial.print(Rtc.minutes(),HEX);
//  Serial.print(":");
//  Serial.println(Rtc.seconds(),HEX);
//  Serial.print(",");
  Serial.print(F0);
  Serial.print(",");
  Serial.print(F1);
  Serial.print(",");
  Serial.print(F2);  
  Serial.print(",");
  Serial.print(F3);
  Serial.print(",");
  Serial.print(F4);
  Serial.print(",");
  Serial.print(F5);
  Serial.print(",");
  Serial.print(F6);
  Serial.print(",");
  Serial.print(F7);
  Serial.print(",");
  Serial.print(F8);
  Serial.print(",");
  Serial.print(F9);
  Serial.print(",");
  Serial.print(F10);
  Serial.print(",");
  Serial.print(F11);
  Serial.print(",");
  Serial.print(F12);
  Serial.print(",");
  Serial.print(F13);
  Serial.print(",");
  Serial.print(F14);
  Serial.print(",");
  Serial.print(F15);
  Serial.print(",,,,");

  Serial.print(x);    // 頭圧力
  Serial.print(",");
  Serial.print(y);    // 右肩圧力
  Serial.print(",");
  Serial.println(flag);
  
  
  //  Serial.print(z);    // 左肩圧力
  //  Serial.print(",");
  //  Serial.print(val);  // 肩圧力のmax値
  //  Serial.print(",");
//  Serial.print(a);
//  Serial.print(",");
//  Serial.println(b);



   
  if (metro1. check() == 1){
    if (y > x){  // 3個以上の圧力センサ使用時はvalhの方がbetter
      digitalWrite(pwm1Pin,LOW);
      digitalWrite(pwm2Pin,LOW);
      digitalWrite(in1Pin,HIGH);
      digitalWrite(in2Pin,LOW);
    }

    if (y == x){
      digitalWrite(pwm1Pin,LOW);
      digitalWrite(pwm2Pin,LOW);
      digitalWrite(in1Pin, HIGH);
      digitalWrite(in2Pin,HIGH); 
    }

    if (y < x){
      digitalWrite(in1Pin, LOW);
      digitalWrite(in2Pin,HIGH); 
      analogWrite(pwm1Pin,255);
      analogWrite(pwm2Pin,255);
    }
    // 誤作動防止
    if (x == 0 && y > 0 || x > 0 && y == 0){
      digitalWrite(pwm1Pin,LOW);
      digitalWrite(pwm2Pin,LOW);
      digitalWrite(in1Pin, HIGH);
      digitalWrite(in2Pin,HIGH); 
    }

  }
  if (metro2. check() ==1){
    if (Time  > 10000){  // timeで指定しているがセンサの平均値のブレをifの動作条件に加えたほうが快適な起床に繋がる
      digitalWrite(9, OUTPUT);

    }

    //センサ平均値(未完)
    // if (metro3. check() == 1){
    // for(i=0; i<1000; i++){
    // val = max(y, z);
    // valplus += val;
    // val = 0;
    // }
    // valave = valplus/1000;
    // valplus = 0;
    // }

  }


}


