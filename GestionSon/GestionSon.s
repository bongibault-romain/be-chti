	PRESERVE8
	THUMB   
		

; ====================== zone de r�servation de donn�es,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite

	export GestionSon_Index
		
GestionSon_Index dcd 0
	
; ===============================================================================================
	


		
;Section ROM code (read only) :		
	area    moncode,code,readonly
; �crire le code ici

	import LongueurSon
	import Son

	export GestionSon_callback
	
GestionSon_callback
	ldr r1, =GestionSon_Index
	ldr r0,[r1]
	
	ldr r2, =LongueurSon
	ldr r3, [r2]
	
	add r0,#1
	
	cmp r0, r3
	bne Not_Reset
	mov r0,#0 		;l'index est reset

Not_Reset
	str r0,[r1] 	;l'index est mis � jour
	
	bx lr




		
		
	END	