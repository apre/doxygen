/*
 * Show off AdaParser abilities.
 */

#include <iostream>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <deque>
using namespace std;

#define BUFSIZE 2048
#define COMMENT_SIZE (2*BUFSIZE)

#include "ada_tockens.h"

typedef std::deque<Ada_Tocken_T> Ada_Tocken_List_T;




void print_tock(const char* ts, const char * te,int line) {
	char buffer[512];
	int size_tocken = te-ts;

	if (size_tocken < 512) {
		strncpy(buffer,ts,size_tocken);
		buffer[size_tocken] = 0;
		printf("%d:[%s]",line,buffer);

	}

}

#define PT print_tock(ts,te,cur_line)

void print_tocken(const char* saved_p, const char* p) {
	char buffer[50];


	int size_comment = p- saved_p ;

	if (size_comment < 50) {

		strncpy(buffer,saved_p,size_comment);
		char * c = buffer;
		buffer[size_comment] = 0;
		printf("(%d):[%s]\n",size_comment,c);

	} else {
		cerr << "<ERROR: print_tocken failed because internal buffer is too small for " << size_comment << " bytes" << endl;
	}

}

int act;

const char * ts, * te;
struct AdaParser
{
	int cur_line;
	int cur_char;
	int start_word;
	int start_comment;

	/** after lexer pass, the tocken list are stored there. */
	Ada_Tocken_List_T Tocken_List;

	char const * p_start_comment;
	char const * p_start_typename;
	char const * p_stop_typename;
	char const * p_start_ident;
	char const * p_end_ident;
	char const * p_start_packname;
	char const * p_end_packname;
	char const * p_start_with;
	char const * p_end_with;
	char const * p_start_;
	char const * p_end_;
	int end_comment;
	int start_literal;

	char Comment_Line[COMMENT_SIZE];
	int cs;

	/** size of the buffer used to extract the tocken.
	  It must be big enought to hold a full comment line.
	 */
#define TMP_BUF_SIZE 512

	/** buffer that temporary holds the tocken value before conversion into std::string */
	char tmp_buffer[TMP_BUF_SIZE];

	int init( );
	int execute( const char *data, int len, bool isEof );
	int finish( );

	/**
	  push a tocken into the tocken list.

	 */
	void add_tocken(unsigned int token_id,const char* ts, const char * te,int line) ;
};

