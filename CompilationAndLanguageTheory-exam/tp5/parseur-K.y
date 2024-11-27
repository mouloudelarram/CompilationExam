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
%token LB RB LP RP SEMICOLON COMMA MAIN
%token ASSIGN IF ELSE WHILE

%left ADD SUB
%left MUL
%left AND OR
%left ASSIGN 
%left EQ LT LE
%right NOT
%right INT VOID MAIN
%nonassoc LB RB LP RP

%type <ival> Exp

%start main

%%

// main
main : INT MAIN  LP RP LB 
        {Mode = LOCAL; d.base = d.sommet;} 
        Prg RB 
        {Mode = GLOBAL; d.base = 0;}
    ;

Prg : Stm                                          {  }
    | Stm Prg                                      {  } 
    | LB 
        {Mode = LOCAL; d.base = d.sommet;} 
        Prg RB 
        {Mode = GLOBAL; d.base = 0;}
    ;

Stm : INT ID SEMICOLON                             
    {   
        ajouterVariable(&d, $2, Mode, NULL, Adresse++); 
        fprintf(file, "\t%s: .word 0\n", $2); 
    }
    | INT ID Sec SEMICOLON                         
    { 
        ajouterVariable(&d, $2, Mode, NULL, Adresse++); 
        fprintf(file, "\t%s: .word 0\n", $2); 
    }
    | ID ASSIGN 
    { 
        if(affectationValide(&d, $1)) {
            if (DeclationVariable == 1) { 
                DeclationVariable = 0; 
                fprintf(file, ".text\n\tmain:\n"); 
            }
        }
    } 
    Exp SEMICOLON                      
    { 
        fprintf(file, "\t\tsw $t0, %s \n",$1); 
    }
    | IF LP Exp RP LB 
    { 
        Mode = LOCAL; 
        d.base = d.sommet;
    } 
    Prg RB 
    {
        Mode = GLOBAL; 
        d.base = 0;
    } 
    ELSE LB 
    {
        fprintf(file, "\t\tj fin\n\tELSE:\n"); 
        Mode = LOCAL; d.base = d.sommet;
    } 
    Prg RB     
    {
        Mode = GLOBAL; 
        d.base = 0;
    }                   
    | WHILE 
    {
        fprintf(file,"\twhile:\n");
    } 
    LP Exp RP LB 
    {
        fprintf(file,"\tj fin\n"); 
        Mode = LOCAL; 
        d.base = d.sommet;
        fprintf(file,"\tloop:\n");
    }  
    Prg RB 
    { 
        fprintf(file,"\tj while\n"); 
        Mode = GLOBAL; 
        d.base = 0;
    }
    | VOID SEMICOLON                              
    | IF LP Exp RP Stm ELSE Stm                   
    | SEMICOLON                                   
    ;            

Sec : COMMA ID Sec                                 
    { 
        ajouterVariable(&d, $2, Mode, NULL, Adresse++); 
        fprintf(file, "\t%s: .word 0\n", $2); 
    }
    | COMMA ID                                    
    { 
        ajouterVariable(&d, $2, Mode, NULL, Adresse++); 
        fprintf(file, "\t%s: .word 0\n", $2); 
    }
    ;

Exp : Exp ADD Exp                          { $$ = $1 + $3; fprintf(file, "\t\tadd $t0, $t1, $t2\n"); }
    | Exp SUB Exp                          { $$ = $1 - $3; fprintf(file, "\t\tsub $t0, $t1, $t2\n"); }
    | Exp MUL Exp                          { $$ = $1 * $3; fprintf(file, "\t\tmul $t0, $t1, $t2\n"); }
    | Exp AND Exp                          { $$ = $1 && $3; fprintf(file, "\t\tand $t0, $t1, $t2\n"); }
    | Exp OR Exp                           { $$ = $1 || $3; fprintf(file, "\t\tor $t0, $t1, $t2\n"); }
    | NOT Exp                              { $$ = !$2;  fprintf(file, "\t\tnot $t0, $t1\n");}
    | Exp EQ Exp                           { $$ = $1 == $3; fprintf(file, "\t\tbne $t0, $zero, ELSE\n"); }
    | Exp LT Exp                           { $$ = $1 < $3; fprintf(file, "\t\tblt $t0, $t1, loop \n"); }
    | Exp LE Exp                           { $$ = $1 <= $3; fprintf(file, "\t\tble $t0, $t1, loop \n"); }
    | LP Exp RP                            { $$ = $2; fprintf(file, "\t\tli $t%d, %d\n",t++, $2); }
    | NUM                                  { $$ = $1; fprintf(file, "\t\tli $t%d, %d\n",t++, $1);}
    | ID                                   { }
    | ID LP Exp RP                         { } 
    | VOID                                 { } 
    ;
%%

void yyerror(const char *s) {
    printf("Erreur de syntaxe : %s\n", s);
    exit(0);
}
 

 