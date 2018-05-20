;�������� ������ 17-2 ���� 3 
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
N dw ?
M dw ?
Matrix db 128 dup (?)
MAX dw ?
MIN dw ?
iterator dw ?
outHandle dd ?
inHandle dd ?
namberW dd ?
namberR dd ?
ConsoleTitle db "���� 3",0	
StartText db "������������ ������ �3 �������� �.�. ������ 17-2 ������� 11",0
Task db "� ���������� ������� ������������� �������� ������� ������ �� �����������",0dh,0ah, 
"����� �������� ����������� � ������������ �������� � �� ������� �� � ����� ����������",0
MatrixText db "��������� �������",0
NewLine db 0dh,0ah
TextN db "������� N",0
TextM db "������� M", 0	
NumberBuf db 5 dup (?)	
TextBuf db 60 dup (?)	
TitleMB db "��� 3",0
formatMatrix db "%d ",0
MaxFormat db "������������ �������� �������� � ������� = %d",0
MinFormat db "����������� �������� �������� � ������� = %d",0
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
invoke CharToOem, ADDR TextN, ADDR TextN
invoke CharToOem, ADDR TextM, ADDR TextM
;=========������ � ������ � ������� =========================
invoke WriteConsoleA, outHandle, ADDR StartText, SIZEOF StartText, ADDR namberW, NULL 
invoke WriteConsoleA, outHandle, ADDR NewLine, SIZEOF NewLine, ADDR namberW, NULL
invoke WriteConsoleA, outHandle, ADDR Task, SIZEOF Task, ADDR namberW, NULL
invoke WriteConsoleA, outHandle, ADDR NewLine, SIZEOF NewLine, ADDR namberW, NULL
invoke WriteConsoleA, outHandle, ADDR TextN, SIZEOF TextN, ADDR namberW, NULL
invoke ReadConsole, inHandle,	ADDR NumberBuf, SIZEOF NumberBuf, ADDR namberR, NULL
invoke crt_atoi, addr NumberBuf								
MOV N, AX 
invoke WriteConsoleA, outHandle, ADDR TextM, SIZEOF TextM, ADDR namberW, NULL
invoke ReadConsole, inHandle,	ADDR NumberBuf, SIZEOF NumberBuf, ADDR namberR, NULL
invoke crt_atoi, addr NumberBuf								
MOV M, AX 
;=====���� ����� � ���������� ==========
MOV AX, N
MUL M
MOV iterator , AX
mov esi,offset Matrix
@Input:
MOV AX, iterator
CMP AX, 0
JE @InputEnd
invoke ReadConsole, inHandle,	ADDR NumberBuf, SIZEOF NumberBuf, ADDR namberR, NULL
invoke crt_atoi, addr NumberBuf
MOV [ESI], AX		
ADD ESI, 2
MOV AX, iterator
SUB AX, 1
MOV iterator, AX			
JMP @Input
@InputEnd:
;========����� ������� �� �����=====================
invoke CharToOem, ADDR MatrixText, ADDR MatrixText
invoke WriteConsoleA, outHandle, ADDR MatrixText, SIZEOF MatrixText, ADDR namberW, NULL
invoke WriteConsoleA, outHandle, ADDR NewLine, SIZEOF NewLine, ADDR namberW, NULL
LEA ESI, Matrix
MOV AX, N
MUL M
MOV iterator , AX
Output:
MOV AX, iterator
CMP AX, 0
JE OutputEnd
MOV BX, word ptr [ESI]
invoke wsprintf, addr NumberBuf,addr formatMatrix, BX
invoke CharToOem, ADDR NumberBuf, ADDR NumberBuf
invoke WriteConsoleA, outHandle, ADDR NumberBuf, SIZEOF NumberBuf, ADDR namberW, NULL
ADD ESI, 2
MOV AX, iterator
SUB AX, 1
MOV iterator, AX
MOV AX, iterator
div byte ptr N
CMP AH, 0
JE newline
JMP Output
newline:
invoke WriteConsoleA, outHandle, ADDR NewLine, SIZEOF NewLine, ADDR namberW, NULL
JMP Output
OutputEnd:
;=============����� ������������� ��������  � ��� �����==============================
LEA ESI, Matrix
MOV AX, N
MUL M
MOV iterator , AX
MOV AX, [ESI]
MOV MAX,AX
ADD ESI,2
Mmax:
MOV AX, iterator
CMP AX, 1
JE MaxEND
MOV AX, [ESI]
CMP AX, MAX
JA MaxProm
MOV AX, iterator
SUB AX, 1
MOV iterator, AX
ADD ESI,2
JMP Mmax
MaxProm:
MOV MAX, AX
MOV AX, iterator
SUB AX, 1
MOV iterator, AX
ADD ESI,2
JMP Mmax
MaxEND:
invoke wsprintf, addr TextBuf,addr MaxFormat, MAX
invoke CharToOem, ADDR TextBuf, ADDR TextBuf
invoke WriteConsoleA, outHandle, ADDR TextBuf, SIZEOF TextBuf, ADDR namberW, NULL
invoke WriteConsoleA, outHandle, ADDR NewLine, SIZEOF NewLine, ADDR namberW, NULL
;========����� ������������ �������� � ��� �����=======================
LEA ESI, Matrix
MOV AX, N
MUL M
MOV iterator , AX
MOV AX, [ESI]
MOV MIN,AX
ADD ESI,2
Mmin:
MOV AX, iterator
CMP AX, 1
JE MinEND
MOV AX, [ESI]
CMP AX, MIN
JL MinProm
MOV AX, iterator
SUB AX, 1
MOV iterator, AX
ADD ESI,2
JMP Mmin
MinProm:
MOV MIN, AX
MOV AX, iterator
SUB AX, 1
MOV iterator, AX
ADD ESI,2
JMP Mmin
MinEND:
invoke wsprintf, addr TextBuf,addr MinFormat, MIN
invoke CharToOem, ADDR TextBuf, ADDR TextBuf
invoke WriteConsoleA, outHandle, ADDR TextBuf, SIZEOF TextBuf, ADDR namberW, NULL
invoke WriteConsoleA, outHandle, ADDR NewLine, SIZEOF NewLine, ADDR namberW, NULL
;==========���������� ��������� � ������� =====================================





invoke ReadConsole, inHandle,	ADDR NumberBuf, SIZEOF NumberBuf, ADDR namberR, NULL









	            								
invoke ExitProcess, 0 					
end start				