%{
#include "parseur.tab.h"
%}

%%

"int"       { return INT; }
"("         { return LPAREN; }
")"         { return RPAREN; }
","         { return COMMA; }
"*"         { return STAR; }
"="         { return EQUAL; }
[ \t\n]     ; // Ignore whitespace

[a-zA-Z_][a-zA-Z0-9_]*  { yylval.strValue = strdup(yytext); return IDENTIFIER; }
[0-9]+                  { yylval.intValue = atoi(yytext); return NUMBER; }

. { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
