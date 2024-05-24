	PRESERVE8
	THUMB   
		

; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly

;Section RAM (read write):
	area    maram,data,readwrite

	export GestionSon_Index
	export SortieSon
		
GestionSon_Index
	dcd 3512
	dcd 0
	dcd 1452
	dcd 256
SortieSon dcw 0

Player_0 equ 0
Player_1 equ 4
Player_2 equ 8
Player_3 equ 12

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
	push {r4,r5}
	
	ldr r2, =LongueurSon
	ldr r3, [r2]
	
	mov r4, #0
	
	; chargement de l'index #player 0
	ldr r1, =GestionSon_Index
	ldr r0, [r1, #Player_0]
	
	; si Longueur_Son <= GestionSon_Index
	cmp r3, r0
	ble LPlayer_1

	; récupération du tableau Son
	ldr r2,=Son
	ldrsh r2, [r2, r0, LSL #1]
	lsr r2, r2, #2
	add r4, r2
	
	; post incrémentation du compteur
	add r0,#1		
	str r0,[r1, #Player_0]
	
LPlayer_1
	; chargement de l'index #player 1
	ldr r1, =GestionSon_Index
	ldr r0, [r1, #Player_1]
	
	; si Longueur_Son <= GestionSon_Index
	cmp r3, r0
	ble LPlayer_2
	
	; récupération du tableau Son
	ldr r2,=Son
	ldrsh r2, [r2, r0, LSL #1]
	lsr r2, r2, #2
	add r4, r2
	
	; post incrémentation du compteur
	add r0,#1		
	str r0,[r1, #Player_1]
	
LPlayer_2
	; chargement de l'index #player 2
	ldr r1, =GestionSon_Index
	ldr r0, [r1, #Player_2]
	
	; si Longueur_Son <= GestionSon_Index
	cmp r3, r0
	ble LPlayer_3
	
	; récupération du tableau Son
	ldr r2,=Son
	ldrsh r2, [r2, r0, LSL #1]
	lsr r2, r2, #2
	add r4, r2
	
	; post incrémentation du compteur
	add r0,#1		
	str r0,[r1, #Player_2]
	
LPlayer_3
	; chargement de l'index #player 2
	ldr r1, =GestionSon_Index
	ldr r0, [r1, #Player_3]
	
	; si Longueur_Son <= GestionSon_Index
	cmp r3, r0
	ble LAVG
	
	; récupération du tableau Son
	ldr r2,=Son
	ldrsh r2, [r2, r0, LSL #1]
	lsr r2, r2, #2
	add r4, r2
	
	; post incrémentation du compteur
	add r0,#1		
	str r0,[r1, #Player_3]
	
LAVG	
	; calculs pour la remise à l'échelle
	add r4, #32768
	mov r0, #720
	mul r4, r0
	lsr r4, r4, #16
Return
	; mise à jour de SortieSon
	ldr r1, =SortieSon
	str r4, [r1]
	
	push {lr}
	mov r0, r4
	bl PWM_Set_Value_TIM3_Ch3
	pop {lr}
	pop {r4,r5}
	bx lr
	endp
	
GestionSon_Start proc
	lsr r0, r0, #4
	ldr r1, =GestionSon_Index
	mov r2, #0
	str r2, [r1, r0]
	bx lr
	endp
		
GestionSon_Stop proc
	lsr r0, r0, #4
	ldr r1, =GestionSon_Index
	ldr r2, =LongueurSon
	ldr r2, [r2]
	str r2, [r1, r0]
	bx lr
	endp
	
	END	