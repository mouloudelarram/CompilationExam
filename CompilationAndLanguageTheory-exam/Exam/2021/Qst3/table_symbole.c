// ALP Sidane && EL ARRAM Mouloud
#include "table_symbole.h"

extern int yyerror(char *s);

void initDico(dico *d) {
    d->base = 0;
    d->sommet = 0;
}

void ajouterVariable(dico *d, char *nom, mode mode, n_type *type, int adresse) {
    if (d->sommet >= maxDico) {
        printf("Erreur: Dictionnaire plein\n");
        exit(1);
    }

    variable *v = chercherVariable(d, nom, mode);
    if (v != NULL) {
        printf("Variable %s deja existant\n", nom);
        yyerror("Variable deja existant");

    } else {
        printf("Ajoute de variable %s au table de symboles\n", nom);
        
        variable v;
        v.nom = strdup(nom);
        v.mode = mode;
        v.type = type;
        v.adresse = adresse;
        
        d->tab[d->sommet] = v;
        d->sommet++;
    }
}

variable *chercherVariable(dico *d, char *nom, mode Mode) {
    for (int i = d->sommet - 1; i >= d->base; i--) {
        if (strcmp(d->tab[i].nom, nom) == 0 && d->tab[i].mode == Mode) {
            return &(d->tab[i]);
        }
    }
    
    return NULL;
}

variable *affectationValide(dico *d, char *nom) {
    for (int i = d->sommet - 1; i >= 0; i--) {
        if (strcmp(d->tab[i].nom, nom) == 0) {
            return &(d->tab[i]);
        }
    } 
    printf("Erreur: affectation d'une variable non declrare\n");
    yyerror("Affectation d'une variable non declrare");
        
    exit(0);    
    return NULL;
}

/*
int main() {
    dico d;
    initDico(&d);
    
   
    ajouterVariable(&d, "x", GLOBAL, NULL, 0);
    ajouterVariable(&d, "y", LOCAL, NULL, 1);
    
    variable *v = chercherVariable(&d, "x");
    if (v != NULL) {
        printf("Variable x trouvée\n");
    } else {
        printf("Variable x non trouvée\n");
    }
    
    v = chercherVariable(&d, "z");
    if (v != NULL) {
        printf("Variable z trouvée\n");
    } else {
        printf("Variable z non trouvée\n");
    }
    
    return 0;
}
*/