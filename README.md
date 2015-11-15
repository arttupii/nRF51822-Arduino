
nRF51822-Arduino
================

This branch is to provide BLE concurrent Central and Peripheral using Nordic SoftDevice S130.

This add-on also provides BLE API for the nRF51822 SoC to act as BLE Central/Peripheral role designed for SoftDevice S130.


Requirement
===========

1. A generic nRF51822 deveopment board (search "nRF51822 module wireless" on eBay etc). Note you only need the RF module not the full motherboard, if you are happy to wire the RF module to the "programmer" yourself
2. A STM32F103C8 board ( to convert into a Black Magic Probe SWD programmer). (Search ebay for "stm32f103c8t board". The best boards are the long thin ones, not the rectangular ones)
3. A USB to Serial converter (only used to program the Black Magic Probe onto the STM32 board) (Search eBay for "USB Serial module". Make sure you can see that it has a 3.3V output not just 5V)
3. Arduino IDE version 1.6.5 (Do not use newer versions, they may not work).
4. PC with one of the following OS:
    - Mac OSX 10.9 (Mavericks) / 10.10.4 (Yosemite) (current tested version).
    - Windows 7 and 8.x (current tested version).
    - Linux (current tested on Ubuntu 14.04).



Installation of the core
========================

Clone this repo or download the zip (make sure you download the S130 branch)

Copy the RBL folder from  /arduino-1.6.x/hardware to the hardware folder inside your Arduino sketches folder
If your sketches folder e.g. on Windows its My Documents/Arduino , does not contain a folder called   hardware ,
make a new folder in your Arduino folder , called hardware, and copy the RBL folder into that folder.

Additionally, in the Boards Manager, you need to install either the Due or Zero (SAM or SAMD) boards. 
This is required for the ARM compiler.


Turning the STM32F103 board into a Black Magic Probe programmer
===============================================================

To Do.


Install USB CDC Driver
======================

Black Magic Probe drivers are required by Windows.

They can be downloaded from Blacksphere website by following this link
http://www.blacksphere.co.nz/downloads/bmp_driver_20130819.zip


Flash with S130 Softdevice
=========================


Due to its license, I dont think I can bundle the S130 SoftDevice file in the repo :-(
So you will need to download this from this page on Nordic's website

http://www.nordicsemi.com/eng/Products/Bluetooth-Smart-Bluetooth-low-energy/nRF51822#Downloads

under the section marked Softdevices

CLick on the link to S130-SD

This link may or may not work for you
http://www.nordicsemi.com/eng/Products/Bluetooth-Smart-Bluetooth-low-energy/nRF51822#additional-terms-content-link-resource-download-link46579-16-57692621

This will prompt you to accept something (though it doesnt appear to be agreement), and you should be able to download a zip file (s130_nrf51_1.0.0.zip)

Unzip this file so that you can extract the file named s130_nrf51_1.0.0_softdevice.hex

You now need to flash the softdevice onto your module. Note. You only need to do this once per board, as the softdevice should not get erased when you upload a new sketch.

You you upload will vary depending on your programmer hardware

If you are using the Black Magic Probe, you need to know which device or Windows COM port it is using. In Windows open the device manager and look in the Ports section for the device called Black Magic GDB Server.
This will have a COM number e.g. COM5

For the Black Magic Probe on Windows I've made a batch file to run gdb, however you still need to manually issue the
following commands after GDB is running

```
set confirm off
target extended-remote \\.\<THE COM PORT OF YOU BLACK MAGIC PROBE GDB SERER>
monitor swdp_scan
attach 1
monitor erase_mass
file <THE PATH TO THE S130 SOFTDEVICE HEX FILE>
load
quit
```

The overall result you will see, should look something like this

```
GNU gdb (GNU Tools for ARM Embedded Processors) 7.6.0.20140228-cvs
Copyright (C) 2013 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "--host=i686-w64-mingw32 --target=arm-none-eabi".
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>.
(gdb) set confirm off
(gdb) target extended-remote \\.\COM12
Remote debugging using \\.\COM12
(gdb) monitor swdp_scan
Target voltage: Not Implemented!
Available Targets:
No. Att Driver
 1      Nordic nRF51 0x0084
(gdb) attach 1
Attaching to Remote target
0xfffffffe in ?? ()
(gdb) monitor erase_mass
erase..
(gdb) file s130_nrf51_1.0.0_softdevice.hex
Reading symbols from C:\Users\rogerclark\Documents\Arduino\nRF51822-Arduino\install_softdevice\s130_nrf51_1.0.0_softdevice.hex...(no debugging symbols found)...done
.
(gdb) load
Loading section .sec1, size 0x7c0 lma 0x0
Loading section .sec2, size 0xf000 lma 0x1000
Loading section .sec3, size 0xb4d8 lma 0x10000
Start address 0x0, load size 109720
Transfer rate: 22 KB/sec, 979 bytes/write.
(gdb) quit
Detaching from program: C:\Users\rogerclark\Documents\Arduino\nRF51822-Arduino\install_softdevice\s130_nrf51_1.0.0_softdevice.hex, Remote target
```

To do the same thing using JLink, please consult the JLink commander documentation.


Once the Softdevice has been successfully installed, you can fire up the Arduino IDE and get going


How to 
===========

1. Select board and serial port of the Black Magic GDB Server

  Select the Generic nRF51822 board in the menu of Arduino IDE and serial port.

    Menu > Tools > Board > Generic nRF51822
    
  Select the RAM size

    Menu > Tools > Board > Generic nRF51822 > RAM Size
    

  Select the COM port of the Black Magic GDB Server
  
    Menu > Tools > Board > Generic nRF51822 > Port
    (note this is the port of the GDB server not the same port as you will use to see the debug output)
    
  
2. Blink

  To test the board, we suggest you to load the Blink example to see if it works.

    Menu > Examples > 01.Basics > Blink

3. BLE Examples

  There are some BLE examples you can try.
  
    Menu > Examples > BLE_API

  #### BLE_HRM
   
  This is an Heart Rate Monitor demo, it simulates Heart Rate detection. You can use Nordic nRFToolBox App to play. For BLEController, SimpleChat and SimpleControls, you can use RBL BLE Controller App to play.

  #### BLE_Beacon
    
  This is to implement Apple's iBeacon, you can try it with our BeaconTool available in the AppStore for iOS and PlayStore for Android.

  #### SimpleControls
  
  This sample shows how to define your own protocol and to control the I/O of the board from a Central (e.g. iPhone) using BLE Controller Apps.
  
  #### SimpleChat
  
  This sample allows you to send text message from the board to your central device such as iPhone or Android using our BLE Controller Apps.
  
  #### BLEController

  This example allows you to use our BLE Controller Apps (available for iOS and Android) to control the pin state such as High, Low, PWM, Analog, etc.
  
  #### nRF51822_UART
  
  This example allows you to exchange data with your central device (e.g. iPhone 5) and the data will be redirected to the UART.




Limitations
===========

1. Serial Interface

    As Arduino does not have flow control in serial port implementation, the Serial port is limited to 9600bps since the BLE stack require flow control in order to support higher speed. If you are not going to use BLE, you can use higher speed. 

License
=======

Software core originally by RedBearLabs (see license below)

Modifications by Roger Clark (me) 

Further modifcations using some files from Sandeep Mistry

GDB upload to Black Magic Probe by Rick Kimball

Black Magic Probe firmware - porting to STM32 by Rick Kimball, with additions by Roger Clark (me)


Original Licence
================

Copyright (c) 2013-2015 RedBearLab

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

