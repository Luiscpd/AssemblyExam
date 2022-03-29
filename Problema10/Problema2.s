	AREA codigo,CODE, READONLY, ALIGN=2
	THUMB
	EXPORT Start
		
; Calculo de indice de masa corporal (IMC)
; ¿Cuál es su peso en libras y estatura en metros?

Start
	
	VLDR.F32 S0, =238 ; Peso en libras
	VLDR.F32 S1, =1.87 ; Estura en metros

	B Conversion
	
Conversion

	VLDR.F32 S2, =2.24 ; 1kg = 2.24lb
	VDIV.F32 S3, S0,S2 ; Conversion de libras a kilgramos

	B Calculo
	
Calculo 

	VMUL.F32 S4, S1,S1 ; Estatura al cuadrado 
	VDIV.F32 S5, S3,S4 ; Peso/Estatura^2, valor de IMC
	
	B IMC4


; Se establece el nivel de peso con el IMC correspondiente
; 1. Bajo peso
; 2. Normal
; 3. Sobrepeso
; 4. Obesidad

; Nivel de peso se guardara en S6

IMC4
	; Valores de comparacion para IMC
	VLDR.F32 S7, =30
	VLDR.F32 S8, =29.9
	VLDR.F32 S9, = 25
	VLDR.F32 S10, = 24.9
	VLDR.F32 S11, = 18.5

	VCMP.F32 S5, S7 ; Comparamos IMC con 30
	
	VMRS APSR_nzcv, FPSCR
	BGE Obesidad ;Si IMC es mayor o igual a 30 salta a obesidad
	BLE IMC30 ; Si es menor que 30 salta a IMC30
	
IMC30

	VCMP.F32 S5,S8 ; Comparamos IMC con 29.9
	
	VMRS APSR_nzcv, FPSCR
	BLE IMC31 ; Si IMC es menor o igual que, saltamos a IMC31
	
IMC31

	VCMP.F32 S5,S9 ; Comparamos IMC con 25
	
	VMRS APSR_nzcv, FPSCR
	BGE Sobrepeso ; Si IMC es mayor o igua que, saltamos a Sobrepeso
	BLT IMC2 ; Si es menor que, saltamos a IMC2

IMC2
	
	VCMP.F32 S5,S10 ;Comparamos IMC con 24.9
	
	VMRS APSR_nzcv, FPSCR
	
	BEQ Normal ; Si IMC es igual a 24.9 saltamos a Normal
	BLT IMC20 ; Si IMC es menor que, saltamos a IMC20
	
IMC20

	VCMP.F32 S5,S11 ; Comparamos IMC con 18.5
	
	VMRS APSR_nzcv, FPSCR
	
	BGE Normal ; Si IMC es mayor o igual que, saltamos a Normal
	BLT IMC1 ; Si IMC es menor que saltamos a IMC1
	
IMC1

	VCMP.F32 S5,S11 ; Comparamos IMC con 18.5
	
	VMRS APSR_nzcv, FPSCR
	
	BLT BajoPeso ; Si IMC es menor que saltamos a BajoPeso
	
BajoPeso
	
	VLDR.F32 S6, =1 ; Segun tabla de IMC asignamos valor a S6
	
	B Stop
	
Normal

	VLDR.F32 S6, =2 ; Segun tabla de IMC asignamos valor a S6
	
	B Stop

Sobrepeso	

	VLDR.F32 S6, =3 ; Segun tabla de IMC asignamos valor a S6
	
	B Stop
	
Obesidad

	VLDR.F32 S6, =4 ; Segun tabla de IMC asignamos valor a S6
	
	B Stop
	
Stop B Stop
	ALIGN
	END
