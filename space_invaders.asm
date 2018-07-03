jmp main

invaders_pos: var #1

main:
	
	loadn r1, #118
	store invaders_pos, r1
	
	#880

;	call print_invaders
;	call delete_invaders
;		
;	loadn r1, #120
;	store invaders_pos, r1

;	call print_invaders
;	call delete_invaders
;		
;	loadn r1, #122
;	store invaders_pos, r1

;	call print_invaders
;	call delete_invaders
		
;;	loadn r1, #124
;	store invaders_pos, r1
;
;	call print_invaders
;	call delete_invaders
;;		
;	loadn r1, #164
;	store invaders_pos, r1
;
;	call print_invaders
;	call delete_invaders
		
;	loadn r1, #162
;	store invaders_pos, r1
;
;	call print_invaders
;	call delete_invaders
;		
;	loadn r1, #160
;	store invaders_pos, r1
;
;	call print_invaders
;	call delete_invaders
;		
;	loadn r1, #158
;	store invaders_pos, r1
;
;	call print_invaders
;	call delete_invaders
;	
	halt


print_invaders:
	loadn r0, #0
	load r1, invaders_pos
	loadn r4, #'A'
	
	
print_invaders_loop_linha:	

	loadn r2, #3
	loadn r5, #39
	
print_invaders_loop_coluna:
	mov r3, r2
	add r3, r3, r1

	outchar r4, r3
	loadn r6, #40
	inc r3
	outchar r4, r3
	add r3, r3, r6
	outchar r4, r3
	dec r3
	outchar r4, r3
	
	loadn r6, #6
	add r2, r2, r6
	cmp r5, r2
	jne print_invaders_loop_coluna
	
	loadn r2, #6
	cmp r0, r2
	loadn r2, #3
	add r0, r0, r2
	loadn r2, #120
	add r1, r1, r2
	jne print_invaders_loop_linha

	loadn r0, #65535
	loadn r1, #0
	
print_invaders_delay0:
	inc r1
	cmp r0, r1
	jne print_invaders_delay0

	loadn r0, #65535
	loadn r1, #00
	
print_invaders_delay1:
	inc r1
	cmp r0, r1
	jne print_invaders_delay1

	loadn r0, #65535
	loadn r1, #0
	
print_invaders_delay2:
	inc r1
	cmp r0, r1
	jne print_invaders_delay2

	loadn r0, #65535
	loadn r1, #0

print_invaders_delay3:
	inc r1
	cmp r0, r1
	jne print_invaders_delay3

	loadn r0, #65535
	loadn r1, #00
	
print_invaders_delay4:
	inc r1
	cmp r0, r1
	jne print_invaders_delay4

	loadn r0, #65535
	loadn r1, #0
	
print_invaders_delay5:
	inc r1
	cmp r0, r1
	jne print_invaders_delay5

	loadn r0, #65535
	loadn r1, #0
	
print_invaders_delay6:
	inc r1
	cmp r0, r1
	jne print_invaders_delay6

	loadn r0, #65535
	loadn r1, #0
	
print_invaders_delay7:
	inc r1
	cmp r0, r1
	jne print_invaders_delay7

	loadn r0, #65535
	loadn r1, #0
	
print_invaders_delay8:
	inc r1
	cmp r0, r1
	jne print_invaders_delay8

	loadn r0, #65535
	loadn r1, #0
	
print_invaders_delay9:
	inc r1
	cmp r0, r1
	jne print_invaders_delay9
	rts
	
	
	
delete_invaders:
	loadn r0, #0
	load r1, invaders_pos
	loadn r4, #127
	
	
delete_invaders_loop_linha:	

	loadn r2, #3
	loadn r5, #39
	
delete_invaders_loop_coluna:
	mov r3, r2
	add r3, r3, r1

	outchar r4, r3
	loadn r6, #40
	inc r3
	outchar r4, r3
	add r3, r3, r6
	outchar r4, r3
	dec r3
	outchar r4, r3
	
	loadn r6, #6
	add r2, r2, r6
	cmp r5, r2
	jne delete_invaders_loop_coluna
	
	loadn r2, #6
	cmp r0, r2
	loadn r2, #3
	add r0, r0, r2
	loadn r2, #120
	add r1, r1, r2
	jne delete_invaders_loop_linha

	rts
	