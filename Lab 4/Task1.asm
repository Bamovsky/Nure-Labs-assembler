;Черкашин АКТСИу 17-2 Лаба 4 задание №1
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
MassifA dw 255 dup (?)
MassifB dw 255 dup (?)
outHandle dd ?
inHandle dd ?
namberW dd ?
namberR dd ?
ConsoleTitle db "Лаба 4",0	
StartText db "Лабараторная работа №4 Черкашин В.А. АКТСИу 17-2 Вариант 11",0
Task db "Задан массив А, сформировать массив B из элементов А, у элементов которого",0dh,0ah, 
"биты 10, 13 и 15 равны 0. Вывести массив B, а так-же кол-во элементов.",0
NumberBuf db 7 dup (?)	
TextBuf db 60 dup (?)	
NewLine db 0dh,0ah
TextN db "Введите кол-во элементов в массиве",0
Output db "%d ",0
Output16 db "%0X ",0
Modificator dw 1010110111111111b
MasText db "Введенный массив : ",0
MasText2 db "Отформированный массив : ",0
.code
start:
;======Получение консоли, установка Titile, получение Handle====
invoke AllocConsole	 																												   					         
invoke GetStdHandle, STD_OUTPUT_HANDLE 							
MOV outHandle, EAX
invoke GetStdHandle, STD_INPUT_HANDLE 							    
MOV inHandle, EAX	
invoke CharToOem, ADDR ConsoleTitle, ADDR ConsoleTitle
invoke SetConsoleTitle, ADDR ConsoleTitle
;=========Перекодирование==================================
invoke CharToOem, ADDR StartText, ADDR StartText
invoke CharToOem, ADDR Task, ADDR Task
invoke CharToOem, ADDR TextN, ADDR TextN
invoke CharToOem, ADDR MasText, ADDR MasText
invoke CharToOem, ADDR MasText2, ADDR MasText2
;=========Запись и чтение с консоли =========================
invoke WriteConsoleA, outHandle, ADDR StartText, SIZEOF StartText, ADDR namberW, NULL 
invoke WriteConsoleA, outHandle, ADDR NewLine, SIZEOF NewLine, ADDR namberW, NULL
invoke WriteConsoleA, outHandle, ADDR Task, SIZEOF Task, ADDR namberW, NULL
invoke WriteConsoleA, outHandle, ADDR NewLine, SIZEOF NewLine, ADDR namberW, NULL
invoke WriteConsoleA, outHandle, ADDR TextN, SIZEOF TextN, ADDR namberW, NULL
invoke ReadConsole, inHandle,	ADDR NumberBuf, SIZEOF NumberBuf, ADDR namberR, NULL
invoke crt_atoi, addr NumberBuf
MOV N, AX
;=====Формирование массива А================================
LEA EDI, MassifA
CLD
MOV BP, 0
@Input:
CMP BP, N
JE @InputEnd
invoke ReadConsole, inHandle,	ADDR NumberBuf, SIZEOF NumberBuf, ADDR namberR, NULL
invoke crt_atoi, addr NumberBuf
STOSW
INC BP
JMP @Input
@InputEnd:
MOV EDI,0
;=====Вывод введенного массива =============================
invoke WriteConsoleA, outHandle, ADDR MasText, SIZEOF MasText, ADDR namberW, NULL
invoke WriteConsoleA, outHandle, ADDR NewLine, SIZEOF NewLine, ADDR namberW, NULL
LEA ESI, MassifA
CLD
MOV BP, 0
@Output:
CMP BP, N
JE @OutputEnd
LODSW
invoke wsprintf, addr NumberBuf,addr Output, AX
invoke CharToOem, ADDR NumberBuf, ADDR NumberBuf
invoke WriteConsoleA, outHandle, ADDR NumberBuf, SIZEOF NumberBuf , ADDR namberW, NULL
INC BP
JMP @Output
@OutputEnd:
MOV ESI, 0
invoke WriteConsoleA, outHandle, ADDR NewLine, SIZEOF NewLine, ADDR namberW, NULL
;======Формирование массива B =============================
LEA ESI, MassifA
LEA EDI, MassifB
CLD
MOV BP, 0
@Form:
CMP BP, N
JE @FormEnd
LODSW
AND AX, Modificator
STOSW
INC BP
JMP @Form
@FormEnd:
MOV ESI,0
MOV EDI,0
;====Вывод массива B =======================================
invoke WriteConsoleA, outHandle, ADDR MasText2, SIZEOF MasText2, ADDR namberW, NULL
invoke WriteConsoleA, outHandle, ADDR NewLine, SIZEOF NewLine, ADDR namberW, NULL
LEA ESI, MassifB
CLD
MOV BP, 0
@Output1:
CMP BP, N
JE @Output1End
LODSW
invoke wsprintf, addr NumberBuf,addr Output, AX
invoke CharToOem, ADDR NumberBuf, ADDR NumberBuf
invoke WriteConsoleA, outHandle, ADDR NumberBuf, SIZEOF NumberBuf , ADDR namberW, NULL
INC BP
JMP @Output1
@Output1End:
MOV ESI, 0
invoke WriteConsoleA, outHandle, ADDR NewLine, SIZEOF NewLine, ADDR namberW, NULL
;=========== Вывод массива B в 16 коде =====================
invoke WriteConsoleA, outHandle, ADDR MasText2, SIZEOF MasText2, ADDR namberW, NULL
invoke WriteConsoleA, outHandle, ADDR NewLine, SIZEOF NewLine, ADDR namberW, NULL
LEA ESI, MassifB
CLD
MOV BP, 0
@Output2:
CMP BP, N
JE @Output2End
LODSW
invoke wsprintf, addr NumberBuf,addr Output16, AX
invoke CharToOem, ADDR NumberBuf, ADDR NumberBuf
invoke WriteConsoleA, outHandle, ADDR NumberBuf, SIZEOF NumberBuf , ADDR namberW, NULL
INC BP
JMP @Output2
@Output2End:
MOV ESI, 0
invoke WriteConsoleA, outHandle, ADDR NewLine, SIZEOF NewLine, ADDR namberW, NULL
;=========== Вывод массива B в бинарном коде ===============
;======Что б консоль не закрылась ==========================
invoke ReadConsole, inHandle,	ADDR NumberBuf, SIZEOF NumberBuf, ADDR namberR, NULL            								
invoke ExitProcess, 0 					
end start				