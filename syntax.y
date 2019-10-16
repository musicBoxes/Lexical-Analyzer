%{
	#include "tree.h"
	#define YYSTYPE struct treeNode*
    #include "lex.yy.c"
	int childNum;
	int error_flag = 0;
	char errmsg[100];
	struct treeNode* childNodeList[8];
	void yyerror(char*);
%}
%token ID CHAR FLOAT INT
%token TYPE STRUCT IF ELSE WHILE RETURN 
%token DOT SEMI COMMA ASSIGN LT LE GT GE NE EQ 
%token PLUS MINUS MUL DIV AND OR NOT LP RP LB RB LC RC 
%right ASSIGN NOT
%left OR AND LT LE GT GE EQ NE ADD SUB MUL DIV DOT LB RB LP RP
%%
Program: ExtDefList { childNum = 1; childNodeList[0]=$1; $$=createNode(childNum, childNodeList, "Program", @$.first_line); if (!error_flag) treePrint($$); }
    ;
ExtDefList: ExtDef ExtDefList { childNum = 2; childNodeList[0]=$1; childNodeList[1]=$2; $$=createNode(childNum, childNodeList, "ExtDefList", @$.first_line); }
    |  { $$=createEmpty(); }
    ;
ExtDef: Specifier ExtDecList SEMI { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "ExtDef", @$.first_line); }
    | Specifier SEMI { childNum = 2; childNodeList[0]=$1; childNodeList[1]=$2; $$=createNode(childNum, childNodeList, "ExtDef", @$.first_line); }
    | Specifier FunDec CompSt { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "ExtDef", @$.first_line); }
    ;
ExtDecList: VarDec { childNum = 1; childNodeList[0]=$1; $$=createNode(childNum, childNodeList, "ExtDecList", @$.first_line); }
    | VarDec COMMA ExtDecList { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "ExtDecList", @$.first_line); }
    ;
Specifier: TYPE { childNum = 1; childNodeList[0]=$1; $$=createNode(childNum, childNodeList, "Specifier", @$.first_line); }
    | StructSpecifier { childNum = 1; childNodeList[0]=$1; $$=createNode(childNum, childNodeList, "Specifier", @$.first_line); }
    ;
StructSpecifier: STRUCT ID LC DefList RC { childNum = 5; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; childNodeList[3]=$4; childNodeList[4]=$5; $$=createNode(childNum, childNodeList, "StructSpecifier", @$.first_line); }
    | STRUCT ID { childNum = 2; childNodeList[0]=$1; childNodeList[1]=$2; $$=createNode(childNum, childNodeList, "StructSpecifier", @$.first_line); }
    ;
VarDec: ID { childNum = 1; childNodeList[0]=$1; $$=createNode(childNum, childNodeList, "VarDec", @$.first_line); }
    | VarDec LB INT RB { childNum = 4; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; childNodeList[3]=$4; $$=createNode(childNum, childNodeList, "VarDec", @$.first_line); }
    ;
FunDec: ID LP VarList RP { childNum = 4; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; childNodeList[3]=$4; $$=createNode(childNum, childNodeList, "FunDec", @$.first_line); }
    | ID LP RP { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "FunDec", @$.first_line); }
    ;
VarList: ParamDec COMMA VarList { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "VarList", @$.first_line); }
    | ParamDec { childNum = 1; childNodeList[0]=$1; $$=createNode(childNum, childNodeList, "VarList", @$.first_line); }
    ;
ParamDec: Specifier VarDec { childNum = 2; childNodeList[0]=$1; childNodeList[1]=$2; $$=createNode(childNum, childNodeList, "ParamDec", @$.first_line); }
    ;
CompSt: LC DefList StmtList RC { childNum = 4; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; childNodeList[3]=$4; $$=createNode(childNum, childNodeList, "CompSt", @$.first_line); }
    | LC DefList StmtList error { printf("Error type B at Line %d: LC DefList StmtList error\n", @$.first_line); /*yyerror(errmsg);*/ }
    ;
StmtList: Stmt StmtList { childNum = 2; childNodeList[0]=$1; childNodeList[1]=$2; $$=createNode(childNum, childNodeList, "StmtList", @$.first_line); }
    |  { $$=createEmpty(); }
    ;
