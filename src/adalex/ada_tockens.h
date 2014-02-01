#if !defined(ADA_TOKENS_INCLUDED)
#define ADA_TOKENS_INCLUDED 1



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
KEYWORD,//,,,/ ='=>',
CHAR_LIT,
CHAR_STRING,
NUMERIC_LIT,
NUMERIC_LIST,
COMMENT,
NEW_LINE,
SEP,
} Ada_Tocken_Type_T;


#ifdef __cplusplus
 #define EXTERNC extern "C"
 #else
 #define EXTERNC
#endif

EXTERNC void push_tocken(Ada_Tocken_Type_T,int line,const char*);

#undef EXTERNC





#endif

