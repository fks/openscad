#setup bison for qmake
bison.name = Bison ${QMAKE_FILE_IN}
bison.input = BISONSOURCES
bison.output = ${QMAKE_FILE_PATH}/${QMAKE_FILE_BASE}_yacc.cpp
bison.commands = bison -d -p ${QMAKE_FILE_BASE} -o ${QMAKE_FILE_PATH}/${QMAKE_FILE_BASE}_yacc.cpp ${QMAKE_FILE_IN}
bison.commands += && mv ${QMAKE_FILE_PATH}/${QMAKE_FILE_BASE}_yacc.hpp ${QMAKE_FILE_PATH}/${QMAKE_FILE_BASE}_yacc.h
bison.CONFIG += target_predeps
bison.variable_out = GENERATED_SOURCES
silent:bison.commands = @echo Bison ${QMAKE_FILE_IN} && $$bison.commands
QMAKE_EXTRA_COMPILERS += bison
bison_header.input = BISONSOURCES
bison_header.output = ${QMAKE_FILE_PATH}/${QMAKE_FILE_BASE}_yacc.h
bison_header.commands = bison -d -p ${QMAKE_FILE_BASE} -o ${QMAKE_FILE_PATH}/${QMAKE_FILE_BASE}_yacc.cpp ${QMAKE_FILE_IN}
bison_header.commands += && mv ${QMAKE_FILE_PATH}/${QMAKE_FILE_BASE}_yacc.hpp ${QMAKE_FILE_PATH}/${QMAKE_FILE_BASE}_yacc.h
bison_header.CONFIG += target_predeps no_link
silent:bison_header.commands = @echo Bison ${QMAKE_FILE_IN} && $$bison.commands
QMAKE_EXTRA_COMPILERS += bison_header
