%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);

%}

%union {
    int intValue;
    char* strValue;
}

%token <intValue> NUMBER
%token <strValue> IDENTIFIER
%token INT LPAREN RPAREN COMMA STAR EQUAL
%left '+' '-'
%left '*' '/'

%type <intValue> dec exp aff

%%

program: dec_list aff_list
       ;

dec_list: /* empty */
        | dec_list INT var_list ';'
        ;

var_list: IDENTIFIER
        | var_list COMMA IDENTIFIER
        ;

dec: INT var_list ';'
   ;

aff_list: /* empty */
        | aff_list aff ';'
        ;

aff: IDENTIFIER EQUAL exp ';'
   ;

exp: term
   | exp '+' term   { printf("ADD\n"); }
   | exp '-' term   { printf("SUBTRACT\n"); }
   ;

term: factor
    | term '*' factor  { printf("MULTIPLY\n"); }
    | term '/' factor  { printf("DIVIDE\n"); }
    ;

factor: NUMBER
      | IDENTIFIER
      | STAR factor     { printf("DEREFERENCE\n"); }
      | '&' factor      { printf("ADDRESS\n"); }
      | LPAREN exp RPAREN
      ;

%%

void yyerror(const char* s) {
    fprintf(stderr, "Erreur syntaxique : %s\n", s);
    exit(EXIT_FAILURE);
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <input_file>\n", argv[0]);
        return EXIT_FAILURE;
    }

    FILE* inputFile = fopen(argv[1], "r");
    if (!inputFile) {
        perror("Erreur d'ouverture du fichier");
        return EXIT_FAILURE;
    }

    yyin = inputFile;
    yyparse();

    fclose(inputFile);

    return EXIT_SUCCESS;
}
