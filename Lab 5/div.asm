.486 ;используетс€ набор команд i80486
.model flat, STDCALL ;модель FLAT, соглашение STDCALL
option casemap:none ;различать ѕ–ќѕ»—Ќџ≈ и строчные
PUBLIC _prDIV ;процедура prADD - общедоступна€
.code ;сегмент кода
_prDIV PROC  ;заголовок процедуры prADD
PUSH EBP ;сохранение регистра EBP
MOV EBP,ESP ;установить EBP на вершину стека
MOV AX, SWORD PTR [EBP+8] ;1-й параметр A - по адресу [EBP+8]
MOV BL, BYTE ptr [EBP+10]
IDIV BL ;2-й параметр B - по адресу [EBP+10]
CBW
POP EBP ;восстановление регистра EBP
RET 4 ;точка выхода, удал€ем 4 байта
_prDIV ENDP ;ENDP Ц окончание описани€ prADD
END ;конец внешней процедуры