Stmt: Exp SEMI { childNum = 2; childNodeList[0]=$1; childNodeList[1]=$2; $$=createNode(childNum, childNodeList, "Stmt", @$.first_line); }
    | CompSt { childNum = 1; childNodeList[0]=$1; $$=createNode(childNum, childNodeList, "Stmt", @$.first_line); }
    | RETURN Exp SEMI { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Stmt", @$.first_line); }
    | IF LP Exp RP Stmt { childNum = 5; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; childNodeList[3]=$4; childNodeList[4]=$5; $$=createNode(childNum, childNodeList, "Stmt", @$.first_line); }
    | IF LP Exp RP Stmt ELSE Stmt { childNum = 7; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; childNodeList[3]=$4; childNodeList[4]=$5; childNodeList[5]=$6; childNodeList[6]=$7; $$=createNode(childNum, childNodeList, "Stmt", @$.first_line); }
    | WHILE LP Exp RP Stmt { childNum = 5; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; childNodeList[3]=$4; childNodeList[4]=$5; $$=createNode(childNum, childNodeList, "Stmt", @$.first_line); }
    | Exp error { printf("Error type B at Line %d: Exp error\n", @$.first_line); yyerrok; /*yyerror(errmsg);*/ }
	| RETURN Exp error { printf("Error type B at Line %d: Exp error\n", @$.first_line); yyerrok; /*yyerror(errmsg);*/ } 
//	| RETURN error SEMI { printf("Error type B at Line %d: RETURN error SEMI\n", @$.first_line); /*yyerrok;*/ /*yyerror(errmsg);*/ } 
	;
DefList: Def DefList { childNum = 2; childNodeList[0]=$1; childNodeList[1]=$2; $$=createNode(childNum, childNodeList, "DefList", @$.first_line); }
    |  { $$=createEmpty(); }
    ;
Def: Specifier DecList SEMI { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Def", @$.first_line); }
    ;
DecList: Dec { childNum = 1; childNodeList[0]=$1; $$=createNode(childNum, childNodeList, "DecList", @$.first_line); }
    | Dec COMMA DecList { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "DecList", @$.first_line); }
    ;
Dec: VarDec { childNum = 1; childNodeList[0]=$1; $$=createNode(childNum, childNodeList, "Dec", @$.first_line); }
    | VarDec ASSIGN Exp { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Dec", @$.first_line); }
//	| VarDec ASSIGN error { printf("Error type B at Line %d: VarDec ASSIGN error\n", @$.first_line); /*yyerror(errmsg);*/ yyerrok; }
	;
Exp: Exp ASSIGN Exp { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Exp", @$.first_line); }
    | Exp AND Exp { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Exp", @$.first_line); }
    | Exp OR Exp { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Exp", @$.first_line); }
    | Exp LT Exp { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Exp", @$.first_line); }
    | Exp LE Exp { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Exp", @$.first_line); }
    | Exp GT Exp { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Exp", @$.first_line); }
    | Exp GE Exp { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Exp", @$.first_line); }
    | Exp NE Exp { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Exp", @$.first_line); }
    | Exp EQ Exp { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Exp", @$.first_line); }
    | Exp PLUS Exp { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Exp", @$.first_line); }
    | Exp MINUS Exp { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Exp", @$.first_line); }
    | Exp MUL Exp { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Exp", @$.first_line); }
    | Exp DIV Exp { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Exp", @$.first_line); }
    | LP Exp RP { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Exp", @$.first_line); }
    | MINUS Exp { childNum = 2; childNodeList[0]=$1; childNodeList[1]=$2; $$=createNode(childNum, childNodeList, "Exp", @$.first_line); }
    | NOT Exp { childNum = 2; childNodeList[0]=$1; childNodeList[1]=$2; $$=createNode(childNum, childNodeList, "Exp", @$.first_line); }
    | ID LP Args RP { childNum = 4; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; childNodeList[3]=$4; $$=createNode(childNum, childNodeList, "Exp", @$.first_line); }
    | ID LP RP { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Exp", @$.first_line); }
    | Exp LB Exp RB { childNum = 4; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; childNodeList[3]=$4; $$=createNode(childNum, childNodeList, "Exp", @$.first_line); }
    | Exp DOT ID { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Exp", @$.first_line); }
    | ID { childNum = 1; childNodeList[0]=$1; $$=createNode(childNum, childNodeList, "Exp", @$.first_line); }
    | INT { childNum = 1; childNodeList[0]=$1; $$=createNode(childNum, childNodeList, "Exp", @$.first_line); }
    | FLOAT { childNum = 1; childNodeList[0]=$1; $$=createNode(childNum, childNodeList, "Exp", @$.first_line); }
    | CHAR { childNum = 1; childNodeList[0]=$1; $$=createNode(childNum, childNodeList, "Exp", @$.first_line); }
    | ID LP Args error { printf("Error type B at Line %d: ID LP Args error\n", @$.first_line); /*yyerror(errmsg);*/ yyerrok; }
	| Exp ASSIGN error { printf("Error type B at Line %d: Exp ASSIGN error\n", @$.first_line); /*yyerror(errmsg);*/ yyerrok; }
	| error { /*printf("Exp error\n"); yyerrok;*/ }
	;
Args: Exp COMMA Args { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Args", @$.first_line); }
    | Exp { childNum = 1; childNodeList[0]=$1; $$=createNode(childNum, childNodeList, "Args", @$.first_line); }
    ;
%%

void yyerror(char* s){
	//printf("%s\n", s);
}

int main(){
    yyparse();
}