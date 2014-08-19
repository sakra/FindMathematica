# FindMathematica MUnit test examples

# run MUnit test file (.mt) as CMake test
Mathematica_MUnit_add_test(NAME MUnit_testfile
	SCRIPT "${CMAKE_CURRENT_SOURCE_DIR}/test.mt"
	TIMEOUT 20)

# run MUnit test with initialization code and alternative logger
Mathematica_MUnit_add_test(NAME MUnit_UnitsTests
	CODE "Needs[\"Units`\"]"
	SCRIPT "${CMAKE_CURRENT_SOURCE_DIR}/UnitsTests.mt"
	LOGGERS "{BatchPrintLogger[]}"
	TIMEOUT 20)

# run MUnit test with test input on stdin
Mathematica_MUnit_add_test(NAME MUnit_inputtest
	SCRIPT "${CMAKE_CURRENT_SOURCE_DIR}/inputtest.mt" INPUT "41"
	TIMEOUT 20)

Mathematica_MUnit_resolve_suite(_testFiles
	"${CMAKE_CURRENT_SOURCE_DIR}/testsuite.mt"
	RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}")
message (STATUS "Test files in testsuite.mt: ${_testFiles}")

# run MUnit test file with TestSuite (.mt) as CMake test
Mathematica_MUnit_add_test(NAME MUnit_testsuite
	CODE "Needs[\"Units`\"]"
	SCRIPT "${CMAKE_CURRENT_SOURCE_DIR}/testsuite.mt"
	TIMEOUT 20)

add_convenience_test_target(MUnitTests "MUnit")
