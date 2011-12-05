# FindMathematica LibraryLink examples

include_directories(${Mathematica_INCLUDE_DIRS})

set(_Examples
	arbitraryTensor.c demo.c
	demo_eval.c demo_error.c demo_mathlink.c
	demo_numerical.c demo_shared.c demo_string.c)

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
target_link_libraries(demo_eval ${Mathematica_MathLink_LIBRARIES})
target_link_libraries(demo_mathlink ${Mathematica_MathLink_LIBRARIES})

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
CODE
"demoII=LibraryFunctionLoad[\"demo\", \"demo_I_I\", {Integer}, Integer]
demoRR=LibraryFunctionLoad[\"demo\", \"demo_R_R\", {Real}, Real]
demoIRR=LibraryFunctionLoad[\"demo\", \"demo_IR_R\", {Integer, Real}, Real]
demoTIR=LibraryFunctionLoad[\"demo\", \"demo_TI_R\", {{Real, 1}, Integer}, Real]
demo1TIR=LibraryFunctionLoad[\"demo\", \"demo1_TI_R\", {{Real, 1, \"Manual\"}, Integer}, Real]
demo2TIR=LibraryFunctionLoad[\"demo\", \"demo2_TI_R\", {{Real, 1, \"Shared\"}, Integer}, Real]
demoIT=LibraryFunctionLoad[\"demo\", \"demo_I_T\", {Integer}, {Integer, 1}]
demoTTT=LibraryFunctionLoad[\"demo\", \"demo_TT_T\", {{Real, 1}, {Integer, 1}}, {Real, _}]
demoTTTT=LibraryFunctionLoad[\"demo\", \"demo_TTT_T\", {{Real, 1}, {Integer, _}, {Real, _}}, {Integer, _}]
demoTT=LibraryFunctionLoad[\"demo\", \"demo_T_T\", {{_, _}}, {_, _}]
demoBoolean1=LibraryFunctionLoad[\"demo\", \"demoBoolean1\", {\"Boolean\"}, \"Boolean\"]
demoComplex1=LibraryFunctionLoad[\"demo\", \"demoComplex1\", {Complex}, Complex]
demoVoid=LibraryFunctionLoad[\"demo\", \"demoVoid\", {}, \"Void\"]
array = Range[1., 10]
Print[demoII[10]]
Print[demoRR[10.]]
Print[demoIRR[3,13.]]
Print[demoTIR[array,1]]
Print[demo1TIR[array,2]]
Print[demo2TIR[array,3]]
Print[demoIT[5]]
Print[demoTTT[array,{1}]]
Print[demoTTTT[array,1,10.0]]
Print[demoTT[{{1,2},{3,4}}]]
Print[demoBoolean1[True]]
Print[demoComplex1[1. + 2. I]]
Print[demoVoid[]]"
)

do_mathematica_librarylink_test(demo_string
# Expected output regular expression
"3
\"Rfymjrfynhf\"
\"acitamehtaM\""
CODE
"countSubstring=LibraryFunctionLoad[\"demo_string\", \"countSubstring\", {\"UTF8String\", \"UTF8String\"}, Integer]
encodeString=LibraryFunctionLoad[\"demo_string\", \"encodeString\", {\"UTF8String\", Integer}, \"UTF8String\"]
reverseString=LibraryFunctionLoad[\"demo_string\", \"reverseString\", {\"UTF8String\"}, \"UTF8String\" ]
Print[countSubstring[\"Mathematica\",\"a\"]]
Print[encodeString[\"Mathematica\", 5]]
Print[reverseString[\"Mathematica\"]]"
)

do_mathematica_librarylink_test(demo_mathlink
# Expected output regular expression
"2
\"acitamehtaM\""
CODE
"addtwo=LibraryFunctionLoad[\"demo_mathlink\", \"addtwo\", LinkObject, LinkObject]
reverseString=LibraryFunctionLoad[\"demo_mathlink\", \"reverseString\", LinkObject, LinkObject]
Print[addtwo[1,1]]
Print[reverseString[\"Mathematica\"]]"
)

do_mathematica_librarylink_test(demo_eval
# Expected output regular expression
"\nMyFunction::info: Message called from within Library function.
3"
CODE
"fun=LibraryFunctionLoad[\"demo_eval\", \"function1\", {Integer, Integer}, Integer]
MyFunction::info=\"`1`\"
Print[fun[1,2]]"
)

add_convenience_test_target(LibraryLinkTests "LibraryLink")
