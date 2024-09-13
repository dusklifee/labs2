section .data
    extern numerator_asm, denominator_asm, result_asm
    extern a, b, d

section .bss
    ; Память под переменные, не инициализированные заранее
    numerator_asm resd 1
    denominator_asm resd 1
    result_asm resd 1

section .text
    global calc_asm

calc_asm:
    ; Вычисление числителя: numerator_asm = 2 * d - 96 / a
    mov eax, [d]           ; eax = d
    shl eax, 1             ; eax = 2 * d
    mov ebx, [a]           ; ebx = a
    mov ecx, 96            ; ecx = 96
    xor edx, edx           ; обнуление edx (для деления)
    div ebx                ; ecx / a, результат в eax
    sub eax, ecx           ; eax = 2 * d - (96 / a)
    mov [numerator_asm], eax ; Сохранение результата числителя

    ; Вычисление знаменателя: denominator_asm = 34 / b - a + 1
    mov eax, 34            ; eax = 34
    mov ebx, [b]           ; ebx = b
    xor edx, edx           ; обнуление edx (для деления)
    div ebx                ; eax = 34 / b
    sub eax, [a]           ; eax = (34 / b) - a
    add eax, 1             ; eax = (34 / b) - a + 1
    mov [denominator_asm], eax ; Сохранение результата знаменателя

    ; Проверка на деление на 0
    mov eax, [denominator_asm]
    cmp eax, 0
    je div_by_zero         ; Переход если деление на 0

    ; Вычисление результата: result_asm = numerator_asm / denominator_asm
    mov eax, [numerator_asm]
    mov ebx, [denominator_asm]
    xor edx, edx           ; обнуление edx (для деления)
    div ebx                ; eax = numerator_asm / denominator_asm
    mov [result_asm], eax ; Сохранение результата

    ret

div_by_zero:
    mov dword [result_asm], -1 ; Если деление на 0, результат -1
    ret