#define AT(x) add_tocken(x,ts,te,cur_line);
%%{
	machine AdaParser; 

	action package_name_found {
		cout << "package name found: ";
		//printf("p:%s\n",p);
		print_tocken(p_start_packname,p_end_packname);
	}

	action save_p{
		//	pp = p; cout << p << endl;
		;
	}


	action with_found {
		cout << "with found : " ;
		print_tocken(p_start_with,p_end_with);
	}
	action package_found {
		cout << "package found" << endl;
		//printf("p:%s\n",p);
	}

	action type_found {
		cout << "type found"<<endl;
	}

	action type_name_found {
		cout << "type name found:  ";
		print_tocken(p_start_typename,p_stop_typename);
	}
	action identifier_found {

		print_tocken(p_start_ident,p);

	}

	action start_ada_comment {
		long int pi = (long int) p;
		p_start_comment = p;
	}

	action end_ada_comment {
		long int 
			pi = (long int) p;

		int size_comment = p- p_start_comment ;
		end_comment = cur_char;
		//cout << "end ada comment " << pi  << endl; 

		if (size_comment < COMMENT_SIZE) {

			strncpy(Comment_Line,p_start_comment,size_comment);
			char * c = Comment_Line;
			Comment_Line[size_comment] = 0;
			//--printf("-- c:(%2d)[--%s",size_comment,c);

		} else {
			cerr << "ERROR: Comment Buffer too small" << endl;
		}
	}

	action ada_comment_block { ; }

	spc = (" " | "\t");
	sp = (spc spc*);

	eol = ("\n");
	action begin_comment { cout << "vvvvvv begin comment block" << endl;}
	action finish_comment { cout << "^^^^ end comment " << endl;}

#	ada_comment = ((sp*)'--'%start_ada_comment([^\n\r]*eol%end_ada_comment) ) ;
#	ada_comments = (  ada_comment+ )**%ada_comment_block ;

#	ada_comment_line = ((sp*)'--'%start_ada_comment([^\n\r]*eol) )@end_ada_comment;
#	ada_comment = (ada_comment_line+ ada_comment_line**) %ada_comment_block;

	ada_comment_line = ((sp*)'--'%start_ada_comment((any--eol)*eol) )@end_ada_comment;
	ada_comment =(ada_comment_line ada_comment_line**)+ %ada_comment_block;

	k_ABORT     = ("ABORT"i);
	k_ABS       = ("ABS"i);
	k_ABSTRACT  = ("ABSTRACT"i);
	k_ACCEPT    = ("ACCEPT"i);
	k_ACCESS    = ("ACCESS"i);
	k_ALIASED   = ("ALIASED"i);
	k_ALL       = ("ALL"i);
	k_AND       = ("AND"i);
	k_ARRAY     = ("ARRAY"i);
	k_AT        = ("AT"i);
	k_BEGIN     = ("BEGIN"i);
	k_BODY      = ("BODY"i);
	k_CASE      = ("CASE"i);
	k_CONSTANT  = ("CONSTANT"i);
	k_DECLARE   = ("DECLARE"i);
	k_DELAY     = ("DELAY"i);
	k_DELTA     = ("DELTA"i);
	k_DIGITS    = ("DIGITS"i);
	k_DO        = ("DO"i);
	k_ELSE      = ("ELSE"i);
	k_ELSIF     = ("ELSIF"i);
	k_END       = ("END"i);
	k_ENTRY     = ("ENTRY"i);
	k_EXCEPTION = ("EXCEPTION"i);
	k_EXIT      = ("EXIT"i);
	k_FOR       = ("FOR"i);
	k_FUNCTION  = ("FUNCTION"i);
	k_GENERIC   = ("GENERIC"i);
	k_GOTO      = ("GOTO"i);
	k_IF        = ("IF"i);
	k_IN        = ("IN"i);
	k_IS        = ("IS"i);
	k_LIMITED   = ("LIMITED"i);
	k_LOOP      = ("LOOP"i);
	k_MOD       = ("MOD"i);
	k_NEW       = ("NEW"i);
	k_NOT       = ("NOT"i);
	k_NULL      = ("NULL"i);
	k_OF        = ("OF"i);
	k_OR        = ("OR"i);
	k_OTHERS    = ("OTHERS"i);
	k_OUT       = ("OUT"i);
	k_PACKAGE   = ("PACKAGE"i);
	k_PRAGMA    = ("PRAGMA"i);
	k_PRIVATE   = ("PRIVATE"i);
	k_PROCEDURE = ("PROCEDURE"i);
	k_PROTECTED = ("PROTECTED"i);
	k_RAISE     = ("RAISE"i);
	k_RANGE     = ("RANGE"i);
	k_RECORD    = ("RECORD"i);
	k_REM       = ("REM"i);
	k_RENAMES   = ("RENAMES"i);
	k_REQUEUE   = ("REQUEUE"i);
	k_RETURN    = ("RETURN"i);
	k_REVERSE   = ("REVERSE"i);
	k_SELECT    = ("SELECT"i);
	k_SEPARATE  = ("SEPARATE"i);
	k_SUBTYPE   = ("SUBTYPE"i);
	k_TAGGED    = ("TAGGED"i);
	k_TASK      = ("TASK"i);
	k_TERMINATE = ("TERMINATE"i);
	k_THEN      = ("THEN"i);
	k_TYPE      = ("TYPE"i);
	k_UNTIL     = ("UNTIL"i);
	k_USE       = ("USE"i);
	k_WHEN      = ("WHEN"i);
	k_WHILE     = ("WHILE"i);
	k_WITH      = ("WITH"i);
	k_XOR       = ("XOR"i);



	ada_kw1 = (k_ABORT|k_ABS|k_ABSTRACT |k_ACCEPT | k_ACCESS | k_ALIASED | k_ALL | k_AND | k_ARRAY | k_AT | k_BEGIN | k_BODY | k_CASE | k_CONSTANT | k_DECLARE );
	ada_kw2= (k_DELAY k_DELTA k_DIGITS k_DO k_ELSE k_ELSIF k_END k_ENTRY k_EXCEPTION| k_EXIT );
	ada_kw3=(k_FOR |k_FUNCTION | k_GENERIC | k_GOTO | k_IF | k_IN | k_IS | k_LIMITED | k_LOOP | k_MOD | k_NEW | k_NOT | k_NULL | k_OF | k_OR );
	ada_kw4=( k_OTHERS | k_OUT | k_PACKAGE | k_PRAGMA | k_PRIVATE | k_PROCEDURE| k_PROTECTED| k_RAISE | k_RANGE | k_RECORD | k_REM | k_RENAMES | k_REQUEUE | k_RETURN | k_REVERSE );
	ada_kw5=( k_SELECT | k_SEPARATE | k_SUBTYPE | k_TAGGED | k_TASK | k_TERMINATE| k_THEN | k_TYPE | k_FOR | k_FUNCTION | k_GENERIC | k_GOTO | k_IF | k_IN | k_IS | k_LIMITED );
	ada_kw6=( k_LOOP | k_MOD | k_NEW | k_NOT | k_NULL | k_OF | k_OR | k_OTHERS | k_OUT | k_PACKAGE | k_PRAGMA | k_PRIVATE | k_PROCEDURE| k_PROTECTED| k_RAISE );
	ada_kw7=( k_RANGE | k_RECORD | k_REM | k_RENAMES | k_REQUEUE | k_RETURN | k_REVERSE | k_SELECT | k_SEPARATE | k_SUBTYPE | k_TAGGED | k_TASK | k_UNTIL );
	ada_kw8=( k_USE | k_WHEN | k_WHILE | k_WITH | k_XOR );

	ada_keywords = (ada_kw1 | ada_kw2|ada_kw3|ada_kw4|ada_kw5|ada_kw6|ada_kw7|ada_kw8);


	word = ((alpha('_'?alnum)*) );

	package = ("package"i);

	simple_name = word ;
	compound_name = (word ('.' word )* );

	c_name_list = (compound_name (',' compound_name)*);

	with_clause = k_WITH sp %{p_start_with = p;}  c_name_list%{p_end_with = p;} sp? ';' @with_found;

	identifier = (alpha ('_'?[a-zA-Z0-9])*) ; 


	package_name = (("package"i) sp%{p_start_packname = p; } compound_name%{p_end_packname = p; } sp k_IS) @package_name_found;
	type_name = (k_TYPE sp%{p_start_typename = p; } word%{p_stop_typename = p; }  sp k_IS)  @type_name_found;

	action eoc {cout << "EOC" <<endl;}

#main :=  (ada_comment| with_clause| ada_keywords| package_name |  word | type_name | sp | any)*;

	integer = digit('_'? digit )*;

	char_string = '"'('"''"'|[^\n\"])*'"';

	exponent = (([eE])'+'?integer);
	base = integer;
	extended_digit = alnum;
	based_integer = extended_digit('_'?extended_digit)*;
	based_literal = base '#' based_integer ('.' based_integer)? '#' exponent?;

	decimal_literal = integer('.'?integer)?exponent?;

main := |*

	      ada_keywords { AT(KEYWORD);cout << "[";PT;cout << "]";}; 
      ada_comment_line {AT(COMMENT); cur_line++;PT;};
      spc {};
      eol {line_count++;cur_line++;cout  << endl;};
      identifier {AT(IDENTIFIER);PT;};
      integer {AT(INTEGER);PT;};
      "." { AT('.');cout << ".";};
      "<" { AT('<');cout <<   "<"   ;};  
      "(" {  AT('(');   cout <<   "("   ;}; 
      "+" {  AT('+');   cout <<   "+"   ;}; 
      "|" {  AT('|');   cout <<   "|"   ;}; 
      "&" {  AT('&');   cout <<   "&"   ;}; 
      "*" {  AT('*');   cout <<   "*"   ;}; 
      ")" {  AT(')');   cout <<   ")"   ;}; 
      ";" {  AT(';');   cout <<   ";"   ;}; 
      "-" {  AT('-');   cout <<   "-"   ;}; 
      "/" {  AT('/');   cout <<   "/"   ;}; 
      "," {  AT(',');   cout <<   ","   ;}; 
      ">" {  AT('>');   cout <<   ">"   ;}; 
      ":" {  AT(':');   cout <<   ":"   ;}; 
      "=" {  AT('=');   cout <<   "="   ;}; 
      "'" {  AT('\'');   cout <<   "'"   ;}; 
      ".." {AT(RANGE); cout <<   ".."   ;};
      "<<" {AT(SHIFT_LEFT); cout <<   "<<"   ;};
      "<>" {AT(NEQ); cout <<   "<>"   ;};
      "<=" {AT(LTEQ) cout <<   "<="   ;};
      "**" {AT(POWER); cout <<   "**"   ;};
      "/=" {AT(NEQ); cout <<   "/="   ;};
      ">>" {AT(SHIFT_RIGHT); cout <<   ">>"   ;};
      ">=" {AT(GTEQ); cout <<   ">="   ;};
      ":=" {AT(ASSIGN); cout <<   ":="   ;};
      "=>" {AT(ARROW); cout <<   "=>"   ;};



# '..' {PT;};
      ':=' {PT;};

      char_string {AT(CHAR_LIT);PT;};
      based_literal {AT(BASED_LITERAL);PT;};
      decimal_literal {AT(DECIMAL_LITERAL);PT;};






      *|;


}%%

%% write data;

int AdaParser::init( )
{
	%% write init;
	cur_char = 0;
	cur_line = 0;
	return 1;
}

void AdaParser::add_tocken(unsigned int token_id,const char* ts, const char * te,int line)  {

	Ada_Tocken_T t;
	char tmp_buffer[TMP_BUF_SIZE];
	int size_tocken = te-ts;

	if (size_tocken < TMP_BUF_SIZE) {
		strncpy(tmp_buffer,ts,size_tocken);
		tmp_buffer[size_tocken] = 0;


	} else {
		printf("Error: %d (too big tocken)\n");
	}

	t.value = tmp_buffer;
	t.line = line;
	t.tockenId = token_id;


	///t.type = tc;
	//t.text = value;
	//	t.line = line;

	Tocken_List.push_back(t);

}
int AdaParser::execute( const char *data, int len, bool isEof )
{
	const char *p = data;
	const char *pe = data + len;
	const char *eof = isEof ? pe : 0;

	int line_count = 0;



	%% write exec;



	if ( cs == AdaParser_error )
		return -1;
	if ( cs >= AdaParser_first_final )
		return 1;
	return 0;
}

int AdaParser::finish( )
{
	if ( cs == AdaParser_error )
		return -1;
	if ( cs >= AdaParser_first_final )
		return 1;
	return 0;
}


AdaParser AdaParserMachine;
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

	AdaParserMachine.init();
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
		AdaParserMachine.execute( buf, len, len != BUFSIZE );
		if ( len != BUFSIZE )
			break;
	}

	if (file_read) {
		fclose(f);
	}

	if ( AdaParserMachine.finish() <= 0 )
		cerr << "AdaParser: error parsing input" << endl;



	cout << "Read: "<< AdaParserMachine.cur_line << " lines, " << AdaParserMachine.Tocken_List.size() << " tockens"  << endl;
	return 0;
}


// vim: smartindent syntax=ragel :
