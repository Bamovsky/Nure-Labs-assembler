.486 								;используется набор команд i80386
.model flat, stdcall					;используемая модель памяти FLAT
option casemap: none
include \masm32\include\windows.inc
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc
includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib
;===================================================================================
.data								;сегмент данных
MsgBoxTitle db "Вывод информации",0		      ;строка заголовка
MsgBoxText  db 128 dup(?)         			;буфер вывода
FirstName   db "Владимир",0                     ;инициализация имени
LastName    db "Черкашин",0                     ;инициализация фамилии
MiddleName  db "Андреевич" ,0                   ;инициализация отчества
NameOfGroup db "АКТСИу 17-2" ,0                 ;инициализация имени группы
DirectionOfLearn db "АКТАКИТ",0                 ;инициализация направления обучения
Day db 27                                       ;инициализация дня рождения
Mounth db 9                                     ;инициализация месяца рождения
Year dw 1997                                    ;инициализация года рождения
GroupCode db 2                                  ;Инициализация шифра группы
LearnCode db 151                                ;инициализция направления обучения
format1 db "Дата рождения студента",	            ;строка спецификации формата
0dh,0ah, "День %d", 0dh,0ah, "Месяц %d", 0dh,0ah, "Год %d",0
format2 db "АКТСИУ 17-%d",0
format3 db "АКТАКИТ",0dh,0ah, "Шифр %d",0
format4 db "Дата рождения студента H",	       ;строка спецификации формата
0dh,0ah, "День %0X", 0dh,0ah, "Месяц %0X", 0dh,0ah, "Год %0X",0
;===================================================================================
.code								;сегмент кода
start:
     
invoke MessageBox, 0, 					;invoke – вызов функции API MessageBox
ADDR FirstName, 						;ADDR нахождение адреса FirstName
ADDR MsgBoxTitle, 					;ADDR нахождение адреса MsgBoxTitle
MB_OK OR MB_ICONEXCLAMATION 				;кнопка «OK»

invoke MessageBox, 0, 					;invoke – вызов функции API MessageBox
ADDR LastName, 						;ADDR нахождение адреса LastName
ADDR MsgBoxTitle, 					;ADDR нахождение адреса MsgBoxTitle
MB_YESNO OR MB_ICONINFORMATION OR MB_DEFBUTTON1	;кнопка Да/нет

invoke MessageBox, 0, 					;invoke – вызов функции API MessageBox
ADDR MiddleName, 						;ADDR нахождение адреса MiddleName
ADDR MsgBoxTitle, 					;ADDR нахождение адреса MsgBoxTitle
MB_OKCANCEL OR MB_ICONQUESTION OR MB_DEFBUTTON2	;кнопка «OK»

invoke MessageBox, 0, 					;invoke – вызов функции API MessageBox
ADDR NameOfGroup, 					;ADDR нахождение адреса NameOfGroup
ADDR MsgBoxTitle, 					;ADDR нахождение адреса MsgBoxTitle
MB_YESNOCANCEL OR MB_ICONSTOP OR MB_DEFBUTTON3			;кнопка «OK»

invoke MessageBox, 0, 					;invoke – вызов функции API MessageBox
ADDR DirectionOfLearn, 					;ADDR нахождение адреса DirectionOfLearn
ADDR MsgBoxTitle, 					;ADDR нахождение адреса MsgBoxTitle
MB_RETRYCANCEL OR MB_ICONQUESTION OR MB_DEFBUTTON2  ;кнопка «OK»
           
movzx eax,Day
push eax
movzx eax,Mounth
push eax
movzx eax,Year
push eax
LEA eax, format1
push eax
LEA eax, MsgBoxText
push eax
call wsprintf
add  esp,5*4



invoke MessageBox, 0, 					;invoke – вызов функции API MessageBox
ADDR MsgBoxText, 					      ;ADDR нахождение адреса DirectionOfLearn
ADDR MsgBoxTitle, 					;ADDR нахождение адреса MsgBoxTitle
MB_OKCANCEL OR MB_YESNO OR MB_DEFBUTTON1 OR MB_ICONSTOP ;кнопка «OK»


invoke wsprintf,addr MsgBoxText,addr format2,GroupCode

invoke MessageBox, 0, 					;invoke – вызов функции API MessageBox
ADDR MsgBoxText, 					      ;ADDR нахождение адреса DirectionOfLearn
ADDR MsgBoxTitle, 					;ADDR нахождение адреса MsgBoxTitle
MB_YESNO OR MB_DEFBUTTON1 OR MB_ICONSTOP        ;кнопка «OK»

invoke wsprintf,addr MsgBoxText,addr format3,LearnCode

invoke MessageBox, 0, 					;invoke – вызов функции API MessageBox
ADDR MsgBoxText, 					      ;ADDR нахождение адреса DirectionOfLearn
ADDR MsgBoxTitle, 					;ADDR нахождение адреса MsgBoxTitle
MB_YESNO OR MB_DEFBUTTON1 OR MB_ICONSTOP        ;кнопка «OK»

movzx eax,Day
movzx edx,Mounth
movzx ecx,Year
invoke wsprintf,addr MsgBoxText,addr format4,eax,edx,ecx


invoke MessageBox, 0, 					;invoke – вызов функции API MessageBox
ADDR MsgBoxText, 					      ;ADDR нахождение адреса DirectionOfLearn
ADDR MsgBoxTitle, 					;ADDR нахождение адреса MsgBoxTitle
MB_OKCANCEL OR MB_YESNO OR MB_DEFBUTTON1 OR MB_ICONSTOP ;кнопка «OK»


invoke ExitProcess, 0					;invoke – вызов функции API
end start






