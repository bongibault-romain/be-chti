	PRESERVE8
	THUMB   
		

; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly

;Section RAM (read write):
	area    maram,data,readwrite

	export GestionSon_Index
	export SortieSon
		
GestionSon_Index dcd 0
SortieSon dcw 0



; ===============================================================================================
	


		
;Section ROM code (read only) :		
	area    moncode,code,readonly
; écrire le code ici

	import LongueurSon
	import Son

	export GestionSon_callback

; extern Son;
; extern LongueurSon;
; extern GestionSon_Index;
;
; if (GestionSon_Index < Longueur_Son) {
; 	GestionSon_Index = GestionSon_Index + 1;
; 	int Echelle = ((Son[GestionSon_Index] + 32768) * 720) / 65536;
; }
;
; 
;
; return;

GestionSon_callback
	ldr r1, =GestionSon_Index
	ldr r0,[r1]
	
	ldr r2, =LongueurSon
	ldr r3, [r2]
	
	cmp r0, r3
	ble Not_Stop
	bx lr

Not_Stop
	add r0,#1		;l'index est reset
	str r0,[r1] 	;l'index est mis à jour
	
	ldr r2,=Son
	ldrh r3, [r2, r0, LSL #1]
	add r3, #32768
	mov r1, #720
	mul r3, r1
	lsr r3, r3, #16
	
	ldr r1, =SortieSon
	str r3, [r1]
	bx lr
	
	END	