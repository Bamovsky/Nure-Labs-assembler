.486 ;������������ ����� ������ i80486
.model flat, STDCALL ;������ FLAT, ���������� STDCALL
option casemap:none ;��������� ��������� � ��������
PUBLIC _prADD ;��������� prADD - �������������
.code ;������� ����
_prADD PROC ;��������� ��������� prADD
PUSH EBP ;���������� �������� EBP
MOV EBP,ESP ;���������� EBP �� ������� �����
MOV AX,WORD PTR [EBP+8] ;1-� �������� A - �� ������ [EBP+8]
ADD AX,WORD PTR [EBP+10] ;2-� �������� B - �� ������ [EBP+10]
POP EBP ;�������������� �������� EBP
RET 4 ;����� ������, ������� 4 �����
_prADD ENDP ;ENDP � ��������� �������� prADD
END ;����� ������� ���������