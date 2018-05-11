.486						;используется набор команд i80486
.model flat, STDCALL		;модель FLAT, соглашение STDCALL
option casemap:none			;различать ПРОПИСНЫЕ и строчные
.data						;сегмент данных
A 	SWORD 	1180h 	;A=0001 0001 1000 0000b=4480d
B 	SWORD 	2280h	;B=0010 0010 1000 0000b=8832d 
D 	SWORD 	1100h 	;D= 0001 0001 0000 0000b=4352d
Y 	SWORD ?			;Y=A+B-D
mD 	SWORD ?			; D=-D 
ApB 	SWORD ? 			;ApB=A+B
ApBmD 	SWORD ? 			;ApBmD=A+B-D
addrA 	DWORD ? 			;адрес А
addrB 	DWORD ?			;адрес В
addrD 	DWORD ?			;адрес D
addrY 	DWORD ?			;адрес Y=A+B-D
addrmD 	DWORD ?			;адрес mD
addrApB 	DWORD ?			;адрес ApB=A+B
addrApBmD 	DWORD ?			;адрес ApBmD=A+B-D
.code 						;сегмент кода
start: 						;метка начала основной программы
MOV addrD,OFFSET D 			;адрес D ' addrD
MOV addrB,OFFSET B 			;адрес B ' addrB
MOV addrA,OFFSET A 			;адрес A ' addrA
MOV addrY,OFFSET Y			;адрес Y ' addrY
MOV addrmD,OFFSET mD		;адрес mD ' addrmD
MOV addrApB,OFFSET ApB		;адрес ApB ' addrApB
MOV addrApBmD,OFFSET ApBmD	;адрес ApBmD ' addrApBmD
;=======================================
MOV EBX, addrA				;EBX=addrA - адрес A
MOV ECX, addrB				;ECX=addrB - адрес B
MOV EAX,0 				;EAX=0
MOV AX, [EBX] 				;AX=A, в [EBX] адрес A
ADD AX,[ECX] 				;AX=AX+B=A+B, в [ECX] адрес B
MOV EBX, addrApB 			;EBX=addrApB - адрес ApB=A+B
MOV [EBX],AX 				;ApB=AX=A+B, в [EBX] адрес ApB
;=======================================
MOV EBX,addrmD 			;EBX=addrmD - адрес mD=-D
MOV EDX,addrD 				;EDX=addrD - адрес D
MOV SI, [EDX] 				;SI=D, X], в [EDX] адрес D
NEG SI 						;SI=-SI=-D
MOV [EBX],SI 				;mD=SI=-D, в [EBX] адрес mD
;=======================================
SUB AX, [EDX] 				;AX=AX-D=A+B-D, в [EDX] адрес D
MOV EDX, addrApBmD 			;EDX=addrApBmD - адрес ApBmD=A+B-D
MOV [EDX], AX 				;ApBmD=AX=A+B-D, в [EDX] адрес ApBmD
MOV EDX, addrY 			;EDX=addrY, - адрес Y=A+B-D
MOV [EDX], AX 				;Y=AX=A+B-D, в [EDX] адрес Y
ret						;выход в ОС Windows
end start					;конец основной программы 
