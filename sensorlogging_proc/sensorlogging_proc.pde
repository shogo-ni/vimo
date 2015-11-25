import processing.serial.*;
Serial myPort;
String datastr;
PrintWriter output;
int count = 1;

void setup()
{
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[0],9600);
  myPort.clear();
  
  output  = createWriter("test.csv");
}

void draw()
{
  if (count > 100) {
    output.flush();
    output.close();
    exit();
  }
  count++;
  
  if ( myPort.available() > 0) {
    delay(1000);
    datastr = myPort.readString();
    int[] tempdata = int(split(datastr, ','));
    //  println(datastr);
    String datetimestr = nf(day(),2)+","+nf(hour(),2)+","+nf(minute(),2)+","+nf(second(),2);
    output.println(datetimestr + "," + tempstr );
  }
}

