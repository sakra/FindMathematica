# FindMathematica WSTP examples

include_directories(${Mathematica_INCLUDE_DIRS})

set (_TemplateExamples addtwo.tm bitops.tm counter.tm reverse.tm sumalist.tm)
set (_Targets "")

if (NOT CMAKE_CROSSCOMPILING)

	# add a CMake executable target for each WSTP template based example
	foreach (_Example ${_TemplateExamples})
		if (EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/${_Example}")
			get_filename_component(_OutputName ${_Example} NAME_WE)
			set (_TargetName "ws${_OutputName}")
			if (EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/${_OutputName}.c")
				Mathematica_WSTP_add_executable (${_TargetName} ${_Example} ${_OutputName}.c)
			else()
				Mathematica_WSTP_WSPREP_TARGET(${_Example} OUTPUT ${_Example}.c)
				add_executable (${_TargetName} WIN32 ${_Example}.c)
				target_link_libraries (${_TargetName} ${Mathematica_WSTP_LIBRARIES})
			endif()
			if (TARGET ${_TargetName})
				set_target_properties(${_TargetName} PROPERTIES OUTPUT_NAME "${_OutputName}")
				set_target_properties(${_TargetName} PROPERTIES FOLDER "WSTP")
				list (APPEND _Targets ${_TargetName})
			endif()
			if (Mathematica_WSTP_LINKER_FLAGS)
				set_target_properties(${_TargetName} PROPERTIES LINK_FLAGS "${Mathematica_WSTP_LINKER_FLAGS}")
			endif()
		endif()
	endforeach()

	# export wsprep header and trailer code for the current target platform
	Mathematica_WSTP_WSPREP_EXPORT_FRAMES(
		OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/wsprep-frames"
		SYSTEM_ID ${Mathematica_SYSTEM_ID})

else()

	# Processing WSTP templates with wsprep upon cross-compiling requires using a
	# custom wsprep header and wsprep trailer compatible to the target platform.
	# These wsprep frame files can be exported using the native wsprep executable on
	# the target platform with the function Mathematica_WSTP_WSPREP_EXPORT_FRAMES.
	# The exported frame files need to be stored in the build tree and can then be
	# used upon cross-compiling.
	set (_wsprepHeader
		"${CMAKE_CURRENT_SOURCE_DIR}/wsprep-frames/wsprep_header_${Mathematica_SYSTEM_ID}.txt")
	set (_wsprepTrailer
		"${CMAKE_CURRENT_SOURCE_DIR}/wsprep-frames/wsprep_trailer_${Mathematica_SYSTEM_ID}.txt")
	if (NOT EXISTS ${_wsprepHeader} OR
		NOT EXISTS ${_wsprepTrailer})
		message(STATUS "Skipping WSTP examples, wsprep frames for Mathematica system ID ${Mathematica_SYSTEM_ID} are not available.")
	else()
		foreach (_Example ${_TemplateExamples})
			if (EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/${_Example}")
				get_filename_component(_OutputName ${_Example} NAME_WE)
				set (_TargetName "ws${_OutputName}")
				Mathematica_WSTP_WSPREP_TARGET(${_Example}
					CUSTOM_HEADER "${_wsprepHeader}" CUSTOM_TRAILER "${_wsprepTrailer}")
				if (EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/${_OutputName}.c")
					add_executable (${_TargetName} WIN32 ${_Example}.c ${_OutputName}.c)
				else()
					add_executable (${_TargetName} WIN32 ${_Example}.c)
				endif()
				if (TARGET ${_TargetName})
					target_link_libraries (${_TargetName} ${Mathematica_WSTP_LIBRARIES})
					set_target_properties(${_TargetName} PROPERTIES OUTPUT_NAME "${_OutputName}")
					set_target_properties(${_TargetName} PROPERTIES FOLDER "WSTP")
					list (APPEND _Targets ${_TargetName})
				endif()
			endif()
		endforeach()
	endif()

endif()

set(_Examples factor.c factor2.c factor3.c quotient.c)

# add a CMake executable target for each WSTP C only example
foreach (_Example ${_Examples})
	if (EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/${_Example}")
		get_filename_component(_OutputName ${_Example} NAME_WE)
		set (_TargetName "ws${_OutputName}")
		add_executable (${_TargetName} ${_Example})
		target_link_libraries (${_TargetName} ${Mathematica_WSTP_LIBRARIES})
		set_target_properties(${_TargetName} PROPERTIES OUTPUT_NAME "${_OutputName}")
		set_target_properties(${_TargetName} PROPERTIES FOLDER "WSTP")
		set_target_properties(${_TargetName} PROPERTIES INSTALL_RPATH "${Mathematica_RUNTIME_LIBRARY_DIRS}")
		list (APPEND _Targets ${_TargetName})
	endif()
endforeach()

# fix WSTP shared library references under Mac OS X
Mathematica_ABSOLUTIZE_LIBRARY_DEPENDENCIES(${_Targets})

if (DEFINED Mathematica_USERBASE_DIR)
	foreach (_systemID ${Mathematica_SYSTEM_IDS})
		install(TARGETS ${_Targets}
			RUNTIME DESTINATION
				"${Mathematica_USERBASE_DIR}/SystemFiles/Kernel/Binaries/${_systemID}"
			CONFIGURATIONS "Release")
	endforeach()
endif()

# define a helper function to simplify adding WSTP executable tests
function (do_WSTP_test _target _expectedOutputRegEx)
	if (NOT TARGET ${_target})
		return()
	endif()
	foreach (_systemID ${Mathematica_SYSTEM_IDS})
		get_target_property(_outputName ${_target} OUTPUT_NAME)
		set (_testName "WSTP_${_systemID}_${_outputName}")
		list (FIND Mathematica_HOST_SYSTEM_IDS "${_systemID}" _index)
		if (${_index} GREATER -1)
			Mathematica_WSTP_add_test (
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

do_WSTP_test(wsaddtwo
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

do_WSTP_test(wsbitops
# Expected output regular expression
"bitAnd\\[x, y\\] gives the bitwise conjunction  of two integers x and y\\.
bitComplements\\[{x1,x2,...}\\] generates  a list of the bitwise complements of the integers xi\\.
579
{-1, -2, -3}"
SCRIPT "bitopsTest.m"
)

do_WSTP_test(wscounter
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

do_WSTP_test(wsreverse
# Expected output regular expression
"\"acitamehtaM\""
CODE "Print[reverseString[\"Mathematica\"]]"
)

do_WSTP_test(wssumalist
# Expected output regular expression
"107"
CODE "Print[SumAList[{30,7,70}]]"
)

do_WSTP_test(wsfactor
# Expected output regular expression
"Integer to factor: 3 \\^ 2\n41 \\^ 1\n"
INPUT "369")

do_WSTP_test(wsfactor2
# Expected output regular expression
"Integer to factor: \n *List \\[\n *List \\[3 , 2 ], \n *List \\[41 , 1 ]]\n"
INPUT "369")

do_WSTP_test(wsfactor3
# Expected output regular expression
"Integer to factor: \n *List \\[\n *List \\[3 , 2 ], \n *List \\[41 , 1 ]]\n"
INPUT_FILE "${CMAKE_CURRENT_SOURCE_DIR}/test_input.txt")

do_WSTP_test(wsquotient
# Expected output regular expression
"Two integers m/n: quotient = 1570\n"
INPUT "4711/3")

add_convenience_test_target(WSTPTests "WSTP")
