.486 ;������������ ����� ������ i80486
.model flat, STDCALL ;������ FLAT, ���������� STDCALL
option casemap:none ;��������� ��������� � ��������
PUBLIC _prDIV ;��������� prADD - �������������
.code ;������� ����
_prDIV PROC  ;��������� ��������� prADD
PUSH EBP ;���������� �������� EBP
MOV EBP,ESP ;���������� EBP �� ������� �����
MOV AX, SWORD PTR [EBP+8] ;1-� �������� A - �� ������ [EBP+8]
MOV BL, BYTE ptr [EBP+10]
IDIV BL ;2-� �������� B - �� ������ [EBP+10]
CBW
POP EBP ;�������������� �������� EBP
RET 4 ;����� ������, ������� 4 �����
_prDIV ENDP ;ENDP � ��������� �������� prADD
END ;����� ������� ���������