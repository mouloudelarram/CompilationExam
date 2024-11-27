#include <stdio.h>

extern int yyparse(void);
int element;
int ELEMENT_OCCURENCE_EXISTS = 0;

int main(void) {
    yyparse();
    if (ELEMENT_OCCURENCE_EXISTS) {
        printf("Element %d exists in the array.\n", element);
    } else {
        printf("Element %d does not exist in the array.\n", element);
    }
    return 0;
}