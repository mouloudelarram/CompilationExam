/*le fichier source doit etre sous forme .element x .list a1,a2,a3,....,an*/

%{
    #include "parseur.tab.h"
    #include <stdio.h>
    #include <stdlib.h>
    int yylex();
    int yywrap();
%}

%%
[0-9]+ { yylval.ival = atoi(yytext); printf("Number: %d\n", yylval.ival);return NUMBER; }
"," { printf("Comma\n"); return COMMA; }
".element " { printf("Element\n"); return ELEMENT; }
".list " { printf("List\n"); return LIST; }
[ \t\n] { /* ignore whitespace */ }
. { printf("Unknown character: %s\n", yytext); }
%%

int yywrap() {
    return 1;
}