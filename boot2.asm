org 0x500
jmp 0x0000:start

line1 db 'Enchendo o tanque da nave', 0
line2 db 'Verificando motores', 0
line3 db 'Iniciando sistemas', 0
line4 db 'A nave esta pronta para decolar', 0
line5 db 'Decolando', 0
line6 db " [OK]", 0
final db '...', 0

start:
    mov bl, 6
    call clear

    step1:
        mov cx, 3
        mov si, line1
        call printLine

        mov si, final
        call printEnd

        call erase

        mov si, line6
        call printOk
        call newLine

    step2:
        mov cx, 3
        mov si, line2
        call printLine

        mov si, final
        call printEnd

        call erase

        mov si, line6
        call printOk
        call newLine

    step3:
        mov cx, 3
        mov si, line3
        call printLine

        mov si, final
        call printEnd

        call erase

        mov si, line6
        call printOk
        call newLine

    step4:
        mov cx, 3
        mov si, line4
        call printLine

        mov si, final
        call printEnd
        call newLine

    step5:
        mov si, line5
        call printLine
        
        mov si, final
        call printFinal

    xor ax, ax
    mov ds, ax
    mov es, ax

    mov ax, 0x7e0 ;0x7e0<<1 = 0x7e00 (início de kernel.asm)
    mov es, ax
    xor bx, bx    ;posição es<<1+bx

    jmp reset

clear:
    mov ah, 0x2
    mov dx, 0
    mov bh, 0
    int 10h

    mov al, 0x20
    mov ah, 0x9
    mov bh, 0
    mov cx, 1000
    int 10h

    mov bh, 0
    mov dx, 0
    mov ah, 0x2
    int 10h
ret

printLine:
    
    lodsb
    cmp al, 0
    je return

    mov ah, 0xe
    int 10h

    mov dx, 200
    call timing

    jmp printLine

printEnd:

    lodsb
    cmp al, 0
    je return

    mov ah, 0xe
    int 10h

    mov dx, 2000
    call timing

    jmp printEnd

printFinal:

    lodsb
    cmp al, 0
    je return

    mov ah, 0xe
    int 10h

    mov dx, 3000
    call timing

    jmp printFinal

printOk:

    lodsb
    cmp al, 0
    je return

    mov ah, 0xe
    int 10h

    jmp printOk

erase:
    for:
        dec cx
        mov al, 0x08
        mov ah, 0eh
        int 10h

        mov al, ''
        mov ah, 0eh
        int 10h

        mov al, 0x08
        mov ah, 0eh
        int 10h
        cmp cx, 0
        jne for
ret

return:
ret

timing:
    mov bp, dx
    uselessFor:
    dec bp
    nop
    jnz uselessFor
    dec dx
    cmp dx, 0
    jnz uselessFor
ret

newLine:
    mov al, 10
    mov ah, 0eh
    int 10h
    mov al, 13
    mov ah, 0eh
    int 10h
ret

reset:
    mov ah, 00h ;reseta o controlador de disco
    mov dl, 0   ;floppy disk
    int 13h

    jc reset    ;se o acesso falhar, tenta novamente

    jmp load

load:
    mov ah, 02h ;lê um setor do disco
    mov al, 20  ;quantidade de setores ocupados pelo kernel
    mov ch, 0   ;track 0
    mov cl, 3   ;sector 3
    mov dh, 0   ;head 0
    mov dl, 0   ;drive 0
    int 13h

    jc load     ;se o acesso falhar, tenta novamente

    jmp 0x7e00  ;pula para o setor de endereco 0x7e00 (start do kernel)