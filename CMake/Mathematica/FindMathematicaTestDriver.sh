#!/bin/bash
# FindMathematica test driver script for UNIX systems

#logger $# "$@"
#logger $LD_LIBRARY_PATH
#logger $DYLD_FRAMEWORK_PATH
#logger $DYLD_LIBRARY_PATH

INPUT_OPTION=$1

if [ "$INPUT_OPTION" = "noinput" ]
then
	TEST_EXECUTABLE=$2
else
	TEST_EXECUTABLE=$3
fi

if [ "$OSTYPE" = "cygwin" ]
then
	# make sure that executable has the right format under Cygwin
	TEST_EXECUTABLE="`cygpath --unix \"$TEST_EXECUTABLE\"`"
fi

if [ "$INPUT_OPTION" = "input" ]
then
	echo "$2" | "$TEST_EXECUTABLE" "${@:4}"
elif [ "$INPUT_OPTION" = "inputfile" ]
then
	"$TEST_EXECUTABLE" < "$2" "${@:4}"
else
	"$TEST_EXECUTABLE" "${@:3}"
fi
