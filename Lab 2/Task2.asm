.486						;������������ ����� ������ i80486
.model flat, STDCALL		;������ FLAT, ���������� STDCALL
option casemap:none			;��������� ��������� � ��������
.data						;������� ������
A 	SWORD 	1180h 	;A=0001 0001 1000 0000b=4480d
B 	SWORD 	2280h	;B=0010 0010 1000 0000b=8832d 
D 	SWORD 	1100h 	;D= 0001 0001 0000 0000b=4352d
Y 	SWORD ?			;Y=A+B-D
mD 	SWORD ?			; D=-D 
ApB 	SWORD ? 			;ApB=A+B
ApBmD 	SWORD ? 			;ApBmD=A+B-D
addrA 	DWORD ? 			;����� �
addrB 	DWORD ?			;����� �
addrD 	DWORD ?			;����� D
addrY 	DWORD ?			;����� Y=A+B-D
addrmD 	DWORD ?			;����� mD
addrApB 	DWORD ?			;����� ApB=A+B
addrApBmD 	DWORD ?			;����� ApBmD=A+B-D
.code 						;������� ����
start: 						;����� ������ �������� ���������
MOV addrD,OFFSET D 			;����� D ' addrD
MOV addrB,OFFSET B 			;����� B ' addrB
MOV addrA,OFFSET A 			;����� A ' addrA
MOV addrY,OFFSET Y			;����� Y ' addrY
MOV addrmD,OFFSET mD		;����� mD ' addrmD
MOV addrApB,OFFSET ApB		;����� ApB ' addrApB
MOV addrApBmD,OFFSET ApBmD	;����� ApBmD ' addrApBmD
;=======================================
MOV EBX, addrA				;EBX=addrA - ����� A
MOV ECX, addrB				;ECX=addrB - ����� B
MOV EAX,0 				;EAX=0
MOV AX, [EBX] 				;AX=A, � [EBX] ����� A
ADD AX,[ECX] 				;AX=AX+B=A+B, � [ECX] ����� B
MOV EBX, addrApB 			;EBX=addrApB - ����� ApB=A+B
MOV [EBX],AX 				;ApB=AX=A+B, � [EBX] ����� ApB
;=======================================
MOV EBX,addrmD 			;EBX=addrmD - ����� mD=-D
MOV EDX,addrD 				;EDX=addrD - ����� D
MOV SI, [EDX] 				;SI=D, X], � [EDX] ����� D
NEG SI 						;SI=-SI=-D
MOV [EBX],SI 				;mD=SI=-D, � [EBX] ����� mD
;=======================================
SUB AX, [EDX] 				;AX=AX-D=A+B-D, � [EDX] ����� D
MOV EDX, addrApBmD 			;EDX=addrApBmD - ����� ApBmD=A+B-D
MOV [EDX], AX 				;ApBmD=AX=A+B-D, � [EDX] ����� ApBmD
MOV EDX, addrY 			;EDX=addrY, - ����� Y=A+B-D
MOV [EDX], AX 				;Y=AX=A+B-D, � [EDX] ����� Y
ret						;����� � �� Windows
end start					;����� �������� ��������� 
