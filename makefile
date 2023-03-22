CXX = g++
FLEX = flex
SOURCES := lex.yy.cc

lex: lex.yy.cc
	${CXX} lex.yy.cc -O2 -o lex

lex.yy.cc: rules.l
	${FLEX} rules.l

clean:
	rm lex.yy.cc