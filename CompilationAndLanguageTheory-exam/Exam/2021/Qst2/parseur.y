%{
    #include <stdio.h>
    #include <stdlib.h>
    void yyerror(char *s);
    int yylex(void);    
    extern int element;
    extern int ELEMENT_OCCURENCE_EXISTS;
%}

%union {
    int ival;
}

%token <ival> NUMBER COMMA ELEMENT LIST

%start prog

%%
prog: ELEMENT NUMBER {element = $2;} LIST list 
    ;

list: NUMBER COMMA list {if ($1 == element) ELEMENT_OCCURENCE_EXISTS = 1;}
    | NUMBER {if ($1 == element) ELEMENT_OCCURENCE_EXISTS = 1;}
    ;
%%

void yyerror(char *s) {
    printf("%s\n", s);
    exit(0);
}