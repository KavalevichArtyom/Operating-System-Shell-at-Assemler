include 'emu8086.inc'

pointer macro a, b
    
    mov ah, 02h
    mov dh, a
    mov dl, b
    mov bh, 0
    int 10h 
       
endm    
   
   
   
printStr macro a
    
   mov ah, 09h
   mov dx, offset a
   int 21h
       
endm      
  
  
  
tak macro
    
    pointer 18, 30
    printStr pla
 
    pointer 19, 30   
    printStr _pla    

    pointer 20, 30    
    printStr _pla_      
    
endm
  
  
  
mainMenu macro
   
    _cikl:
    
    cmp proverka, 1
    jz cc
    
    pointer 0, 0
    printStr wert    
    
    draw 43h,  1,  10, 20, 12    
    draw 13h,  15, 0,  20, 9      
    draw 43h,  1,  66, 20, 68  
    draw 13h,  15, 69, 20, 79
    draw 33h,  21, 0,  22, 79 
    
    pointer 6,  30
    printStr _wert
    
    pointer 8,  30
    printStr _wert_
    
    pointer 10, 30
    printStr __wert_
    
    pointer 12, 30    
    printStr __wert__
    
    pointer 14, 30     
    printStr ___wert__
    
    pointer 16, 30    
    printStr ___wert___

    cc:           

    pointer 16, 48
    mov proverka, 0 
         
    mov cx, 30
    mov ah, 01
    xor si, si
    int 21h   
    
    ;============Word_processor==========   
    mov buf_main_menu[si], al
    cmp buf_main_menu[si], 49
    jz  yes
    jmp no
    
    yes:    
        push di
        push bx
        push dx
        push ax
        push cx 
        
            fonWordProcessor
            console string, 10
             
        pop cx
        pop ax
        pop dx
        pop bx
        pop di

    no:
    ;================gameSnake=============
        mov buf_main_menu[si], al
        cmp buf_main_menu[si], 50
        jz  _yes
        jmp _no   
    
    _yes:   
        push di
        push bx
        push dx
        push ax
        push cx
        
            Fon_games
        
        pop cx
        pop ax
        pop dx
        pop bx 
        pop di

    _no:
    ;================gameSnake=============
        mov buf_main_menu[si], al
        cmp buf_main_menu[si], 51
        jz  _yes_
        jmp _no_
    
    _yes_:    
        push di
        push bx
        push dx
        push ax
        push cx
        
            tak  
            add proverka, 1
                       
        pop cx                                                                     
        pop ax
        pop dx
        pop bx 
        pop di
         
         
    _no_:
    ;==================Exit============
        cmp buf_main_menu[si], 52
        jz  _end_
        inc si      
    
    loop _cikl 
        _end_:
        call  CLEAR_SCREEN 
endm 
     
     

draw macro a, b, c, d,  e  
    
    mov ah, 06h
    mov al, 00h 
    mov bh, a
    mov ch, b;stroka
    mov cl, c;Stolbec
    mov dh, d
    mov dl, e
    int 10h   
       
endm    
  
  
  
Fon_games  macro     
    
    call  CLEAR_SCREEN    
  
    draw 43h,  4,  10, 10, 12  
    draw 43h,  4,  10, 4,  54         
    draw 33h,  10, 10, 10, 70 
    draw 33h,  10, 69, 19, 70
    draw 53h,  19, 50, 19, 70
    draw 53h,  19, 5,  19, 40
    draw 83h,  13, 5,  17, 20 
    draw 83h,  17, 30, 13, 40
    draw 23h,  4,  60, 4,  79 
    draw 23h,  13, 55, 15, 65 
   
    mov di, 3360
    mov si, offset text2
    mov cx, 80
    mov ah, 05h
    
    for1: lodsb
       stosw
    loop for1  
    
    pointer 22, 35 
    printStr __pla_  

    mov di, 3680
    mov si, offset settingsGames
    mov cx, 23
    mov ah, 03h  
    
    s: lodsb
       stosw
    loop s 
    
    pointer 23, 61
    printStr __pla__ 
    pointer 23, 79
    
    mov cx, 20
    mov ah, 01
    xor si, si
    
    r2:
        int 21h 
        
        ;================New===============   
        mov buf_games[si], al
        cmp buf_games[si], 49
        jz  x2
        jmp e2
        
        x2: 
            push di
            push bx
            push dx
            push ax
            push cx
                gameSnake
            pop cx
            pop ax
            pop dx
            pop bx 
            pop di 
        
        e2:
            cmp buf_games[si], 50
            jz  g2
            inc si  
    
    loop r2    
    
    g2:  
    call    CLEAR_SCREEN 
    ;mainMenu 
