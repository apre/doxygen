/** \file
 * @brief test file for ada lexer.
 * */

#include <ada_tockens.h>
#include <stdlib.h>
#include <stdio.h>
#include <iostream>
using namespace std;

AdaLexer AdaLexerMachine;
char buf[BUFSIZE];

int main(int argc, char* argv[])
{
	int i;
	FILE * f;
	int file_read = 0;
	for (i=0;i<argc;i++) {
		printf("%d:%s\n",i,argv[i]);
	}
	cout << "argc: " << argc <<endl;
	f = NULL;
	if (argc==2) {
		printf("fopen\n");
		file_read = 1;

		cout << "fopen   fin " <<endl;
		f = fopen(argv[1],"r");	
	}

	AdaLexerMachine.init();
	while ( 1 ) {
		int len;
		if (file_read) {
			printf("fread\n");
			len = fread( buf, 1, BUFSIZE, f );
		} else {
			cout << "stdin" << endl;
			len = fread( buf, 1, BUFSIZE, stdin );
		}
		//int len = fread( buf, 1, BUFSIZE, stdin );
		AdaLexerMachine.execute( buf, len, len != BUFSIZE );
		if ( len != BUFSIZE )
			break;
	}

	if (file_read) {
		fclose(f);
	}

	if ( AdaLexerMachine.finish() <= 0 )
		cerr << "AdaParser: error parsing input" << endl;



	cout << "Read: "<< AdaLexerMachine.cur_line << " lines, " << AdaLexerMachine.Tocken_List.size() << " tockens"  << endl;
	return 0;
}
