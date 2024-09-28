section .data
    extern numerator_asm, denominator_asm, result_asm
    extern a, b, d

section .text
    global calc_asm

calc_asm:
    ; Вычисление числителя: numerator_asm = 2 * d - 96 / a
    mov rax, [rel d]       ; rax = d
    shl rax, 1             ; rax = 2 * d
    mov rbx, [rel a]       ; rbx = a
    mov rcx, 96            ; rcx = 96
    cqo                    ; Знаковое расширение для деления
    idiv rbx               ; rcx / a
    sub rax, rcx           ; rax = 2 * d - (96 / a)
    mov [rel numerator_asm], rax ; Сохранение результата числителя

    ; Вычисление знаменателя: denominator_asm = 34 / b - a + 1
    mov rax, 34            ; rax = 34
    mov rbx, [rel b]       ; rbx = b
    cqo                    ; Знаковое расширение для деления
    idiv rbx               ; rax = 34 / b
    sub rax, [rel a]       ; rax = (34 / b) - a
    add rax, 1             ; rax = (34 / b) - a + 1
    mov [rel denominator_asm], rax ; Сохранение результата знаменателя

    ; Проверка на деление на 0
    cmp rax, 0
    je div_by_zero         ; Переход если деление на 0

    ; Вычисление результата: result_asm = numerator_asm / denominator_asm
    mov rax, [rel numerator_asm]
    mov rbx, [rel denominator_asm]
    cqo                    ; Знаковое расширение для деления
    idiv rbx               ; rax = numerator_asm / denominator_asm
    mov [rel result_asm], rax ; Сохранение результата

    ret

div_by_zero:
    mov qword [rel result_asm], -1  ; Если деление на 0, результат -1
    ret
