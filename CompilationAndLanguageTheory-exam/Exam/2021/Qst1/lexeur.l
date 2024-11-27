%{
    #include "parseur.tab.h"
    #include <stdio.h>
    int yylex(void);
    int yywrap(void);
%}

%%

"CREATE TABLE" {return CREATE_TABLE;}
"CONSTRAINT" {return CONSTRAINT;}
"PRIMARY KEY" {return PRIMARY_KEY;}
"REFERENCES" {return REFERENCES;}
"FOREIGN KEY" {return FOREIGN_KEY;}
"NOT NULL" {return NOT_NULL;}
"DATE" {return DATE;}
"VARCHAR2" {return VARCHAR2;}
"NUMBER" {return NUMBER;}
[0-9]+ {return INTEGER;}
[A-Za-z0-9]+ {return IDENTIFIER;}
"(" {return OPEN_PAREN;}
")" {return CLOSE_PAREN;}
"," {return COMMA;}
";" {return SEMICOLON;}
[ \t\n]   { /* Ignore whitespaces and newlines */ }
. {return yytext[0];}

%%

int yywrap(void) {
    return 1;
}