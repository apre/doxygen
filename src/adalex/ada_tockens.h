#if !defined(ADA_TOKENS_INCLUDED)
#define ADA_TOKENS_INCLUDED 1

#include <string>
#include <deque>

/** the next two probably need deleteme*/
#define BUFSIZE 2048
#define COMMENT_SIZE (2*BUFSIZE)


#define KEYWORD  128
#define COMMENT 129
#define IDENTIFIER 130
#define INTEGER 131
#define RANGE 132
#define SHIFT_LEFT 133
#define DIFFERENT 134
#define LTEQ 135
#define POWER 136
#define NEQ 137
#define SHIFT_RIGHT 138
#define GTEQ 139
#define ASSIGN 140
#define ARROW 141
#define CHAR_LIT 142
#define BASED_LITERAL 143
#define DECIMAL_LITERAL 144
/*
typedef enum {
DOT='.',
LT='<',
PAR_OPEN='(',
PLUS='+' ,
PIPE='|' ,
AMP='&' ,
STAR='*' ,
PAR_CLOSE=')' ,
SEMI_COLUMN=';' ,
MINUS='-' ,
SLASH='/' ,
COMA=',' ,
GT='>' ,
COLUN=':' ,
EQUAL='=' ,
TICK=200 ,
DOT_DOT, // ..
SHIFT_LEFT, // <<
LTGT, // <>
LTOEQ,//, ='<=',
STARSTAR,//, ='**',
NOTEQ,// ='/=',
SHIFT_RIGHT,//='>>',
GTOEQ,//='>=',
ASSIGN,//=':=',
ARROW,//,,,/ ='=>',
//KEYWORD,//,,,/ ='=>',
CHAR_LIT,
CHAR_STRING,
NUMERIC_LIT,
NUMERIC_LIST,
COMMENT,
NEW_LINE,
SEP,
} Ada_Tocken_Type_T;
*/

#ifdef __cplusplus
 #define EXTERNC extern "C"
 #else
 #define EXTERNC


#endif
/*
EXTERNC void push_tocken(Ada_Tocken_Type_T,int line,const char*);
*/
#undef EXTERNC

/** describe an Ada tocken read from the source file.*/
struct Ada_Tocken_T {
	/** type identifier of the tockenn */
	int  tockenId;
	/** tocken value*/
	std::string value;
	/** line number where the tocken has been found*/
	int line;
};

typedef std::deque<Ada_Tocken_T> Ada_Tocken_List_T;

struct AdaLexer
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
	
	/* ragel specific state manchine vars */
	
	int cs,top,stack[64];



	/** size of the buffer used to extract the tocken.
	  It must be big enought to hold a full comment line.
	 */
#define ADA_LEX_TMP_BUF_SIZE 512

	/** buffer that temporary holds the tocken value before conversion into std::string */
	char tmp_buffer[ADA_LEX_TMP_BUF_SIZE];

	int init( );
	int execute( const char *data, int len, bool isEof );
	int finish( );

	/**
	  push a tocken into the tocken list.

	 */
	void add_tocken(unsigned int token_id,const char* ts, const char * te,int line) ;
};


#endif

