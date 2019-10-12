%{
	#define SYN
    #include"lex.yy.c"
	int cnt = 0;
	char ans[1024][256];
	void yyerror(char*);
%}
%token ID CHAR FLOAT INT
%token TYPE STRUCT IF ELSE WHILE RETURN 
%token DOT SEMI COMMA ASSIGN LT LE GT GE NE EQ 
%token PLUS MINUS MUL DIV AND OR NOT LP RP LB RB LC RC 
%%
Program: ExtDefList { sprintf(ans[cnt++], "Program(%d)\n", yylineno); }
    ;
ExtDefList: ExtDef ExtDefList { sprintf(ans[cnt++], "ExtDef(%d)\n", yylineno); }
    | 
    ;
ExtDef: Specifier ExtDecList SEMI { sprintf(ans[cnt++], "ExtDef(%d)\n", yylineno); }
    | Specifier SEMI { sprintf(ans[cnt++], "ExtDef(%d)\n", yylineno); }
    | Specifier FunDec CompSt { sprintf(ans[cnt++], "ExtDef(%d)\n", yylineno); }
    ;
ExtDecList: VarDec { sprintf(ans[cnt++], "VarDec(%d)\n", yylineno); }
    | VarDec COMMA ExtDecList { sprintf(ans[cnt++], "VarDec(%d)\n", yylineno); }
    ;
	
Specifier: TYPE { sprintf(ans[cnt++], "Specifier(%d)\n", yylineno); }
    | StructSpecifier { sprintf(ans[cnt++], "Specifier(%d)\n", yylineno); }
    ;
StructSpecifier: STRUCT ID LC DefList RC { sprintf(ans[cnt++], "StructSpecifier(%d)\n", yylineno); }
    | STRUCT ID { sprintf(ans[cnt++], "StructSpecifier(%d)\n", yylineno); }
    ;
	
VarDec: ID { sprintf(ans[cnt++], "VarDec(%d)\n", yylineno); }
    | VarDec LB INT RB { sprintf(ans[cnt++], "VarDec(%d)\n", yylineno); }
    ;
FunDec: ID LP VarList RP { sprintf(ans[cnt++], "FunDec(%d)\n", yylineno); }
    | ID LP RP { sprintf(ans[cnt++], "FunDec(%d)\n", yylineno); }
    ;
VarList: ParamDec COMMA VarList { sprintf(ans[cnt++], "VarList(%d)\n", yylineno); }
    | ParamDec { sprintf(ans[cnt++], "VarList(%d)\n", yylineno); }
    ;
ParamDec: Specifier VarDec { sprintf(ans[cnt++], "ParamDec(%d)\n", yylineno); }
    ;
	
CompSt: LC DefList StmtList RC { sprintf(ans[cnt++], "CompSt(%d)\n", yylineno); }
    ;
StmtList: Stmt StmtList { sprintf(ans[cnt++], "StmtList(%d)\n", yylineno); }
    | 
    ;
Stmt: Exp SEMI { sprintf(ans[cnt++], "Stmt(%d)\n", yylineno); }
    | CompSt { sprintf(ans[cnt++], "Stmt(%d)\n", yylineno); }
    | RETURN Exp SEMI { sprintf(ans[cnt++], "Stmt(%d)\n", yylineno); }
    | IF LP Exp RP Stmt { sprintf(ans[cnt++], "Stmt(%d)\n", yylineno); }
    | IF LP Exp RP Stmt ELSE Stmt { sprintf(ans[cnt++], "Stmt(%d)\n", yylineno); }
    | WHILE LP Exp RP Stmt { sprintf(ans[cnt++], "Stmt(%d)\n", yylineno); }
    ;
	
DefList: Def DefList { sprintf(ans[cnt++], "DefList(%d)\n", yylineno); }
    | 
    ;
Def: Specifier DecList SEMI { sprintf(ans[cnt++], "Def(%d)\n", yylineno); }
    ;
DecList: Dec
    | Dec COMMA DecList { sprintf(ans[cnt++], "DecList(%d)\n", yylineno); }
    ;
Dec: VarDec
    | VarDec ASSIGN Exp { sprintf(ans[cnt++], "Dec(%d)\n", yylineno); }
    ;
	
Exp: Exp ASSIGN Exp { sprintf(ans[cnt++], "Exp(%d)\n", yylineno); }
    | Exp AND Exp { sprintf(ans[cnt++], "Exp(%d)\n", yylineno); }
    | Exp OR Exp { sprintf(ans[cnt++], "Exp(%d)\n", yylineno); }
    | Exp LT Exp { sprintf(ans[cnt++], "Exp(%d)\n", yylineno); }
    | Exp LE Exp { sprintf(ans[cnt++], "Exp(%d)\n", yylineno); }
    | Exp GT Exp { sprintf(ans[cnt++], "Exp(%d)\n", yylineno); }
    | Exp GE Exp { sprintf(ans[cnt++], "Exp(%d)\n", yylineno); }
    | Exp NE Exp { sprintf(ans[cnt++], "Exp(%d)\n", yylineno); }
    | Exp EQ Exp { sprintf(ans[cnt++], "Exp(%d)\n", yylineno); }
    | Exp PLUS Exp { sprintf(ans[cnt++], "Exp(%d)\n", yylineno); }
    | Exp MINUS Exp { sprintf(ans[cnt++], "Exp(%d)\n", yylineno); }
    | Exp MUL Exp { sprintf(ans[cnt++], "Exp(%d)\n", yylineno); }
    | Exp DIV Exp { sprintf(ans[cnt++], "Exp(%d)\n", yylineno); }
    | LP Exp RP { sprintf(ans[cnt++], "Exp(%d)\n", yylineno); }
    | MINUS Exp { sprintf(ans[cnt++], "Exp(%d)\n", yylineno); }
    | NOT Exp { sprintf(ans[cnt++], "Exp(%d)\n", yylineno); }
    | ID LP Args RP { sprintf(ans[cnt++], "Exp(%d)\n", yylineno); }
    | ID LP RP { sprintf(ans[cnt++], "Exp(%d)\n", yylineno); }
    | Exp LB Exp LB { sprintf(ans[cnt++], "Exp(%d)\n", yylineno); }
    | Exp DOT ID { sprintf(ans[cnt++], "Exp(%d)\n", yylineno); }
    | ID { sprintf(ans[cnt++], "Exp(%d)\n", yylineno); }
    | INT { sprintf(ans[cnt++], "Exp(%d)\n", yylineno); }
    | FLOAT { sprintf(ans[cnt++], "Exp(%d)\n", yylineno); }
    | CHAR { sprintf(ans[cnt++], "Exp(%d)\n", yylineno); }
    ;
Args: Exp COMMA Args { sprintf(ans[cnt++], "Args(%d)\n", yylineno); }
    | Exp { sprintf(ans[cnt++], "Args(%d)\n", yylineno); }
    ;
%%

int main(){
	//char input[1 << 16];
	//scanf("%s", input);
	//printf("%s", input);
    yyparse();
	for (int i = 0 ; i < cnt ; i ++)
		printf("%s", ans[i]);
}