#include <stdio.h>

// Объявление переменных
extern int a, b, d;
extern int numerator_asm, denominator_asm, result_asm;
extern void calc_asm(void);

int main() {
    // Инициализация переменных
    a = 5; // Пример значения
    b = 10; // Пример значения
    d = 20; // Пример значения

    // Вызов ассемблерной функции
    calc_asm();

    // Вывод результатов
    printf("Numerator (ASM): %d\n", numerator_asm);
    printf("Denominator (ASM): %d\n", denominator_asm);
    printf("Result (ASM): %d\n", result_asm);

    // Вычисление на C для проверки
    int numerator = 2 * d - 96 / a;
    int denominator = 34 / b - a + 1;
    int result = (denominator != 0) ? numerator / denominator : -1;

    // Вывод результатов вычислений на C
    printf("Numerator (C): %d\n", numerator);
    printf("Denominator (C): %d\n", denominator);
    printf("Result (C): %d\n", result);

    return 0;
}
