;Черкашин В.А. Лаба 2 задание 1 Вариант 11
.486					
.model flat, STDCALL	   
option casemap:none
include \masm32\include\windows.inc
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc
include   \masm32\include\msvcrt.inc			      
includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\msvcrt.lib 		
;=========================================	
.data
; Формула f(x)=a*x^2 - a*b*d/y+d 
X dw 4 
A dw -8
B dw 6
D dw 8
Y dw 12
XmX dw ?
AmXmX dw ?
AmB dw ?
AmBmD dw ?
YpD dw ?
Z dw ?
F dw ?
outHandle
Title db "Лаба 2!!!!",0

;==========================================					
.code
start:
MOV AX, X
MUL X
MOV XmX , AX
;============================================
MOV AX, A
MUL XmX
MOV AmXmX, AX
;============================================
MOV AX, A
MUL B
MOV AmB, AX
;============================================
MOV AX, D
MUL AmB
MOV AmBmD, AX
;============================================
MOV AX, Y
ADD AX, D
MOV YpD, AX
;============================================
MOV AX, AmBmD
DIV YpD
MOV  Z, AX
;============================================
MOV AX, AmXmX
SUB AX, Z
MOV F, AX
;==Запрос Консоли, Установка Title, Получения handle==
invoke AllocConsole	
invoke CharToOem, ADDR Title, ADDR Title
invoke SetConsoleTitle, ADDR titleStr 																					   					         
invoke GetStdHandle, STD_OUTPUT_HANDLE 							
MOV outHandle, EAX													



	
ret					
end start				
