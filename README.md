
nRF51822-Arduino
================

This branch is to provide BLE concurrent Central and Peripheral using Nordic SoftDevice S130.

This is a work in progress which add support for Arduino IDE to allow compiling nRF51822 firmware.

This add-on also provides BLE API for the nRF51822 SoC to act as BLE Central/Peripheral role designed for SoftDevice S130.


Requirement
===========

1. nRF51822 deveopment board, here we will use RBL nRF51822 as an example.
2. Arduino IDE version 1.6.5 (Do not use newer versions, they may not work).
3. PC with one of the following OS:
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


Install USB CDC Driver
======================

Black Magic Probe drivers are required by Windows.

To Do.


Flash with S130 V9 Softdevice
=========================

To Do.


How It Works
============

To Do.


How to Play
===========

1. Select board and serial port

  Select the Generic nRF51822 board in the menu of Arduino IDE and serial port.

    Menu > Tools > Board > Generic nRF51822
    
  Select the RAM size

    Menu > Tools > Board > Generic nRF51822 > RAM Size
  
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

    As Arduino does not have flow control in serial port implementation, the Serial port (Pin 0 and 1) is limited to 9600bps since the BLE stack require flow control in order to support higher speed. If you are not going to use BLE, you can use higher speed. 



Software core originally by RedBearLabs (see license below)
Modifications by Roger Clark (me) 
Further modifcations using some files from Sandeep Mistry
GDB upload to Black Magic Probe by Rick Kimball
Black Magic Probe firmware - porting to STM32 by Rick Kimball, with additions by Roger Clark (me)


License
=======

Copyright (c) 2013-2015 RedBearLab

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

