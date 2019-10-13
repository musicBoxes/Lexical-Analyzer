%{
	#include "tree.h"
	#define YYSTYPE struct treeNode*
    #include "lex.yy.c"
	int childNum, tag;
	struct treeNode* childNodeList[8];
	void yyerror(char*);
%}
%token ID CHAR FLOAT INT
%token TYPE STRUCT IF ELSE WHILE RETURN 
%token DOT SEMI COMMA ASSIGN LT LE GT GE NE EQ 
%token PLUS MINUS MUL DIV AND OR NOT LP RP LB RB LC RC 
%%
Program: ExtDefList { childNum = 1; childNodeList[0]=$1; $$=createNode(childNum, childNodeList, "Program", line); treePrint($$); }
    ;
ExtDefList: ExtDef ExtDefList { childNum = 2; childNodeList[0]=$1; childNodeList[1]=$2; $$=createNode(childNum, childNodeList, "ExtDefList", line); }
    |  { $$=createEmpty(); }
    ;
ExtDef: Specifier ExtDecList SEMI { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "ExtDef", line); }
    | Specifier SEMI { childNum = 2; childNodeList[0]=$1; childNodeList[1]=$2; $$=createNode(childNum, childNodeList, "ExtDef", line); }
    | Specifier FunDec CompSt { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "ExtDef", line); }
    ;
ExtDecList: VarDec { childNum = 1; childNodeList[0]=$1; $$=createNode(childNum, childNodeList, "ExtDecList", line); }
    | VarDec COMMA ExtDecList { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "ExtDecList", line); }
    ;
Specifier: TYPE { childNum = 1; childNodeList[0]=$1; $$=createNode(childNum, childNodeList, "Specifier", line); }
    | StructSpecifier { childNum = 1; childNodeList[0]=$1; $$=createNode(childNum, childNodeList, "Specifier", line); }
    ;
StructSpecifier: STRUCT ID LC DefList RC { childNum = 5; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; childNodeList[3]=$4; childNodeList[4]=$5; $$=createNode(childNum, childNodeList, "StructSpecifier", line); }
    | STRUCT ID { childNum = 2; childNodeList[0]=$1; childNodeList[1]=$2; $$=createNode(childNum, childNodeList, "StructSpecifier", line); }
    ;
VarDec: ID { childNum = 1; childNodeList[0]=$1; $$=createNode(childNum, childNodeList, "VarDec", line); }
    | VarDec LB INT RB { childNum = 4; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; childNodeList[3]=$4; $$=createNode(childNum, childNodeList, "VarDec", line); }
    ;
FunDec: ID LP VarList RP { childNum = 4; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; childNodeList[3]=$4; $$=createNode(childNum, childNodeList, "FunDec", line); }
    | ID LP RP { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "FunDec", line); }
    ;
VarList: ParamDec COMMA VarList { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "VarList", line); }
    | ParamDec { childNum = 1; childNodeList[0]=$1; $$=createNode(childNum, childNodeList, "VarList", line); }
    ;
ParamDec: Specifier VarDec { childNum = 2; childNodeList[0]=$1; childNodeList[1]=$2; $$=createNode(childNum, childNodeList, "ParamDec", line); }
    ;
CompSt: LC DefList StmtList RC { childNum = 4; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; childNodeList[3]=$4; $$=createNode(childNum, childNodeList, "CompSt", line); }
    ;
StmtList: Stmt StmtList { childNum = 2; childNodeList[0]=$1; childNodeList[1]=$2; $$=createNode(childNum, childNodeList, "StmtList", line); }
    |  { $$=createEmpty(); }
    ;
Stmt: Exp SEMI { childNum = 2; childNodeList[0]=$1; childNodeList[1]=$2; $$=createNode(childNum, childNodeList, "Stmt", line); }
    | CompSt { childNum = 1; childNodeList[0]=$1; $$=createNode(childNum, childNodeList, "Stmt", line); }
    | RETURN Exp SEMI { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Stmt", line); }
    | IF LP Exp RP Stmt { childNum = 5; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; childNodeList[3]=$4; childNodeList[4]=$5; $$=createNode(childNum, childNodeList, "Stmt", line); }
    | IF LP Exp RP Stmt ELSE Stmt { childNum = 7; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; childNodeList[3]=$4; childNodeList[4]=$5; childNodeList[5]=$6; childNodeList[6]=$7; $$=createNode(childNum, childNodeList, "Stmt", line); }
    | WHILE LP Exp RP Stmt { childNum = 5; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; childNodeList[3]=$4; childNodeList[4]=$5; $$=createNode(childNum, childNodeList, "Stmt", line); }
    ;
DefList: Def DefList { childNum = 2; childNodeList[0]=$1; childNodeList[1]=$2; $$=createNode(childNum, childNodeList, "DefList", line); }
    |  { $$=createEmpty(); }
    ;
Def: Specifier DecList SEMI { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Def", line); }
    ;
DecList: Dec { childNum = 1; childNodeList[0]=$1; $$=createNode(childNum, childNodeList, "DecList", line); }
    | Dec COMMA DecList { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "DecList", line); }
    ;
Dec: VarDec { childNum = 1; childNodeList[0]=$1; $$=createNode(childNum, childNodeList, "Dec", line); }
    | VarDec ASSIGN Exp { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Dec", line); }
    ;
Exp: Exp ASSIGN Exp { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Exp", line); }
    | Exp AND Exp { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Exp", line); }
    | Exp OR Exp { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Exp", line); }
    | Exp LT Exp { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Exp", line); }
    | Exp LE Exp { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Exp", line); }
    | Exp GT Exp { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Exp", line); }
    | Exp GE Exp { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Exp", line); }
    | Exp NE Exp { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Exp", line); }
    | Exp EQ Exp { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Exp", line); }
    | Exp PLUS Exp { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Exp", line); }
    | Exp MINUS Exp { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Exp", line); }
    | Exp MUL Exp { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Exp", line); }
    | Exp DIV Exp { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Exp", line); }
    | LP Exp RP { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Exp", line); }
    | MINUS Exp { childNum = 2; childNodeList[0]=$1; childNodeList[1]=$2; $$=createNode(childNum, childNodeList, "Exp", line); }
    | NOT Exp { childNum = 2; childNodeList[0]=$1; childNodeList[1]=$2; $$=createNode(childNum, childNodeList, "Exp", line); }
    | ID LP Args RP { childNum = 4; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; childNodeList[3]=$4; $$=createNode(childNum, childNodeList, "Exp", line); }
    | ID LP RP { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Exp", line); }
    | Exp LB Exp RB { childNum = 4; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; childNodeList[3]=$4; $$=createNode(childNum, childNodeList, "Exp", line); }
    | Exp DOT ID { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Exp", line); }
    | ID { childNum = 1; childNodeList[0]=$1; $$=createNode(childNum, childNodeList, "Exp", line); }
    | INT { childNum = 1; childNodeList[0]=$1; $$=createNode(childNum, childNodeList, "Exp", line); }
    | FLOAT { childNum = 1; childNodeList[0]=$1; $$=createNode(childNum, childNodeList, "Exp", line); }
    | CHAR { childNum = 1; childNodeList[0]=$1; $$=createNode(childNum, childNodeList, "Exp", line); }
    ;
Args: Exp COMMA Args { childNum = 3; childNodeList[0]=$1; childNodeList[1]=$2; childNodeList[2]=$3; $$=createNode(childNum, childNodeList, "Args", line); }
    | Exp { childNum = 1; childNodeList[0]=$1; $$=createNode(childNum, childNodeList, "Args", line); }
    ;
%%

int main(){
    yyparse();
}