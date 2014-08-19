# FindMathematica pure Mathematica examples

# run Mathematica code while CMake is configuring and capture its output in a CMake variable
Mathematica_EXECUTE(
	CODE "Print[StandardForm[$LicenseID]]"
	OUTPUT_VARIABLE Mathematica_LicenseID
	TIMEOUT 10)
message(STATUS "Mathematica License ID ${Mathematica_LicenseID}")

# run Mathematica code while CMake is configuring and capture its output in a CMake cache variable
Mathematica_EXECUTE(
	CODE "Print[StandardForm[$MachineID]]"
	OUTPUT_VARIABLE Mathematica_MathID CACHE DOC "Mathematica Math ID"
	TIMEOUT 10)
message(STATUS "Mathematica Math ID ${Mathematica_MathID}")

# find Mathematica package
Mathematica_FIND_PACKAGE(Mathematica_NETLink_PACKAGE_FILE "NETLink`" DOC "NETLink package.")
Mathematica_GET_PACKAGE_DIR(Mathematica_NETLink_PACKAGE_DIR "${Mathematica_NETLink_PACKAGE_FILE}")
message(STATUS "Mathematica .NET/Link package directory ${Mathematica_NETLink_PACKAGE_DIR}")

# run Mathematica code while CMake is configuring and write output to file
Mathematica_EXECUTE(
	SCRIPT "${CMAKE_CURRENT_SOURCE_DIR}/demo.m"
	OUTPUT_FILE "demo.m.log" TIMEOUT 10)

Mathematica_EXECUTE(
	SCRIPT "${CMAKE_CURRENT_SOURCE_DIR}/directories.m"
	OUTPUT_FILE "directories.m.log" TIMEOUT 10)

# generate a static library from a template file that is processed by
# the Mathematica function Splice before compiling
include_directories(${Mathematica_INCLUDE_DIR})
Mathematica_SPLICE_C_CODE(spliceDemo.mc OUTPUT spliceDemo.c)
add_library(spliceDemo STATIC spliceDemo.c)
set_target_properties(spliceDemo PROPERTIES FOLDER "Mathematica")

if ("${Mathematica_VERSION_MAJOR}" GREATER 5)
	# add a post-build action which computes the MD5 checksum of the library
	Mathematica_ADD_CUSTOM_COMMAND(TARGET spliceDemo POST_BUILD
		CODE "Print[OutputForm[BaseForm[FileHash[\"$<TARGET_FILE:spliceDemo>\",\"MD5\"],16]]]"
		COMMENT "Computing spliceDemo MD5 checksum.")
endif()

# add a stand-alone target which runs Mathematica code
Mathematica_ADD_CUSTOM_TARGET(CurrentDate ALL
	CODE "Print[DateString[]]"
	COMMENT "Show the current date.")
set_target_properties(CurrentDate PROPERTIES FOLDER "Mathematica")

# add a stand-alone target which runs Mathematica code from an encoded source file
Mathematica_ENCODE(demo.m)
Mathematica_ADD_CUSTOM_TARGET(DemoScript ALL
	SCRIPT "${CMAKE_CURRENT_BINARY_DIR}/demo.m"
	COMMENT "Running demo.m")
set_target_properties(DemoScript PROPERTIES FOLDER "Mathematica")
Mathematica_ENCODE(directories.m OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/directories.m" CHECK_TIMESTAMPS)

# add a convenience target which holds Mathematica source files for IDEs
add_custom_target(MathematicaExamples ALL
	DEPENDS "${CMAKE_CURRENT_BINARY_DIR}/demo.m"
	SOURCES
		"${CMAKE_CURRENT_SOURCE_DIR}/demo.m"
		"${CMAKE_CURRENT_SOURCE_DIR}/directories.m"
		"${CMAKE_CURRENT_SOURCE_DIR}/spliceDemo.mc")
set_target_properties(MathematicaExamples PROPERTIES FOLDER "Mathematica")

# define a helper function to simplify CMake Mathematica tests
function (do_mathematica_test _name _cmds _expectedOutput)
	foreach (_systemID ${Mathematica_SYSTEM_IDS})
		set (_testName "Mathematica_${_systemID}_${_name}")
		list (FIND Mathematica_HOST_SYSTEM_IDS ${_systemID} _index)
		if (${_index} GREATER -1)
			Mathematica_add_test (
				NAME "${_testName}" CODE "${_cmds}"
				SYSTEM_ID "${_systemID}" ${ARGN})
			Mathematica_set_tests_properties (${_testName}
				PROPERTIES TIMEOUT 10
				PASS_REGULAR_EXPRESSION "${_expectedOutput}")
		else()
			message (STATUS "Skipping test ${_testName}, cross-compiling from ${Mathematica_HOST_SYSTEM_ID}.")
		endif()
	endforeach()
endfunction ()

# regular CMake tests

do_mathematica_test(Simple
"Print[1+1]"
# Expected output
"2")

do_mathematica_test(FactorInteger
"Print[FactorInteger[2434500]]"
# Expected output
"{{2, 2}, {3, 2}, {5, 3}, {541, 1}}")

do_mathematica_test(Prime
"Print[Prime[Input[]]]"
# Expected output
"27529"
INPUT "3007")

add_convenience_test_target(MathematicaTests "Mathematica")
