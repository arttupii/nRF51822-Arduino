rem: @echo off
rem: Note %~dp0 get path of this batch file
rem: Need to change drive if My Documents is on a drive other than C:
set driverLetter=%~dp0
set driverLetter=%driverLetter:~0,2%
%driverLetter%
cd %~dp0
rem: the two line below are needed to fix path issues with incorrect slashes before the bin file name
set tmpBinFilePath=%1
set tmpBinFilePath=%tmpBinFilePath:/=\%

rem: create commander script file with the tmp bin that the Arduino IDE creates

@echo loadbin %tmpBinFilePath% , 0x1c000 > %tmpBinFilePath%.jlink
@echo r >> %tmpBinFilePath%.jlink
@echo q >> %tmpBinFilePath%.jlink

rem: Upload using jlink commander via the Windows shortcut 
rem: Use nRF51822_XXAB as the device type as this is the lowest common denominator and prevents JLink giving errors about RAM size
"J-Link Commander.lnk" -device nRF51822_XXAA  -CommanderScript %tmpBinFilePath%.jlink