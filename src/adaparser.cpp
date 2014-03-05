/******************************************************************************
 *
 *
 *
 * Copyright (C) 2014 by Adrien PRE <adrienpre+doxygen @ at @ gmail.com>
 *
 * Permission to use, copy, modify, and distribute this software and its
 * documentation under the terms of the GNU General Public License is hereby
 * granted. No representations are made about the suitability of this software
 * for any purpose. It is provided "as is" without express or implied warranty.
 * See the GNU General Public License for more details.
 *
 * Documents produced by Doxygen are derivative works derived from the
 * input used in their production; they are not affected by this license.
 *
 */

#include "adaparser.h"

#include "commentscan.h"
#include "entry.h"

#include <qfile.h>
#include <qxml.h>
#include <qstring.h>

#include "message.h"
#include "util.h"
#include "arguments.h"
#include <iostream>
using namespace std;




// -----------------------------------------------------------------------
// DBusXMLScanner
// -----------------------------------------------------------------------

AdaFileParser::AdaFileParser()
{ }

AdaFileParser::~AdaFileParser()
{ }

void AdaFileParser::parseInput(const char * fileName,
                                const char * /* fileBuf */,
                                Entry *root,
                                bool /*sameTranslationUnit*/,
                                QStrList & /*filesInSameTranslationUnit*/)
{
	printf("AdaFileParser::parseInput(%s)\n",fileName);
}

bool AdaFileParser::needsPreprocessing(const QCString & /* extension */)
{ return (false); }

void AdaFileParser::parseCode(CodeOutputInterface & /* codeOutIntf */,
                               const char * /* scopeName */,
                               const QCString & /* input */,
                               SrcLangExt /* lang */,
                               bool /* isExampleBlock */,
                               const char * /* exampleName */,
                               FileDef * /* fileDef */,
                               int /* startLine */,
                               int /* endLine */,
                               bool /* inlineFragment */,
                               MemberDef * /* memberDef */,
                               bool /*showLineNumbers*/,
                               Definition * /* searchCtx */,
                               bool /*collectXRefs*/ )
{
	printf("AdaFileParser::ParseCode)\n");

}

void AdaFileParser::resetCodeParserState()
{ }

void AdaFileParser::parsePrototype(const char * /* text */)
{ }
