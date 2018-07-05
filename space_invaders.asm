jmp main

invaders_pos: var #1
invaders_move: var #2
invaders_clock: var #2
invaders_alive: var #18

you_win: string "Y O U    W I N !"
game_over: string "G A M E    O V E R!"
start_game: string "Press a button to start"

static invaders_pos, #118
static invaders_move, #0
static invaders_move + #1, #0
static invaders_clock, #0
static invaders_clock + #1, #0
static invaders_alive, #0
static invaders_alive + #1, #0
static invaders_alive + #2, #0
static invaders_alive + #3, #0
static invaders_alive + #4, #0
static invaders_alive + #5, #0
static invaders_alive + #6, #0
static invaders_alive + #7, #0
static invaders_alive + #8, #0
static invaders_alive + #9, #0
static invaders_alive + #10, #0
static invaders_alive + #11, #0
static invaders_alive + #12, #0
static invaders_alive + #13, #0
static invaders_alive + #14, #0
static invaders_alive + #15, #0
static invaders_alive + #16, #0
static invaders_alive + #17, #0

spaceship_pos: var #1
spaceship_clock: var #1

static spaceship_pos, #1180
static spaceship_clock, #0

bullet_pos: var #1
bullet_shoot: var #1
bullet_clock: var #1

static bullet_pos, #0
static bullet_shoot, #0
static bullet_clock, #0

main:
	loadn r0, #start_game
	loadn r1, #568
	call print_string
	call press_to_start
	
loop:
	call spaceship_print
	call spaceship_move
	call bullet_att_pos

	call invaders_att_pos
	call verify_win
	jmp loop

end_game:
	
	halt
	
; ----------------------------------- ----------------------------------- -----------------------------------
; -----------------------------------            Acoes da nave            ----------------------------------- 	
; ----------------------------------- ----------------------------------- -----------------------------------
spaceship_move:
	loadn r0, #300
	load r1, spaceship_clock
	inc r1
	store spaceship_clock, r1
	cmp r1, r0
	loadn r1, #0
	store spaceship_clock, r1
	
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
	rts
	
spaceship_right:
	loadn r3, #1
	cmp r2, r3
	jeq spaceship_shoot_return
	call spaceship_delete
	dec r0
	store spaceship_pos, r0
	rts
	
spaceship_left:
	loadn r3, #38
	cmp r2, r3
	jeq spaceship_shoot_return
	call spaceship_delete
	inc r0
	store spaceship_pos, r0
	rts
	
spaceship_shoot:
	load r0, bullet_shoot
	loadn r1, #1
	cmp r1, r0
	jeq spaceship_shoot_return
	store bullet_shoot, r1
	load r0, spaceship_pos
	loadn r1, #40
	sub r0, r0, r1
	store bullet_pos, r0
	call bullet_print
spaceship_shoot_return:
	rts


; ----------------------------------- ----------------------------------- -----------------------------------
; -----------------------------------          Impressao da Nave          -----------------------------------
; ----------------------------------- ----------------------------------- -----------------------------------
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
	
	
; ----------------------------------- ----------------------------------- -----------------------------------
; -----------------------------------            Acoes do Tiro            -----------------------------------
; ----------------------------------- ----------------------------------- -----------------------------------
bullet_att_pos:
	load r0, bullet_clock
	loadn r1, #50
	inc r0
	store bullet_clock, r0
	cmp r0, r1
	jne spaceship_shoot_return
	loadn r0, #0
	store bullet_clock, r0

	load r0, bullet_shoot
	loadn r1, #0
	cmp r0, r1
	jeq spaceship_shoot_return
	
 	call bullet_delete
	load r0, bullet_pos
	loadn r1, #30
	div r0, r0, r1
	loadn r1, #0
	cmp r0, r1
	jne bullet_up
	jmp bullet_end
	
bullet_up:	
	load r0, bullet_pos
	loadn r1, #40
	sub r0, r0, r1
	store bullet_pos, r0
	call bullet_print
	call bullet_colision
	rts
	
bullet_end:
	loadn r0, #0
	store bullet_shoot, r0
	rts
	
bullet_colision:
	loadn r0, #0
	
	loadn r4, #0
	loadn r5, #0

bullet_colision_loop:
	load r1, invaders_pos
	loadn r2, #3
	add r1, r1, r2
	add r6, r5, r4
	add r6, r6, r1
	
	loadn r3, #invaders_alive
	add r2, r3, r0
	loadi r3, r2
	loadn r1, #1
	cmp r1, r3
	jeq bullet_colision_cheked
	
	load r2, bullet_pos
	cmp r6, r2
	jeq bullet_colision_hit
	inc r6
	cmp r6, r2
	jeq bullet_colision_hit
	loadn r1, #40
	add r6, r6, r1
	cmp r6, r2
	jeq bullet_colision_hit
	dec r6
	cmp r6, r2
	jeq bullet_colision_hit
	
bullet_colision_cheked:
	inc r0
	loadn r1, #6
	add r4, r1, r4
	loadn r1, #36
	cmp r4, r1
	jne bullet_colision_loop
	
	loadn r4, #0
	loadn r1, #120
	add r5, r1, r5
	loadn r1, #360
	cmp r5, r1
	jne bullet_colision_loop
	rts
	
