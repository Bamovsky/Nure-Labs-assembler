;Черкашин В.А. АКТСИу17-2 лаб 1 Задание 3
.486 										;используется набор команд i80486
.model flat, stdcall							;используемая модель памяти FLAT
option casemap: none
include \masm32\include\windows.inc
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc
include   \masm32\include\msvcrt.inc			      ;для crt_atoi
includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\msvcrt.lib 					;для crt_atoi
;=======================================================================================
.data 									;сегмент данных
titleStr db "Консоль: вывод и ввод данных",0			;заголовок консоли
MsgBoxTitle db "Вывод информации",0  			      ;строка заголовка
MsgBoxText  db "Консоль завершила работу",0  			;строка вывода				        
FirstName   db 15 dup(?)                                  ;инициализация имени
LastName    db 16 dup(?)                                  ;инициализация фамилии
MiddleName  db 16 dup(?)                                 ;инициализация отчества
NameOfGroup db 16 dup(?)                                 ;инициализация имени группы
DirectionOfLearn db 16 dup(?)                            ;инициализация направления обучения
Day db ?                                                    ;инициализация дня рождения
Mounth db ?                                                 ;инициализация месяца рождения
Year dw ?                                                   ;инициализация года рождения
GroupCode db ?                                              ;Инициализация шифра группы
LearnCode db ?                                              ;инициализция направления обучения
buf1 BYTE "Введение данных",
0,0Ah,0Dh									;буфер1 для выводимой строки + перевод строки
buf2 BYTE "Введите Фамилию",0 				      ;буфер2 для выводимой строки
buf3 BYTE "Введите Имя",0 				            ;буфер3 для выводимой строки
buf4 BYTE "Введите Отчество",0 					;буфер4 для выводимой строки
buf5 BYTE "Введите Название группы",0 				;буфер5 для выводимой строки
buf6 BYTE "Введите Направление обучения",0 			;буфер6 для выводимой строки
buf7 BYTE "Введите День рождения",0 			            ;буфер7 для выводимой строки
buf8 BYTE "Введите Месяц рождения (числом)",0 			;буфер8 для выводимой строки
buf9 BYTE "Введите Год рождения",0 			            ;буфер9 для выводимой строки
buf10 BYTE "Введите Шифр группы",0 			            ;буфер10 для выводимой строки
buf11 BYTE "Введите Шифр направления обучения",0 		;буфер11 для выводимой строки
outHandle  DWORD ?							;ячейка памяти для хэндла вывода
inHandle   DWORD ?							;ячейка памяти для хэндла ввода
namberW    DWORD ? 							;количество выводимых символов
namberR    DWORD ? 							;количество вводимых символов
format1 db  0dh, "Вывод на консоль: Фамилия студента: %hS Имя студента: %hS Отчество: %hS Группа: %hS Направления обучения: %hS",0
format2 db 0dh, "День: %d Месяц: %d Год: %d Шифр группы: %d Шифр направления обучения: %d",0
;===================================буферы===============================================
NumberBuf db 30 dup (?)                                     ;буффер для чисел в 30 байт
TextBuf db 255 dup (?)                                      ;буффер для строк в 255 байт
;========================================================================================
.code 									;сегмент кода
start:
invoke AllocConsole							;запрашиваем у ОС Windows консоль
;перекодируем titleStr как источник и получатель из Win1251 -> DOS
invoke CharToOem, 							;invoke - вызов функции API CharToOem
ADDR titleStr, 								;ADDR- определение адреса titleStr получателя
ADDR titleStr								;ADDR- определение адреса titleStr источника
invoke SetConsoleTitle, 						;invoke - вызов функции API SetConsoleTitle
ADDR titleStr ;								;ADDR- определение адреса titleStr
invoke GetStdHandle, 							;invoke - вызов функции API GetStdHandle 
STD_INPUT_HANDLE 							      ;получаем хэндл ввода
MOV inHandle, EAX						            ;сохраняе хэндл вывода в ячейке inHandle
invoke GetStdHandle, 							;invoke - вызов функции API GetStdHandle 
STD_OUTPUT_HANDLE 							;получаем хэндл вывода
MOV outHandle, EAX							;сохраняе хэндл вывода в ячейке outHandle

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

invoke CharToOem, 							
ADDR buf5, 									
ADDR buf5 								     

invoke CharToOem, 							
ADDR buf6, 									
ADDR buf6 								      

invoke CharToOem, 							
ADDR buf7, 									
ADDR buf7 								      

invoke CharToOem, 							
ADDR buf8, 									
ADDR buf8 								      

invoke CharToOem, 							
ADDR buf9, 									
ADDR buf9 								      

invoke CharToOem, 							
ADDR buf10,								      
ADDR buf10							            

