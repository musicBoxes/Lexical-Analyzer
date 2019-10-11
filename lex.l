%{
    // just let you know you have macros!
    #define EXIT_OK 0
    #define EXIT_FAIL 1

    // and global variables
    int chars = 0;
    int words = 0;
    int lines = 0;
	int spaces = 0;
%}
ID [a-zA-Z_]([a-zA-Z_]|[0-9])*
INT_DEC (-?)(([1-9][0-9]{0,9}))
INT_HEX (-?)(0[xX][1-9a-f][0-9a-f]{0,7}))
INT INT_DEC|INT_HEX
FLOAT -?(1-9)(0-9)*.(0-9)*
CHAR '.*'
TYPE [int|float|char]
%%
ID { printf("ID %s\n", yytext); }
INT { 
//char *str = yytext;
//while (*str != 0)	{ printf("char:%c %d\n", *str, *str); str++; }
printf("INT %s\n", yytext); 
}
FLOAT { printf("FLOAT %s\n", yytext); }
CHAR { printf("CHAR %s\n", yytext); }
TYPE { printf("TYPE %s\n", yytext); }
struct { printf("STRUCT\n"); }
if { printf("IF\n"); }
else { printf("ELSE\n"); }
while { printf("WHILE\n"); }
return { printf("RETURN\n"); }
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
\S { printf("Error type A at line %d: Unknown characters \'%s\' \n", yylineno, yytext); }
%%
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
        printf("lines=%-8d words=%-8d chars=%-8d space=%-8d %s\n", lines, words, chars, spaces, file_path);
        return EXIT_OK;
    }
    else{
        fputs("Too much arguments!\n", stderr);
        return EXIT_FAIL;
    }
}
