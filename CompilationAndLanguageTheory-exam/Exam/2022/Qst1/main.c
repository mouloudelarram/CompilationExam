#include <stdio.h>

extern int yyparse();

int main() {
    if (yyparse() == 0) {
        printf("Parsing successful!\n");
    } else {
        printf("Parsing failed!\n");
    }

    return 0;
}