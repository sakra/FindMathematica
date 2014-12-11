# FindMathematica example project

cmake_minimum_required(VERSION 2.8.9)

project (Mathematica-project)

set (CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/CMake/Mathematica")

set (CMAKE_VERBOSE_MAKEFILE OFF)
set (CMAKE_COLOR_MAKEFILE ON)
set (CMAKE_SKIP_ASSEMBLY_SOURCE_RULES ON)
set (CMAKE_SKIP_PREPROCESSED_SOURCE_RULES ON)
set (CMAKE_INCLUDE_CURRENT_DIR ON)
set (CMAKE_INCLUDE_DIRECTORIES_PROJECT_BEFORE ON)

if (NOT CMAKE_CONFIGURATION_TYPES AND NOT CMAKE_BUILD_TYPE)
	set (CMAKE_BUILD_TYPE Debug)
endif()
set_property(GLOBAL PROPERTY USE_FOLDERS 1)

# find Java
find_package(Java 1.6 COMPONENTS Development)

# default settings for options that affect search
#set (Mathematica_USE_STATIC_LIBRARIES OFF)
#set (Mathematica_USE_MINIMAL_LIBRARIES ON)
#set (Mathematica_USE_LIBCXX_LIBRARIES ON)
#set (Mathematica_MathLink_FIND_VERSION_MAJOR 3)
#set (Mathematica_WSTP_FIND_VERSION_MAJOR 3)
#set (Mathematica_DEBUG OFF)

# finds newest Mathematica installation and its default components
find_package(Mathematica)

# finds Mathematica 10.0.2 installation and required components
#find_package(Mathematica 10.0.2 EXACT REQUIRED MathLink WSTP JLink WolframLibrary)

# finds Mathematica >= 9 installation and optional components
#find_package(Mathematica 9 COMPONENTS MathLink JLink)

if (Mathematica_MathLink_DEFINITIONS)
	add_definitions(${Mathematica_MathLink_DEFINITIONS})
endif()

if (Mathematica_WSTP_DEFINITIONS)
	add_definitions(${Mathematica_WSTP_DEFINITIONS})
endif()

enable_testing()

# helper macro which adds convenience target which lets you run tests from IDE
macro (add_convenience_test_target _targetName _testRegEx)
	if (CMAKE_CONFIGURATION_TYPES)
		add_custom_target("${_targetName}"
			COMMAND
				${CMAKE_CTEST_COMMAND} -V --force-new-ctest-process
					--tests-regex "${_testRegEx}"
					--build-config "${CMAKE_CFG_INTDIR}")
	else()
		add_custom_target("${_targetName}"
			COMMAND
				${CMAKE_CTEST_COMMAND} -V --force-new-ctest-process
					--tests-regex "${_testRegEx}")
	endif()
	set_target_properties("${_targetName}" PROPERTIES FOLDER "Tests")
endmacro()

if (${Mathematica_FOUND})
	message(STATUS "Mathematica Version ${Mathematica_VERSION}")
	# Mathematica_SYSTEM_IDS contains the list of Mathematica platform system IDs that the
	# project is being compiled for. This usually contains just one entry (e.g., "Windows").
	# It may contain multiple entries if we are building a universal binary under Mac OS X
	# (e.g., "MacOSX-x86-64;MacOSX-x86").
	message(STATUS "Mathematica Target System IDs ${Mathematica_SYSTEM_IDS}")
	# Mathematica_HOST_SYSTEM_IDS is the list of Mathematica platform system IDs that can
	# run on the build host. If we are executing the CMake build under a 64-bit version of
	# Windows this would be "Windows-x86-64;Windows". Under a 32-bit version of Windows this
	# would be just "Windows".
	message(STATUS "Mathematica Host System IDs ${Mathematica_HOST_SYSTEM_IDS}")
	# Mathematica_BASE_DIR is the directory for systemwide files to be loaded by Mathematica
	message(STATUS "Mathematica Base Directory ${Mathematica_BASE_DIR}")
	# Mathematica_USERBASE_DIR is the directory for user-specific files to be loaded by Mathematica
	message(STATUS "Mathematica User Base Directory ${Mathematica_USERBASE_DIR}")
	add_subdirectory(MathematicaExamples)
	if (${Mathematica_JLink_FOUND})
		add_subdirectory(DocumentationExamples)
	endif()
endif()

if (${Mathematica_WolframLibrary_FOUND})
	# copy LibraryLink example files from Mathematica installation to source directory
	if (EXISTS "${Mathematica_HOST_ROOT_DIR}/SystemFiles/Links/LibraryLink")
		file (GLOB_RECURSE _LibraryLinkExamples
			"${Mathematica_HOST_ROOT_DIR}/SystemFiles/Links/LibraryLink/*.c")
		file (COPY ${_LibraryLinkExamples}
			DESTINATION "${CMAKE_SOURCE_DIR}/LibraryLinkExamples"
			NO_SOURCE_PERMISSIONS)
		add_subdirectory(LibraryLinkExamples)
	endif()
	add_subdirectory(CodeGenerationExamples)
endif()

if (${Mathematica_MathLink_FOUND})
	# copy MathLink example files from Mathematica installation to source directory
	if (EXISTS "${Mathematica_MathLink_HOST_ROOT_DIR}/MathLinkExamples")
		file (GLOB_RECURSE _MathLinkExamples
			"${Mathematica_MathLink_HOST_ROOT_DIR}/MathLinkExamples/*.tm"
			"${Mathematica_MathLink_HOST_ROOT_DIR}/MathLinkExamples/*.c")
		file (COPY ${_MathLinkExamples}
			DESTINATION "${CMAKE_SOURCE_DIR}/MathLinkExamples"
			NO_SOURCE_PERMISSIONS)
		add_subdirectory(MathLinkExamples)
	endif()
endif()

if (${Mathematica_WSTP_FOUND})
	# copy WSTP example files from Mathematica installation to source directory
	if (EXISTS "${Mathematica_WSTP_HOST_ROOT_DIR}/WSTPExamples")
		file (GLOB_RECURSE _WSTPExamples
			"${Mathematica_WSTP_HOST_ROOT_DIR}/WSTPExamples/*.tm"
			"${Mathematica_WSTP_HOST_ROOT_DIR}/WSTPExamples/*.c")
		file (COPY ${_WSTPExamples}
			DESTINATION "${CMAKE_SOURCE_DIR}/WSTPExamples"
			NO_SOURCE_PERMISSIONS)
		add_subdirectory(WSTPExamples)
	endif()
endif()

if (Mathematica_MUnit_FOUND)
	add_subdirectory(MUnitExamples)
endif ()

if (JAVA_FOUND AND Mathematica_JLink_FOUND)
	# copy J/Link example files from Mathematica installation to source directory
	if (EXISTS "${Mathematica_JLink_PACKAGE_DIR}/Examples")
		file (GLOB_RECURSE _JLinkLinkExamples
			"${Mathematica_JLink_PACKAGE_DIR}/Examples/*.java")
		file (COPY ${_JLinkLinkExamples}
			DESTINATION "${CMAKE_SOURCE_DIR}/JLinkExamples"
			NO_SOURCE_PERMISSIONS)
		add_subdirectory(JLinkExamples)
	endif()
endif()
