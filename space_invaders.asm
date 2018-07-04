jmp main

invaders_pos: var #1
invaders_move: var #2

spaceship_pos: var #1

bullet_pos: var #1
bullet_shoot: var #1

main:
	
	loadn r0, #118
	store invaders_pos, r0
	loadn r0, #1180
	store spaceship_pos, r0
	loadn r0, #0
	store bullet_shoot, r0
	
	loadn r0, #invaders_move
	loadn r1, #0
	storei r0, r1
	inc r0
	storei r0, r1
	
;;	call spaceship_print
	
loop:
	call spaceship_print
	call spaceship_move

;	call invaders_att_pos
;	call print_invaders
;	call delete_invaders
	jmp loop
	halt
	
spaceship_move:
	load r0, spaceship_pos
	inchar r1
	loadn r3, #40
	mod r2, r0, r3
	
	loadn r3, #'a'
	cmp r1, r3
	jeq spaceship_right
	loadn r3, #'d'
	cmp r1, r3
	jeq spaceship_left
	loadn r3, #'s'
	cmp r1, r3
	jeq spaceship_shoot
	jmp spaceship_move_return
	
spaceship_right:
	loadn r3, #1
	cmp r2, r3
	jeq spaceship_move_return
	call spaceship_delete
	dec r0
	jmp spaceship_move_return
	
spaceship_left:
	loadn r3, #38
	cmp r2, r3
	jeq spaceship_move_return
	call spaceship_delete
	inc r0
	jmp spaceship_move_return

spaceship_move_return:
	store spaceship_pos, r0
	rts

spaceship_print:
	load r0, spaceship_pos
	loadn r1, #'A'
	loadn r2, #2304
	add r1, r1, r2
	
	outchar r1, r0
	rts
	
spaceship_delete:
	load r0, spaceship_pos
	loadn r1, #127
	loadn r2, #2304
	add r1, r1, r2
	
	outchar r1, r0
	rts
	
spaceship_shoot:
	load r0, spaceship_pos
	loadn r1, #40
	add r0, r0, r1
	store bullet_pos, r0
	loadn r1, #1
	store bullet_shoot, r1
	rts
	
bullet_print:
	load r0, bullet_shoot
	loadn r1, #1
	cmp r0, r1
	jeq bullet_print_return
	
	load r0, bullet_pos
	loadn r1, #'.'
	loadn r2, #2816
	add r1, r1, r2
	
	outchar r1, r0
	rts
	
bullet_print_return:
	rts

invaders_att_pos:
	loadn r0, #invaders_move
	loadi r1, r0
	inc r0
	loadi r2, r0
	load r3, invaders_pos
	
	loadn r4, #878
	cmp r3, r4
	jeq invaders_att_return
	
	loadn r4, #3
	cmp r2, r4
	jeq invaders_down
	
	loadn r4, #1
	cmp r1, r4
	jeq invaders_left
			
invaders_right:
	inc r2
	loadn r4, #2
	add r3, r3, r4
	jmp invaders_att_return
	
invaders_left:
	inc r2
	loadn r4, #2
	sub r3, r3, r4
	jmp invaders_att_return
	

invaders_down:	
	loadn r2, #0
	loadn r4, #40
	add r3, r3, r4
	
	inc r1
	loadn r4, #2
	mod r1, r1, r4
	jmp invaders_att_return
	
invaders_att_return:
	store invaders_pos, r3
	storei r0, r2
	dec r0
	storei r0, r1
	rts

print_invaders:
	loadn r0, #0
	load r1, invaders_pos
	loadn r4, #'*'
	
	
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
	