invoke CharToOem, 							
ADDR buf11, 								
ADDR buf11 								     

invoke WriteConsoleA, 							
outHandle, 									
ADDR buf1, 									
SIZEOF buf1, 								
ADDR namberW, 								
NULL 										

invoke WriteConsoleA, 							
outHandle, 									
ADDR buf2, 									
SIZEOF buf2, 								
ADDR namberW, 								
NULL 										

invoke ReadConsole, 							
inHandle,									
ADDR FirstName,								
SIZEOF FirstName,							
ADDR namberR, 								
NULL 										

invoke OemToChar,ADDR FirstName,ADDR FirstName


invoke WriteConsoleA, 							
outHandle, 									
ADDR buf3, 									
SIZEOF buf3, 								
ADDR namberW, 								
NULL 										

invoke ReadConsole, 							
inHandle,									
ADDR LastName,								
SIZEOF LastName,							
ADDR namberR, 								
NULL 										

invoke OemToChar,ADDR LastName,ADDR LastName

invoke WriteConsoleA, 							
outHandle, 									
ADDR buf4, 									
SIZEOF buf4, 								
ADDR namberW, 								
NULL 										

invoke ReadConsole, 							
inHandle,								
ADDR MiddleName,								
SIZEOF MiddleName,							 
ADDR namberR, 								
NULL 										

invoke OemToChar,ADDR MiddleName,ADDR MiddleName


invoke WriteConsoleA, 							
outHandle, 									
ADDR buf5, 									
SIZEOF buf5, 							
ADDR namberW, 								
NULL 										

invoke ReadConsole, 							
inHandle,									
ADDR NameOfGroup,								
SIZEOF NameOfGroup,							
ADDR namberR, 								
NULL 										

invoke OemToChar,ADDR NameOfGroup,ADDR NameOfGroup

invoke WriteConsoleA, 							
outHandle, 									
ADDR buf6, 								
SIZEOF buf6, 								
ADDR namberW, 							
NULL 										

invoke ReadConsole, 							
inHandle,									
ADDR DirectionOfLearn,							
SIZEOF DirectionOfLearn,						
ADDR namberR, 								
NULL 										

invoke OemToChar,ADDR DirectionOfLearn,ADDR DirectionOfLearn

invoke WriteConsoleA, 							
outHandle, 									
ADDR buf7, 									
SIZEOF buf7, 								
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

MOV Day, AL                                                 

invoke WriteConsoleA, 							
outHandle, 									
ADDR buf8, 									
SIZEOF buf8, 								
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

MOV Mounth, AL                                              

invoke WriteConsoleA, 							
outHandle, 									
ADDR buf9, 									
SIZEOF buf9, 								
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

MOV Year, AX                                               

invoke WriteConsoleA, 							
outHandle, 									
ADDR buf10, 									
SIZEOF buf10, 								
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

MOV GroupCode, AL                                          


invoke WriteConsoleA, 					         	
outHandle, 								     
ADDR buf11, 								
SIZEOF buf11, 								
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

MOV LearnCode, AL                                            
 
LEA eax,DirectionOfLearn
push eax
LEA eax, NameOfGroup
push eax
LEA eax, MiddleName
push eax
LEA eax, LastName
push eax
LEA eax, FirstName
push eax
LEA eax, format1
push eax
LEA eax, TextBuf
push eax
call wsprintf
add  esp,7*4
invoke CharToOem, 							
ADDR TextBuf, 									
ADDR TextBuf 									
invoke WriteConsoleA, 					         	
outHandle, 								      
ADDR TextBuf, 								
SIZEOF TextBuf, 								
ADDR namberW, 								 
NULL 									      
cld ;снять флаг DF
lea di, TextBuf
mov cx, SIZEOF TextBuf
sub al, al ;обнуляем записываемый байт 
rep stosb ;обнуляем массив байтов
movzx eax,LearnCode
push eax
movzx eax,GroupCode
push eax
movzx eax,Year
push eax
movzx eax, Mounth
push eax
movzx eax, Day
push eax
LEA eax, format2
push eax
LEA eax, TextBuf
push eax
call wsprintf
add  esp,7*4
invoke CharToOem, 							
ADDR TextBuf, 									
ADDR TextBuf 									
invoke WriteConsoleA, 					         	
outHandle, 								      
ADDR TextBuf, 								
SIZEOF TextBuf, 								
ADDR namberW, 								
NULL 									     
;чтобы консоль не закрылась, вызываем MessageBox
invoke MessageBox, 0, 							
ADDR MsgBoxText, 								
ADDR MsgBoxTitle, 							
MB_OK  									
invoke ExitProcess, 0 						      
end start
