%{
    //Group 2 : EL ARRAM Mouloud
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include "table_symbole.h"

    extern dico d;
    extern FILE *file;
    extern int t;
    extern int DeclationVariable;
    extern int Adresse;
    extern mode Mode;

    int yylex();
    void yyerror(const char *s);
%}

%union {
    int ival;
    char *sval;
}

%token <ival> NUM
%token <sval> ID


%token ADD SUB MUL AND OR NOT EQ LT LE LEFT RIGHT
%token INT VOID 
%token LB RB LP RP SEMICOLON COMMA COLON
%token ASSIGN IF ELSE WHILE SWITCH CASE BREAK DEFAULT

%left ADD SUB
%left MUL
%left AND OR
%left ASSIGN 
%left EQ LT LE
%right NOT
%right INT VOID
%nonassoc LB RB LP RP

%type <ival> Exp

%start Prg

%%

Prg : Stm                                          {  }
    | Stm Prg                                      {  } 
    | LB {Mode = LOCAL; d.base = d.sommet;} Prg RB {Mode = GLOBAL; d.base = 0;}
    ;

Stm : INT ID SEMICOLON                             { ajouterVariable(&d, $2, Mode, NULL, Adresse++); fprintf(file, "\t%s: .word 0\n", $2); }
    | ID ASSIGN Exp SEMICOLON                      { affectationValide(&d, $1)}
    | INT ID Sec SEMICOLON                         { ajouterVariable(&d, $2, Mode, NULL, Adresse++); fprintf(file, "\t%s: .word 0\n", $2); }
    | IF LP Exp RP LB {Mode = LOCAL; d.base = d.sommet;} Prg RB {Mode = GLOBAL; d.base = 0;} ELSE LB {Mode = LOCAL; d.base = d.sommet;} Prg RB     {Mode = GLOBAL; d.base = 0;}
    | WHILE LP Exp RP LB {Mode = LOCAL; d.base = d.sommet;}  Prg RB {Mode = GLOBAL; d.base = 0;}
    | VOID SEMICOLON                               {  }
    | IF LP Exp RP Stm ELSE Stm                    {  }
    | SEMICOLON                                    {  }
    | SWITCH LP Exp RP LB {Mode = LOCAL; d.base = d.sommet;} CasesList CaseDefault RB {Mode = GLOBAL; d.base = 0;}
    ;            

CasesList : CASE Exp COLON {Mode = LOCAL; d.base = d.sommet;} Prg {Mode = GLOBAL; d.base = 0;} BREAK SEMICOLON
    | CasesList CASE Exp COLON {Mode = LOCAL; d.base = d.sommet;} Prg {Mode = GLOBAL; d.base = 0;} BREAK SEMICOLON

CaseDefault :  
    | DEFAULT COLON {Mode = LOCAL; d.base = d.sommet;} Prg {Mode = GLOBAL; d.base = 0;} BREAK SEMICOLON
    ;

Sec : COMMA ID Sec                                 { ajouterVariable(&d, $2, Mode, NULL, Adresse++); fprintf(file, "\t%s: .word 0\n", $2); }
    | COMMA ID                                     { ajouterVariable(&d, $2, Mode, NULL, Adresse++); fprintf(file, "\t%s: .word 0\n", $2); }
    ;

Exp : Exp ADD Exp                          { $$ = $1 + $3; }
    | Exp SUB Exp                          { $$ = $1 - $3; }
    | Exp MUL Exp                          { $$ = $1 * $3; }
    | Exp AND Exp                          { $$ = $1 && $3; }
    | Exp OR Exp                           { $$ = $1 || $3; }
    | NOT Exp                              { $$ = !$2; }
    | Exp EQ Exp                           { $$ = $1 == $3; }
    | Exp LT Exp                           { $$ = $1 < $3; }
    | Exp LE Exp                           { $$ = $1 <= $3; }
    | LP Exp RP                            { $$ = $2; }
    | NUM                                  { $$ = $1; }
    | ID                                   { }
    | ID LP Exp RP                         { } 
    | VOID                                 { $$ = 0; } 
    ;
%%

void yyerror(const char *s) {
    printf("Erreur de syntaxe : %s\n", s);
    exit(0);
}
 

 