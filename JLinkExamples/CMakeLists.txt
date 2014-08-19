# FindMathematica J/Link examples

include(UseJava)

# add J/Link jar to Java compiler include path
set(CMAKE_JAVA_INCLUDE_PATH "${Mathematica_JLink_JAR_FILE}")
# force Java 6 compilation of example sources, J/Link is not compatible with Java 7
# sample source files use Windows character encoding
set(CMAKE_JAVA_COMPILE_FLAGS "-source" "1.6" "-target" "1.6" "-encoding" "Cp1252")

if (NOT CYGWIN)
	# UseJava module cannot handle Cygwin path syntax
	add_jar(AddTwo AddTwo.java)
	add_jar(FormatArray FormatArray.java)
	add_jar(GraphicsApp GraphicsApp.java)
	add_jar(GraphicsDlg GraphicsDlg.java)
	add_jar(SampleProgram SampleProgram.java)
	add_jar(SimpleFrontEnd SimpleFrontEnd.java)
	set_target_properties(AddTwo FormatArray GraphicsApp GraphicsDlg SampleProgram SimpleFrontEnd PROPERTIES FOLDER "JLink")
endif()

# define a helper function to simplify adding J/Link executable tests
function (do_jlink_test _target _expectedOutputRegEx)
	if (NOT TARGET ${_target})
		return()
	endif()
	foreach (_systemID ${Mathematica_SYSTEM_IDS})
		set (_testName "JLink_${_systemID}_${_target}")
		list (FIND Mathematica_HOST_SYSTEM_IDS "${_systemID}" _index)
		if (${_index} GREATER -1)
			Mathematica_JLink_ADD_TEST (
				NAME ${_testName} TARGET ${_target}
				SYSTEM_ID "${_systemID}" ${ARGN})
			Mathematica_set_tests_properties (${_testName}
				PROPERTIES TIMEOUT 30
				PASS_REGULAR_EXPRESSION "${_expectedOutputRegEx}")
			if (COMMAND log_test_properties)
				log_test_properties("${_testName}")
			endif()
		else()
			message (STATUS "Skipping test ${_testName}, cross-compiling from ${Mathematica_HOST_SYSTEM_ID}.")
		endif()
	endforeach()
endfunction ()

do_jlink_test(SampleProgram
# Expected output regular expression
"2 \\+ 2 = 4\n3 \\+ 3 = 6\n4 \\+ 4 = 8"
KERNEL_OPTIONS "-noinit"
)

do_jlink_test(AddTwo
# Expected output regular expression
"5\n7"
CODE
"LoadJavaClass[\"AddTwo\",AllowShortContext->True,StaticsVisible->True]"
"Print[AddTwo`addtwo[2,3]]"
# Sequence forces start of a new CompoundExpression
"Sequence[]"
"Print[addtwo[3,4]]"
)

do_jlink_test(FormatArray
# Expected output regular expression
"{\"1.0000\", \"2.0000\", \"3.0000\", \"4.0000\", \"5.0000\", \"6.0000\", \"7.0000\", \"8.0000\", \"9.0000\", \"10.0000\"}"
SCRIPT "FormatArrayTest.m"
)
