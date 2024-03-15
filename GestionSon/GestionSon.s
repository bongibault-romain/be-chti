	PRESERVE8
	THUMB   
		

; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite

	export GestionSon_Index
		
GestionSon_Index dcd 0
	
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
; GestionSon_Index = GestionSon_Index + 1;
; if (GestionSon_Index == Longueur_Son) {
; 	GestionSon_Index = 0;
; }
;
; int Echelle = ((Son[GestionSon_Index] + 32768) * 720) / 65536;
;
; return;

GestionSon_callback
	ldr r1, =GestionSon_Index
	ldr r0,[r1]
	
	ldr r2, =LongueurSon
	ldr r3, [r2]
	
	add r0,#1
	
	cmp r0, r3
	beq Not_Reset
	mov r0,#0

Not_Reset
	str r0,[r1]
	bx lr




		
		
	END	