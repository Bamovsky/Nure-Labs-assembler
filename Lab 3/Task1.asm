;�������� �.�. ���� 3 ������� 1 ������� 11
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
iterator dw ?
Heap dd ?
HeapAl dd ?
outHandle dd ?
inHandle dd ?
namberW dd ?
namberR dd ?
ConsoleTitle db "���� 3",0	
StartText db "������������ ������ �3 �������� �.�. ������ 17-2 ������� 11",0
Task db "� ���������� ������� ������������� �������� ������� ������ �� �����������",0dh,0ah,
"����� �������� ������������ � ������������� �������� ������� � �� ������� �� � ����� ����������",0
NewLine db 0dh,0ah
TextN db "������� N",0
TextM db "������� M", 0	
NumberBuf db 5 dup (?)	
TextBuf db 30 dup (?)	
format db "%d",0
TitleMB db "��� 3",0
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
;==== ��������� ������ � ���� ===============
MOV AX, N
MUL M
call GetProcessHeap ; �������� ���������� ����
mov Heap,eax
invoke HeapAlloc, Heap, HEAP_ZERO_MEMORY, AX ;�������� ������ � ����
MOV HeapAl, EAX 
;====���������� ������ � ����==============




	            								
invoke ExitProcess, 0 					
end start				
