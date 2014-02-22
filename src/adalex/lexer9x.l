%{
/******* A "lex"-style lexer for Ada 9X ****************************/
/* Copyright (C) Intermetrics, Inc. 1994 Cambridge, MA  USA        */
/* Copying permitted if accompanied by this statement.             */
/* Derivative works are permitted if accompanied by this statement.*/
/* This lexer is known to be only approximately correct, but it is */
/* more than adequate for most uses (the lexing of apostrophe is   */
/* not as sophisticated as it needs to be to be "perfect").        */
/* As usual there is *no warranty* but we hope it is useful.       */
/*******************************************************************/
#include <stdio.h>
#include <ctype.h>



#include "ada_tockens.h"
//#include "y.tab.h"

int error_count;

int Ada_lexline=1;
%}
%option noyywrap 

DIGIT                   [0-9]
EXTENDED_DIGIT          [0-9a-zA-Z]
INTEGER                 ({DIGIT}(_?{DIGIT})*)
EXPONENT                ([eE](\+?|-){INTEGER})
DECIMAL_LITERAL         {INTEGER}(\.?{INTEGER})?{EXPONENT}?
BASE                    {INTEGER}
BASED_INTEGER           {EXTENDED_DIGIT}(_?{EXTENDED_DIGIT})*
BASED_LITERAL           {BASE}#{BASED_INTEGER}(\.{BASED_INTEGER})?#{EXPONENT}?

%%
"."                      {push_tocken(DOT,Ada_lexline,yytext);}  
"<"                      {push_tocken(LT,Ada_lexline,yytext);}  
"("                      {push_tocken(PAR_OPEN,Ada_lexline,yytext);}  
"+"                      {push_tocken(PLUS,Ada_lexline,yytext);}  
"|"                      {push_tocken(PIPE,Ada_lexline,yytext);}  
"&"                      {push_tocken(AMP,Ada_lexline,yytext);}  
"*"                      {push_tocken(STAR,Ada_lexline,yytext);}  
")"                      {push_tocken(PAR_CLOSE,Ada_lexline,yytext);}  
";"                      {push_tocken(SEMI_COLUMN,Ada_lexline,yytext);}  
"-"                      {push_tocken(MINUS,Ada_lexline,yytext);}  
"/"                      {push_tocken(SLASH,Ada_lexline,yytext);}  
","                      {push_tocken(COMA,Ada_lexline,yytext);}  
">"                      {push_tocken(GT,Ada_lexline,yytext);}  
":"                      {push_tocken(COLUN,Ada_lexline,yytext);}  
"="                      {push_tocken(EQUAL,Ada_lexline,yytext);}  
"'"                      {push_tocken(TICK,Ada_lexline,yytext);}  
".."                     {push_tocken(DOT_DOT,Ada_lexline,yytext);}  
"<<"                     {push_tocken(SHIFT_LEFT,Ada_lexline,yytext);}  
"<>"                     {push_tocken(LTGT,Ada_lexline,yytext);}  
"<="                     {push_tocken(LTOEQ,Ada_lexline,yytext);}  
"**"                     {push_tocken(STARSTAR,Ada_lexline,yytext);}  
"/="                     {push_tocken(NOTEQ,Ada_lexline,yytext);}  
">>"                     {push_tocken(SHIFT_RIGHT,Ada_lexline,yytext);}  
">="                     {push_tocken(GTOEQ,Ada_lexline,yytext);}  
":="                     {push_tocken(ASSIGN,Ada_lexline,yytext);}  
"=>"                     {push_tocken(ARROW,Ada_lexline,yytext);}  
[a-zA-Z](_?[a-zA-Z0-9])* {push_tocken(KEYWORD,Ada_lexline,yytext);}  
"'"."'"                  {push_tocken(CHAR_LIT,Ada_lexline,yytext);}  
\"(\"\"|[^\n\"])*\"      {push_tocken(CHAR_STRING,Ada_lexline,yytext);}  
{DECIMAL_LITERAL}        {push_tocken(NUMERIC_LIT,Ada_lexline,yytext);}  
{BASED_LITERAL}          {push_tocken(NUMERIC_LIST,Ada_lexline,yytext);}  
--.*\n                   {push_tocken(COMMENT,Ada_lexline,yytext);Ada_lexline++;}  ;
[\n]                     {push_tocken(NEW_LINE,Ada_lexline,yytext);Ada_lexline++;printf("%s ",yytext);}  ;
[ \t\f]                {push_tocken(SEP,Ada_lexline,yytext);printf("%s ",yytext);}  ;
.                      {fprintf(stderr, "  Illegal character:%c: on line %d\n",
                            *yytext, yylineno);
                         error_count++;}
