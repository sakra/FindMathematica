FindMathematica manual
======================

FindMathematica is a CMake module that tries to find a Wolfram Language installation and provides
CMake functions for its C/C++ interface.

Installation
------------

Copy the directory `CMake/Mathematica` to the root directory of your CMake project. In the
top-level `CMakeList.txt` file add the module directory to the CMake module search path:

    set (CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/CMake/Mathematica" ${CMAKE_MODULE_PATH})

Optional CMake MUnit testing support requires the installation of the Wolfram MUnit package. MUnit
is built into *Mathematica* 10 or later. For earlier versions of *Mathematica*, a compatible MUnit 
package ships with Wolfram Workbench 2.0. The JAR file `com.wolfram.eclipse.testing_2.0.126.jar` in
the `plugins` subdirectory of the Workbench installation folder contains different MUnit package
versions for *Mathematica* versions 5.2 to 9.0.

To install MUnit, extract the MUnit package version appropriate for your installed *Mathematica*
version from the JAR file to a directory on the *Mathematica* `$Path` (e.g.,
`$BaseDirectory/Applications` or `$UserBaseDirectory/Applications`). Alternatively you can
copy the MUnit package to the FindMathematica module directory which is automatically prepended
to `$Path` when the Wolfram Language kernel is launched through the FindMathematica module.

If you plan on generating Wolfram Language documentation with CMake, the installation of two Wolfram
documentation build packages, which also ship with Wolfram Workbench 2.0, is required.
The JAR file `com.wolfram.eclipse.paclet.develop_2.0.138.jar` in the `plugins` subdirectory of the
Workbench installation folder contains the package folders `DocumentationBuild` and `Transmogrify`.
These must be copied to a directory on the Wolfram Language `$Path`.

The `DocumentationBuild` package also requires the installation of [Apache Ant][aant]. In order for
Apache Ant to be found by CMake, the environment variable `ANT_HOME` needs to point to Apache Ant's
installation directory.

MathLink and WSTP require the installation of [libuuid][uuid] under Linux. To install `libuuid`
under Debian-based distros run:

    $ sudo apt install uuid-dev

To install `libuuid` under RedHat-based distros run:

    $ sudo dnf install libuuid-devel

Usage
-----

If you are new to CMake, check out the [CMake tutorial][cmtut] first.

To find the newest Wolfram Language installation in a CMake list file, run the `find_package`
command:

    find_package(Mathematica)

The FindMathematica module will look for a Wolfram Language installation in the default installation
location of the used platform. Under Windows, it will also use installation locations from the
Windows Registry.

By default, FindMathematica will return the newest Wolfram Language installation it can find.
To find a minimum version of Wolfram Language, run the `find_package` command with a version
argument:

    find_package(Mathematica 10.0)

To find a specific version of Wolfram Language, run the `find_package` command with a version
argument and the parameter `EXACT`:

    find_package(Mathematica 10.0.2 EXACT)

Depending on the version of Wolfram Language, the FindMathematica module will try to find the
components `MathLink`, `WolframLibrary`, `WSTP`, `JLink` and `MUnit`. To explicitly specify the
components to be found, use:

    find_package(Mathematica COMPONENTS MathLink WolframLibrary)

The package ships as a fully functional CMake project that demonstrates how to use functionality
provided by the FindMathematica module:

* `MathematicaExamples` show how to run plain Wolfram Language code as part of the build process.
* `MathLinkExamples` build all standard MathLink example files.
* `WSTPExamples` build all standard WSTP example files.
* `LibraryLinkExamples` build all standard LibraryLink example files.
* `CodeGenerationExamples` builds binaries from Wolfram Language compiled functions exported to C.
* `MUnitExamples` demonstrate how to run Wolfram Language MUnit test files as CMake tests.
* `DocumentationExamples` demonstrate how to build Wolfram Language documentation.
* `JLinkExamples` builds JAR archives from J/Link example source files.

### Basic Windows Usage

#### Visual Studio

To build the FindMathematica project with Visual Studio C++ for 64-bit Windows, open a Visual
Studio command prompt, change directory to the `FindMathematica` root directory, and run the
following commands:

    D:\FindMathematica>mkdir build
    D:\FindMathematica>cd build
    D:\FindMathematica\build>cmake -G "Visual Studio 16 2019" -A x64 ..

Then open the generated Visual Studio solution file with Visual Studio C++ 2019:

    D:\FindMathematica\build>start Mathematica-project.sln

Alternatively, you can build and test the project's "Debug" configuration from the command prompt:

    D:\FindMathematica\build>cmake --build . --config Debug
    D:\FindMathematica\build>ctest --build-config Debug

To build the "Release" configuration and install the built files to your user base directory, run:

    D:\FindMathematica\build>cmake --build . --target install --config Release

To build the Wolfram Language documentation in notebook format, run:

    D:\FindMathematica\build>cmake --build . --config Debug --target documentation

FindMathematica supports building 32-bit and 64-bit MathLink executables and LibraryLink dynamic
libraries using the appropriate link libraries that ship with the Windows version.
If you are using a 32-bit version of Windows, you can run the Wolfram Language kernel only in
32-bit mode, though. If you are using a 64-bit version of Windows, you can run the Wolfram Language
kernel both as a 64-bit native executable or as a 32-bit executable under WoW64.

#### MinGW

To build the FindMathematica project with [MinGW][mingw] run the following commands from a command
prompt:

    D:\FindMathematica\build>cmake -G "MinGW Makefiles" ..
    D:\FindMathematica\build>mingw32-make

### Basic Linux Usage

To build the FindMathematica project with the CMake makefile generator, open a shell session
in the `FindMathematica` root directory and enter the following commands:

    $ mkdir build
    $ cd build
    $ cmake ..
    $ make

Optionally, you can run all tests and install the built files to your user base directory:

    $ make test
    $ make install

To build the Wolfram Language documentation in notebook format, run:

    $ make documentation

FindMathematica supports building 32-bit and 64-bit MathLink executables and LibraryLink shared
libraries using the appropriate link libraries that ship with the Linux version.
If you are using a 64-bit version of Linux, you can run the Wolfram Language kernel both as a 64-bit
executable or as a 32-bit executable.

To cross-compile to 32-bit Linux under 64-bit Linux, the packages `ia32-libs` and `libc6-dev-i386`
need to be installed. To force a 32-bit build, run:

    $ cmake -DCMAKE_C_FLAGS=-m32 -DCMAKE_CXX_FLAGS=-m32 ..

### Basic macOS Usage

To build the FindMathematica project with the CMake makefile generator, open Terminal.app,
change to the `FindMathematica` root directory and enter the following commands:

    $ mkdir build
    $ cd build
    $ cmake ..
    $ make

Optionally, you can run all tests and install the built files to your user base directory:

    $ make test
    $ make install

To build the Wolfram Language documentation in notebook format, run:

    $ make documentation

To build the FindMathematica project with the Xcode project generator, run CMake with the
following arguments:

    $ cmake -G "Xcode" ..

Then open the generated Xcode project file `Mathematica-project.xcodeproj` with Xcode.app.

FindMathematica supports building MathLink executables and LibraryLink shared libraries for any
macOS architecture type supported by the installed macOS version. 
To select the build target architecture types, set the CMake `CMAKE_OSX_ARCHITECTURES` variable.

E.g., to build a macOS universal binary, use the following setting:

    $ cmake "-DCMAKE_OSX_ARCHITECTURES=arm64;x86_64" ..

Used Variables
--------------

The module uses the following variables upon the invocation of `find_package`:

* `Mathematica_FIND_VERSION` - full requested Wolfram Language version string
* `Mathematica_FIND_VERSION_EXACT` - `TRUE` if `EXACT` option was given upon `find_package`
* `Mathematica_FIND_QUIETLY` - `TRUE` if `QUIET` option was given upon `find_package`
* `Mathematica_FIND_REQUIRED` - `TRUE` if `REQUIRED` option was given upon `find_package`
* `Mathematica_FIND_COMPONENTS` - Set of Wolfram Language components requested upon `find_package`
* `Mathematica_FIND_REQUIRED_MathLink` - `TRUE` if `REQUIRED` option was given for component MathLink
* `Mathematica_FIND_REQUIRED_WSTP` - `TRUE` if `REQUIRED` option was given for component MathLink
* `Mathematica_FIND_REQUIRED_WolframLibrary` - `TRUE` if `REQUIRED` option was given for component WolframLibrary
* `Mathematica_FIND_REQUIRED_JLink` - `TRUE` if `REQUIRED` option was given for component JLink
* `Mathematica_FIND_REQUIRED_MUnit` - `TRUE` if `REQUIRED` option was given for component MUnit
* `Mathematica_USE_STATIC_LIBRARIES` - if `TRUE`, prefer static libraries to dynamic libraries (defaults to `FALSE`)
* `Mathematica_USE_MINIMAL_LIBRARIES` - if `TRUE`, prefer minimal libraries to full libraries (defaults to `FALSE`)
* `Mathematica_USE_LIBCXX_LIBRARIES` - if `TRUE`, prefer libc++ linked libraries to libstdc++ linked libraries (defaults to `FALSE`, only applies to macOS)
* `Mathematica_MathLink_FIND_VERSION_MAJOR` - requested MathLink interface version (e.g., `"3"`)
* `Mathematica_MathLink_FIND_VERSION_MINOR` - requested MathLink revision number (e.g., `"16"`)
* `Mathematica_WSTP_FIND_VERSION_MAJOR` - requested WSTP interface version (e.g., `"4"`)
* `Mathematica_WSTP_FIND_VERSION_MINOR` - requested WSTP revision version (e.g., `"25"`)
* `Mathematica_DEBUG` - if `TRUE`, enable debugging output (defaults to `FALSE`)
* `Mathematica_RUN_KERNEL_ON_CONFIGURE` - if `TRUE`, allow FindMathematica to implicitly run the *Mathematica* kernel at CMake configure time (defaults to `TRUE`)

Defined Variables
-----------------

The module defines the following variables:

* `Mathematica_CMAKE_MODULE_DIR` - directory containing the FindMathematica module (always prepended to `$Path`)
* `Mathematica_CMAKE_MODULE_VERSION` - FindMathematica module version
* `Mathematica_FOUND` - True if Wolfram Language installation and all required components are found
* `Mathematica_SYSTEM_ID` - default build target platform System ID (e.g., `"Windows"` or `"Linux"`)
* `Mathematica_SYSTEM_IDS` - list of supported build target platform System IDs (e.g., `"MacOSX"`, `"MacOSX-x86"`, `"MacOSX-x86-64"`)
* `Mathematica_HOST_SYSTEM_ID` - default host platform System ID (e.g., `"Windows-x86-64"` or `"MacOSX-x86-64"`)
* `Mathematica_HOST_SYSTEM_IDS` - list of System IDs available with the host installation
* `Mathematica_ROOT_DIR` - Wolfram Language installation directory valid for the build target platform
* `Mathematica_HOST_ROOT_DIR` - Wolfram Language installation directory valid for the host platform (corresponds to `$InstallationDirectory`)
* `Mathematica_KERNEL_EXECUTABLE` - path to host Wolfram Language kernel executable
* `Mathematica_FRONTEND_EXECUTABLE` - path to host Wolfram Language frontend executable
* `Mathematica_BASE_DIR` - directory for system-wide files (corresponds to `$BaseDirectory`)
* `Mathematica_USERBASE_DIR` - directory for user-specific files (corresponds to `$UserBaseDirectory`)
* `Mathematica_INCLUDE_DIR` - header file `mdefs.h` include directory
* `Mathematica_INCLUDE_DIRS` - list of include directories for all components
* `Mathematica_LIBRARIES` - list of libraries to link against for all components
* `Mathematica_LIBRARY_DIRS` - list of Wolfram Language library directories for all components
* `Mathematica_RUNTIME_LIBRARY_DIRS` - list of Wolfram Language library directories required at runtime
* `Mathematica_RUNTIME_LIBRARY_DIRS_DEBUG` - list of debug Wolfram Language library directories required at runtime
* `Mathematica_VERSION` - Wolfram Language version number given as "major.minor.patch"
* `Mathematica_VERSION_MAJOR` - Wolfram Language major version number
* `Mathematica_VERSION_MINOR` - Wolfram Language minor version number
* `Mathematica_VERSION_PATCH` - Wolfram Language patch version number
* `Mathematica_VERSION_STRING` - Wolfram Language version string given as "major.minor.patch"
* `Mathematica_VERSION_COUNT` - Wolfram Language version component count (usually 3)
* `Mathematica_CREATION_ID` - Wolfram Language installation creation ID number

The module defines the following variables for component `WolframLibrary`:

* `Mathematica_WolframLibrary_FOUND` - True if the Wolfram Language installation has WolframLibrary
* `Mathematica_WolframLibrary_INCLUDE_DIR` - WolframLibrary include directory (contains header files `WolframLibrary.h` and `WolframRTL.h`)
* `Mathematica_WolframLibrary_LIBRARY` - path to WolframRTL library for the default target platform (e.g., `WolframRTL_Minimal.lib`)
* `Mathematica_WolframLibrary_LIBRARIES` - WolframRTL libraries for all target platforms and required system libraries
* `Mathematica_WolframLibrary_VERSION` - WolframLibrary version number given as "version"
* `Mathematica_WolframLibrary_VERSION_MAJOR` - WolframLibrary version number
* `Mathematica_WolframLibrary_VERSION_STRING` - WolframLibrary version number given as "version"
* `Mathematica_WolframLibrary_VERSION_COUNT` - WolframLibrary number of version components (usually 1)
* `Mathematica_LibraryLink_PACKAGE_FILE` - LibraryLink package file
* `Mathematica_LibraryLink_PACKAGE_DIR` - LibraryLink package root directory
* `Mathematica_WolframLibrary_RUNTIME_LIBRARY_DIRS` - list of WolframLibrary library directories required at runtime
* `Mathematica_WolframLibrary_RUNTIME_LIBRARY_DIRS_DEBUG` - list of debug WolframLibrary library directories required at runtime

The module defines the following variables for component `MathLink`:

* `Mathematica_MathLink_FOUND` - True if the Wolfram Language installation has MathLink SDK
* `Mathematica_MathLink_ROOT_DIR` - MathLink C SDK root directory for the default target platform
* `Mathematica_MathLink_HOST_ROOT_DIR` - MathLink C SDK root directory for the host platform
* `Mathematica_MathLink_INCLUDE_DIR` - header file `mathlink.h` include directory for the default target platform
* `Mathematica_MathLink_LIBRARY` - path to MathLink library for the default target platform
* `Mathematica_MathLink_LIBRARIES` - MathLink library for all target platforms and required system libraries
* `Mathematica_MathLink_MPREP_EXECUTABLE` - path to host `mprep` executable (MathLink template file preprocessor)
* `Mathematica_MathLink_HOST_INCLUDE_DIR` - header file `mathlink.h` include directory for the host platform
* `Mathematica_MathLink_DEFINITIONS` - MathLink compile definitions, e.g., `-DMLINTERFACE=3`
* `Mathematica_MathLink_LINKER_FLAGS` - MathLink linker flags
* `Mathematica_MathLink_VERSION` - MathLink version number given as "interface.revision"
* `Mathematica_MathLink_VERSION_MAJOR` - MathLink interface number
* `Mathematica_MathLink_VERSION_MINOR` - MathLink revision number
* `Mathematica_MathLink_VERSION_STRING` - MathLink version string given as "interface.revision"
* `Mathematica_MathLink_VERSION_COUNT` - MathLink version component count (usually 2)
* `Mathematica_MathLink_RUNTIME_LIBRARY_DIRS` - list of MathLink library directories required at runtime
* `Mathematica_MathLink_RUNTIME_LIBRARY_DIRS_DEBUG` - list of debug MathLink library directories required at runtime

The module defines the following variables for component `WSTP`:

* `Mathematica_WSTP_FOUND` - True if the Wolfram Language installation has WSTP SDK
* `Mathematica_WSTP_ROOT_DIR` - WSTP C SDK root directory for the default target platform
* `Mathematica_WSTP_HOST_ROOT_DIR` - WSTP C SDK root directory for the host platform
* `Mathematica_WSTP_INCLUDE_DIR` - header file `wstp.h` include directory for the default target platform
* `Mathematica_WSTP_LIBRARY` - path to WSTP library for the default target platform
* `Mathematica_WSTP_LIBRARIES` - WSTP library for all target platforms and required system libraries
* `Mathematica_WSTP_WSPREP_EXECUTABLE` - path to host `wsprep` executable (WSTP template file preprocessor)
* `Mathematica_WSTP_HOST_INCLUDE_DIR` - header file wstp.h include directory for the host platform
* `Mathematica_WSTP_DEFINITIONS` - WSTP compile definitions, e.g., `-DWSINTERFACE=4`
* `Mathematica_WSTP_LINKER_FLAGS` - WSTP linker flags
* `Mathematica_WSTP_VERSION` - WSTP version number given as "interface.revision"
* `Mathematica_WSTP_VERSION_MAJOR` - WSTP interface number
* `Mathematica_WSTP_VERSION_MINOR` - WSTP revision number
* `Mathematica_WSTP_VERSION_STRING` - WSTP version string given as "interface.revision"
* `Mathematica_WSTP_VERSION_COUNT` - WSTP version component count (usually 2)
* `Mathematica_WSTP_RUNTIME_LIBRARY_DIRS` - list of WSTP library directories required at runtime
* `Mathematica_WSTP_RUNTIME_LIBRARY_DIRS_DEBUG` - list of debug WSTP library directories required at runtime

The module defines the following variables for component `JLink`:

* `Mathematica_JLink_FOUND` - True if the Wolfram Language installation has J/Link SDK
* `Mathematica_JLink_PACKAGE_DIR` - J/Link package root directory
* `Mathematica_JLink_JAR_FILE` - Full path to J/Link JAR file
* `Mathematica_JLink_JAVA_HOME` - Full path to Java SDK bundled with *Mathematica*
* `Mathematica_JLink_JAVA_EXECUTABLE` - path to the host Java runtime executable used by J/Link
* `Mathematica_JLink_RUNTIME_LIBRARY` - Full path to JLinkNativeLibrary
* `Mathematica_JLink_VERSION` - J/Link version number given as "major.minor.patch"
* `Mathematica_JLink_VERSION_MAJOR` - J/Link major version number
* `Mathematica_JLink_VERSION_MINOR` - J/Link minor version number
* `Mathematica_JLink_VERSION_PATCH` - J/Link patch version number
* `Mathematica_JLink_VERSION_STRING` - J/Link version string given as "major.minor.patch"
* `Mathematica_JLink_VERSION_COUNT` - JLink version component count (usually 3)

The module defines the following variables for component `MUnit`:

* `Mathematica_MUnit_FOUND` - True if the Wolfram Language installation has the Wolfram MUnit package
* `Mathematica_MUnit_PACKAGE_FILE` - MUnit package file
* `Mathematica_MUnit_PACKAGE_DIR` - MUnit package root directory
* `Mathematica_MUnit_VERSION` - MUnit version number given as "major.minor.patch"
* `Mathematica_MUnit_VERSION_MAJOR` - MUnit major version number
* `Mathematica_MUnit_VERSION_MINOR` - MUnit minor version number
* `Mathematica_MUnit_VERSION_PATCH` - MUnit patch version number
* `Mathematica_MUnit_VERSION_STRING` - MUnit version string given as "major.minor.patch"
* `Mathematica_MUnit_VERSION_COUNT` - MUnit version component count (usually 3)

Defined Functions
-----------------

Depending on the Wolfram Language version and components found, the module defines the following functions:

    Mathematica_TO_NATIVE_STRING(string result)

Converts a CMake string to a Wolfram Language `InputForm` string usable verbatim in Wolfram Language code.

    Mathematica_TO_NATIVE_LIST(result [element ...])

Converts a CMake list to a Wolfram Language `InputForm` list usable verbatim in Wolfram Language code.

    Mathematica_TO_NATIVE_PATH(path result)

Converts a CMake file path to a Wolfram Language `InputForm` file path for the native platform usable
verbatim in Wolfram Language code. The input can be a single CMake path or a CMake path list.
If multiple consecutive paths in the CMake path list share the same directory portion, the
function produces a compact Wolfram Language code representation using `Map` and `ToFileName`.

    Mathematica_EXECUTE(
      [ CODE <stmnt> [ stmnt ...] ]
      [ SCRIPT <script file> ]
      [ SYSTEM_ID systemID ]
      [ KERNEL_OPTIONS <flag> [ <flag> ...] ]
      [ TIMEOUT seconds ]
      [ RESULT_VARIABLE <result variable> ]
      [ OUTPUT_VARIABLE <output variable> [ CACHE [DOC "cache documentation string"] ] ]
      [ ERROR_VARIABLE <error variable> ]
      [ INPUT_FILE <file> ]
      [ OUTPUT_FILE <file> ]
      [ ERROR_FILE <file> ])

This function executes Wolfram Language code at CMake configuration time. The Wolfram Language code can
be specified as a list of in-line Wolfram Language statements and/or as a path to a Wolfram Language
script file. Multiple in-line statements are wrapped inside a Wolfram Language `CompoundExpression`.

If the optional `CACHE` argument is specified, the captured result of the executed Wolfram Language
code is added to a cache variable named `<output variable>`. The execution will not be repeated
unless the variable is cleared, or the result is the Wolfram Language expression `$Failed` or
`$Aborted`, or a false CMake constant.

The `SYSTEM_ID` option lets you override the Wolfram Language kernel executable architecture used
(e.g., on Windows-x86-64 you can set the `SYSTEM_ID` option to `"Windows"` to run the 32-bit kernel
executable). 
On Linux-x86-64 set the `SYSTEM_ID` option to `"Linux"` to run the 32-bit version of the
kernel. 
On macOS, you can set the `SYSTEM_ID` option to `"MacOSX-x86"` to execute the 32-bit
portion of the Wolfram Language kernel universal binary.

The `KERNEL_OPTIONS` parameter lets you add launch arguments (e.g., `"-pwfile mathpass"`) used upon
starting the Wolfram Language kernel. If the option is missing, it defaults to `"-noinit -noprompt"`.

The working directory of the Wolfram Language kernel process is set to the `CMAKE_CURRENT_BINARY_DIR`.
The other options are passed through to the CMake command `execute_process`. This function is
available if the Wolfram Language kernel executable has been found.

    Mathematica_ADD_CUSTOM_TARGET(
      targetname [ALL]
      [ CODE <stmnt> [ stmnt ...] ]
      [ SCRIPT <script file> ]
      [ DEPENDS <depend> [ <depend> ... ] ]
      [ SYSTEM_ID systemID ]
      [ KERNEL_OPTIONS <flag> [ <flag> ...] ]
      [ COMMENT comment ]
      [ SOURCES src1 [ src2... ] ])

This function adds a target that executes Wolfram Language code at build time. The Wolfram Language code
can be specified as a list of in-line Wolfram Language statements and/or as a path to a Wolfram Language
script file. Multiple in-line statements are wrapped inside a Wolfram Language `CompoundExpression`.

The `SYSTEM_ID` option lets you override the Wolfram Language kernel executable architecture used.
The working directory of the Wolfram Language kernel process is set to the `CMAKE_CURRENT_BINARY_DIR`.

The `KERNEL_OPTIONS` parameter lets you add launch arguments (e.g., `"-pwfile mathpass"`) used upon
starting the Wolfram Language kernel. If the option is missing, it defaults to `"-noinit -noprompt"`.

The other options are passed through to the CMake command `add_custom_target`. This function is
available if the Wolfram Language kernel executable has been found.

    Mathematica_ADD_CUSTOM_COMMAND(
      OUTPUT output1 [ output2 ... ]
      [ CODE <stmnt> [ stmnt ...] ]
      [ SCRIPT <script file> ]
      [ MAIN_DEPENDENCY depend ]
      [ DEPENDS [ <depend> ... ] ]
      [ SYSTEM_ID systemID ]
      [ KERNEL_OPTIONS <flag> [ <flag> ...] ]
      [ DEPENDS [ depends ...] ]
      [ COMMENT comment] [APPEND])

This function adds a target that executes Wolfram Language code to generate output files. The
Wolfram Language code is responsible for generating the specified output files. The Wolfram Language code
can be specified as a list of in-line Wolfram Language statements and/or as a path to a Wolfram Language
script file. Multiple in-line statements are wrapped inside a Wolfram Language `CompoundExpression`.

The `SYSTEM_ID` option lets you override the Wolfram Language kernel executable architecture used.

The `KERNEL_OPTIONS` parameter lets you add launch arguments (e.g., `"-pwfile mathpass"`) used upon
starting the Wolfram Language kernel. If the option is missing, it defaults to `"-noinit -noprompt"`.

The working directory of the Wolfram Language kernel process is set to the `CMAKE_CURRENT_BINARY_DIR`.
The other options are passed through to the CMake command `add_custom_command`.
This function is available if the Wolfram Language kernel executable has been found.

    Mathematica_ADD_CUSTOM_COMMAND(
      TARGET target
      PRE_BUILD | PRE_LINK | POST_BUILD
      [ CODE <stmnt> [ stmnt ...] ]
      [ SCRIPT <script file> ]
      [ SYSTEM_ID systemID ]
      [ KERNEL_OPTIONS <flag> [ <flag> ...] ]
      [ COMMENT comment ])

This function adds Wolfram Language code to an existing target which is run before or after building
the target. The code will only execute when the target itself is built. The Wolfram Language
code can be specified as a list of in-line Wolfram Language statements and/or as a path to a
Wolfram Language script file. Multiple in-line statements are wrapped inside a Wolfram Language
`CompoundExpression`.

The `KERNEL_OPTIONS` parameter lets you add launch arguments (e.g., `"-pwfile mathpass"`) used upon
starting the Wolfram Language kernel. If the option is missing, it defaults to `"-noinit -noprompt"`.

The `SYSTEM_ID` option lets you override the Wolfram Language kernel executable architecture used.

The working directory of the Wolfram Language kernel process is set to the `CMAKE_CURRENT_BINARY_DIR`.
The other options are passed through to the CMake command `add_custom_command`.
This function is available if the Wolfram Language kernel executable has been found.

    Mathematica_ADD_TEST(
      NAME testname
      [ CODE <stmnt> [ stmnt ...] ]
      [ SCRIPT <script file> ]
      [ COMMAND <command> [arg ...] ]
      [ SYSTEM_ID systemID ]
      [ KERNEL_OPTIONS <flag> [ <flag> ...] ]
      [ INPUT text | INPUT_FILE file ]
      [ CONFIGURATIONS [ Debug | Release | ... ] ])

This function adds a CMake test to the project which runs Wolfram Language code. The code can
be specified as a list of in-line Wolfram Language statements and/or as a path to a Wolfram Language
script file. Multiple in-line statements are wrapped inside a Wolfram Language `CompoundExpression`.

The `SYSTEM_ID` option lets you override the Wolfram Language kernel executable used for running this
test. This is necessary for testing LibraryLink dynamic libraries which require an architecture
compatible kernel executable (e.g., on Windows-x86-64 you can set the `SYSTEM_ID` option to
`"Windows"` to run the 32-bit kernel executable).

The `KERNEL_OPTIONS` parameter lets you add launch arguments (e.g., `"-pwfile mathpass"`) used upon
starting the Wolfram Language kernel. If the option is missing, it defaults to `"-noinit -noprompt"`.

The string specified by the `INPUT` option is fed to the Wolfram Language kernel as standard input.
The `INPUT_FILE` option specifies a file fed to the Wolfram Language kernel as standard input.

The test driver sets up environment variables `TEST_NAME` and `TEST_CONFIGURATION` which can be
queried in the Wolfram Language code by using the `Environment` function.

The other options are passed through to the CMake command `add_test`. This function is available if
the Wolfram Language kernel executable has been found.

    Mathematica_SET_TESTS_PROPERTIES(
      testname [ testname...]
      [ PROPERTIES prop1 value1 prop2 value2 ])

This function adds the required Wolfram Language runtime libraries to the environment variable
property of the given tests. The other options are passed through to the CMake command
`set_tests_properties`.

    Mathematica_ADD_LIBRARY(
      libraryname
      source1 source2 ... sourceN)

This function adds a CMake `MODULE` library target which builds a Wolfram Library from the given
sources. The generated dynamic library is loadable into the Wolfram Language kernel by using the
function `LibraryFunctionLoad`.

The function ensures that the generated library file follows the naming conventions expected
by the Wolfram Language function `LibraryFunctionLoad`.

This function is available if a Wolfram Language installation which supports LibraryLink has been
found.

    Mathematica_WolframLibrary_SET_PROPERTIES(
      libraryname [ libraryname...]
      [ PROPERTIES prop1 value1 prop2 value2 ])

This function makes sure that the file names of the given WolframLibrary shared libraries follow
the naming conventions expected by Wolfram Language upon locating a library with `FindLibrary`.
The other options are passed through to the CMake command `set_target_properties`.

    Mathematica_WolframLibrary_ADD_TEST(
      NAME testname
      TARGET <WolframLibrary target>
      [ CODE <stmnt> [ stmnt ...] ]
      [ SCRIPT <script file> ]
      [ SYSTEM_ID systemID ]
      [ KERNEL_OPTIONS <flag> [ <flag> ...] ]
      [ INPUT text | INPUT_FILE file ]
      [ CONFIGURATIONS [ Debug | Release | ... ] ])

This function adds a CMake test which loads the WolframLibrary target library and then runs
Wolfram Language test code. The Wolfram Language code specified in a `CODE` or `SCRIPT` option is
wrapped into code that loads the WolframLibrary target shared library in the following way:

    libPath = full path to <WolframLibrary target>
    LibraryLoad[ libPath ]
    Print[LibraryLink`$LibraryError]
    <stmnts>
    run <script file>
    LibraryUnload[ libPath ]

The string specified by the `INPUT` option is fed to the Wolfram Language kernel as standard input.
The `INPUT_FILE` option specifies a file fed to the Wolfram Language kernel as standard input.

The `SYSTEM_ID` option lets you override the Wolfram Language kernel executable used for running this
test (e.g., on macOS you can set the `SYSTEM_ID` option to `"MacOSX-x86"` to execute the 32-bit
portion of the Wolfram Language kernel universal binary).

The `KERNEL_OPTIONS` parameter lets you add launch arguments (e.g., `"-pwfile mathpass"`) used upon
starting the Wolfram Language kernel. If the option is missing, it defaults to `"-noinit -noprompt"`.

The test driver sets up environment variables `TEST_NAME` and `TEST_CONFIGURATION` which can be
queried in the Wolfram Language code by using the `Environment` function.

The other options are passed through to the CMake command `add_test`. This function is available if
the Wolfram Language kernel executable has been found and if the Wolfram Language installation supports
LibraryLink.

    Mathematica_GENERATE_C_CODE(
      <script file>
      [ DEPENDS [ <depend> ... ] ]
      [ OUTPUT <C source file> ])

This function uses the CCodeGenerator package to convert Wolfram Language code to C code that can be
run independently of the Wolfram Language kernel. 
Upon running, the C code only requires the Wolfram Runtime Library.

The Wolfram Language kernel script file needs to set up definitions of compiled functions and return a list
of them along with their desired C function names in the last line. Example:

    (* Wolfram Language code *)
    square = Compile[ {{x}}, x^2 ];
    cube = Compile[ {{x}}, x^3 ];
    {{square,cube},{"square","cube"}}

The function then adds a custom command which runs the Wolfram Language kernel function `CCodeGenerate` to
produce a C source file and a C header file that contains the compiled Wolfram Language functions.

The output files are created in the `CMAKE_CURRENT_BINARY_DIR`. The names of the source file and
the header file are obtained by adding the extensions .c and .h to the Wolfram Language script file
name, respectively.

The `DEPENDS` option specifies additional files on which the generated C code file depends.
The `OUTPUT` option can be used to produce output files with different names.

This function is available if the Wolfram Language kernel executable has been found and if the
Wolfram Language installation has a Wolfram Runtime Library.

    Mathematica_ENCODE(
      <input file> [ <input file> ... ]
      [ OUTPUT <output file> [ <output file> ... ] | <output directory> ]
      [ COMMENT comment ]
      [ KEY <encoding key> ]
      [ MACHINE_ID <machine ID> ]
      [ CHECK_TIMESTAMPS ] )

This function adds a custom command which runs the Wolfram Language function `Encode` on the given input
files. Wolfram Language encoded files contain only printable ASCII characters.

By default, each encoded output file is created with the same name as the corresponding input file
in `CMAKE_CURRENT_BINARY_DIR`. The `OUTPUT` option can be used to create the output files in
a different directory or with different names.

The `COMMENT` option lets you customize the log message printed when the Encode function is invoked.

The `KEY` option specifies a string to be used as the encoding key. The `MACHINE_ID` option makes
the encoded file readable only on a computer with the given `$MachineID`.

If the `CHECK_TIMESTAMPS` option is given, the encoded output file is only generated if it does not
yet exist or if the existing one is older than the corresponding input file.

This function is available if the Wolfram Language kernel executable has been found.

    Mathematica_FIND_PACKAGE(
      <variable> <package name>
      [ DOC "cache documentation string" ]
      [ SYSTEM_ID systemID ]
      [ KERNEL_OPTIONS <flag> [ <flag> ...] ])

This function finds the full CMake style path of the Wolfram Language package file that would get
loaded by the command `Get[<package name>]`.

A cache entry named by `<variable>` will be created to store the result. If the full path to the
package file is found, the result is stored in the variable, and the search will not be repeated
unless the variable is cleared. If nothing is found, the result will be `<variable>-NOTFOUND`, and
the search will be attempted again the next time `Mathematica_FIND_PACKAGE` is invoked with the same
variable.

The argument after `DOC` will be used for the documentation string in the cache.

The `SYSTEM_ID` option lets you override the Wolfram Language kernel executable architecture used.

The `KERNEL_OPTIONS` parameter lets you add launch arguments (e.g., `"-pwfile mathpass"`) used upon
starting the Wolfram Language kernel. If the option is missing, it defaults to `"-noinit -noprompt"`.
This function is available if the Wolfram Language kernel executable has been found.

    Mathematica_GET_PACKAGE_DIR(
      <variable> <package file>)

Given the full path of a file inside a Wolfram Language package, this function locates the root
directory of the Wolfram Language package and returns it in `<variable>`.

    Mathematica_ABSOLUTIZE_LIBRARY_DEPENDENCIES(
      targetname [ targetname...])

Under macOS, this function replaces the default install-names used for the Wolfram Language shared
libraries with absolute paths to those shared libraries for the given targets. 
On other platforms, the function does not have an effect.

e.g., in *Mathematica* 10, the default install-name for the MathLink shared library is:

    @executable_path/../Frameworks/mathlink.framework/Versions/4.25/mathlink

This path won't work for stand-alone executables that link to the dynamic MathLink library, unless
the mathlink framework directory is added to the `DYLD_LIBRARY_PATH` environment variable. This
function replaces the reference to the default install-name in the given target executable with the
absolute path to the MathLink library, which will work without requiring the `DYLD_LIBRARY_PATH`
environment variable to be set.

    Mathematica_MathLink_MPREP_TARGET(
      <mprep template file>
      [ OUTPUT <C source file>
      [ CUSTOM_HEADER <header file> ]
      [ CUSTOM_TRAILER <trailer file> ]
      [ LINE_DIRECTIVES ])

This function adds a custom command which creates a C source file from a MathLink template (.tm)
file with `mprep`. The generated C source file contains MathLink glue code that makes C functions
callable from the Wolfram Language via a MathLink connection.

The output file is created in the `CMAKE_CURRENT_BINARY_DIR`. The name of the output file is
obtained by adding the extensions `.c` to the input file name. If the extension of the MathLink
template file is `.tmpp`, the output file's extension will be `.cpp`, forcing compilation as a C++
file. The `OUTPUT` option can be used to produce an output file with a different name.

The options `CUSTOM_HEADER` and `CUSTOM_TRAILER` can be set to make `mprep` use a custom header and
trailer code for the generated output file. This is necessary upon cross-compiling, because the
default mprep header and trailer code emitted by `mprep` only compiles on the host platform.

If the option `LINE_DIRECTIVES` is given, the generated C source file will contain preprocessor
line directives which reference the copied code sections in the template file.

This function is available if the MathLink executable `mprep` has been found.

    Mathematica_MathLink_ADD_EXECUTABLE(
      <executable file name>
      <mprep template file>
      source1 source2 ... sourceN)

This function adds a target which creates a MathLink executable from a MathLink template file and
the given source files. It acts as a CMake replacement for the MathLink template file compiler `mcc`.

This function is available if the MathLink executable `mprep` has been found.

    Mathematica_MathLink_ADD_TEST(
      NAME testname
      TARGET <MathLink executable target>
      [ CODE <stmnt> [ stmnt ...] ]
      [ SCRIPT <script file> ]
      [ SYSTEM_ID systemID ]
      [ KERNEL_OPTIONS <flag> [ <flag> ...] ]
      [ LINK_PROTOCOL <protocol> ]
      [ LINK_MODE Launch | ParentConnect ]
      [ INPUT text | INPUT_FILE file ]
      [ CONFIGURATIONS [ Debug | Release | ... ] ])

This function adds a CMake test which runs the MathLink target executable in one of two ways:
If the `CODE` or `SCRIPT` option is present, the generated CMake test will launch the Wolfram Language
kernel and connect the MathLink executable target using the `Install` function.

The given Wolfram Language kernel test code is wrapped in the following way:

    link=Install[<MathLink executable target>]
    <stmnts>
    run <script file>
    Uninstall[link]

This corresponds to setting the `LINK_MODE` parameter to `ParentConnect`.

If neither `CODE` nor `SCRIPT` are present, the generated CMake test will launch the MathLink target
executable as a front-end to the Wolfram Language kernel. This corresponds to setting the `LINK_MODE`
parameter to `Launch`.

The `LINK_PROTOCOL` parameter specifies the MathLink link protocol (e.g., `"TCPIP"`) to use.

The text specified by the `INPUT` option is fed to the launched executable as standard input.
The `INPUT_FILE` option specifies a file fed to the launched executable as standard input.

The `SYSTEM_ID` option lets you override the Wolfram Language kernel executable used for running this
test (e.g., on Linux-x86-64 set the `SYSTEM_ID` option to `"Linux"` to run the 32-bit version of the
kernel).

The `KERNEL_OPTIONS` parameter lets you add launch arguments (e.g., `"-pwfile mathpass"`) used upon
starting the Wolfram Language kernel. If the option is missing, it defaults to `"-noinit -noprompt"`.

The test driver sets up environment variables `TEST_NAME` and `TEST_CONFIGURATION` which can be
queried in the Wolfram Language code by using the `Environment` function.

This function is available if the Wolfram Language kernel executable has been found and if the
Wolfram Language installation has a MathLink SDK.

    Mathematica_MathLink_MPREP_EXPORT_FRAMES(
      [ SYSTEM_ID systemID ]
      [ OUTPUT_DIRECTORY dir ]
      [ FORCE ] )

This function runs at CMake configure time and exports the default header and trailer code produced
by `mprep` on the host platform to text files. The files are written to the given `OUTPUT_DIRECTORY`
(defaults to the value of `CMAKE_CURRENT_BINARY_DIR`). Existing frame files in the output directory
are not overwritten unless the option `FORCE` is used.

The `SYSTEM_ID` option lets you set the System ID the frames are exported for. It defaults to the
value of `Mathematica_HOST_SYSTEM_ID`. The exported files can be used as custom `mprep` header and
trailer code when cross-compiling on a different host platform then.

e.g., exporting the MathLink mprep frames under 32-bit Windows will produce the files
`mprep_header_Windows.txt` and `mprep_trailer_Windows.txt`.

This function is available if the MathLink executable `mprep` has been found.

    Mathematica_WSTP_WSPREP_TARGET(
      <wsprep template file>
      [ OUTPUT <C source file>
      [ CUSTOM_HEADER <header file> ]
      [ CUSTOM_TRAILER <trailer file> ]
      [ LINE_DIRECTIVES ])

This function behaves as `Mathematica_MathLink_MPREP_TARGET` but uses WSTP instead of MathLink.

    Mathematica_WSTP_ADD_EXECUTABLE(
      <executable file name>
      <wsprep template file>
      source1 source2 ... sourceN)

This function behaves as `Mathematica_MathLink_ADD_EXECUTABLE` but uses WSTP instead of MathLink.

    Mathematica_WSTP_ADD_TEST(
      NAME testname
      TARGET <WSTP executable target>
      [ CODE <stmnt> [ stmnt ...] ]
      [ SCRIPT <script file> ]
      [ SYSTEM_ID systemID ]
      [ KERNEL_OPTIONS <flag> [ <flag> ...] ]
      [ LINK_PROTOCOL <protocol> ]
      [ LINK_MODE Launch | ParentConnect ]
      [ INPUT text | INPUT_FILE file ]
      [ CONFIGURATIONS [ Debug | Release | ... ] ])

This function behaves as `Mathematica_MathLink_ADD_TEST` but uses WSTP instead of MathLink.

    Mathematica_WSTP_WSPREP_EXPORT_FRAMES(
      [ SYSTEM_ID systemID ]
      [ OUTPUT_DIRECTORY dir ]
      [ FORCE ] )

This function behaves as `Mathematica_MathLink_MPREP_EXPORT_FRAMES` but uses WSTP instead of
MathLink.

    Mathematica_JLink_ADD_TEST(
      NAME testname
      TARGET <Java JAR custom target>
      [ CODE <stmnt> [ stmnt ...] ]
      [ SCRIPT <script file> ]
      [ MAIN_CLASS <Java class name> ]
      [ CLASSPATH <class path entry> [ <class path entry> ...] ]
      [ SYSTEM_ID systemID ]
      [ KERNEL_OPTIONS <flag> [ <flag> ...] ]
      [ LINK_PROTOCOL <protocol> ]
      [ LINK_MODE Launch | ParentConnect ]
      [ INPUT text | INPUT_FILE file ]
      [ CONFIGURATIONS [ Debug | Release | ... ] ])

This function adds a CMake test which runs the given Java JAR target in one of two ways:
If the `CODE` or `SCRIPT` option is present, the generated CMake test will launch the Wolfram Language
kernel and add the JAR target file path to the J/Link class search path.

The given Wolfram Language test code is wrapped in the following way:

    Needs["JLink`"]
    AddToClassPath[<Java JAR file target>]
    <stmnts>
    run <script file>

This corresponds to setting the `LINK_MODE` parameter to `ParentConnect`.

If neither `CODE` nor `SCRIPT` are present, the generated CMake test will launch the Java JAR target
as a front-end to the Wolfram Language kernel. This corresponds to setting the `LINK_MODE` parameter
to `Launch`.

The `LINK_PROTOCOL` specifies the MathLink link protocol (e.g., `"TCPIP"`) to use.

The option `CLASSPATH` specifies a list of directories, JAR archives, and ZIP archives to search for
class files. The J/Link JAR file is always added to the class path. The optional `MAIN_CLASS`
parameter specifies the Java class whose main method should be invoked.

The text specified by the `INPUT` option is fed to the launched JAR as standard input. The
`INPUT_FILE` option specifies a file fed to the launched JAR as standard input.

The `SYSTEM_ID` option lets you override the Wolfram Language kernel executable used for running this
test (e.g., on Linux-x86-64 set the `SYSTEM_ID` option to `"Linux"` to run the 32-bit version of the
kernel).

The `KERNEL_OPTIONS` parameter lets you add launch arguments (e.g., `"-pwfile mathpass"`) used upon
starting the Wolfram Language kernel. If the option is missing, it defaults to `"-noinit -noprompt"`.

The test driver sets up environment variables `TEST_NAME` and `TEST_CONFIGURATION` which can be
queried in the Wolfram Language code by using the `Environment` function.

This function is available if the Wolfram Language kernel executable has been found and if the
Wolfram Language installation has a J/Link SDK.

    Mathematica_MUnit_RESOLVE_SUITE(
      result [RELATIVE path]
      <test file> [ <test file> ... ] )

This function resolves `TestSuite[{ ... }]` expressions in the given MUnit test files (.mt or .wlt)
into the list of underlying MUnit test files. The test file names are interpreted relative to
the test suite file. By default, the function returns the absolute paths of the parsed test
files. If the `RELATIVE` option is specified, results will be returned as a relative path to
the given path. If a given test file does not contain a `TestSuite` expression, its path will
be returned instead.

This function is available if the MUnit package and the Wolfram Language kernel executable have been
found.

    Mathematica_MUnit_ADD_TEST(
      NAME testname
      [ CODE <stmnt> [ stmnt ...] ]
      SCRIPT <test script or notebook>
      [ LOGGERS <stmnt> ]
      [ SYSTEM_ID systemID ]
      [ KERNEL_OPTIONS <flag> [ <flag> ...] ])
      [ INPUT text | INPUT_FILE file ]
      [ TIMEOUT seconds ]
      [ CONFIGURATIONS [ Debug | Release | ... ] ])

This function adds a CMake test which runs a Wolfram MUnit test file (.mt or .wlt). If the test
file contains a `TestSuite[{ ... }]` expression, all the test files that belong to the suite will be
run.

The Wolfram Language code specified with the `CODE` option can be used to initialize
the kernel state before the MUnit test file is run.

The CMake test will only succeed if all MUnit test expressions in the test file pass.
The test is run with the Wolfram MUnit test package in the following way:

    Needs["MUnit`"]
    <stmnts>
    TestRun[ <test script or notebook> ]

The `LOGGERS` options is passed through to the TestRun function and specifies the list
of MUnit loggers to use (e.g., `{VerbosePrintLogger[]}`).

The function requires the Wolfram MUnit package to be available on the Wolfram Language `$Path`.

The string specified by the `INPUT` option is fed to the Wolfram Language kernel as standard input.
The `INPUT_FILE` option specifies a file fed to the Wolfram Language kernel as standard input.

The `TIMEOUT` option will be used to initialize to `TIMEOUT` property of the generated CMake test.

The `SYSTEM_ID` option lets you override the Wolfram Language kernel executable used for running this
test (e.g., on 64-bit Windows you can set the `SYSTEM_ID` option to `"Windows"` to execute the
32-bit version of the Wolfram Language kernel).

The `KERNEL_OPTIONS` parameter lets you add launch arguments (e.g., `"-pwfile mathpass"`) used upon
starting the Wolfram Language kernel. If the option is missing, it defaults to `"-noinit -noprompt"`.

The test driver sets up environment variables `TEST_NAME` and `TEST_CONFIGURATION` which can be
queried in the Wolfram Language code by using the `Environment` function.

The other options are passed through to the CMake command `add_test`. This function is available if
the MUnit package and the Wolfram Language kernel executable have been found.

    Mathematica_ADD_DOCUMENTATION(
      targetname [ ALL ]
      [ DOCUMENTATION_TYPE "Notebook" | "HTML" ]
      [ INPUT_DIRECTORY dir ]
      [ OUTPUT_DIRECTORY dir ]
      [ APPLICATION_NAME name ]
      [ LANGUAGE name ]
      [ CHECK_TIMESTAMPS ]
      [ INCLUDE_NOTEBOOKS ]
      [ COMMENT comment ]
      [ JAVACMD path ]
      [ SOURCES src1 [ src2... ] ])

This function adds a custom target which builds documentation from previously authored Wolfram Language
documentation notebooks (e.g., guide pages, symbol pages, and tutorial pages).

The function requires the Wolfram Language packages `DocumentationBuild` and `Transmogrify` to be
available on the Wolfram Language `$Path`. The documentation is generated by invoking Apache Ant build
scripts provided by the `DocumentationBuild` package.

The build script looks for documentation notebooks in the given `INPUT_DIRECTORY` and writes the
built documentation to the given `OUTPUT_DIRECTORY`. If omitted, `INPUT_DIRECTORY` defaults to
the value of `CMAKE_CURRENT_SOURCE_DIR` and `OUTPUT_DIRECTORY` defaults to the value of
`CMAKE_CURRENT_BINARY_DIR`.

Previously built documentation files in `OUTPUT_DIRECTORY` are removed before the Ant script is
invoked.

`DOCUMENTATION_TYPE` specifies the type (`"Notebook"` or `"HTML"`) of the built documentation with
`"Notebook"` being the default.

`APPLICATION_NAME` gives the base name of the generated documentation links (defaults to
the value of `PROJECT_NAME`).

`LANGUAGE` sets the documentation language (e.g., `"Japanese"`). It defaults to `"English"`, if
omitted.

If the `CHECK_TIMESTAMPS` option is given, the documentation is generated if it does not yet exist,
or if a documentation notebook in the `INPUT_DIRECTORY` is newer than the corresponding notebook in
the `OUTPUT_DIRECTORY`.

If the `INCLUDE_NOTEBOOKS` option is `TRUE`, the existing documentation notebooks will be added as
sources to the generated custom target.

The option `JAVACMD` can be set to the full path to the Java runtime executable use by Apache Ant.
It defaults to the value of `Mathematica_JLink_JAVA_EXECUTABLE`.

The other options are passed through to the CMake command `add_custom_target`.

If the required Wolfram Language packages or Apache Ant are not found, the generated custom target will
just generate an empty documentation directory. This function is available if J/Link and the
Wolfram Language kernel executable have been found.

Known Issues
------------

* Each invocation of a Wolfram Language kernel through the FindMathematica module consumes one
  controller kernel license. You may run out of free controller kernel licenses if you
  do a parallel build with CMake or run tests in parallel with CTest.

[aant]:https://ant.apache.org/
[cmtut]:https://cmake.org/cmake/help/latest/guide/tutorial/index.html
[uuid]:https://linux.die.net/man/3/libuuid
[mingw]:http://www.mingw.org/
