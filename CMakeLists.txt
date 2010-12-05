# FindMathematica example project

cmake_minimum_required(VERSION 2.8.3)

project (Mathematica-project)

set (CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/CMake/Mathematica" ${CMAKE_MODULE_PATH})

set (CMAKE_VERBOSE_MAKEFILE Off)
set (CMAKE_COLOR_MAKEFILE On)
if (NOT CMAKE_CONFIGURATION_TYPES)
	set (CMAKE_BUILD_TYPE Release)
endif()
set_property(GLOBAL PROPERTY USE_FOLDERS 1)

set (Mathematica_USE_STATIC_LIBRARIES Off)
set (Mathematica_USE_MINIMAL_LIBRARIES Off)
set (Mathematica_DEBUG Off)

# finds default Mathematica installation and its default components
find_package(Mathematica)

# finds Mathematica 8 installation and required components
#find_package(Mathematica 8 REQUIRED MathLink WolframLibrary)

# finds Mathematica 7 installation and component MathLink
#find_package(Mathematica 7 COMPONENTS MathLink)

# finds Mathematica 5.2
#find_package(Mathematica 5.2)

enable_testing()

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
	# run Mathematica code while CMake is configuring and capture its output in a variable.
	Mathematica_EXECUTE(
		CODE "Print[StandardForm[$UserBaseDirectory]]"
		OUTPUT_VARIABLE MATHEMATICA_USERBASE_DIR TIMEOUT 10)
	message(STATUS "Mathematica user base directory ${MATHEMATICA_USERBASE_DIR}")
	add_subdirectory(MathematicaExamples)
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
