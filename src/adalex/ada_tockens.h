#if !defined(ADA_TOKENS_INCLUDED)
#define ADA_TOKENS_INCLUDED 1

#define KEYWORD  128
#define COMMENT 129
#define IDENTIFIER 130
#define INTEGER 131
#define RANGE 132
#define SHIFT_LEFT 133
#define NEQ 134
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



#endif

