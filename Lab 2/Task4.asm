.486						;������������ ����� ������ i80486
.model flat, STDCALL		;������ FLAT, ���������� STDCALL
option casemap:none			;��������� ��������� � ��������
include \masm32\include\windows.inc
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc
includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib
.stack 128 				;������� ����� 128 ����
.data						;������� ������
A 	SWORD 	1180h 		;A=0001 0001 1000 0000b=4480d
B 	SWORD 	2280h		;B=0010 0010 1000 0000b=8832d 
D 	SWORD 	1100h 		;D= 0001 0001 0000 0000b=4352d
Y 	SWORD ?				;Y=A+B-D
mD 	SWORD ?				;D=-D 
ApB 	SWORD ? 			;ApB=A+B
ApBmD 	SWORD ? 			;ApBmD=A+B-D
addrA 	DWORD ? 			;����� �
addrB 	DWORD ?				;����� �
addrD 	DWORD ?				;����� D
addrY 	DWORD ?				;����� Y=A+B-D
addrmD 	DWORD ?				;����� mD
addrApB 	DWORD ?			;����� ApB=A+B
addrApBmD 	DWORD ?		;����� ApBmD=A+B-D
;=======���������� ������� MessageBox ================
MsgBoxTitle BYTE "��������� MessageBox",0
MsgBoxText  BYTE 128 dup(?),0
;=======������ ������������ �������====================
format1 db "�������� � � 10-� ������� A=", "%d","d",0Dh,0Ah,
"�������� � � 16-� ��c���� �=","%x","h",0Dh,0Ah, 
"����� ������ ������ [�]=","%lx","h",0
;======================================================
.code 						;������� ����
start: 						;����� ������ �������� ���������
MOV addrD,OFFSET D 			;����� D  addrD
MOV addrB,OFFSET B 			;����� B ' addrB
MOV addrA,OFFSET A 			;����� A ' addrA
MOV addrY,OFFSET Y			;����� Y ' addrY
MOV addrmD,OFFSET mD		;����� mD ' addrmD
MOV addrApB,OFFSET ApB		;����� ApB ' addrApB
MOV addrApBmD,OFFSET ApBmD	;����� ApBmD ' addrApBmD
;=======================================
PUSH D 					;��������� D � ����, [ESP]=[ESP+2]
PUSH B					;��������� B � ����, [ESP]=[ESP+2]
PUSH A 					;��������� A � ����, [ESP]=[ESP+2]
MOV EBP,ESP 			;EBP=ESP ��� ������� � ����� �� EBP
;=======================================
invoke wsprintf, addr MsgBoxText,addr format1, A, A, addrA
invoke MessageBox, 0, ADDR MsgBoxText, ADDR MsgBoxTitle, MB_OK
;=======================================
MOV AX,[EBP] 			;AX=A, � �� ����� �� ������ [EBP]
ADD AX,[EBP+2] 		;AX=AX+B, B �� ����� �� ������ [EBP+2]
MOV ECX,addrApB		;ECX=addrApB, ����� ApB � [ECX]
MOV [ECX],AX 			;ApB=AX=A+B, ����� ApB � [ECX]
;=======================================
MOV EBX,addrmD			;EBX=addrmD - ����� mD � [EBX]
MOV DX,[EBP+4]			;DX=D, D �� ����� �� ������ [EBP+4]
NEG DX 					;DX=-DX=-D
MOV [EBX],DX			;mD=DX=-D, ����� mD � [EBX]
;=======================================
SUB AX,[EBP+4] 		;AX=AX-D, D �� ����� �� ������ [EBP+4]
MOV ESI,addrApBmD		;ESI=addrApBmD, ����� ApBmD � [ESI]
MOV [ESI],AX			;ApBmD=AX, ����� ApBmD � [ESI]
MOV EDI,addrY 			;EDI= addrY, ����� Y � [EDI]
MOV [EDI],AX 			;Y=AX, ����� Y � [EDI]
invoke ExitProcess, 0 	;API ������� ���������� ��������
end start				;����� �������� ��������� 

