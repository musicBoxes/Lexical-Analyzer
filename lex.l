%{
	#include"tree.h"
	#define YYSTYPE struct treeNode*
	#include"syntax.tab.h"
    // just let you know you have macros!
    #define EXIT_OK 0
    #define EXIT_FAIL 1
	
	int yycolno = 1;
	#define YY_USER_ACTION \
	yylloc.first_line = yylineno; \
	yylloc.first_column = yycolno; \
	yylloc.last_line = yylineno; \
	yylloc.last_column = yycolno + yyleng; \
	yycolno += yyleng;
	
	int line = 1;
	char tmp[20];
%}
INT_DEC -?([1-9][0-9]{0,9}))
INT_HEX -?(0[xX][1-9a-f][0-9a-f]{0,7})
INT_ INT_DEC|INT_HEX
%option yylineno
ID [a-zA-Z_]([a-zA-Z_]|[0-9])*
INT -?([0-9]{1,10})|(0[xX][0-9a-f]{1,8})
FLOAT -?[0-9]*[.][0-9]+([eE][+-]?[0-9]*|[0])?f?
CHAR '.|(0[xX][0-9a-f]{1,2})'
TYPE (int)|(float)|(char)
%%
{TYPE} { sprintf(tmp, "TYPE: %s", yytext); yylval = createLeaf(tmp); return TYPE; }
struct { yylval = createLeaf("STRUCT"); return STRUCT; }
if { yylval = createLeaf("IF"); return IF; }
else { yylval = createLeaf("ELSE"); return ELSE; }
while { yylval = createLeaf("WHILE"); return WHILE; }
return { yylval = createLeaf("RETURN"); return RETURN; }
{INT} { sprintf(tmp, "INT: %s", yytext); yylval = createLeaf(tmp); return INT; }
{FLOAT} { sprintf(tmp, "FLOAT: %s", yytext); yylval = createLeaf(tmp); return FLOAT; }
{ID} { sprintf(tmp, "ID: %s", yytext); yylval = createLeaf(tmp); return ID; }
{CHAR} { sprintf(tmp, "CHAR: %s", yytext); yylval = createLeaf(tmp); return CHAR; }
\. { yylval = createLeaf("DOT"); return DOT; }
; { yylval = createLeaf("SEMI"); return SEMI; }
, { yylval = createLeaf("COMMA"); return COMMA; }
= { yylval = createLeaf("ASSIGN"); return ASSIGN; }
\< { yylval = createLeaf("LT"); return LT; }
\<= { yylval = createLeaf("LE"); return LE; }
> { yylval = createLeaf("GT"); return GT; }
>= { yylval = createLeaf("GE"); return GE; }
!= { yylval = createLeaf("NE"); return NE; }
== { yylval = createLeaf("EQ"); return EQ; }
\+ { yylval = createLeaf("PLUS"); return PLUS; }
- { yylval = createLeaf("MINUS"); return MINUS; }
\* { yylval = createLeaf("MUL"); return MUL; }
\/ { yylval = createLeaf("DIV"); return DIV; }
&& { yylval = createLeaf("AND"); return AND; }
\|\| { yylval = createLeaf("OR"); return OR; }
! { yylval = createLeaf("NOT"); return NOT; }
\( { yylval = createLeaf("LP"); return LP; }
\) { yylval = createLeaf("RP"); return RP; }
\[ { yylval = createLeaf("LB"); return LB; }
\] { yylval = createLeaf("RB"); return RB; }
\{ { yylval = createLeaf("LC"); return LC; }
\} { yylval = createLeaf("RC"); return RC; }
[ \r\t]+ {  }
"//" { char c; while ((c=input()) != '\n'); }
"/*" { char c; while (c=input()) { if (c == '*') { c=input(); if (c=='/') break; else unput(c);}}}
[\n] { line++; yycolno = 1; }
. { printf("Error type A at Line %d: Unknown characters \'%s\' \n", yylineno, yytext); return ERROR_TYPE_A;}
%%
#ifndef MYTREE
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