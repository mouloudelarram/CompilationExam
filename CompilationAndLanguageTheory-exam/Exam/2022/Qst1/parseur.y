%{
    /* La grammaire est de type LL(1), car elle peut être analysée de gauche à droite avec une recherche d'un symbole d'anticipation et une avance d'un seul symbole. */
    /* La grammaire n'est pas ambiguë car chaque symbole d'entrée a une seule interprétation possible lors de l'analyse syntaxique. */

    #include <stdio.h>
    #include <stdlib.h>
    void yyerror(char *s);
    int yylex();    
%}

%token NUMBER COMMA STATE TRANSITION COLON ARROW LPAREN RPAREN EOL

%start prog

%%
prog: STATE NUMBER EOL marquage_list TRANSITION EOL transaction_list { }
    ;

marquage_list: NUMBER COLON NUMBER EOL { }
    | marquage_list NUMBER COLON NUMBER EOL { }
    ;

transaction_list: NUMBER COLON LPAREN number_list RPAREN ARROW LPAREN number_list RPAREN { }
    | transaction_list NUMBER EOL COLON LPAREN number_list RPAREN ARROW LPAREN number_list RPAREN { }
    ;

number_list: NUMBER { }
    | number_list COMMA NUMBER { }
    ;

%%

void yyerror(char *s) {
    printf("%s\n", s);
    exit(0);
}