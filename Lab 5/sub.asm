.486 ;������������ ����� ������ i80486
.model flat, STDCALL ;������ FLAT, ���������� STDCALL
option casemap:none ;��������� ��������� � ��������
PUBLIC _prSUB ;��������� prADD - �������������
.code ;������� ����
_prSUB PROC ;��������� ��������� prADD
PUSH EBP ;���������� �������� EBP
MOV EBP,ESP ;���������� EBP �� ������� �����
MOV AX, SWORD PTR [EBP+8] ;1-� �������� A - �� ������ [EBP+8]
SUB AX, SWORD PTR [EBP+10] ;2-� �������� B - �� ������ [EBP+10]
POP EBP ;�������������� �������� EBP
RET 4 ;����� ������, ������� 4 �����
_prSUB ENDP ;ENDP � ��������� �������� prADD
END ;����� ������� ���������