endm
 
 
 
gameSnake macro
    
    local back1, next1, next2, next3, next4, next5, exit, koadla                
        
    pointer 12, 40    
    xor dx, dx   
    
    back1:
        add dlina_zm, 1
        ;input command from key
        mov ah, 0
        int 16h
        ;analizing
        ;key "S"
        cmp zmejka,0
        jnz exit2  
        
        mov ddn,    dh
        mov dup1,   dh
        mov dleft,  dl
        mov dright, dl  
        
    exit2:
        cmp zmejka, 1
        jnz exit3       
        
        mov dddn,   dh
        mov ddup1,  dh
        mov ddleft, dl
        mov ddright,dl  
        
    exit3:
        cmp zmejka, 2
        jnz exit4  
        
        mov addn,   dh
        mov adup1,  dh
        mov adleft, dl
        mov adright,dl        
        
    exit4:     
        cmp zmejka, 3
        jnz exit5   
        
        mov qddn,   dh
        mov qdup1,  dh
        mov qdleft, dl
        mov qdright,dl      
        
    exit5:    
        cmp zmejka, 4
        jnz exit6     
        
        mov zddn,   dh
        mov zdup1,  dh
        mov zdleft, dl
        mov zdright,dl 
        
    exit6:
        mov dn,     dh
        mov up,     dh
        mov left,   dl
        mov right,  dl
        
        add zmejka, 1
        cmp zmejka, 6
        jnz koadla
        
        push dx
        
        mov dh, ddn
        mov dh, dup1
        mov dl, dleft
        mov dl, dright
        
            draw 00h, ddn, dleft, dup1, dright 
        
             
            mov ddn,    0
            mov dup1,   0
            mov dleft,  0
            mov dright, 0
            
            mov dh, dddn
            mov dh, ddup1
            mov dl, ddleft
            mov dl, ddright
        
            draw 00h, dddn, ddleft, ddup1, ddright 
             
            mov dddn,   0
            mov ddup1,  0
            mov ddleft, 0
            mov ddright,0  
            
            mov dh, addn
            mov dh, adup1
            mov dl, adleft
            mov dl, adright
            
            draw 00h, addn, adleft, adup1, adright
            
             
            mov addn,   0
            mov adup1,  0
            mov adleft, 0
            mov adright,0 
            
            mov dh, qddn
            mov dh, qdup1
            mov dl, qdleft
            mov dl, qdright
           
            draw 00h, qddn, qdleft, qdup1, qdright    
             
            mov qddn,   0
            mov qdup1,  0
            mov qdleft, 0
            mov qdright,0 
            
            mov dh, zddn
            mov dh, zdup1
            mov dl, zdleft
            mov dl, zdright
            
            draw 00h, zddn, zdleft, zdup1, zdright
               
            mov zddn,   0
            mov zdup1,  0
            mov zdleft, 0
            mov zdright,0
            pop dx
            
        mov zmejka, 0
    
    koadla:  
        cmp al, 115
        jnz next1
        inc dh  
        
        mov ah, 02h
        int 10h 
        
        mov ah, 0Ah
        mov al, 178
        mov bh, 0
        mov cx, 1
        int 10h
    
    next1:
    ;key "D"
        cmp al, 100
        jnz next2
        inc dl  
        
        mov ah, 02h
        Int 10h
        
        mov ah, 0Ah
        mov al, 178        
        mov bl, 9
        mov bh, 0
        mov cx, 1
        int 10h 
    
    next2:
    ;key "W"
        cmp al, 119
        jnz next3
        dec dh  
        
        mov ah, 02h
        Int 10h  
        
        mov ah, 0Ah
        mov al, 178
        mov bl, 9
        mov bh, 0
        mov cx, 1
        int 10h
    
    next3:
    ;key "A"
        cmp al, 97
        jnz next4       
        dec dl      
        
        mov ah, 02h
        Int 10h   
        
        mov ah, 0Ah
        mov al, 178
        mov bl, 9
        mov bh, 0
        mov cx, 1
        int 10h
    
    next4:
    ;clear screan "N"
        cmp al, 09
        jnz next5
        xor dx, dx
    
    next5:
    ;exit "Enter"
        cmp al, 13
        jz exit
        jmp back1 
    
    exit:
        pointer 23, 79 
