.486
.model flat, STDCALL
option casemap:none 
PUBLIC _prDIV 
.code 
_prDIV PROC  
IDIV BL 
CBW
RET 
_prDIV ENDP 
END 