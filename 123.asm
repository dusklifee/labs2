section .data
    numerator_asm dq 0         ; Переменные для хранения числителя, знаменателя и результата
    denominator_asm dq 0
    result_asm dq 0
    a dq 5                     ; Пример значений для a, b и d
    b dq 3
    d dq 7

section .text
    ; Вычисление числителя: numerator_asm = 2 * d - 96 / a
    mov rax, [d]           ; rax = d
    shl rax, 1             ; rax = 2 * d
    mov rbx, [a]           ; rbx = a
    mov rcx, 96            ; rcx = 96
    cqo                    ; Знаковое расширение для деления
    idiv rbx               ; rcx / a
    sub rax, rcx           ; rax = 2 * d - (96 / a)
    mov [numerator_asm], rax ; Сохранение результата числителя

    ; Вычисление знаменателя: denominator_asm = 34 / b - a + 1
    mov rax, 34            ; rax = 34
    mov rbx, [b]           ; rbx = b
    cmp rbx, 0             ; Проверка деления на 0
    je div_by_zero         ; Переход, если b == 0
    cqo                    ; Знаковое расширение для деления
    idiv rbx               ; rax = 34 / b
    sub rax, [a]           ; rax = (34 / b) - a
    add rax, 1             ; rax = (34 / b) - a + 1
    mov [denominator_asm], rax ; Сохранение результата знаменателя

    ; Проверка знаменателя на 0
    cmp rax, 0
    je div_by_zero         ; Переход если деление на 0

    ; Вычисление результата: result_asm = numerator_asm / denominator_asm
    mov rax, [numerator_asm]
    mov rbx, [denominator_asm]
    cqo                    ; Знаковое расширение для деления
    idiv rbx               ; rax = numerator_asm / denominator_asm
    mov [result_asm], rax  ; Сохранение результата

    jmp end                ; Переход в конец программы

div_by_zero:
    mov qword [result_asm], -1  ; Если деление на 0, результат -1

end:
    ; Программа завершена
