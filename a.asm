org 0x7c00
jmp 0x0000:start

data:
	lcyan db 11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11
    dblue db 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
    fase db '00101100111',0
start:
	call reset_registers
    call iniciar_video
    
    mov si, fase
    .for:
        lodsb
    loop .for
    push si
	pop si
    cmp al,'0'
    jne l11
        mov si, lcyan
        jmp l11f
    l11:
    mov si, dblue
    l11f:
    call drawImg1
    ;lodsb
    ;cmp al,'0'
    ;jne l12
    ;    mov si, lcyan
    ;    jmp l12f
    ;l12:
    ;mov si, dblue
    ;l12f:
    ;call drawImg2
    ;pop cx
    ;inc cx
    jmp end

reset_registers:

	xor ax, ax
	mov ds, ax
	mov cx, 1
	mov dx, ax
	
	mov si, dblue

	ret
	
iniciar_video:

	mov ah, 4FH
	mov al, 02H
	mov bx, 10H
	int 10h
    ret

start_vivi:
	mov al, 13h
	mov ah, 0
	int 10h
    ret

writePixel:
	mov ah, 0ch
	int 10h
	ret

drawImg1: ;antes de usar, precisamos dizer quem s1 vai pegar
	;call start_vivi
	mov dx, 0
	.for1: 
		cmp dl, 8
		je .endfor1
		mov cx, 0
		.for2:
			cmp cl, 8
			je .endfor2
			lodsb
			call writePixel
			inc cx
			jmp .for2
		.endfor2:
		inc dx
		jmp .for1
	.endfor1:
	ret
    drawImg2: ;antes de usar, precisamos dizer quem s1 vai pegar
	call start_vivi
	mov dx, 0
	.for1: 
		cmp dl, 4
		je .endfor1
		mov cx, 4
		.for2:
			cmp cl, 8
			je .endfor2
			lodsb
			call writePixel
			inc cx
			jmp .for2
		.endfor2:
		inc dx
		jmp .for1
	.endfor1:
	ret
    drawImg3: ;antes de usar, precisamos dizer quem s1 vai pegar
	call start_vivi
	mov dx, 4
	.for1: 
		cmp dl, 8
		je .endfor1
		mov cx, 4
		.for2:
			cmp cl, 8
			je .endfor2
			lodsb
			call writePixel
			inc cx
			jmp .for2
		.endfor2:
		inc dx
		jmp .for1
	.endfor1:
	ret
    drawImg4: ;antes de usar, precisamos dizer quem s1 vai pegar
	call start_vivi
	mov dx, 4
	.for1: 
		cmp dl, 8
		je .endfor1
		mov cx, 4
		.for2:
			cmp cl, 8
			je .endfor2
			lodsb
			call writePixel
			inc cx
			jmp .for2
		.endfor2:
		inc dx
		jmp .for1
	.endfor1:
	ret
    drawImg5: ;antes de usar, precisamos dizer quem s1 vai pegar
	call start_vivi
	mov dx, 4
	.for1: 
		cmp dl, 8
		je .endfor1
		mov cx, 4
		.for2:
			cmp cl, 8
			je .endfor2
			lodsb
			call writePixel
			inc cx
			jmp .for2
		.endfor2:
		inc dx
		jmp .for1
	.endfor1:
	ret
    drawImg6: ;antes de usar, precisamos dizer quem s1 vai pegar
	call start_vivi
	mov dx, 4
	.for1: 
		cmp dl, 8
		je .endfor1
		mov cx, 4
		.for2:
			cmp cl, 8
			je .endfor2
			lodsb
			call writePixel
			inc cx
			jmp .for2
		.endfor2:
		inc dx
		jmp .for1
	.endfor1:
	ret
    drawImg7: ;antes de usar, precisamos dizer quem s1 vai pegar
	call start_vivi
	mov dx, 4
	.for1: 
		cmp dl, 8
		je .endfor1
		mov cx, 4
		.for2:
			cmp cl, 8
			je .endfor2
			lodsb
			call writePixel
			inc cx
			jmp .for2
		.endfor2:
		inc dx
		jmp .for1
	.endfor1:
	ret
    drawImg8: ;antes de usar, precisamos dizer quem s1 vai pegar
	call start_vivi
	mov dx, 4
	.for1: 
		cmp dl, 8
		je .endfor1
		mov cx, 4
		.for2:
			cmp cl, 8
			je .endfor2
			lodsb
			call writePixel
			inc cx
			jmp .for2
		.endfor2:
		inc dx
		jmp .for1
	.endfor1:
	ret


end:
	jmp $

times 510 - ($ - $$) db 0
dw 0xaa55