endm
  
  
  
newLine macro op1 
    
    mov cx, cikl 
    add si, cikl
    mov ah, 05
    add dlina_stroki, 80 
    
    printn op1
    mov cikl, 80 

endm
     
     
     

console macro a1, b1 
    
    pointer 23, 40
    printStr __text_    
    pointer 23, 58     
     
    mov cx, b1
    mov ah, 01
    xor si, si
    
    r1:
        int 21h 
        ;================New===============   
        mov a1[si], al
        cmp a1[si], 49
        jz  x1
        jmp e1    
        
        x1:
            push di
            push bx
            push dx
            push ax
            push cx       
            
                newFile    
            
            pop cx
            pop ax
            pop dx
            pop bx 
            pop di
        
        e1:
        ;================save==============
            mov a1[si], al
            cmp a1[si], 50
            jz  x4
            jmp e4   
        
        x4:
            push di
            push bx
            push dx
            push ax
            push cx     
            
                save  
            
            pop cx
            pop ax
            pop dx
            pop bx
            pop di
        
        e4:
        ;=================open=============
            mov a1[si], al
            cmp a1[si], 51
            jz  x3
            jmp e3 
            
            x3:
                push di
                push bx
                push dx
                push ax
                push cx 
                
                    open 
                    printFile
                    pointer 23, 58
                    
                pop cx
                pop ax
                pop dx
                pop bx 
                pop di
        
        e3:
        ;==================Exit============
            cmp a1[si], 52
            jz  g1
            inc si  
        
    loop r1    
    
    g1: 
        xor si, si 
        call  CLEAR_SCREEN

endm
   
 
   
comStr macro a, b
    
    pointer 22, 0 
    printStr __text__ 
    
    pointer 23, 0 
    printStr ___text__
         
endm    



inputConsole macro a, b  
    
    mov cx, b
    mov ah, 01
    xor si, si
    
    r:
        int 21h
        
        add dlina_stroki,1
        dec cikl 
        
        mov a[si],al
        cmp a[si],13 
        jz  x
        jmp e   
        
        x: 
            push di
            push bx
            push dx
            push ax
            push cx 
            
                newLine '' 
            
            pop cx
            pop ax
            pop dx
            pop bx 
            pop di
        
        e:
            cmp a[si], 09
            jz  g
            inc si
    loop r 
    
    g:
      
endm
  
  
    
newFile macro 
     
    pointer 4, 0                 
    inputConsole namepar, 254   
    pointer 23, 58
        
    sub dlina_stroki, 2
    sub dlina_stroki, 1
      
endm   
     
     
     
