CC=gcc
FLEX=flex
BISON=bison

lexical:
	$(FLEX) lex.l
	$(CC) lex.yy.c -lfl -o lexical.out
clean:
	@rm -f syntax.tab.* *.out *.output
syn:
	$(FLEX) lex.l
	$(BISON) -t -d -v syntax.y
	$(CC) -w syntax.tab.c -lfl -ly -o syntax.out
