# FindMathematica CodeGeneration examples

include_directories(${Mathematica_INCLUDE_DIRS})
include_directories(${CMAKE_CURRENT_BINARY_DIR})

# add CMake executable target for single Mathematica function
Mathematica_GENERATE_C_CODE(compute.m OUTPUT compute.c)
add_executable (compute compute_main.c compute.c)
set_target_properties(compute PROPERTIES FOLDER "CodeGeneration")
target_link_libraries (compute ${Mathematica_WolframLibrary_LIBRARIES})

# add CMake executable target for multiple Mathematica functions
Mathematica_GENERATE_C_CODE(functions.m)
add_executable (functions functions.c functions.m.c)
set_target_properties(functions PROPERTIES FOLDER "CodeGeneration")
target_link_libraries (functions ${Mathematica_WolframLibrary_LIBRARIES})

# add CMake static library target for Mathematica control system expression
Mathematica_GENERATE_C_CODE(control.m OUTPUT control.c)
add_library (control STATIC control.c)
set_target_properties(control PROPERTIES FOLDER "CodeGeneration")
target_link_libraries (control ${Mathematica_WolframLibrary_LIBRARIES})

if (DEFINED MATHEMATICA_USERBASE_DIR)
	install(TARGETS compute functions
		RUNTIME DESTINATION
			"${MATHEMATICA_USERBASE_DIR}/SystemFiles/Kernel/Binaries/${Mathematica_SYSTEM_ID}"
		CONFIGURATIONS "Release"
	)
endif()

# define a helper function to simplify adding CodeGeneration tests
function (do_mathematica_codegeneration_test _target _expectedOutputRegEx)
	if (NOT TARGET ${_target})
		return()
	endif()
	foreach (_systemID ${Mathematica_SYSTEM_IDS})
		set (_testName "CodeGeneration_${_systemID}_${_target}")
		list (FIND Mathematica_HOST_SYSTEM_IDS ${_systemID} _index)
		if (${_index} GREATER -1)
			Mathematica_add_test (NAME ${_testName}
				COMMAND "$<TARGET_FILE:${_target}>"
				SYSTEM_ID "${_systemID}" ${ARGN})
			Mathematica_set_tests_properties(${_testName}
				PROPERTIES PASS_REGULAR_EXPRESSION "${_expectedOutputRegEx}"
				TIMEOUT 15)
		else()
			message (STATUS "Skipping test ${_testName}, cross-compiling from ${Mathematica_HOST_SYSTEM_ID}.")
		endif()
	endforeach()
endfunction ()

# tests

do_mathematica_codegeneration_test(compute "compute 417.15")
do_mathematica_codegeneration_test(functions "square 416.16\ncube 8489.66")
