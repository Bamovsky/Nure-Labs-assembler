;Черкашин В.А. Лаба 2 задание 3 Вариант 11
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
X dw ? 
A dw ?
B dw ?
D dw ?
Y dw ?
XmX SWORD ?
AmXmX SWORD ?
AmB SWORD ?
AmBmD SWORD ?
YpD SWORD ?
Z SWORD ?
F SWORD ?
addrXmX dd ?
addrAmXmX dd ?
addrAmB dd ?
addrAmBmD dd ?
addrYpD dd ?
addrZ dd ?
outHandle dd ?
inHandle dd ?
ConsoleTitle db "Лаба 2", 0
TitleMB db "Промежуточные результаты",0
TextBuf db 50 dup (?)
format db "Промежуточные результаты",0dh,0ah,"XmX=%d",0dh,0ah, "AmXmX=%d",0dh,0ah, "AmBmD=%d",0dh,0ah, "YpD=%d",0dh,0ah,"Z=%d",0
format1 db "Адресса промежуточных результатов",0dh,0ah,"addrXmX=%d",0dh,0ah, "addrAmXmX=%d",0dh,0ah, "addrAmBmD=%d",0dh,0ah, "addrYpD=%d",0dh,0ah,"addrZ=%d",0
format2 db "Размер промежуточных результатов в байтах",0dh,0ah,"sizeXmX=%d",0dh,0ah, "sizeAmXmX=%d",0dh,0ah, "sizeAmBmD=%d",0dh,0ah, "sizeYpD=%d",0dh,0ah,"sizeZ=%d",0
result db "Конечный результат %d", 0
namberW dd ?
namberR dd ?
buf db "Введите X",0
buf1 db "Введите A",0
buf2 db "Введите B",0
buf3 db "Введите D",0
buf4 db "Введите Y",0
StartText db "Выполнил студент группы АКТСИу 17-2 Черкашин В.А Вариант №11 Используя стек",0dh,0ah,0
Task db "Формула f(x)=a*x^2 - a*b*d/y+d, где X=4, A=-8, B=6, D=8, Y=12",0dh,0ah,0
NumberBuf db 16 dup (?)
;==========================================					
.code
start:
;==Запрос Консоли, Установка Title, Получения handle
invoke AllocConsole	 																												   					         
invoke GetStdHandle, STD_OUTPUT_HANDLE 							
MOV outHandle, EAX
invoke GetStdHandle, 						
STD_INPUT_HANDLE 							    
MOV inHandle, EAX						            
;===Перекодируем строк =================
invoke CharToOem, 						      
ADDR ConsoleTitle, 								      
ADDR ConsoleTitle 

invoke SetConsoleTitle, ADDR ConsoleTitle

invoke CharToOem, 						      
ADDR StartText, 								      
ADDR StartText 
invoke CharToOem, 						      
ADDR Task, 								      
ADDR Task 
invoke CharToOem, 						      
ADDR buf, 								      
ADDR buf 
invoke CharToOem, 						      
ADDR buf1, 								      
ADDR buf1 
invoke CharToOem, 						      
ADDR buf2, 								      
ADDR buf2 
invoke CharToOem, 						      
ADDR buf3, 								      
ADDR buf3 
invoke CharToOem, 						      
ADDR buf4, 								      
ADDR buf4 
;===Заносим значения=====================

invoke WriteConsoleA, 							
outHandle, 									
ADDR StartText, 									
SIZEOF StartText, 								
ADDR namberW, 								
NULL 

invoke WriteConsoleA, 							
outHandle, 									
ADDR Task, 									
SIZEOF Task, 								
ADDR namberW, 								
NULL 


invoke WriteConsoleA, 							
outHandle, 									
ADDR buf, 									
SIZEOF buf, 								
ADDR namberW, 								
NULL 

invoke ReadConsole, 							
inHandle,									
ADDR NumberBuf,								
SIZEOF NumberBuf,							
ADDR namberR, 								
NULL 	

invoke crt_atoi, 							     
addr NumberBuf								
MOV X, AX 

