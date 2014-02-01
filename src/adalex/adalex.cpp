
#include <qfile.h>
#include <qxml.h>
#include <qstring.h>

#include <deque>
#include <string>
#include <iostream>

using namespace std;




//extern "C" {
#include <stdio.h>

extern FILE *AdaLexYYin, *AdaLexYYout;
//}
//extern "C" int printf( const char *fmt, ... );

#include <ada_tockens.h>

typedef struct Ada_Tocken_s
{
	Ada_Tocken_Type_T type;
	string text;
	int line;

} Ada_Tocken_T;



typedef std::deque<Ada_Tocken_T> Tocken_List_T;

Tocken_List_T G_Tocken_List;




void push_tocken(Ada_Tocken_Type_T tc, int line, const char* value) {

	Ada_Tocken_T t;


	printf("[%s] ",value);

	t.type = tc;
	t.text = value;

	t.line = line;

	G_Tocken_List.push_back(t);

}


/** Reduce the number of tockens.
 *     - Merge continuous comment lines. 
 * */

void Tocken_List_Reduce(Tocken_List_T * TL) {

	int Number_of_tockens = TL->size();
	int i;
	int index = 0;


	while (index < Number_of_tockens) {

		if ( index+1 < Number_of_tockens) { // check that not last element

			if  ( (TL->at(index).type == COMMENT) && (TL->at(index+1).type == COMMENT)){
 TL->at(index).text +=  TL->at(index+1).text; 
			TL->erase(TL->begin()+index+1);
			index--;
			}

		

		}


	index++;
	Number_of_tockens = TL->size();
	}


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

	cout << "end." << endl;
	cout << G_Tocken_List.size() << " tockens." << endl;

	int i;

	Tocken_List_Reduce(&G_Tocken_List);
	for( i=0;i<G_Tocken_List.size()-1;i++) {
		if (G_Tocken_List[i].type != SEP) {
	cout <<  "["   /*<< G_Tocken_List[i].line <<","<< G_Tocken_List[i].type<<" "  */   <<	G_Tocken_List[i].text << "] " ;
		}
	}

	cout << endl;

	cout << "After reduction " <<  G_Tocken_List.size() << " tockens." << endl;


}

