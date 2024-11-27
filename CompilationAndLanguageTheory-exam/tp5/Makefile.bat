cls
flex lexeur-K.l
bison -d parseur-K.y
gcc -o main main.c parseur-K.tab.c lex.yy.c table_symbole.c
pause
cls