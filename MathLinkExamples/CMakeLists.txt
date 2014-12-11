# FindMathematica MathLink examples

include_directories(${Mathematica_INCLUDE_DIRS})

set (_TemplateExamples addtwo.tm bitops.tm counter.tm reverse.tm sumalist.tm)
set (_Targets "")

if (NOT CMAKE_CROSSCOMPILING)

	# add a CMake executable target for each MathLink template based example
	foreach (_Example ${_TemplateExamples})
		get_filename_component(_TargetName ${_Example} NAME_WE)
		if (EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/${_Example}" AND
			EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/${_TargetName}.c")
			Mathematica_MathLink_add_executable (${_TargetName} ${_Example} ${_TargetName}.c)
		elseif (EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/${_Example}")
			Mathematica_MathLink_MPREP_TARGET(${_Example} OUTPUT ${_Example}.c)
			add_executable (${_TargetName} WIN32 ${_Example}.c)
			target_link_libraries (${_TargetName} ${Mathematica_MathLink_LIBRARIES})
		endif()
		if (TARGET ${_TargetName})
			set_target_properties(${_TargetName} PROPERTIES FOLDER "MathLink")
			list (APPEND _Targets ${_TargetName})
		endif()
		if (Mathematica_MathLink_LINKER_FLAGS)
			set_target_properties(${_TargetName} PROPERTIES LINK_FLAGS "${Mathematica_MathLink_LINKER_FLAGS}")
		endif()
	endforeach()

	# export mprep header and trailer code for the current target platform
	Mathematica_MathLink_MPREP_EXPORT_FRAMES(
		OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/mprep-frames"
		SYSTEM_ID ${Mathematica_SYSTEM_ID})

else()

	# Processing MathLink templates with mprep upon cross-compiling requires using a
	# custom mprep header and mprep trailer compatible to the target platform.
	# These mprep frame files can be exported using the native mprep executable on
	# the target platform with the function Mathematica_MathLink_MPREP_EXPORT_FRAMES.
	# The exported frame files need to be stored in the build tree and can then be
	# used upon cross-compiling.
	set (_mprepHeader
		"${CMAKE_CURRENT_SOURCE_DIR}/mprep-frames/mprep_header_${Mathematica_SYSTEM_ID}.txt")
	set (_mprepTrailer
		"${CMAKE_CURRENT_SOURCE_DIR}/mprep-frames/mprep_trailer_${Mathematica_SYSTEM_ID}.txt")
	if (NOT EXISTS ${_mprepHeader} OR
		NOT EXISTS ${_mprepTrailer})
		message(STATUS "Skipping MathLink examples, mprep frames for Mathematica system ID ${Mathematica_SYSTEM_ID} are not available.")
	else()
		foreach (_Example ${_TemplateExamples})
			get_filename_component(_TargetName ${_Example} NAME_WE)
			Mathematica_MathLink_MPREP_TARGET(${_Example}
				CUSTOM_HEADER "${_mprepHeader}" CUSTOM_TRAILER "${_mprepTrailer}")
			if (EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/${_TargetName}.c")
				add_executable (${_TargetName} WIN32 ${_Example}.c ${_TargetName}.c)
			else()
				add_executable (${_TargetName} WIN32 ${_Example}.c)
			endif()
			target_link_libraries (${_TargetName} ${Mathematica_MathLink_LIBRARIES})
			set_target_properties(${_TargetName} PROPERTIES FOLDER "MathLink")
			list (APPEND _Targets ${_TargetName})
		endforeach()
	endif()

endif()

set(_Examples factor.c factor2.c factor3.c quotient.c)

# add a CMake executable target for each MathLink C only example
foreach (_Example ${_Examples})
	get_filename_component(_TargetName ${_Example} NAME_WE)
	add_executable (${_TargetName} ${_Example})
	target_link_libraries (${_TargetName} ${Mathematica_MathLink_LIBRARIES})
	list (APPEND _Targets ${_TargetName})
	set_target_properties(${_TargetName} PROPERTIES FOLDER "MathLink")
	set_target_properties(${_TargetName} PROPERTIES INSTALL_RPATH "${Mathematica_RUNTIME_LIBRARY_DIRS}")
endforeach()

# fix MathLink shared library references under Mac OS X
Mathematica_ABSOLUTIZE_LIBRARY_DEPENDENCIES(${_Targets})

if (DEFINED Mathematica_USERBASE_DIR)
	foreach (_systemID ${Mathematica_SYSTEM_IDS})
		install(TARGETS ${_Targets}
			RUNTIME DESTINATION
				"${Mathematica_USERBASE_DIR}/SystemFiles/Kernel/Binaries/${_systemID}"
			CONFIGURATIONS "Release")
	endforeach()
endif()

# define a helper function to simplify adding MathLink executable tests
function (do_mathlink_test _target _expectedOutputRegEx)
	if (NOT TARGET ${_target})
		return()
	endif()
	foreach (_systemID ${Mathematica_SYSTEM_IDS})
		set (_testName "MathLink_${_systemID}_${_target}")
		list (FIND Mathematica_HOST_SYSTEM_IDS "${_systemID}" _index)
		if (${_index} GREATER -1)
			Mathematica_MathLink_add_test (
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

# tests

do_mathlink_test(addtwo
# Expected output regular expression
"AddTwo\\[x, y\\] gives the sum of two machine integers x and y\\.
5
(-2147483648|0)
\\$Failed"
CODE
"?AddTwo
Print[AddTwo[2, 3]]
Print[AddTwo[2^31 - 1, 1]]
Print[AddTwo[2^31, 1]]"
)

do_mathlink_test(bitops
# Expected output regular expression
"bitAnd\\[x, y\\] gives the bitwise conjunction  of two integers x and y\\.
bitComplements\\[{x1,x2,...}\\] generates  a list of the bitwise complements of the integers xi\\.
579
{-1, -2, -3}"
SCRIPT "bitopsTest.m"
)

do_mathlink_test(counter
# Expected output regular expression
"AddToCounter\\[ ck, n\\] adds n to the counter *ck and returns the accumulated value\\.
11
12
32"
CODE
"link2=Install[First[link]]"
"?AddToCounter
Print[AddToCounter[link,11]]
Print[AddToCounter[link2,12]]
Print[AddToCounter[link,21]]
Uninstall[link2]"
)

do_mathlink_test(reverse
# Expected output regular expression
"\"acitamehtaM\""
CODE "Print[reverseString[\"Mathematica\"]]"
)

do_mathlink_test(sumalist
# Expected output regular expression
"107"
CODE "Print[SumAList[{30,7,70}]]"
)

do_mathlink_test(factor
# Expected output regular expression
"Integer to factor: 3 \\^ 2\n41 \\^ 1\n"
INPUT "369")

do_mathlink_test(factor2
# Expected output regular expression
"Integer to factor: \n *List \\[\n *List \\[3 , 2 ], \n *List \\[41 , 1 ]]\n"
INPUT "369")

do_mathlink_test(factor3
# Expected output regular expression
"Integer to factor: \n *List \\[\n *List \\[3 , 2 ], \n *List \\[41 , 1 ]]\n"
INPUT_FILE "${CMAKE_CURRENT_SOURCE_DIR}/test_input.txt")

do_mathlink_test(quotient
# Expected output regular expression
"Two integers m/n: quotient = 1570\n"
INPUT "4711/3")

add_convenience_test_target(MathLinkTests "MathLink")
