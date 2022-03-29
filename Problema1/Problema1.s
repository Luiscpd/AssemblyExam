	AREA codigo,CODE, READONLY, ALIGN=2
	THUMB
	EXPORT Start
		
; ¿Qué área le gustaría calcular?
; 1. Triangulo
; 2. Rectangulo
; 3. Circulo
Start
	VLDR.F32 S0, =1 ;Se escoge la figura geométrica

	B Triangulo ;Salto al ciclo Triangulo

;Se presetan los siguientes ciclos para las diferentes opciones que puede elegir el usuario

Triangulo	

	VLDR.F32 S1, =1 ; Opción 1 para el usuario
	VCMP.F32 S0, S1 ; Compara valor S0 con S1
	
	VMRS APSR_nzcv, FPSCR
	BNE Rectangulo; Si S0 y S1 son diferentes salta al ciclo Rectangulo
	BEQ AreaTriangulo ; Si S0 y S1 son iguales salta a calcular el area del triangulo
	
Rectangulo

	VLDR.F32 S2, =2 ; Opción 2 para el usuario
	
	VCMP.F32 S0, S2 ; Compara valor S0 con S2
	
	VMRS APSR_nzcv, FPSCR
	BNE Circulo ; Si S0 y S2 son diferentes salta al ciclo Circulo
	BEQ AreaRectangulo ; Si S0 y S2 son iguales salta a calcular el area del rectangulo
	
Circulo

	VLDR.F32 S3, =3 ; Opción 3 para el usuario
	
	VCMP.F32 S0, S3 ; Compara valor de S0 con S3
	
	VMRS APSR_nzcv, FPSCR
	BNE Stop ; Si se ingresa un numero erroneo finaliza el programa
	BEQ AreaCirculo ; Calcula area circulo

; Se presentan las areas de las figuras geométricas correspondientes

AreaTriangulo

	VLDR.F32 S6, =2 ; /2

	;Ingrese la base y altura del triangulo:
	VLDR.F32 S4, =4 ; Base
	VLDR.F32 S5, =4 ; Altura

	
	VMUL.F32 S7,S4,S5 ; Base*Altura 
	VDIV.F32 S8, S7,S6 ; (Base*Altura)/2. Resultado se guarda en S8
	
	B Stop
	
AreaRectangulo
	
	;Ingrese la base y altura del rectangulo:
	VLDR.F32 S9, =4 ; Base
	VLDR.F32 S10, = 2 ; Altura
	
	VMUL.F32 S11, S9,S10 ; Base*Altura. Resultado se guarda en S11
	
	B Stop
	
AreaCirculo
	
	VLDR.F32 S6, =2 ; /2
	
	; Ingrese el diametro del circulo:
	VLDR.F32 S12, =6 ; Diametro
	VLDR.F32 S13, =3.1416; Valor de Pi
	
	VDIV.F32 S14, S12,S6; Diametro/2 = Radio
	VMUL.F32 S15, S14,S14; Radio^2
	VMUL.F32 S16, S15,S13; Radio^2*Pi. Resultado se guarda en S16
	
	B Stop

Stop B Stop 
	ALIGN
	END