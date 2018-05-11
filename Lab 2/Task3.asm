.486						;используется набор команд i80486
.model flat, STDCALL		;модель FLAT, соглашение STDCALL
option casemap:none			;различать ПРОПИСНЫЕ и строчные
.stack 128 				;сегмент стека 128 байт
.data						;сегмент данных
A 	SWORD 	1180h 	       ;A=0001 0001 1000 0000b=4480d
B 	SWORD 	2280h	        ;B=0010 0010 1000 0000b=8832d 
D 	SWORD 	1100h 	;D= 0001 0001 0000 0000b=4352d
Y 	SWORD ?			;Y=A+B-D
mD 	SWORD ?			;D=-D 
ApB 	SWORD ? 			;ApB=A+B
ApBmD 	SWORD ? 			;ApBmD=A+B-D
.code 						;сегмент кода
start: 						;метка начала основной программы
PUSH D 						;занесение D в стек, [ESP]=[ESP+2]
PUSH B						;занесение B в стек, [ESP]=[ESP+2]
PUSH A 						;занесение A в стек, [ESP]=[ESP+2]
POP AX 						;AX=A, А из стека, [ESP]=[ESP-2]
POP CX 						;CX=B, B из стека, [ESP]=[ESP-2]
ADD AX,CX 				;AX=AX+CX=A+B=1180h+2280h=3400h
MOV ApB,AX 				;ApB=AX
POP DX 						;DX=D, D из стека, [ESP]=[ESP-2]
MOV mD,DX 				;mD=DX=D=1100h
NEG mD 						;mD=-mD=-D=0EF00h
SUB AX,DX 				;AX=AX-DX=A+B-D=2300h
MOV ApBmD,AX 				;ApBmD=AX=A+B-D=2300h
MOV Y,AX 					;Y=AX=A+B-D=2300h
ret						;выход в ОС Windows
end start					;конец основной программы 
