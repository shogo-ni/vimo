# this is a very simple sample script for logging data from an Arduino
import serial # http://pyserial.sourceforge.net/
import time, datetime

# set this to your serial port (e.g. COM4 on windows or /tty.usb...)
SERIAL_PORT = "/dev/tty.usbmodem1411"
dt = datetime.datetime.now()


# log data from serial port into a text file
def logSensors():
    
    # open the serial port
    serialConnection = serial.Serial( SERIAL_PORT, timeout=2.0 )
    
    # open the output file (for appending)
    outputFile = open( "{:%Y%m%d_%H%M}.csv".format(dt), "a" )
    
    # loop until user breaks
    while True:
        data = serialConnection.readline().strip()
        if data:
            print data
            outputFile.write( '%s,%s,%s,' % (dt.hour, dt.minute, dt.second) + data + "\n" )
        
    
# if run as top-level script
if __name__ == "__main__":
    try:
        logSensors()
    except KeyboardInterrupt:
        pass