invoke WriteConsoleA, 							
outHandle, 									
ADDR buf1, 									
SIZEOF buf1, 								
ADDR namberW, 								
NULL 

invoke ReadConsole, 							
inHandle,									
ADDR NumberBuf,								
SIZEOF NumberBuf,							
ADDR namberR, 								
NULL

invoke crt_atoi, 							     
addr NumberBuf								
MOV A, AX 

invoke WriteConsoleA, 							
outHandle, 									
ADDR buf2, 									
SIZEOF buf2, 								
ADDR namberW, 								
NULL 

invoke ReadConsole, 							
inHandle,									
ADDR NumberBuf,								
SIZEOF NumberBuf,							
ADDR namberR, 								
NULL 

invoke crt_atoi, 							     
addr NumberBuf 								
MOV B, AX 

invoke WriteConsoleA, 							
outHandle, 									
ADDR buf3, 									
SIZEOF buf3, 								
ADDR namberW, 								
NULL 

invoke ReadConsole, 							
inHandle,									
ADDR NumberBuf,								
SIZEOF NumberBuf,							
ADDR namberR, 								
NULL

invoke crt_atoi, 							     
addr NumberBuf								
MOV D, AX 

invoke WriteConsoleA, 							
outHandle, 									
ADDR buf4, 									
SIZEOF buf4, 								
ADDR namberW, 								
NULL 

invoke ReadConsole, 							
inHandle,									
ADDR NumberBuf,								
SIZEOF NumberBuf,							
ADDR namberR, 								
NULL  

invoke crt_atoi, 							     
addr NumberBuf								
MOV Y, AX  	
;=============================================
PUSH X
PUSH X
POP AX
POP BX
MUL BX
MOV XmX , AX 
;============================================
PUSH XmX
PUSH A
POP AX
POP BX
MUL BX
MOV AmXmX, AX										
;============================================
PUSH A
PUSH B
POP AX
POP BX
MUL BX
MOV AmB, AX
;============================================
PUSH D
PUSH AmB
POP AX
POP BX
MUL BX
MOV AmBmD, AX
;============================================
PUSH D
PUSH Y
POP AX
POP BX
ADD AX, BX
MOV YpD, AX
;============================================
PUSH AmBmD
PUSH YpD
POP BX
POP AX
IDIV BL ;AL=0Ah (частное) AH=06h (остаток)
CBW ; Конвертнули
MOV Z, AX
;============================================
PUSH AmXmX
PUSH Z
POP BX
POP AX
SUB AX, BX
MOV F, AX
;============================================
invoke wsprintf, addr TextBuf,addr result, F

invoke CharToOem, 						      
ADDR TextBuf, 								      
ADDR TextBuf

invoke WriteConsoleA, 							
outHandle, 									
ADDR TextBuf, 									
SIZEOF TextBuf, 								
ADDR namberW, 								
NULL

invoke wsprintf, addr TextBuf,addr format, XmX, AmXmX, AmBmD, YpD, Z

invoke MessageBox, 0, 							
ADDR TextBuf, 								
ADDR TitleMB, 							
MB_OK


lea eax,XmX 
mov addrXmX,eax
lea eax,AmXmX 
mov addrAmXmX ,eax
lea eax,AmB
mov addrAmB ,eax
lea eax,AmBmD
mov addrAmBmD ,eax
lea eax,YpD
mov addrYpD ,eax
lea eax,Z
mov addrZ ,eax

invoke wsprintf, addr TextBuf,addr format1, addrXmX, addrAmXmX, addrAmBmD, addrYpD, addrZ

invoke MessageBox, 0, 							
ADDR TextBuf, 								
ADDR TitleMB, 							
MB_OK

invoke wsprintf, addr TextBuf,addr format2, sizeof XmX, sizeof AmXmX, sizeof AmBmD, sizeof YpD, sizeof Z

invoke MessageBox, 0, 							
ADDR TextBuf, 								
ADDR TitleMB, 							
MB_OK 																
invoke ExitProcess, 0 					
end start				
