@echo off
rem FindMathematica test driver script for Windows

setlocal enabledelayedexpansion

rem echo !CMDCMDLINE!
rem echo !PATH!

set "INPUT_OPTION=%~1"
if "!INPUT_OPTION!" == "input" (
	set "TEST_INPUT=%~2"
	set "TEST_EXECUTABLE=%~3"
	shift
	shift
	shift
	shift
) else if "!INPUT_OPTION!" == "inputfile" (
	set "TEST_INPUT_FILE=%~2"
	set "TEST_EXECUTABLE=%~3"
	shift
	shift
	shift
	shift
) else (
	set "TEST_EXECUTABLE=%~2"
	shift
	shift
	shift
)

if "!INPUT_OPTION!" == "input" (
	echo !TEST_INPUT! | "!TEST_EXECUTABLE!" %0 %1 %2 %3 %4 %5 %6 %7 %8 %9
) else if "!INPUT_OPTION!" == "inputfile" (
	"!TEST_EXECUTABLE!" < "!TEST_INPUT_FILE!" %0 %1 %2 %3 %4 %5 %6 %7 %8 %9
) else (
	"!TEST_EXECUTABLE!" %0 %1 %2 %3 %4 %5 %6 %7 %8 %9
)
