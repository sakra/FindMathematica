# FindMathematica LibraryLink examples

include_directories(${Mathematica_INCLUDE_DIRS})

set(_Examples
	arbitraryTensor.c demo.c
	demo_error.c demo_numerical.c demo_shared.c demo_string.c)
if (${Mathematica_MathLink_FOUND})
	list (APPEND _Examples demo_eval.c demo_mathlink.c)
endif()

# add a CMake shared library target for each LibraryLink example
set (_Targets "")
foreach (_Example ${_Examples})
	get_filename_component(_TargetName ${_Example} NAME_WE)
	Mathematica_ADD_LIBRARY (${_TargetName} ${_Example})
	list (APPEND _Targets ${_TargetName})
	set_target_properties(${_TargetName} PROPERTIES FOLDER "LibraryLink")
endforeach()

# define a helper function to simplify adding LibraryLink tests
function (do_mathematica_librarylink_test _target _expectedOutputRegEx)
	if (NOT TARGET ${_target})
		return()
	endif()
	foreach (_systemID ${Mathematica_SYSTEM_IDS})
		set (_testName "LibraryLink_${_systemID}_${_target}")
		list (FIND Mathematica_HOST_SYSTEM_IDS ${_systemID} _index)
		if (${_index} GREATER -1)
			Mathematica_WolframLibrary_ADD_TEST (
				NAME ${_testName} TARGET ${_target}
				SYSTEM_ID "${_systemID}" ${ARGN})
			Mathematica_set_tests_properties (${_testName}
				PROPERTIES TIMEOUT 10
				PASS_REGULAR_EXPRESSION "${_expectedOutputRegEx}")
		else()
			message (STATUS "Skipping test ${_testName}, cross-compiling from ${Mathematica_HOST_SYSTEM_ID}.")
		endif()
	endforeach()
endfunction ()

# demo_eval and demo_mathlink require MathLink
if (${Mathematica_MathLink_FOUND})
	target_link_libraries(demo_eval ${Mathematica_MathLink_LIBRARIES})
	target_link_libraries(demo_mathlink ${Mathematica_MathLink_LIBRARIES})
endif()

if (DEFINED Mathematica_USERBASE_DIR)
	foreach (_systemID ${Mathematica_SYSTEM_IDS})
		install(TARGETS ${_Targets}
			LIBRARY DESTINATION
				"${Mathematica_USERBASE_DIR}/SystemFiles/LibraryResources/${_systemID}"
			CONFIGURATIONS "Release")
	endforeach()
endif()

# tests

do_mathematica_librarylink_test(demo
# Expected output regular expression
"11
100.
39.
1.
2.
3.
{2, 4, 6, 8, 10}
1.
11
{1, 2, 3, 4, 2, 2, 4, 2, 2}
False
1. - 2.*I
Null"
SCRIPT "demo_test.m")

do_mathematica_librarylink_test(demo_string
# Expected output regular expression
"3
\"Rfymjrfynhf\"
\"acitamehtaM\""
SCRIPT "${CMAKE_CURRENT_SOURCE_DIR}/demo_string_test.m")

if (${Mathematica_MathLink_FOUND})

do_mathematica_librarylink_test(demo_mathlink
# Expected output regular expression
"2
\"acitamehtaM\""
CODE
"addtwo=LibraryFunctionLoad[libPath, \"addtwo\", LinkObject, LinkObject]
reverseString=LibraryFunctionLoad[libPath, \"reverseString\", LinkObject, LinkObject]
Print[addtwo[1,1]]
Print[reverseString[\"Mathematica\"]]"
)

do_mathematica_librarylink_test(demo_eval
# Expected output regular expression
"\nMyFunction::info: Message called from within Library function.
3"
CODE
"fun=LibraryFunctionLoad[libPath, \"function1\", {Integer, Integer}, Integer]
MyFunction::info=\"`1`\"
Print[fun[1,2]]"
)

endif()

add_convenience_test_target(LibraryLinkTests "LibraryLink")