bullet_colision_hit:
	loadn r1, #invaders_alive
	add r1, r1, r0
	loadn r0, #1
	storei r1, r0
	
	call delete_invaders
	call print_invaders
	call bullet_delete
	loadn r0, #0
	store bullet_shoot, r0
	rts
	
	
; ----------------------------------- ----------------------------------- -----------------------------------
; -----------------------------------          Impressao do Tiro          -----------------------------------
; ----------------------------------- ----------------------------------- -----------------------------------
bullet_print:
	load r0, bullet_pos
	loadn r1, #'.'
	loadn r2, #2816
	add r1, r1, r2
	
	outchar r1, r0
	rts
	
bullet_delete:
	load r0, bullet_pos
	loadn r1, #127
	
	outchar r1, r0
	rts

; ----------------------------------- ----------------------------------- -----------------------------------
; -----------------------------------           Acao dos Aliens           -----------------------------------
; ----------------------------------- ----------------------------------- -----------------------------------
invaders_att_pos:
	loadn r2, #invaders_clock
	loadi r0, r2
	inc r2
	loadi r1, r2
	
	loadn r3, #1000
	inc r1
	storei r2, r1
	cmp r1, r3
	jne spaceship_shoot_return
	loadn r1, #0
	storei r2, r1
	dec r2
	
	loadn r3, #1
	inc r0
	storei r2, r0
	cmp r0, r3
	jne spaceship_shoot_return
	loadn r0, #0
	storei r2, r0

	loadn r0, #invaders_move
	loadi r1, r0
	inc r0
	loadi r2, r0
	load r3, invaders_pos
	
	loadn r4, #838
	cmp r3, r4
	jeq print_game_over
	
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
	push r0
	push r1
	push r2
	push r3

	call delete_invaders
	
	pop r3
	pop r2
	pop r1
	pop r0
	
	store invaders_pos, r3
	storei r0, r2
	dec r0
	storei r0, r1
	call print_invaders
	rts
; ----------------------------------- ----------------------------------- -----------------------------------
; -----------------------------------        Impressao dos Aliens         -----------------------------------
; ----------------------------------- ----------------------------------- -----------------------------------
print_invaders:
	loadn r0, #0
	load r1, invaders_pos
	loadn r6, #invaders_alive
	loadn r7, #0
	
	
print_invaders_loop_row:	

	loadn r2, #3
	
print_invaders_loop_column:
	mov r3, r2
	add r3, r3, r1

	loadn r4, #1
	add r5, r6, r7
	loadi r5, r5
	cmp r5, r4
	jeq print_invaders_next

	loadn r4, #'*'
	outchar r4, r3
	loadn r5, #40
	inc r3
	outchar r4, r3
	add r3, r3, r5
	outchar r4, r3
	dec r3
	outchar r4, r3
	
print_invaders_next:	
	inc r7
	loadn r5, #6
	add r2, r2, r5
	loadn r5, #39
	cmp r5, r2
	jne print_invaders_loop_column
	
	loadn r2, #6
	cmp r0, r2
	loadn r2, #3
	add r0, r0, r2
	loadn r2, #120
	add r1, r1, r2
	jne print_invaders_loop_row
	rts
	
	
delete_invaders:
	loadn r0, #0
	load r1, invaders_pos
	loadn r4, #127
	
	
delete_invaders_loop_row:	

	loadn r2, #3
	loadn r5, #39
	
delete_invaders_loop_column:
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
	jne delete_invaders_loop_column
	
	loadn r2, #6
	cmp r0, r2
	loadn r2, #3
	add r0, r0, r2
	loadn r2, #120
	add r1, r1, r2
	jne delete_invaders_loop_row

	rts
	
; ----------------------------------- ----------------------------------- -----------------------------------
; -----------------------------------             Fim de Jogo             -----------------------------------
; ----------------------------------- ----------------------------------- -----------------------------------
verify_win:
	loadn r1, #0
	loadn r2, #0
	loadn r3, #18
	
verify_loop:
	loadn r0, #invaders_alive
	add r0, r0, r1
	loadi r4, r0
	cmp r4, r2
	jeq spaceship_shoot_return
	inc r1
	cmp r1, r3
	jne verify_loop
	jmp print_win

press_to_start:
	loadn r0, #255
	inchar r1
	cmp r0, r1
	jeq press_to_start
	call reset_screen
	jmp loop

print_win:
	loadn r0, #you_win
	loadn r1, #572
	call print_string
	jmp end_game

print_game_over:
	loadn r0, #game_over
	loadn r1, #570
	call print_string
	jmp end_game

print_string:
	loadn r3, #'\0'
	loadi r4, r0
	cmp r4, r3
	jeq print_string_end
	outchar r4, r1
	inc r1
	inc r0
	jmp print_string
	
print_string_end:
	rts

reset_screen:
	loadn r0, #1200
	loadn r1, #0
	loadn r2, #127

reset_screen_loop:	
	outchar r2, r1
	inc r1
	cmp r1, r0
	jne reset_screen_loop
	rts