save macro
   
    comStr  filename, 100;   
     
    mov ah, 3Ch	;функция создания файла
	mov cx, 0	;без атрибутов
	mov dx, offset filename	;адрес имени файла
	int 21h     
	
	mov handle, ax	;сохраняем дескриптор файла
	 
	mov ah, 3Dh	;функция открытия файла
	mov al, 2	;доступ для чтения-записи
	mov dx, offset filename	;адрес имени файла
	int 21h 
	
	mov handle, ax	;сохраняем дескриптор файла
    
    ; установим указатель
    ; запишем строку в файл
    
    mov ah, 42h	;функция установки указателя
	mov al, 0	;от начала файла
	mov bx, handle	;дескриптор
	mov cx, 0	;старшая половина указателя
	mov dx, 9	;младшая половина указателя         
	mov dx, 0	;младшая половина указателя
	int 21h	
	 
	mov ah, 3Fh	;функция чтения
   	mov bx, handle	;дескриптор
   	mov cx, dlina_stroki	;столько читать
   	mov dx, offset namepar 	;читать в буфер по этому адресу
   	int 21h
   	
   	mov cx, ax	; столько реально прочитали 
   	
    ; запишем строку в файл
	mov ah, 40h	;функция записи
	mov bx, handle	;дескриптор
	mov cx, dlina_stroki	;длина строки
	mov dx, offset namepar	;адрес строки
	int 21h
    
    ;закроем файл (нет необходимости, если не нужно читать повторно)
	mov ah, 3Eh	;функция закрытия
	mov bx, handle	;дескриптор
	int 21h
	
	pointer 23, 58
	 	    
endm 
  
  
  
open macro
    
    
    push di
    push bx
    push dx
    push ax
    push cx
    
        fonText 4, 0, 19, 79
    
    pop cx
    pop ax
    pop dx
    pop bx 
    pop di
         
    ; откроем файл
	mov ah, 3Dh	;функция открытия файла
	mov al, 2	;доступ для чтения-записи
	mov dx, offset filename	;адрес имени файла
	int 21h
	
	mov handle1, ax	;сохраняем дескриптор файла
    
    mov ah, 42h	;функция установки указателя
	mov al, 0	;от начала файла
	mov bx, handle1	;дескриптор
	mov cx, 0	;старшая половина указателя
    mov dx, 9	;младшая половина указателя  
	mov dx, 0	;младшая половина указателя
	int 21h	
    
    xor cx, cx
    
	mov ah, 3Fh	;функция чтения
	mov bx, handle1	;дескриптор dlina_stroki
	mov cx, len	;столько читать 
	mov cx, dlina_stroki	;столько читать
	mov dx, offset namepar1	;читать в буфер по этому адресу
	int 21h   
	
endm	 
 
 
      
fonText macro a, b, c, d
    
    mov ah, 06h
    mov al, 00h 
    mov bh, 00h
    mov ch, a;stroka
    mov cl, b;Stolbec
    mov dh, c
    mov dl, d
    int 10h
    
endm       
      
  
      
printFile macro    
   
   mov di, 640 
   
   push cx   
   
       mov ah,  07h 
       mov cx,  len  
       mov cx,  dlina_stroki
       mov si,  offset namepar1
       
       nw: lodsb
           stosw
       loop nw 
   
   pop cx 
   
   mov dlina_stroki,0
          
endm    
      
      
      
fonWordProcessor macro
   
   call  CLEAR_SCREEN 
   
   mov di,  0
   mov si,  offset text
   mov cx,  80
   mov ah,  05h
   
   a: lodsb
       stosw
   loop a   
    
   pointer 1, 0
   printStr text1   
    
   mov di,  320
   mov si,  offset text2
   mov cx,  80
   mov ah,  05h
   
   for: lodsb
      stosw
   loop for   
    
   mov di,  3360
   mov si,  offset text2
   mov cx,  80
   mov ah,  05h 
   
   for7: lodsb
       stosw
   loop for7
      
endm 



