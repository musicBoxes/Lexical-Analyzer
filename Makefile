CC=gcc
FLEX=flex
BISON=bison

la:
	$(FLEX) lex.l
	$(CC) lex.yy.c -lfl -o la.out
clean:
	@rm -f syntax.tab.* *.out
la_test:
	./la.out test_lex.c
	./la.out test_lex.c > res.txt
syn:
	$(FLEX) lex.l
	$(BISON) -t -d syntax.y
	$(CC) -w syntax.tab.c -lfl -ly -o syn.out
syn_test:
	for i in {1..10}
	do
		./syn.out < ./test/test_1_r$i.c > ./test_result/test_1_r$i.out
	done
