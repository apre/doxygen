
//extern "C" {
#include <stdio.h>

extern FILE *AdaLexYYin, *AdaLexYYout;
//}
extern "C" int printf( const char *fmt, ... );

#include <ada_tockens.h>

void push_tocken(Ada_Tocken_Type_T tc, const char* value) {
	printf("[%s] ",value);
}


extern "C" int AdaLexYYlex(void); 
int main( 
	int argc,
	char **argv)
{
	++argv, --argc;  /* skip over program name */
	if ( argc > 0 )
		AdaLexYYin = fopen( argv[0], "r" );
	else
		AdaLexYYin = stdin;

	AdaLexYYlex();
}

