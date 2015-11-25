#!/usr/bin/python#
# -*- coding: utf-8 -*-

#====================================================================
#=                                                                  =
#=                  	sensor logging to USB	           	    =
#=                                                                  =
#====================================================================

import os, glob, time, datetime
#import smbus
import serial

logging_folder = glob.glob('/media/usb0/log*')[0]
dt = datetime.datetime.now()
file_name = "{:%Y%m%d_%H%M}.csv".format(dt)
logging_file = logging_folder + '/' + file_name

os.system('modprobe w1-gpio')
os.system('modprobe w1-therm')

#i2c = smbus.SMBus(1)
#address = 0x48

con = serial.Serial('/dev/ttyACM0', 9600)

print("Logging to: " + logging_file)

# ---------------   0 prot No.   --------------- #
i = 0
# ---------------------------------------------- #

while True:
# --------   1 read_templature_value    -------- #
#    block = i2c.read_i2c_block_data(address, 0x00, 12)
#    temp = (block[0] << 8 | block[1]) >> 3
#    temp /= 16
#    if(temp >= 256):
#        temp -= 512
# ---------------------------------------------- #

# ------------ 2 read_arduino_value  ----------- #
    ino = con.readline()
# ---------------------------------------------- #

# ------------ data logging to file  ----------- #
    dt = datetime.datetime.now()
    f = open(logging_file,'a')
    f.write('%s.%s.%s,' % (dt.hour, dt.minute, dt.second))
    f.write('%s,' %(i))
    f.write(ino)

#    f.write(',')
#    f.write('%6.2f'%(temp))

    i += 1
    if(dt.minute==0 and dt.second==0):
	f.write('\n')
    f.close()
# ---------------------------------------------- #

