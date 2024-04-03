	PRESERVE8
	THUMB   
		

; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly

;Section RAM (read write):
	area    maram,data,readwrite

	export GestionSon_Index
	export SortieSon
		
GestionSon_Index dcd 5512
SortieSon dcw 0


; ===============================================================================================
	
 
		
;Section ROM code (read only) :		
	area    moncode,code,readonly
; écrire le code ici

	import LongueurSon
	import Son
	import PWM_Set_Value_TIM3_Ch3

	export GestionSon_Callback
	export GestionSon_Start
	export GestionSon_Stop

; extern Son;
; extern LongueurSon;
; extern GestionSon_Index;
;
; if (GestionSon_Index < Longueur_Son) {
; 	int Echelle = ((Son[GestionSon_Index] + 32768) * 720) / 65536;
; 	GestionSon_Index = GestionSon_Index + 1;
; 	SortieSon = Echelle;
; } else {
;	SortieSon = 0;
; }
;
; 
;
; return;
GestionSon_Callback proc
	ldr r1, =GestionSon_Index
	ldr r0,[r1]
	
	ldr r2, =LongueurSon
	ldr r3, [r2]
	
	; si Longueur_Son <= GestionSon_Index
	cmp r3, r0
	mov r3, #360
	ble Return
	
	; récupération du tableau Son
	ldr r2,=Son
	ldrh r3, [r2, r0, LSL #1]
	; extension du bit de signe sur 32 bits
	sxth r3, r3 
	
	; calculs pour la remise à l'échelle
	add r3, #32768
	mov r0, #720
	mul r3, r0
	lsr r3, r3, #16
	
	; post incrémentation du compteur
	ldr r0,[r1]
	add r0,#1		
	str r0,[r1]
Return
	; mise à jour de SortieSon
	ldr r1, =SortieSon
	str r3, [r1]
	
	push {lr}
	mov r0, r3
	bl PWM_Set_Value_TIM3_Ch3
	pop {lr}
	
	bx lr
	endp
	
GestionSon_Start proc
	ldr r1, =GestionSon_Index
	mov r2, #0
	str r2, [r1]
	bx lr
	endp
		
GestionSon_Stop proc
	ldr r1, =GestionSon_Index
	ldr r2, =LongueurSon
	ldr r2, [r2]
	str r2, [r1]
	bx lr
	endp
	
	END	