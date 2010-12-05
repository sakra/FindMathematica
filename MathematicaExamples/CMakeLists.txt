# FindMathematica pure Mathematica examples

# run Mathematica code while CMake is configuring and capture its output in a variable
Mathematica_EXECUTE(
	CODE "Print[StandardForm[$LicenseID]]"
	OUTPUT_VARIABLE _LicenseID TIMEOUT 10)

Mathematica_EXECUTE(
	CODE "Print[StandardForm[$MachineID]]"
	OUTPUT_VARIABLE _mathID TIMEOUT 10)

message(STATUS "Mathematica License ID ${_LicenseID}")
message(STATUS "Mathematica Math ID ${_mathID}")

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
	get_target_property(_spliceDemoLoc spliceDemo LOCATION)
	Mathematica_TO_NATIVE_PATH(${_spliceDemoLoc} _spliceDemoLocMma)
	Mathematica_ADD_CUSTOM_COMMAND(TARGET spliceDemo POST_BUILD
		CODE "Print[OutputForm[BaseForm[FileHash[${_spliceDemoLocMma},\"MD5\"],16]]]"
		COMMENT "Computing spliceDemo MD5 checksum.")
endif()

# add a stand-alone target which runs Mathematica code
Mathematica_ADD_CUSTOM_TARGET(CurrentDate
	CODE "Print[DateString[]]"
	COMMENT "Show the current date.")
set_target_properties(CurrentDate PROPERTIES FOLDER "Mathematica")

# add a stand-alone target which runs Mathematica code from a source file
Mathematica_ADD_CUSTOM_TARGET(DemoScript
	SCRIPT "${CMAKE_CURRENT_SOURCE_DIR}/demo.m"
	COMMENT "Run demo script.")
set_target_properties(DemoScript PROPERTIES FOLDER "Mathematica")

# define a helper function to simplify Mathematica tests
function (do_mathematica_test _name _cmds _expectedOutput)
	Mathematica_add_test (NAME "${_name}" CODE "${_cmds}" ${ARGN})
	set_tests_properties (${_name}
		PROPERTIES PASS_REGULAR_EXPRESSION "${_expectedOutput}"
		TIMEOUT 10)
endfunction ()

# tests

do_mathematica_test(Mathematica_Simple
"Print[1+1]"
# Expected output
"2")

do_mathematica_test(Mathematica_FactorInteger
"Print[FactorInteger[2434500]]"
# Expected output
"{{2, 2}, {3, 2}, {5, 3}, {541, 1}}")

do_mathematica_test(Mathematica_Prime
"Print[Prime[Input[]]]"
# Expected output
"27529"
INPUT "3007")
