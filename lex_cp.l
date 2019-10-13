%{
	#include"syntax.tab.h"
    // just let you know you have macros!
    #define EXIT_OK 0
    #define EXIT_FAIL 1
%}
INT_DEC -?([1-9][0-9]{0,9}))
INT_HEX -?(0[xX][1-9a-f][0-9a-f]{0,7})
INT_ INT_DEC|INT_HEX
%option yylineno
ID [a-zA-Z_]([a-zA-Z_]|[0-9])*
INT -?([1-9][0-9]{0,9}|[0])|(0[xX][1-9a-f][0-9a-f]{0,7}|[0])
FLOAT -?[0-9]*[.][0-9]+([eE][+-]?[0-9]*|[0])?f?
CHAR '.|(\\x[0-9a-f]{1,2})'
TYPE (int)|(float)|(char)
%%
{TYPE} { printf("TYPE %s\n", yytext); return TYPE; }
struct { printf("STRUCT\n"); return STRUCT; }
if { printf("IF\n"); return IF; }
else { printf("ELSE\n"); return ELSE; }
while { printf("WHILE\n"); return WHILE; }
return { printf("RETURN\n"); return RETURN; }
{INT} { printf("INT %s\n", yytext); return INT; }
{FLOAT} { printf("FLOAT %s\n", yytext); return FLOAT; }
{ID} { printf("ID %s\n", yytext); return ID; }
{CHAR} { printf("CHAR %s\n", yytext); return CHAR; }
\. { printf("DOT\n"); return DOT; }
; { printf("SEMI\n"); return SEMI; }
, { printf("COMMA\n"); return COMMA; }
= { printf("ASSIGN\n"); return ASSIGN; }
\< { printf("LT\n"); return LT; }
\<= { printf("LE\n"); return LE; }
> { printf("GT\n"); return GT; }
>= { printf("GE\n"); return GE; }
!= { printf("NE\n"); return NE; }
== { printf("EQ\n"); return EQ; }
\+ { printf("PLUS\n"); return PLUS; }
- { printf("MINUS\n"); return MINUS; }
\* { printf("MUL\n"); return MUL; }
\/ { printf("DIV\n"); return DIV; }
&& { printf("AND\n"); return AND; }
\|\| { printf("OR\n"); return OR; }
! { printf("NOT\n"); return NOT; }
\( { printf("LP\n"); return LP; }
\) { printf("RP\n"); return RP; }
\[ { printf("LB\n"); return LB; }
\] { printf("RB\n"); return RB; }
\{ { printf("LC\n"); return LC; }
\} { printf("RC\n"); return RC; }
[ \n\r\t]+ {  }
. { printf("Error type A at line %d: Unknown characters \'%s\' \n", yylineno, yytext); }
%%
#ifndef SYN
int main(int argc, char **argv){
    char *file_path;
    if(argc < 2){
        fprintf(stderr, "Usage: %s <file_path>\n", argv[0]);
        return EXIT_FAIL;
    }
    else if(argc == 2){
        file_path = argv[1];
        if(!(yyin = fopen(file_path, "r"))){
            perror(argv[1]);
            return EXIT_FAIL;
        }
        yylex();
        return EXIT_OK;
    }
    else{
        fputs("Too much arguments!\n", stderr);
        return EXIT_FAIL;
    }
}
#endif