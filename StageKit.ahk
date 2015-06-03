#NoEnv
#Persistent
#SingleInstance force

#include xinput.ahk
XInput_Init()

SetWorkingDir %A_ScriptDir% ;Ensures a consistent starting directory.

if A_OSVersion in WIN_NT4,WIN_95,WIN_98,WIN_ME  ; if not xp or 2000 quit
{
    MsgBox This script requires Windows 2000/XP or later.
    ExitApp
}

state:=Bin2Num(0000000000000000)
onexit cleanup

gui, add, text,, Please select the device number:
gui,add,dropdownlist, vdevice, 1||2|3|4
gui,add,button, gstart, Start

gui,show
return

guiclose:
gosub cleanup
return

start:

gui, submit

device--

gui,destroy

gui, add, text,, StageKit

gui, add, button, gStrobeOn, Strobe on

gui, add, button, gStrobeOff, Strobe Off

gui, add, button, gFogOn, Fog On

gui, add, button, gFogOff, Fog Off

gui,show

return

cleanup:

exitapp

;Strobe Control.
Slow:

XInput_SetState(device, state, 768)
return

Medium:

XInput_SetState(device, state, 1024)
return

Fast:

XInput_SetState(device, state, 1280)
return

Fastest:

XInput_SetState(device, state, 1536)
return

StrobeOn:

XInput_SetState(device, state, 1280)
return

StrobeOff:

XInput_SetState(device, state, 1792)
return

;Fog control.
FogOn:

XInput_SetState(device, state, 256)
return

FogOff:

XInput_SetState(device, state, 512)
return

;Convert binary to decimal.
Bin2Num(bits, neg="") 
{  
   n = 0              ; If "neg" is not 0 or empty, 11..1 assumed on the left
   Loop Parse, bits
      n += n + A_LoopField
   Return n - !(neg<1)*(1<<StrLen(bits))
}