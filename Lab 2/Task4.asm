.486						;используется набор команд i80486
.model flat, STDCALL		;модель FLAT, соглашение STDCALL
option casemap:none			;различать ПРОПИСНЫЕ и строчные
include \masm32\include\windows.inc
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc
includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib
.stack 128 				;сегмент стека 128 байт
.data						;сегмент данных
A 	SWORD 	1180h 		;A=0001 0001 1000 0000b=4480d
B 	SWORD 	2280h		;B=0010 0010 1000 0000b=8832d 
D 	SWORD 	1100h 		;D= 0001 0001 0000 0000b=4352d
Y 	SWORD ?				;Y=A+B-D
mD 	SWORD ?				;D=-D 
ApB 	SWORD ? 			;ApB=A+B
ApBmD 	SWORD ? 			;ApBmD=A+B-D
addrA 	DWORD ? 			;адрес А
addrB 	DWORD ?				;адрес В
addrD 	DWORD ?				;адрес D
addrY 	DWORD ?				;адрес Y=A+B-D
addrmD 	DWORD ?				;адрес mD
addrApB 	DWORD ?			;адрес ApB=A+B
addrApBmD 	DWORD ?		;адрес ApBmD=A+B-D
;=======переменные функции MessageBox ================
MsgBoxTitle BYTE "Заголовок MessageBox",0
MsgBoxText  BYTE 128 dup(?),0
;=======строка спецификации формата====================
format1 db "Значение А в 10-й системе A=", "%d","d",0Dh,0Ah,
"Значение А в 16-й сиcтеме А=","%x","h",0Dh,0Ah, 
"Адрес ячейки памяти [А]=","%lx","h",0
;======================================================
.code 						;сегмент кода
start: 						;метка начала основной программы
MOV addrD,OFFSET D 			;адрес D  addrD
MOV addrB,OFFSET B 			;адрес B ' addrB
MOV addrA,OFFSET A 			;адрес A ' addrA
MOV addrY,OFFSET Y			;адрес Y ' addrY
MOV addrmD,OFFSET mD		;адрес mD ' addrmD
MOV addrApB,OFFSET ApB		;адрес ApB ' addrApB
MOV addrApBmD,OFFSET ApBmD	;адрес ApBmD ' addrApBmD
;=======================================
PUSH D 					;занесение D в стек, [ESP]=[ESP+2]
PUSH B					;занесение B в стек, [ESP]=[ESP+2]
PUSH A 					;занесение A в стек, [ESP]=[ESP+2]
MOV EBP,ESP 			;EBP=ESP для доступа к стеку по EBP
;=======================================
invoke wsprintf, addr MsgBoxText,addr format1, A, A, addrA
invoke MessageBox, 0, ADDR MsgBoxText, ADDR MsgBoxTitle, MB_OK
;=======================================
MOV AX,[EBP] 			;AX=A, А из стека по адресу [EBP]
ADD AX,[EBP+2] 		;AX=AX+B, B из стека по адресу [EBP+2]
MOV ECX,addrApB		;ECX=addrApB, адрес ApB в [ECX]
MOV [ECX],AX 			;ApB=AX=A+B, адрес ApB в [ECX]
;=======================================
MOV EBX,addrmD			;EBX=addrmD - адрес mD в [EBX]
MOV DX,[EBP+4]			;DX=D, D из стека по адресу [EBP+4]
NEG DX 					;DX=-DX=-D
MOV [EBX],DX			;mD=DX=-D, адрес mD в [EBX]
;=======================================
SUB AX,[EBP+4] 		;AX=AX-D, D из стека по адресу [EBP+4]
MOV ESI,addrApBmD		;ESI=addrApBmD, адрес ApBmD в [ESI]
MOV [ESI],AX			;ApBmD=AX, адрес ApBmD в [ESI]
MOV EDI,addrY 			;EDI= addrY, адрес Y в [EDI]
MOV [EDI],AX 			;Y=AX, адрес Y в [EDI]
invoke ExitProcess, 0 	;API функция завершения процесса
end start				;конец основной программы 