screen macro a,b,c,d
    
    mov ax, 3
    int 10h 
    
    mov ax, 0B800h
    mov es, ax
    mov di, 0 
    mov ax, 0FDBh
    
    
    draw 93h,  7,  28, 10, 39 
    draw 93h,  7,  43, 10, 54
    draw 93h,  12, 28, 15, 39
    draw 93h,  12, 43, 15, 54
    
    cmp load, 0
    jnz a       
    
    mov di, 2794    
    mov si, offset loading
    mov cx, 8
    mov ah, 05h
   
    b: lodsb
       stosw
    loop b
    
    a:   
        cmp load, 1
        jnz c       
        
        mov di, 2794
        mov si, offset vikl
        mov cx, 8
        mov ah, 05h
    
    d: lodsb
       stosw
    loop d
    
    c:    
        add load, 1 
    
endm



statusBar  macro a
   

    mov ax, 0B800h
    mov es, ax 
    mov ax, 0FDBh 
     
    mov di, 3840  
    mov ah, 05h
    mov cx, 40
    
    a:  push cx
        mov cx, 2
        rep stosw
        pop cx 
        
    loop a  
endm 

  
  
data segment                     
    
    namepar     db 254 dup(' '), '$', 10, 13
    namepar1    db 254 dup(' '), '$', 10, 13


    dlina_zm db 0 

    zddn    db 0
    zdup1   db 0 
    zdleft  db 0
    zdright db 0

    qddn    db 0
    qdup1   db 0 
    qdleft  db 0
    qdright db 0

    addn    db 0
    adup1   db 0 
    adleft  db 0
    adright db 0

    ddn     db 0
    dup1    db 0 
    dleft   db 0
    dright  db 0
 
    dddn    db 0
    ddup1   db 0 
    ddleft  db 0
    ddright db 0

    dn      db 0 
    up      db 0 
    left    db 0
    right   db 0 

    zmejka  db 0 

    load    db 0

    dlina_stroki    dw  0 
    buf_games       db  20 dup(' ')
    string          db  5 dup(' ') 
    cikl            dw  80
    buf_main_menu   db  100 dup(' ')
    filename        db  'your_name_file.TXT ',0 
    __text_         db  'Enter the command:$'
    __text__        db  'The path to the file:$'
    ___text__       db  'C:\emu8086\MyBuild\your_name_file.TXT$' 
    _text_          db  '________________________________||MAIN MENU||___________________________________'  
    text            db  '_________________________________WORD PROCESSOR_________________________________' ;Title
    text1           db  '<TAB> - End offer <1> - New File   <2> - save File  <3> - open File  <4> - Exit$' ;Function    
    text2           db  '________________________________________________________________________________'  
    settingsGames   db  '<1> - Start  <2> - Exit',0                               
    loading         db  'starting'
    vikl            db  'shutdown'
    wert            db  '________________________________||MAIN MENU||___________________________________$' 
    _wert           db  '--------Hellp-------$' 
    _wert_          db  '<1> - Word Processor$'
    __wert_         db  '<2> - Game Snake$'
    __wert__        db  '<3> - About this developer$'
    ___wert__       db  '<4> - Exit$' 
    ___wert___      db  'Enter the command:$'
    pla             db  'Developed Kavalevich Artyom$'
    _pla            db  'The student group PZT-25$'
    _pla_           db  '@2015$'
    __pla_          db  'Action worm$' 
    __pla__         db  'Enter the command:$'
    proverka        db  ?
    handle	        dw  ?  
    handle1	        dw	?


    lf1     = 10
    cr1     = 4
    cr      = 4		; возврат каретки
    lf      = 10	; перевод строки 
    stdout1 = 1	 
    stdout  = 2
    str_len = $-string
    len     = $-string
	
ends

stack segment
    dw  256  dup(0)
ends

code segment
    
start:
    mov ax, data
    mov ds, ax
    mov es, ax  
   

    mov ax, 3
    int 10h 
    mov ax, 0B800h
    mov es, ax
    mov di, 0
    mov ax, 0FDBh 
    
    screen t, at, tt, tat
    statusBar a1
    
    call  CLEAR_SCREEN
    mainMenu
     
    screen _t, _at, _tt, _tat
    statusBar a_1
    
mov ax, 4c00h
int 21h  

ends
    DEFINE_PTHIS
    DEFINE_CLEAR_SCREEN
end start