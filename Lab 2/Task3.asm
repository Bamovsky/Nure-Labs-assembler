.486						;������������ ����� ������ i80486
.model flat, STDCALL		;������ FLAT, ���������� STDCALL
option casemap:none			;��������� ��������� � ��������
.stack 128 				;������� ����� 128 ����
.data						;������� ������
A 	SWORD 	1180h 	       ;A=0001 0001 1000 0000b=4480d
B 	SWORD 	2280h	        ;B=0010 0010 1000 0000b=8832d 
D 	SWORD 	1100h 	;D= 0001 0001 0000 0000b=4352d
Y 	SWORD ?			;Y=A+B-D
mD 	SWORD ?			;D=-D 
ApB 	SWORD ? 			;ApB=A+B
ApBmD 	SWORD ? 			;ApBmD=A+B-D
.code 						;������� ����
start: 						;����� ������ �������� ���������
PUSH D 						;��������� D � ����, [ESP]=[ESP+2]
PUSH B						;��������� B � ����, [ESP]=[ESP+2]
PUSH A 						;��������� A � ����, [ESP]=[ESP+2]
POP AX 						;AX=A, � �� �����, [ESP]=[ESP-2]
POP CX 						;CX=B, B �� �����, [ESP]=[ESP-2]
ADD AX,CX 				;AX=AX+CX=A+B=1180h+2280h=3400h
MOV ApB,AX 				;ApB=AX
POP DX 						;DX=D, D �� �����, [ESP]=[ESP-2]
MOV mD,DX 				;mD=DX=D=1100h
NEG mD 						;mD=-mD=-D=0EF00h
SUB AX,DX 				;AX=AX-DX=A+B-D=2300h
MOV ApBmD,AX 				;ApBmD=AX=A+B-D=2300h
MOV Y,AX 					;Y=AX=A+B-D=2300h
ret						;����� � �� Windows
end start					;����� �������� ��������� 
