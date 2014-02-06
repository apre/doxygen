

all: adaparse

QT_TOOLS_DIR=../../qtools
INC_DIR=-I$(QT_TOOLS_DIR)
QT_LIBS= $(QT_TOOLS_DIR)/qcollection.cpp  \
$(QT_TOOLS_DIR)/qcstring.cpp  \
$(QT_TOOLS_DIR)/qgstring.cpp  \
$(QT_TOOLS_DIR)/qstring.cpp  

#$(QT_TOOLS_DIR)/qdatetime.cpp  \
#$(QT_TOOLS_DIR)/qdir.cpp  \
#$(QT_TOOLS_DIR)/qdir_unix.cpp  \
#$(QT_TOOLS_DIR)/qfile.cpp  \
#$(QT_TOOLS_DIR)/qfileinfo.cpp  \
#$(QT_TOOLS_DIR)/qfileinfo_unix.cpp  \
#$(QT_TOOLS_DIR)/qfile_unix.cpp  \
#$(QT_TOOLS_DIR)/qgarray.cpp  \
#$(QT_TOOLS_DIR)/qgcache.cpp  \
#$(QT_TOOLS_DIR)/qgdict.cpp  \
#$(QT_TOOLS_DIR)/qglist.cpp  \
#$(QT_TOOLS_DIR)/qglobal.cpp  \
#$(QT_TOOLS_DIR)/qgvector.cpp  \
#$(QT_TOOLS_DIR)/qiodevice.cpp  \
#$(QT_TOOLS_DIR)/qmap.cpp  \
#$(QT_TOOLS_DIR)/qmutex.cpp  \
#$(QT_TOOLS_DIR)/qmutex_unix.cpp  \
#$(QT_TOOLS_DIR)/qregexp.cpp  \
#$(QT_TOOLS_DIR)/qstringlist.cpp  \
#$(QT_TOOLS_DIR)/qtextcodec.cpp  \
#$(QT_TOOLS_DIR)/qutfcodec.cpp  \
#$(QT_TOOLS_DIR)/qwaitcondition_unix.cpp  
#a$(QT_TOOLS_DIR)/qxml.cpp  

#$(QT_TOOLS_DIR)/qtextstream.cpp  \
#$(QT_TOOLS_DIR)/scstring.cpp  


#$(QT_TOOLS_DIR)/qdatastream.cpp  \
#$(QT_TOOLS_DIR)/qthread_unix.cpp  \
#$(QT_TOOLS_DIR)/qthread.cpp  \
#$(QT_TOOLS_DIR)/qmutex_win32.cpp  \
#$(QT_TOOLS_DIR)/qdir_win32.cpp  \
#$(QT_TOOLS_DIR)/qfile_win32.cpp  \
#$(QT_TOOLS_DIR)/qthread_win32.cpp  \
#$(QT_TOOLS_DIR)/qwaitcondition_win32.cpp  \
#$(QT_TOOLS_DIR)/qfileinfo_win32.cpp  \


CXX_OPT=-pipe -fsigned-char -DQT_LITE_UNICODE -D_LARGEFILE_SOURCE -Wall -W -O2 -I.
adalex: lexer9x.l ada_tockens.h adalex.cpp
#	yacc -d grammar9x.y
	flex -8 -PAdaLexYY -o adalex_gen.c lexer9x.l
	gcc $(INC_DIR) -c adalex_gen.c  -o adalex_gen.o
	g++ 	$(CXX_OPT) $(INC_DIR)  adalex.cpp adalex_gen.o  -o adalex


clean: 
	-rm adalex
	-rm adaparse
	-rm out/adaparse.cpp

out/adaparse.cpp: adaparse.rl
	ragel -o out/adaparse.cpp adaparse.rl
	ragel -V -o out/adaparse.dot adaparse.rl
#	dot -Tsvg -o out/adaparse.svg out/adaparse.dot
#	firefox out/adaparse.svg &

adaparse: out/adaparse.cpp
	g++ 	$(CXX_OPT) $(INC_DIR)  out/adaparse.cpp -o adaparse 
	./adaparse < demo_pack.ads
all: adaparse
