;Черкашин В. АКТСИу 17-2 Лабараторная работа №5 задание 3
.486 
.model flat, STDCALL 
option casemap:none 
.stack 128 
EXTERN _prADD@0 : PROC 
EXTERN _prMUL@0 : PROC
EXTERN _prDIV@0 : PROC 
EXTERN _prSUB@0 : PROC 
ExitProcess PROTO ,:DWORD
MessageBoxA PROTO ,:DWORD, :DWORD, :DWORD, :DWORD 
include \masm32\include\windows.inc 
include \masm32\include\user32.inc 
include \masm32\include\kernel32.inc 
includelib \masm32\lib\user32.lib 
includelib \masm32\lib\kernel32.lib 
PUBLIC _A,_B,_D,_Y,_X,_XmX, _AmXmX, _AmB, _AmBmD, _YpD,_Z,_RESULT
.data ;сегмент данных
; Формула f(x)=a*x^2 - a*b*d/y+d  
_RESULT SWORD ?
_A SWORD -8
_B SWORD 6
_D SWORD 8 
_Y SWORD 12
_X SWORD 4
_XmX SWORD ?
_AmXmX SWORD ?
_AmB SWORD ?
_AmBmD SWORD ?
_YpD SWORD ?
_Z SWORD ?
MsgBoxCaption db "Лаба 5 Черкашин",0 
MsgBoxText db 30 dup (?)
format db "Результат работы программы %d",0
.code 
_start: 
PUSH _X 
PUSH _X
CALL _prMUL@0
MOV _XmX, AX
PUSH _XmX
PUSH _A
CALL _prMUL@0
MOV _AmXmX, AX
PUSH _A
PUSH _B
CALL _prMUL@0
MOV _AmB, AX
PUSH _AmB
PUSH _D
CALL _prMUL@0
MOV _AmBmD, AX
PUSH _Y 
PUSH _D
CALL _prADD@0
MOV _YpD, AX
PUSH _YpD
PUSH _AmBmD
CALL _prDIV@0
MOV _Z, AX
PUSH _Z
PUSH _AmXmX
CALL _prSUB@0
MOV _RESULT, AX
invoke wsprintf, addr MsgBoxText, addr format, _RESULT
INVOKE MessageBoxA, NULL, ADDR MsgBoxText, ADDR MsgBoxCaption, MB_OK 
INVOKE ExitProcess,0
end _start 