%{
    #include <stdio.h>
    #include "parseur.tab.h"
    int yylex();
    int yywrap();
%}

%%
".state" {printf("STATE\n"); return STATE;}
".transition" {printf("TRANSITION\n"); return TRANSITION;}
"," {printf("COMMA\n"); return COMMA;}
":" {printf("COLON\n"); return COLON;}
"->" {printf("ARROW\n"); return ARROW;}
"(" {printf("LPAREN\n"); return LPAREN;}
")" {printf("RPAREN\n"); return RPAREN;}
[0-9]+ {printf("NUMBER %s\n", yytext); return NUMBER;}
[\n] {return EOL;}
. {printf("Error: %s\n", yytext);}
%%

int yywrap()
{
    return 1;
}