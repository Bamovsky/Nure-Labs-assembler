;�������� �.�. ���� 5 ������ 17-2 ������� �1
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
; ������� f(x)=a*x^2 - a*b*d/y+d 
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
ConsoleTitle db "���� 5", 0
TitleMB db "������������� ����������",0
TextBuf db 50 dup (?)
format db "������������� ����������",0dh,0ah,"XmX=%d",0dh,0ah, "AmXmX=%d",0dh,0ah, "AmBmD=%d",0dh,0ah, "YpD=%d",0dh,0ah,"Z=%d",0
format1 db "������� ������������� �����������",0dh,0ah,"addrXmX=%d",0dh,0ah, "addrAmXmX=%d",0dh,0ah, "addrAmBmD=%d",0dh,0ah, "addrYpD=%d",0dh,0ah,"addrZ=%d",0
format2 db "������ ������������� ����������� � ������",0dh,0ah,"sizeXmX=%d",0dh,0ah, "sizeAmXmX=%d",0dh,0ah, "sizeAmBmD=%d",0dh,0ah, "sizeYpD=%d",0dh,0ah,"sizeZ=%d",0
result db "�������� ��������� %d", 0
namberW dd ?
namberR dd ?
buf db "������� X",0
buf1 db "������� A",0
buf2 db "������� B",0
buf3 db "������� D",0
buf4 db "������� Y",0
StartText db "�������� ������� ������ ������ 17-2 �������� �.� ������� �11",0dh,0ah,0
Task db "������� f(x)=a*x^2 - a*b*d/y+d, ��� X=4, A=-8, B=6, D=8, Y=12",0dh,0ah,0
NumberBuf db 16 dup (?)
prADD PROTO :SWORD,:SWORD
prSUB PROTO :SWORD,:SWORD
prMUL PROTO :SWORD,:SWORD
prDIV PROTO :SWORD,:SWORD
;==========================================					
.code
start:
;==������ �������, ��������� Title, ��������� handle
invoke AllocConsole	 																												   					         
invoke GetStdHandle, STD_OUTPUT_HANDLE 							
MOV outHandle, EAX
invoke GetStdHandle, 						
STD_INPUT_HANDLE 							    
MOV inHandle, EAX						            
;===������������ ����� =================
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
;===������� ��������=====================

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
;=========================================
INVOKE prMUL, X,X 
MOV XmX , AX 
;============================================
INVOKE prMUL, A,XmX 
MOV AmXmX, AX										
;============================================
INVOKE prMUL, A,B 
MOV AmB, AX
;============================================
INVOKE prMUL, D,AmB 
MOV AmBmD, AX
;============================================
INVOKE prADD, Y,D 
MOV YpD, AX
;============================================
INVOKE prDIV, AmBmD, YpD
MOV Z, AX
;============================================
INVOKE prSUB, AmXmX,Z
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
;------------�������� ��������� prADD-------------------------
prADD PROC prm1:SWORD,prm2:SWORD ;��������� ��������� prADD
MOV AX,WORD PTR [EBP+8] ;1-� �������� A - �� ������ [ESP+8]
ADD AX,WORD PTR [EBP+12] ;2-� �������� B - �� ������ [ESP+12]
RET ;����� ������ �� prADD, ������� 4 �����
prADD ENDP ;ENDP - ��������� ��������� prADD
;------------�������� ��������� prSUB-------------------------
prSUB PROC prm3:SWORD,prm4:SWORD ;��������� ��������� prADD
MOV AX,WORD PTR [EBP+8] ;1-� �������� A - �� ������ [ESP+8]
SUB AX,WORD PTR [EBP+12] ;2-� �������� B - �� ������ [ESP+12]
RET ;����� ������ �� prADD, ������� 4 �����
prSUB ENDP ;ENDP - ��������� ��������� prADD
;------------�������� ��������� prMUL-------------------------
prMUL PROC prm5:SWORD,prm6:SWORD ;��������� ��������� prADD
MOV AX,WORD PTR [EBP+8] ;1-� �������� A - �� ������ [ESP+8]
MUL WORD PTR [EBP+12] ;2-� �������� B - �� ������ [ESP+12]
RET ;����� ������ �� prADD, ������� 4 �����
prMUL ENDP ;ENDP - ��������� ��������� prADD
;------------�������� ��������� prDIV-------------------------
prDIV PROC prm7:SWORD,prm8:SWORD ;��������� ��������� prADD
MOV AX,WORD PTR [EBP+8] ;1-� �������� A - �� ������ [ESP+8]
MOV BL, byte ptr [EBP+12]
IDIV BL
CBW
RET ;����� ������ �� prADD, ������� 4 �����
prDIV ENDP ;ENDP - ��������� ��������� prADD
;==========================================================				
end start				
