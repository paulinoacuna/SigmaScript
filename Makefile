all: calc

sintactico.tab.c sintactico.tab.h:	sintactico.y
	bison -t -v -d sintactico.y

lex.yy.c: analizador.l sintactico.tab.h
	flex analizador.l

calc: lex.yy.c sintactico.tab.c sintactico.tab.h
	gcc -o calc sintactico.tab.c lex.yy.c

clean:
	rm calc sintactico.tab.c lex.yy.c sintactico.tab.h sintactico.output