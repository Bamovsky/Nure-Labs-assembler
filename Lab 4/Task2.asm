;�������� ������ 17-2 ���� 4 ������� �2
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
StrLen dd ?
SubStrLen dd ?
String db 255 dup (?)
SubString db 255 dup (?)
ResString db 255 dup (?)
outHandle dd ?
inHandle dd ?
namberW dd ?
namberR dd ?
ConsoleTitle db "���� 4",0	
StartText db "������������ ������ �4 �������� �.�. ������ 17-2 ������� 11",0
Task db "������ ������ � ��������� � 0 ������������. ������� ������� ���������",0dh,0ah, 
"�� ������ ����� �� ��� ��� �� �����������. ������� ���-�� �������� �� � ����� ��������������",0
TextBuf db 255 dup (?)	
NewLine db 0dh,0ah
text1 db "������� ������ : ",0
text2 db "������� ��������� : ",0
.code
start:
;======��������� �������, ��������� Titile, ��������� Handle====
invoke AllocConsole	 																												   					         
invoke GetStdHandle, STD_OUTPUT_HANDLE 							
MOV outHandle, EAX
invoke GetStdHandle, STD_INPUT_HANDLE 							    
MOV inHandle, EAX	
invoke CharToOem, ADDR ConsoleTitle, ADDR ConsoleTitle
invoke SetConsoleTitle, ADDR ConsoleTitle
;=========���������������==================================
invoke CharToOem, ADDR StartText, ADDR StartText
invoke CharToOem, ADDR Task, ADDR Task
invoke CharToOem, ADDR text1, ADDR text1
invoke CharToOem, ADDR text2, ADDR text2
;=========������ � ������� ===============================
invoke WriteConsoleA, outHandle, ADDR StartText, SIZEOF StartText, ADDR namberW, NULL 
invoke WriteConsoleA, outHandle, ADDR NewLine, SIZEOF NewLine, ADDR namberW, NULL
invoke WriteConsoleA, outHandle, ADDR Task, SIZEOF Task, ADDR namberW, NULL
invoke WriteConsoleA, outHandle, ADDR NewLine, SIZEOF NewLine, ADDR namberW, NULL
;=====������ � �������======================================
invoke WriteConsoleA, outHandle, ADDR text1, SIZEOF text1, ADDR namberW, NULL
invoke ReadConsole, inHandle,	ADDR String , SIZEOF String , ADDR namberR, NULL 
MOV EAX,namberR
SUB EAX, 2
MOV StrLen, EAX
invoke WriteConsoleA, outHandle, ADDR text2, SIZEOF text2, ADDR namberW, NULL
invoke ReadConsole, inHandle,	ADDR SubString , SIZEOF SubString , ADDR namberR, NULL 
MOV EAX,namberR
SUB EAX,2
MOV SubStrLen, EAX
;======����� � �������� ��������� �� ������ ================
CLD
LEA EDI,String
MOV ECX,StrLen
INC ECX
DeleteStr:
MOV AL, SubString
REPNE SCASB 
CMP CX, 0
JE DeleteStrEnd
MOV EBP, EDI
DEC EBP
MOV BX, CX
MOV CX, word ptr SubStrLen
LEA ESI, SubString
MOV EDI, EBP
REPE CMPSB
CMP CX, 0
JE Del
MOV CX,BX 
MOV EDI, EBP
INC EDI
JMP DeleteStr
Del:
LEA ESI, String
LEA EDI, ResString
MOV CX,BX
MOV DX, word ptr StrLen
SUB DX, CX
MOV CX, DX
REP MOVSB
MOV ESI, EBP
ADD ESI, SubStrLen
MOV CX,BX
SUB CX, word ptr SubStrLen
REP MOVSB
MOV EDI,EBP
INC EDI
MOV CX,BX
JMP DeleteStr
DeleteStrEnd:
invoke WriteConsoleA, outHandle, ADDR ResString, StrLen, ADDR namberW, NULL
;======��� � ������� �� ��������� ==========================
invoke ReadConsole, inHandle,	ADDR TextBuf , SIZEOF TextBuf , ADDR namberR, NULL            								
invoke ExitProcess, 0 					
end start				