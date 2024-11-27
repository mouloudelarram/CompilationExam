#include <stdio.h>
#include "table_symbole.h"

extern int yyparse();

dico d;
FILE *file;
int DeclationVariable = 1;
int t = 0;
int Adresse = -1;
mode Mode = GLOBAL;

int main() {
    file = fopen("mips.asm", "w");
    fprintf(file, ".data\n");
    if (file == NULL) {
        printf("Erreur lors de l'ouverture du fichier\n");
        return 1;
    }

    initDico(&d);
    int rep =yyparse();
    if (rep == 0) {
        printf("Programme Valide\n");
        fprintf(file, "fin:\n# li $v0, 1\n# move $a0, $t0\n# syscall\n");
        fclose(file);    
    }
    else
        printf("Programme Invalide\n");
    return rep;
    
} 