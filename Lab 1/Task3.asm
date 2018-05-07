;�������� �.�. ������17-2 ��� 1 ������� 3
.486 										;������������ ����� ������ i80486
.model flat, stdcall							;������������ ������ ������ FLAT
option casemap: none
include \masm32\include\windows.inc
include \masm32\include\user32.inc
include \masm32\include\kernel32.inc
include   \masm32\include\msvcrt.inc			      ;��� crt_atoi
includelib \masm32\lib\user32.lib
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\msvcrt.lib 					;��� crt_atoi
;=======================================================================================
.data 									;������� ������
titleStr db "�������: ����� � ���� ������",0			;��������� �������
MsgBoxTitle db "����� ����������",0  			      ;������ ���������
MsgBoxText  db "������� ��������� ������",0  			;������ ������				        
FirstName   db 15 dup(?)                                  ;������������� �����
LastName    db 16 dup(?)                                  ;������������� �������
MiddleName  db 16 dup(?)                                 ;������������� ��������
NameOfGroup db 16 dup(?)                                 ;������������� ����� ������
DirectionOfLearn db 16 dup(?)                            ;������������� ����������� ��������
Day db ?                                                    ;������������� ��� ��������
Mounth db ?                                                 ;������������� ������ ��������
Year dw ?                                                   ;������������� ���� ��������
GroupCode db ?                                              ;������������� ����� ������
LearnCode db ?                                              ;������������ ����������� ��������
buf1 BYTE "�������� ������",
0,0Ah,0Dh									;�����1 ��� ��������� ������ + ������� ������
buf2 BYTE "������� �������",0 				      ;�����2 ��� ��������� ������
buf3 BYTE "������� ���",0 				            ;�����3 ��� ��������� ������
buf4 BYTE "������� ��������",0 					;�����4 ��� ��������� ������
buf5 BYTE "������� �������� ������",0 				;�����5 ��� ��������� ������
buf6 BYTE "������� ����������� ��������",0 			;�����6 ��� ��������� ������
buf7 BYTE "������� ���� ��������",0 			            ;�����7 ��� ��������� ������
buf8 BYTE "������� ����� �������� (������)",0 			;�����8 ��� ��������� ������
buf9 BYTE "������� ��� ��������",0 			            ;�����9 ��� ��������� ������
buf10 BYTE "������� ���� ������",0 			            ;�����10 ��� ��������� ������
buf11 BYTE "������� ���� ����������� ��������",0 		;�����11 ��� ��������� ������
outHandle  DWORD ?							;������ ������ ��� ������ ������
inHandle   DWORD ?							;������ ������ ��� ������ �����
namberW    DWORD ? 							;���������� ��������� ��������
namberR    DWORD ? 							;���������� �������� ��������
format1 db  0dh, "����� �� �������: ������� ��������: %hS ��� ��������: %hS ��������: %hS ������: %hS ����������� ��������: %hS",0
format2 db 0dh, "����: %d �����: %d ���: %d ���� ������: %d ���� ����������� ��������: %d",0
;===================================������===============================================
NumberBuf db 30 dup (?)                                     ;������ ��� ����� � 30 ����
TextBuf db 255 dup (?)                                      ;������ ��� ����� � 255 ����
;========================================================================================
.code 									;������� ����
start:
invoke AllocConsole							;����������� � �� Windows �������
;������������ titleStr ��� �������� � ���������� �� Win1251 -> DOS
invoke CharToOem, 							;invoke - ����� ������� API CharToOem
ADDR titleStr, 								;ADDR- ����������� ������ titleStr ����������
ADDR titleStr								;ADDR- ����������� ������ titleStr ���������
invoke SetConsoleTitle, 						;invoke - ����� ������� API SetConsoleTitle
ADDR titleStr ;								;ADDR- ����������� ������ titleStr
invoke GetStdHandle, 							;invoke - ����� ������� API GetStdHandle 
STD_INPUT_HANDLE 							      ;�������� ����� �����
MOV inHandle, EAX						            ;�������� ����� ������ � ������ inHandle
invoke GetStdHandle, 							;invoke - ����� ������� API GetStdHandle 
STD_OUTPUT_HANDLE 							;�������� ����� ������
MOV outHandle, EAX							;�������� ����� ������ � ������ outHandle

invoke CharToOem, 							
ADDR buf1, 									
ADDR buf1 									

invoke CharToOem, 						      
ADDR buf2, 								      
ADDR buf2 									

invoke CharToOem, 							
ADDR buf3, 									
ADDR buf3 									

invoke CharToOem, 							
ADDR buf4, 								
ADDR buf4 								      

invoke CharToOem, 							
ADDR buf5, 									
ADDR buf5 								     

invoke CharToOem, 							
ADDR buf6, 									
ADDR buf6 								      

invoke CharToOem, 							
ADDR buf7, 									
ADDR buf7 								      

invoke CharToOem, 							
ADDR buf8, 									
ADDR buf8 								      

invoke CharToOem, 							
ADDR buf9, 									
ADDR buf9 								      

invoke CharToOem, 							
ADDR buf10,								      
ADDR buf10							            

invoke CharToOem, 							
ADDR buf11, 								
ADDR buf11 								     

invoke WriteConsoleA, 							
outHandle, 									
ADDR buf1, 									
SIZEOF buf1, 								
ADDR namberW, 								
NULL 										

invoke WriteConsoleA, 							
outHandle, 									
ADDR buf2, 									
SIZEOF buf2, 								
ADDR namberW, 								
NULL 										

