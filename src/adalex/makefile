

all: adalex

INC_DIR=-I../../qtools
CXX_OPT=-pipe -fsigned-char -DQT_LITE_UNICODE -D_LARGEFILE_SOURCE -Wall -W -O2 -I.
adalex: lexer9x.l ada_tockens.h adalex.cpp
#	yacc -d grammar9x.y
	flex -8 -PAdaLexYY -o adalex_gen.c lexer9x.l
	gcc $(INC_DIR) -c adalex_gen.c  -o adalex_gen.o
	g++ 	$(CXX_OPT) $(INC_DIR)  adalex.cpp adalex_gen.o  -o adalex


clean: 
	rm adalex
