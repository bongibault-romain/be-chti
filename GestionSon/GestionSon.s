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

	export GestionSon_callback
	
GestionSon_callback
	ldr r1, =GestionSon_Index
	ldr r0,[r1]
	add r0,#1
	str r0,[r1]
	bx lr




		
		
	END	