invoke ReadConsole, 							
inHandle,									
ADDR FirstName,								
SIZEOF FirstName,							
ADDR namberR, 								
NULL 										

invoke OemToChar,ADDR FirstName,ADDR FirstName


invoke WriteConsoleA, 							
outHandle, 									
ADDR buf3, 									
SIZEOF buf3, 								
ADDR namberW, 								
NULL 										

invoke ReadConsole, 							
inHandle,									
ADDR LastName,								
SIZEOF LastName,							
ADDR namberR, 								
NULL 										

invoke OemToChar,ADDR LastName,ADDR LastName

invoke WriteConsoleA, 							
outHandle, 									
ADDR buf4, 									
SIZEOF buf4, 								
ADDR namberW, 								
NULL 										

invoke ReadConsole, 							
inHandle,								
ADDR MiddleName,								
SIZEOF MiddleName,							 
ADDR namberR, 								
NULL 										

invoke OemToChar,ADDR MiddleName,ADDR MiddleName


invoke WriteConsoleA, 							
outHandle, 									
ADDR buf5, 									
SIZEOF buf5, 							
ADDR namberW, 								
NULL 										

invoke ReadConsole, 							
inHandle,									
ADDR NameOfGroup,								
SIZEOF NameOfGroup,							
ADDR namberR, 								
NULL 										

invoke OemToChar,ADDR NameOfGroup,ADDR NameOfGroup

invoke WriteConsoleA, 							
outHandle, 									
ADDR buf6, 								
SIZEOF buf6, 								
ADDR namberW, 							
NULL 										

invoke ReadConsole, 							
inHandle,									
ADDR DirectionOfLearn,							
SIZEOF DirectionOfLearn,						
ADDR namberR, 								
NULL 										

invoke OemToChar,ADDR DirectionOfLearn,ADDR DirectionOfLearn

invoke WriteConsoleA, 							
outHandle, 									
ADDR buf7, 									
SIZEOF buf7, 								
ADDR namberW, 								
NULL 										

invoke ReadConsole, 							
inHandle,									
ADDR NumberBuf,							      
SIZEOF NumberBuf,						            
ADDR namberR, 								
NULL 										

invoke crt_atoi, 							     
addr NumberBuf 								

MOV Day, AL                                                 

invoke WriteConsoleA, 							
outHandle, 									
ADDR buf8, 									
SIZEOF buf8, 								
ADDR namberW, 								
NULL 										

invoke ReadConsole, 							
inHandle,									
ADDR NumberBuf,							      
SIZEOF NumberBuf,						            
ADDR namberR, 								
NULL 										

invoke crt_atoi, 							      
addr NumberBuf 								

MOV Mounth, AL                                              

invoke WriteConsoleA, 							
outHandle, 									
ADDR buf9, 									
SIZEOF buf9, 								
ADDR namberW, 								
NULL 										

invoke ReadConsole, 							
inHandle,									
ADDR NumberBuf,							     
SIZEOF NumberBuf,						            
ADDR namberR, 								
NULL 										

invoke crt_atoi, 							      
addr NumberBuf 							     

MOV Year, AX                                               

invoke WriteConsoleA, 							
outHandle, 									
ADDR buf10, 									
SIZEOF buf10, 								
ADDR namberW, 								
NULL 										

invoke ReadConsole, 							
inHandle,									
ADDR NumberBuf,							      
SIZEOF NumberBuf,						            
ADDR namberR, 							
NULL 									      

invoke crt_atoi, 							      
addr NumberBuf 								

MOV GroupCode, AL                                          


invoke WriteConsoleA, 					         	
outHandle, 								     
ADDR buf11, 								
SIZEOF buf11, 								
ADDR namberW, 								 
NULL 									    

invoke ReadConsole, 						     
inHandle,									
ADDR NumberBuf,							     
SIZEOF NumberBuf,						            
ADDR namberR, 								
NULL 									      

invoke crt_atoi, 							      
addr NumberBuf 								

MOV LearnCode, AL                                            
 
LEA eax,DirectionOfLearn
push eax
LEA eax, NameOfGroup
push eax
LEA eax, MiddleName
push eax
LEA eax, LastName
push eax
LEA eax, FirstName
push eax
LEA eax, format1
push eax
LEA eax, TextBuf
push eax
call wsprintf
add  esp,7*4
invoke CharToOem, 							
ADDR TextBuf, 									
ADDR TextBuf 									
invoke WriteConsoleA, 					         	
outHandle, 								      
ADDR TextBuf, 								
SIZEOF TextBuf, 								
ADDR namberW, 								 
NULL 									      
cld ;����� ���� DF
lea di, TextBuf
mov cx, SIZEOF TextBuf
sub al, al ;�������� ������������ ���� 
rep stosb ;�������� ������ ������
movzx eax,LearnCode
push eax
movzx eax,GroupCode
push eax
movzx eax,Year
push eax
movzx eax, Mounth
push eax
movzx eax, Day
push eax
LEA eax, format2
push eax
LEA eax, TextBuf
push eax
call wsprintf
add  esp,7*4
invoke CharToOem, 							
ADDR TextBuf, 									
ADDR TextBuf 									
invoke WriteConsoleA, 					         	
outHandle, 								      
ADDR TextBuf, 								
SIZEOF TextBuf, 								
ADDR namberW, 								
NULL 									     
;����� ������� �� ���������, �������� MessageBox
invoke MessageBox, 0, 							
ADDR MsgBoxText, 								
ADDR MsgBoxTitle, 							
MB_OK  									
invoke ExitProcess, 0 						      
end start
