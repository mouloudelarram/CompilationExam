#include <stdio.h>

extern int yyparse();

int main() {
    yyparse();
    printf("Programme Valide!\n");
    return 0;
}