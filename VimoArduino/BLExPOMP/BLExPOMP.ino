const int rLED=13;
const int yLED=12;
const int gLED=14;

const int in1Pin = 4;  //motor+
const int in2Pin = 5;  //motor-
const int pwm1Pin = 10;  //ソレノイド1
const int pwm2Pin = 11;  //ソレノイド2

const int in3Pin = 2;
const int in4Pin = 3;
const int pwm3Pin = 8;  //ソレノイド3
const int pwm4Pin = 9;  //ソレノイド4

int rsvData = 0;
int sensorVal = 0;

// ---------------------------------------------

void setup()
{
  Serial.begin(9600);
  
  pinMode(rLED,OUTPUT);
  pinMode(yLED,OUTPUT);
  pinMode(gLED,OUTPUT);
  
  pinMode(in1Pin,OUTPUT); 
  pinMode(in2Pin,OUTPUT); 
  pinMode(pwm1Pin,OUTPUT);
  pinMode(pwm2Pin,OUTPUT);
  
  pinMode(in3Pin,OUTPUT); 
  pinMode(in4Pin,OUTPUT); 
  pinMode(pwm3Pin,OUTPUT);
  pinMode(pwm4Pin,OUTPUT);
  
}

// ---------------------------------------------

void loop()
{
  // 受信処理
  if(Serial.available() > 0){
    rsvData = Serial.read();
    if(rsvData == 1){
      digitalWrite(rLED, HIGH);
  // ポンプ1の動作開始
      digitalWrite(pwm1Pin,LOW);
      digitalWrite(pwm2Pin,LOW);
      digitalWrite(in1Pin,HIGH);
      digitalWrite(in2Pin,LOW);
    }
    else if(rsvData == 0){
      digitalWrite(rLED, LOW); 
  // ポンプ1の停止      
      digitalWrite(pwm1Pin,LOW);
      digitalWrite(pwm2Pin,LOW);
      digitalWrite(in1Pin, HIGH);
      digitalWrite(in2Pin,HIGH); 
    } 
    else if(rsvData == 2){
      digitalWrite(rLED, HIGH);
  // ポンプ1の解放
      digitalWrite(in1Pin, LOW);  
      digitalWrite(in2Pin,HIGH);
      analogWrite(pwm1Pin,255);
      analogWrite(pwm2Pin,255);
    }
    else if(rsvData == 3){
      digitalWrite(yLED, HIGH);
  // ポンプ2の動作開始
      digitalWrite(pwm3Pin,LOW);
      digitalWrite(pwm4Pin,LOW);
      digitalWrite(in3Pin,HIGH);
      digitalWrite(in4Pin,LOW);
    }
    else if(rsvData == 4){
      digitalWrite(yLED, LOW);    
  // ポンプ2の停止
      digitalWrite(pwm3Pin,LOW);
      digitalWrite(pwm4Pin,LOW);
      digitalWrite(in3Pin,HIGH);
      digitalWrite(in4Pin,HIGH);
    }
    else if(rsvData == 5){
      digitalWrite(yLED, HIGH);
   // ポンプ2の解放
      digitalWrite(in3Pin, HIGH);  
      digitalWrite(in4Pin,LOW); 
      analogWrite(pwm3Pin,255);
      analogWrite(pwm4Pin,255);
    }
  }
  

  //センサー読み取り～送信
  sensorVal = analogRead(0);
  sensorVal = sensorVal>>2; //10bit->8bit値
  Serial.write(sensorVal);
  Serial.println(sensorVal);

  //テスト用動作 -----------------------------
   
//      digitalWrite(rLED, HIGH); 
//      digitalWrite(pwm1Pin,LOW);
//      digitalWrite(pwm2Pin,LOW);
//      digitalWrite(in1Pin,HIGH);
//      digitalWrite(in2Pin,LOW);
//
//      digitalWrite(pwm3Pin,LOW);
//      digitalWrite(pwm4Pin,LOW);
//      digitalWrite(in3Pin,HIGH);
//      digitalWrite(in4Pin,LOW);
//      
//  //ウェイト
//  delay(2000);
//  
//   digitalWrite(rLED, LOW); 
//      digitalWrite(pwm1Pin,LOW);
//      digitalWrite(pwm2Pin,LOW);
//      digitalWrite(in1Pin,HIGH);
//      digitalWrite(in2Pin,HIGH); 
//      
//      digitalWrite(pwm3Pin,LOW);
//      digitalWrite(pwm4Pin,LOW);
//      digitalWrite(in3Pin,HIGH);
//      digitalWrite(in4Pin,HIGH);
//  delay(2000);
//      digitalWrite(in1Pin, LOW);  
//      digitalWrite(in2Pin,HIGH); 
//      analogWrite(pwm1Pin,255);
//      analogWrite(pwm2Pin,255);
//
//      digitalWrite(in3Pin, HIGH);  
//      digitalWrite(in4Pin,LOW); 
//      analogWrite(pwm3Pin,255);
//      analogWrite(pwm4Pin,255);
//      
//  delay(2000);

  //テスト用動作 -----------------------------ココまで

delay(100);

}



