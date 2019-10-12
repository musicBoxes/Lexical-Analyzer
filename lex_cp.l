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
CHAR '.*'
TYPE (int)|(float)|(char)
%%
{TYPE} { printf("TYPE %s\n", yytext); return TYPE; }
struct { printf("STRUCT\n"); return STRUCT; }
if { printf("IF\n"); return IF; }
else { printf("ELSE\n"); }
while { printf("WHILE\n"); }
return { printf("RETURN\n"); }
{INT} { printf("INT %s\n", yytext); }
{FLOAT} { printf("FLOAT %s\n", yytext); }
{ID} { printf("ID %s\n", yytext); }
{CHAR} { printf("CHAR %s\n", yytext); }
\. { printf("DOT\n"); }
; { printf("SEMI\n"); }
, { printf("COMMA\n"); }
= { printf("ASSIGN\n"); }
\< { printf("LT\n"); }
\<= { printf("LE\n"); }
> { printf("GT\n"); }
>= { printf("GE\n"); }
!= { printf("NE\n"); }
== { printf("EQ\n"); }
\+ { printf("PLUS\n"); }
- { printf("MINUS\n"); }
\* { printf("MUL\n"); }
\/ { printf("DIV\n"); }
&& { printf("AND\n"); }
\|\| { printf("OR\n"); }
! { printf("NOT\n"); }
\( { printf("LP\n"); }
\) { printf("RP\n"); }
\[ { printf("LB\n"); }
\] { printf("RB\n"); }
\{ { printf("LC\n"); }
\} { printf("RC\n"); }
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