%%


///* To build this, run it through lex, compile it, and link it with */
///* the result of yacc'ing and cc'ing grammar9x.y, plus "-ly"       */
//
//main(argc, argv)
//   int argc;
//   char *argv[];
//{
//    /* Simple Ada 9X syntax checker */
//    /* Checks standard input if no arguments */
//    /* Checks files if one or more arguments */
//
//    extern int error_count;
//    extern int yyparse();
//    extern int yylineno;
//    FILE *flptr;
//    int i;
//
//    if (argc == 1) {
//	yyparse();
//    } else {
//	for (i = 1; i < argc; i++) {
//	    if ((flptr = freopen(argv[i], "r",stdin)) == NULL) {
//		fprintf(stderr, "%s:  Can't open %s", argv[0], argv[i]);
//	    } else {
//		if (argc > 2) fprintf(stderr, "%s:\n", argv[i]);
//		yylineno = 1;
//		yyparse();
//	    }
//	}
//    }
//    if (error_count) {
//	fprintf(stderr, "%d syntax error%s detected\n", error_count,
//	  error_count == 1? "": "s");
//	exit(-1);
//    } else {
//	fprintf(stderr, "No syntax errors detected\n");
//    }
//}
//yywrap() {return 1;}
//
///*
// * Keywords stored in alpha order
// */
//
//typedef struct
//        {
//        char    * kw;
//        int     kwv;
//        } KEY_TABLE;
//
///*
// *      Reserved keyword list and Token values
// *      as defined in y.tab.h
// */
//
//# define NUM_KEYWORDS  69
//
//
//KEY_TABLE key_tab[NUM_KEYWORDS] = {
//                {"ABORT",       ABORT},
//                {"ABS",         ABS},
//		{"ABSTRACT",	ABSTRACT},
//                {"ACCEPT",      ACCEPT},
//                {"ACCESS",      ACCESS},
//		{"ALIASED",	ALIASED},
//                {"ALL",         ALL},
//                {"AND",         AND},
//                {"ARRAY",       ARRAY},
//                {"AT",          AT},
//                {"BEGIN",       BEGiN},
//                {"BODY",        BODY},
//                {"CASE",        CASE},
//                {"CONSTANT",    CONSTANT},
//                {"DECLARE",     DECLARE},
//                {"DELAY",       DELAY},
//                {"DELTA",       DELTA},
//                {"DIGITS",      DIGITS},
//                {"DO",          DO},
//                {"ELSE",        ELSE},
//                {"ELSIF",       ELSIF},
//                {"END",         END},
//                {"ENTRY",       ENTRY},
//                {"EXCEPTION",   EXCEPTION},
//                {"EXIT",        EXIT},
//                {"FOR",         FOR},
//                {"FUNCTION",    FUNCTION},
//                {"GENERIC",     GENERIC},
//                {"GOTO",        GOTO},
//                {"IF",          IF},
//                {"IN",          IN},
//                {"IS",          IS},
//                {"LIMITED",     LIMITED},
//                {"LOOP",        LOOP},
//                {"MOD",         MOD},
//                {"NEW",         NEW},
//                {"NOT",         NOT},
//                {"NULL",        NuLL},
//                {"OF",          OF},
//                {"OR",          OR},
//                {"OTHERS",      OTHERS},
//                {"OUT",         OUT},
//                {"PACKAGE",     PACKAGE},
//                {"PRAGMA",      PRAGMA},
//                {"PRIVATE",     PRIVATE},
//                {"PROCEDURE",   PROCEDURE},
//		{"PROTECTED",	PROTECTED},
//                {"RAISE",       RAISE},
//                {"RANGE",       RANGE},
//                {"RECORD",      RECORD},
//                {"REM",         REM},
//                {"RENAMES",     RENAMES},
//		{"REQUEUE",	REQUEUE},
//                {"RETURN",      RETURN},
//                {"REVERSE",     REVERSE},
//                {"SELECT",      SELECT},
//                {"SEPARATE",    SEPARATE},
//                {"SUBTYPE",     SUBTYPE},
//		{"TAGGED",	TAGGED},
//                {"TASK",        TASK},
//                {"TERMINATE",   TERMINATE},
//                {"THEN",        THEN},
//                {"TYPE",        TYPE},
//		{"UNTIL",	UNTIL},
//                {"USE",         USE},
//                {"WHEN",        WHEN},
//                {"WHILE",       WHILE},
//                {"WITH",        WITH},
//                {"XOR",         XOR}
//                };
//
//to_upper(str)
//        char *str;
//{
//        char * cp;
//        for (cp=str; *cp; cp++) {
//                if (islower(*cp)) *cp -= ('a' - 'A') ;
//	}
//}
//
//lk_keyword(str)
//        char *str;
// {
//        int min;
//        int max;
//        int guess, compare;
//
//        min = 0;
//        max = NUM_KEYWORDS-1;
//        guess = (min + max) / 2;
//        to_upper(str);
//
//        for (guess=(min+max)/2; min<=max; guess=(min+max)/2) {
//                if ((compare = strcmp(key_tab[guess].kw, str)) < 0) {
//                        min = guess + 1;
//                } else if (compare > 0) {
//                        max = guess - 1;
//                } else {
//                        return key_tab[guess].kwv;
//		}
//	}
//        return identifier;
// }
//
//yyerror(s)
//        char *s;
//{
//        extern int yychar;
//
//        error_count++;
//
//        fprintf(stderr,"  %s", s);
//        if (yylineno)
//                fprintf(stderr,", on line %d,", yylineno);
//        fprintf(stderr," on input: ");
//        if (yychar >= 0400) {
//                if ((yychar >= ABORT) && (yychar <= XOR)) {
//                        fprintf(stderr, "(token) %s #%d\n",
//                            key_tab[yychar-ABORT].kw, yychar);
//                } else switch (yychar) {
//                        case char_lit : fprintf(stderr, "character literal\n");
//                                break;
//                        case identifier : fprintf(stderr, "identifier\n");
//                                break;
//                        case char_string : fprintf(stderr, "string\n");
//                                break;
//                        case numeric_lit : fprintf(stderr, "numeric literal\n");
//                                break;
//			case TIC : fprintf(stderr, "single-quote\n");
//				break;
//			case DOT_DOT : fprintf(stderr, "..\n");
//				break;
//			case LT_LT : fprintf(stderr, "<<\n");
//				break;
//			case BOX : fprintf(stderr, "<>\n");
//				break;
//			case LT_EQ : fprintf(stderr, "<=\n");
//				break;
//			case EXPON : fprintf(stderr, "**\n");
//				break;
//			case NE : fprintf(stderr, "/=\n");
//				break;
//			case GT_GT : fprintf(stderr, ">>\n");
//				break;
//			case GE : fprintf(stderr, ">=\n");
//				break;
//			case IS_ASSIGNED : fprintf(stderr, ":=\n");
//				break;
//			case RIGHT_SHAFT : fprintf(stderr, "=>\n");
//				break;
//			default :
//                                fprintf(stderr, "(token) %d\n", yychar);
//                }
//        } else {
//                switch (yychar) {
//                case '\t': fprintf(stderr,"horizontal-tab\n"); return;
//                case '\n': fprintf(stderr,"newline\n"); return;
//                case '\0': fprintf(stderr,"\$end\n"); return;
//                case ' ': fprintf(stderr, "(blank)"); return;
//                default : fprintf(stderr,"(char) %c\n", yychar); return;
//                }
//	}
//}
