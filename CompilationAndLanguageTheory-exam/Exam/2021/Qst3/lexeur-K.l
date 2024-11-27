%{
#include "parseur-K.tab.h"
#include <stdio.h>
#include <string.h>
int yyerror(char *s);
%}



%%

"+"                     { /*printf("ADD\n  ");     */return ADD;   }
"-"                     { /*printf("SUB\n");       */return SUB;   }
"*"                     { /*printf("MUL\n");       */return MUL;   }
"=="                    { /*printf("EQ\n");        */return EQ;    }
"<"                     { /*printf("LT\n");        */return LT;    }
"<="                    { /*printf("LE\n");        */return LE;    }
"&&"                    { /*printf("AND\n");       */return AND;   }
"||"                    { /*printf("OR\n");        */return OR;    }
"!"                     { /*printf("NOT\n");       */return NOT;   }
"("                     { /*printf("LP\n");        */return LP;    }
")"                     { /*printf("RP\n");        */return RP;    }
"int"                   { printf("INT\n");       return INT;   }
"void"                  { /*printf("VOID\n");      */return VOID;  }
"if"                    { /*printf("IF\n");        */return IF;    }
"else"                  { /*printf("ELSE\n");      */return ELSE;  }
"while"                 { /*printf("WHILE\n");     */return WHILE; }
"switch"                { printf("SWITCH\n");    return SWITCH;}
"case"                  { printf("CASE\n");      return CASE;  }
"default"               { printf("DEFAULT\n");   return DEFAULT;}
"break"                 { /*printf("BREAK\n");     */return BREAK; }
"="                     { /*printf("ASSIGN\n");    */return ASSIGN;}
"{"                     { /*printf("LB\n");        */return LB;    }
"}"                     { /*printf("RB\n");        */return RB;    }
";"                     { /*printf("SEMICOLON\n"); */return SEMICOLON;                       }   
","                     { /*printf("COMMA\n");     */return COMMA;                           }
":"                     { printf("COLON\n");     return COLON;                           }
0|[1-9][0-9]*           { yylval.ival = atoi(yytext);   /*printf("NUM %s\n", yytext); */ return NUM;      }  /*printf ("NUM %s \n" , yytext);  lexème (123, NUM) */
[a-zA-Z][a-zA-Z0-9]*    { yylval.sval = strdup(yytext); /*/*printf("ID %s\n", yytext);*/ return ID;       }  /*yyval = strdup(yytext); return ID OP;*/
[ \t\n]                 { /* ignore whitespace */                 }
.                       { yyerror("Unknown character"); exit(0);  }  /* return yytext[0]; */
%%

int yywrap() {
    return 1;
}

