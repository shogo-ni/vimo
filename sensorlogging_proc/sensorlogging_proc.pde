import processing.serial.*;
Serial myPort;    // => /dev/tty.usbmodem1421
String datastr;
PrintWriter output;
int count = 1;

void setup()
{
//  println(Serial.list());
  myPort = new Serial(this, "/dev/tty.usbmodem1421", 9600);
  myPort.clear();
  output  = createWriter("test.csv");
}

void draw()
{
  if (count > 100000) {
    output.flush();    // Writes the remaining data to the file
    output.close();    // Finishes the file
    exit();            // Stops the program
  }
  count++;

  if ( myPort.available() > 0) {
    delay(10000);
    datastr = myPort.readString();
    println(datastr);
    int[] tempdata = int(split(datastr, ','));
    //  println(datastr);
    String datetimestr = nf(day(),2)+","+nf(hour(),2)+","+nf(minute(),2)+","+nf(second(),2);
    String tempstr = String.format("%d,%d,%d,%d,%d,%d", tempdata[0],tempdata[1],tempdata[2],tempdata[3],tempdata[4],tempdata[5]);
    output.println(datetimestr + "," + tempstr);
    println(datetimestr + "," + tempstr);
  }

}

