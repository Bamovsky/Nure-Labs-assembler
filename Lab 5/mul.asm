.486 ;������������ ����� ������ i80486
.model flat, STDCALL ;������ FLAT, ���������� STDCALL
option casemap:none ;��������� ��������� � ��������
PUBLIC _prMUL ;��������� prADD - �������������
.code ;������� ����
_prMUL PROC ;��������� ��������� prADD
PUSH EBP ;���������� �������� EBP
MOV EBP,ESP ;���������� EBP �� ������� �����
MOV AX,WORD PTR [EBP+8] ;1-� �������� A - �� ������ [EBP+8]
MUL WORD PTR [EBP+10] ;2-� �������� B - �� ������ [EBP+10]
POP EBP ;�������������� �������� EBP
RET 4 ;����� ������, ������� 4 �����
_prMUL ENDP ;ENDP � ��������� �������� prADD
END ;����� ������� ���������