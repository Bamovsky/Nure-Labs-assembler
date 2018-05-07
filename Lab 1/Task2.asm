.486 								;������������ ����� ������ i80386
.model flat, stdcall					;������������ ������ ������ FLAT
option casemap: none
include \masm32\include\windows.inc
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc
includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib
;===================================================================================
.data								;������� ������
MsgBoxTitle db "����� ����������",0		      ;������ ���������
MsgBoxText  db 128 dup(?)         			;����� ������
FirstName   db "��������",0                     ;������������� �����
LastName    db "��������",0                     ;������������� �������
MiddleName  db "���������" ,0                   ;������������� ��������
NameOfGroup db "������ 17-2" ,0                 ;������������� ����� ������
DirectionOfLearn db "�������",0                 ;������������� ����������� ��������
Day db 27                                       ;������������� ��� ��������
Mounth db 9                                     ;������������� ������ ��������
Year dw 1997                                    ;������������� ���� ��������
GroupCode db 2                                  ;������������� ����� ������
LearnCode db 151                                ;������������ ����������� ��������
format1 db "���� �������� ��������",	            ;������ ������������ �������
0dh,0ah, "���� %d", 0dh,0ah, "����� %d", 0dh,0ah, "��� %d",0
format2 db "������ 17-%d",0
format3 db "�������",0dh,0ah, "���� %d",0
format4 db "���� �������� �������� H",	       ;������ ������������ �������
0dh,0ah, "���� %0X", 0dh,0ah, "����� %0X", 0dh,0ah, "��� %0X",0
;===================================================================================
.code								;������� ����
start:
     
invoke MessageBox, 0, 					;invoke � ����� ������� API MessageBox
ADDR FirstName, 						;ADDR ���������� ������ FirstName
ADDR MsgBoxTitle, 					;ADDR ���������� ������ MsgBoxTitle
MB_OK OR MB_ICONEXCLAMATION 				;������ �OK�

invoke MessageBox, 0, 					;invoke � ����� ������� API MessageBox
ADDR LastName, 						;ADDR ���������� ������ LastName
ADDR MsgBoxTitle, 					;ADDR ���������� ������ MsgBoxTitle
MB_YESNO OR MB_ICONINFORMATION OR MB_DEFBUTTON1	;������ ��/���

invoke MessageBox, 0, 					;invoke � ����� ������� API MessageBox
ADDR MiddleName, 						;ADDR ���������� ������ MiddleName
ADDR MsgBoxTitle, 					;ADDR ���������� ������ MsgBoxTitle
MB_OKCANCEL OR MB_ICONQUESTION OR MB_DEFBUTTON2	;������ �OK�

invoke MessageBox, 0, 					;invoke � ����� ������� API MessageBox
ADDR NameOfGroup, 					;ADDR ���������� ������ NameOfGroup
ADDR MsgBoxTitle, 					;ADDR ���������� ������ MsgBoxTitle
MB_YESNOCANCEL OR MB_ICONSTOP OR MB_DEFBUTTON3			;������ �OK�

invoke MessageBox, 0, 					;invoke � ����� ������� API MessageBox
ADDR DirectionOfLearn, 					;ADDR ���������� ������ DirectionOfLearn
ADDR MsgBoxTitle, 					;ADDR ���������� ������ MsgBoxTitle
MB_RETRYCANCEL OR MB_ICONQUESTION OR MB_DEFBUTTON2  ;������ �OK�
           
movzx eax,Day
push eax
movzx eax,Mounth
push eax
movzx eax,Year
push eax
LEA eax, format1
push eax
LEA eax, MsgBoxText
push eax
call wsprintf
add  esp,5*4



invoke MessageBox, 0, 					;invoke � ����� ������� API MessageBox
ADDR MsgBoxText, 					      ;ADDR ���������� ������ DirectionOfLearn
ADDR MsgBoxTitle, 					;ADDR ���������� ������ MsgBoxTitle
MB_OKCANCEL OR MB_YESNO OR MB_DEFBUTTON1 OR MB_ICONSTOP ;������ �OK�


invoke wsprintf,addr MsgBoxText,addr format2,GroupCode

invoke MessageBox, 0, 					;invoke � ����� ������� API MessageBox
ADDR MsgBoxText, 					      ;ADDR ���������� ������ DirectionOfLearn
ADDR MsgBoxTitle, 					;ADDR ���������� ������ MsgBoxTitle
MB_YESNO OR MB_DEFBUTTON1 OR MB_ICONSTOP        ;������ �OK�

invoke wsprintf,addr MsgBoxText,addr format3,LearnCode

invoke MessageBox, 0, 					;invoke � ����� ������� API MessageBox
ADDR MsgBoxText, 					      ;ADDR ���������� ������ DirectionOfLearn
ADDR MsgBoxTitle, 					;ADDR ���������� ������ MsgBoxTitle
MB_YESNO OR MB_DEFBUTTON1 OR MB_ICONSTOP        ;������ �OK�

movzx eax,Day
movzx edx,Mounth
movzx ecx,Year
invoke wsprintf,addr MsgBoxText,addr format4,eax,edx,ecx


invoke MessageBox, 0, 					;invoke � ����� ������� API MessageBox
ADDR MsgBoxText, 					      ;ADDR ���������� ������ DirectionOfLearn
ADDR MsgBoxTitle, 					;ADDR ���������� ������ MsgBoxTitle
MB_OKCANCEL OR MB_YESNO OR MB_DEFBUTTON1 OR MB_ICONSTOP ;������ �OK�


invoke ExitProcess, 0					;invoke � ����� ������� API
end start






