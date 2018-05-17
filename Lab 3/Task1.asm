;Черкашин В.А. Лаба 3 задание 1 Вариант 11
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
ConsoleTitle db "Лаба 3",0	
StartText db "Лабараторная работа №3 Черкашин В.А. АКТСИу 17-2 Вариант 11",0
Task db "В двухмерном массиве отсортировать элементы каждого стобца по возрастанию",0dh,0ah,
"Найти значение минимального и максимального элемента массива и их индексы до и после сортировки",0
NewLine db 0dh,0ah
TextN db "Введите N",0
TextM db "Введите M", 0	
NumberBuf db 5 dup (?)	
TextBuf db 30 dup (?)	
format db "%d",0
TitleMB db "Лаб 3",0
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
invoke CharToOem, ADDR TextM, ADDR TextM
;=========Запись и чтение с консоли =========================
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
;==== Выделение памяти в куче ===============
MOV AX, N
MUL M
call GetProcessHeap ; получить дескриптор кучи
mov Heap,eax
invoke HeapAlloc, Heap, HEAP_ZERO_MEMORY, AX ;Выделить память в куче
MOV HeapAl, EAX 
;====Заполнение памяти в куче==============




	            								
invoke ExitProcess, 0 					
end start				
