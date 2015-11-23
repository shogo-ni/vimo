/*
====================================================================
 =                                                                  =
 =                  Arduino analog reading sensors                  =
 =                                                                  =
 ====================================================================
 */

int fsrPin1 = 0; // the FSR and 10K pulldown are connected to a0
int fsrPin2 = 1;
int fsrPin3 = 2;
int fsrPin4 = 3;
int fsrPin5 = 4;
int fsrPin6 = 5;

int fsrReading1; // the analog reading from the FSR resistor divider
int fsrReading2;
int fsrReading3;
int fsrReading4;
int fsrReading5;
int fsrReading6;

byte val = 0;

void setup()
{
  // シリアルモニターの初期化をする
  Serial.begin(9600);
  while (!Serial) {
  }
}
void loop()
{
  // raspberry piとシリアル通信
  if (Serial.available()) Serial.write(Serial.read());
  
//  long x , y , z;
//
//  // 各データを100回読込んで平均化する
//  x = y = z = 0 ;
//  for (int i=0 ; i < 100 ; i++) {
//    x = x + analogRead(3) ;  // Ｘ軸を読込む
//    y = y + analogRead(4) ;  // Ｙ軸を読込む
//    z = z + analogRead(5) ;  // Ｚ軸を読込む
//  }
//
//  x = x / 100 ;
//  y = y / 100 ;
//  z = z / 100 ;

  //  圧力値取得
  fsrReading1 = analogRead(fsrPin1);
  fsrReading2 = analogRead(fsrPin2);
  fsrReading3 = analogRead(fsrPin3);
  fsrReading4 = analogRead(fsrPin4);
  fsrReading5 = analogRead(fsrPin5);
  fsrReading6 = analogRead(fsrPin6);

  // 読み込んだ各軸をそのまま表示する
  Serial.print(fsrReading1);    // 圧力1
  Serial.print(",");
  Serial.print(fsrReading2);    // 圧力2
  Serial.print(",");
  Serial.print(fsrReading3) ;    // 圧力3
  Serial.print(",") ;
  Serial.print(fsrReading4) ;    // 圧力4
  Serial.print(",") ;
  Serial.print(fsrReading5) ;    // 圧力5
  Serial.print(",") ;
  Serial.println(fsrReading6) ;  // 圧力6
  delay(10000);
  
}

