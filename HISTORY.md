## 4.2.0 (2025-08-08)

* Wolfram App 14.3 compatibility
* fix default system ID detection under macOS for Apple Silicon
* add support for `Linux-ARM64`

## 4.1.0 (2025-01-25)

* Wolfram App 14.2 compatibility
* Wolfram App 14.1 compatibility
* raise the minimum required CMake version to 3.10
* remove broken macOS LaunchServices database search

## 4.0.0 (2024-01-10)

* *Mathematica* 14.0 compatibility
* *Mathematica* 13.3 compatibility
* raise the minimum required CMake version to 3.5
* manual updates

## 3.8.0 (2022-12-30)

* *Mathematica* 13.2 compatibility

## 3.7.0 (2022-09-24)

* *Mathematica* 13.1 compatibility

## 3.6.0 (2021-12-15)

* *Mathematica* 13 compatibility
* warn explicitly about common mistakes users make
* fix for Mathematica installed in Windows docker container
* fix broken launch services database search under OS X

## 3.5.0 (2021-05-21)

* *Mathematica* 12.3 compatibility

## 3.4.0 (2020-12-19)

* *Mathematica* 12.2 compatibility
* add `Mathematica_RUN_KERNEL_ON_CONFIGURE` switch to control if FindMathematica is allowed to
  implicitly run the *Mathematica* kernel at CMake configuration time

## 3.3.0 (2020-03-25)

* *Mathematica* 12.1 compatibility
* remove `Mathematica_SPLICE_C_CODE` whose underlying *Mathematica* function `Splice` 
  has been deprecated since *Mathematica* 10 and has been removed in *Mathematica* 12.1
* add new variable `Mathematica_JLink_JAVA_HOME`, which contains the full path to Java SDK 
  bundled with *Mathematica*

## 3.2.7 (2020-02-09)

* fix compatibility with Wolfram Engine under OS X
* fix front end detection for Wolfram Desktop
* manual updates

## 3.2.6 (2020-02-07)

* Wolfram Desktop compatibility
* Wolfram Engine compatibility

## 3.2.5 (2019-04-28)

* *Mathematica* 12.0 compatibility
* add `libuuid` to list of required runtime libraries under Linux
* remove 32-bit Linux from supported system IDs for *Mathematica* versions >= 11.3

## 3.2.4 (2018-03-16)

* *Mathematica* 11.3 compatibility

## 3.2.3 (2017-09-15)

* *Mathematica* 11.2 compatibility
* *Mathematica* 11.1 compatibility
* add new variables for component runtime directories (e.g.,
  `Mathematica_MathLink_RUNTIME_LIBRARY_DIRS`)

## 3.2.2 (2016-09-28)

* Xcode 8 compatibility fix
* Cygwin compatibility fix

## 3.2.1 (2016-08-17)

* *Mathematica* 11 compatibility
* fix rpath handling for code generation examples under Linux and OS X
* fix handling of `Mathematica_USE_LIBCXX_LIBRARIES` for *Mathematica* 10.4 and 11

## 3.2.0 (2016-03-20)

* *Mathematica* 10.4 compatibility
* add variable `Mathematica_MathLink_FIND_VERSION_MINOR` (requested MathLink revision)
* add variable `Mathematica_WSTP_FIND_VERSION_MINOR` (requested WSTP revision)
* rename `Mathematica_JLink_LIBRARY` to `Mathematica_JLink_RUNTIME_LIBRARY`

## 3.1.4 (2015-10-18)

* *Mathematica* 10.3 compatibility
* add work-around to compile LibraryLink examples with Visual Studio 2015

## 3.1.3 (2015-10-10)

* add timestamp check for HTML docu generation
* add `JAVACMD` option to `Mathematica_ADD_DOCUMENTATION`
* use `java_home` to find Java runtime executable under OS X
* remove obsolete code
* documentation updates

## 3.1.2 (2015-07-25)

* *Mathematica* 10.2 compatibility
* fix variable dereferences in `if` commands

## 3.1.1 (2015-04-21)

* fix *Mathematica* 10.1 compatibility issues
* do not use broken `-script` option for *Mathematica* earlier than 10.0
* add variables `Mathematica_LibraryLink_PACKAGE_FILE` and `Mathematica_LibraryLink_PACKAGE_DIR`
* copy standard examples to binary directory instead of source directory
* add CMake tests for new LibraryLink examples

## 3.1.0 (2015-04-06)

* add compatibility with *Mathematica* 10.1
* fix CMake 3.2 compatibility issues
* require at least CMake 2.8.12
* remove obsolete code required for CMake versions older than 2.8.12
* prefer modern executable names (i.e., `wolfram.exe`) over classic ones (i.e., `math.exe`)
* add parameter `LINK_MODE` to some functions (see manual)
* manual updates

## 3.0.3 (2015-02-11)

* work around `cmd.exe` command line length limit when running *Mathematica* code
* fix `cmd.exe` command line quoting issues
* fix for running MUnit tests
* more robust cache cleaning of invalid WSTP related variables
* print message when `DocumentationBuild` package is not installed

## 3.0.2 (2014-12-21)

* fix bug with computing of *Mathematica* 10.0.2 version number
* fix bug with finding correct MathLink / WSTP DeveloperKit under OS X
* CMake 3.1.0 compatibility fixes
* fix quoting issues

## 3.0.1 (2014-12-11)

* add compatibility with *Mathematica* 10.0.2
* add variables `Mathematica_MathLink_DEFINITIONS` and `Mathematica_MathLink_LINKER_FLAGS`
* add variables `Mathematica_WSTP_DEFINITIONS` and `Mathematica_WSTP_LINKER_FLAGS`
* use `-wstp` flag for launching WSTP executables
* prevent conflicts with MSVC runtime library upon linking static MathLink or WSTP library
* add MathLink or WSTP framework directory to `Mathematica_RUNTIME_LIBRARY_DIRS` under OS X
* manual updates

## 3.0.0 (2014-08-19)

* add support for *Mathematica* 10
* CMake 3.0.0 compatibility fixes
* add support for WSTP (Wolfram Symbolic Transfer Protocol)
* move documentation from file `FindMathematica.cmake` to manual file of its own
* preserve directory structure when using `Mathematica_ENCODE` with an output folder
* add variable `Mathematica_MathLink_FIND_VERSION_MAJOR` (requested MathLink major version)
* add variable `Mathematica_JLink_LIBRARY` (path to J/Link's `JLinkNativeLibrary`)
* add variable `Mathematica_JLink_JAVA_EXECUTABLE` (path to the host Java runtime)
* add option `LINK_PROTOCOL` to `Mathematica_MathLink_ADD_TEST` and `Mathematica_JLink_ADD_TEST`
* change in `Mathematica_MathLink_MPREP_TARGET` and `Mathematica_MathLink_ADD_EXECUTABLE`:
  if MathLink template file extension is .tmpp, generate C++ source file from it
* add variable `Mathematica_USE_LIBCXX_LIBRARIES` to prefer libc++ linked libraries to
  libstdc++ linked libraries (OS X only)

## 2.2.5 (2013-06-08)

* handle `Mathematica_FIND_VERSION_EXACT` parameter correctly

## 2.2.4 (2013-02-10)

* honor `MATHEMATICA_HOME` environment variable introduced with *Mathematica* 8.0.4

## 2.2.3 (2013-01-29)

* handle `Mathematica_FIND_VERSION_EXACT` parameter correctly

## 2.2.2 (2012-12-07)

* *Mathematica* 9 compatibility fixes

## 2.2.1 (2012-10-23)

* Windows registry search fix for WoW64
* add option `INCLUDE_NOTEBOOKS` to `Mathematica_ADD_DOCUMENTATION`
* more robust cache cleaning of invalid FindMathematica related variables
* add check to test if *Mathematica* has been registered properly
* move option variable initialization to function of its own
* quoting fixes

## 2.2.0 (2012-09-22)

* add `Mathematica_JLink_ADD_TEST` to run J/Link program as a CMake test
* add J/Link examples
* allow for both `CODE` and `SCRIPT` parameters to be present in functions that execute
  *Mathematica* code
* correctly handle the relative file path given as a `SCRIPT` parameter
* fix Cygwin compatibility problems

## 2.1.0 (2012-09-02)

* add option `CHECK_TIMESTAMPS` to `Mathematica_ADD_DOCUMENTATION` to avoid redundant re-building
  of the documentation when no notebook has changed
* fixed bug with detection of `ant.bat` executable script under Windows
* guard against missing test driver helper scripts
* fixed bug with setting up the kernel command line when both `CODE` and `SCRIPT` are present
* add work-around to prevent CMake commands that run the kernel from hanging when `Abort[]` is used
* add more accurate detection of host processor architecture under OS X
* minor documentation fixes

## 2.0.9 (2012-08-17)

* prevent modification of the CMake policy stack upon CMake version check
* fix target type check in `Mathematica_ABSOLUTIZE_LIBRARY_DEPENDENCIES`

## 2.0.8 (2012-08-09)

* detect Wolfram Finance Platform installation
* fix undefined variable dereference

## 2.0.7 (2012-06-21)

* fix out of range index operation

## 2.0.6 (2012-05-10)

* fix native path conversion issues
* improve compiler version detection code

## 2.0.5 (2012-03-05)

* fix use of uninitialized variables
* fixed Wolfram Library runtime directory selection for OS X 10.7

## 2.0.4 (2012-02-26)

* fix compiler version detection for Visual Studio C++
* fix LaunchServices database search bug under OS X
* add `Mathematica_MathLink_HOST_INCLUDE_DIR`
* quoting fixes

## 2.0.3 (2012-01-19)

* fix LaunchServices database search under OS X 10.7

## 2.0.2 (2012-01-03)

* under Windows search registry determined installation locations first
* under OS X search LaunchServices database determined installation locations first
* under OS X programmatically find path to `lsregister` executable
* tested with CMake 2.8.7

## 2.0.1 (2011-12-20)

* skip cleanup of CMake cache upon initial invocation
* cross-compiling fixes
* add work-around that allows for generating LibraryLink workable DLLs with Cygwin
* add `Mathematica_CREATION_ID` variable
* recompute version information if *Mathematica* is upgraded in-place (e.g., from 8.0.1 to 8.0.4)

## 2.0.0 (2011-12-05)

* add support for finding J/Link
* add support for finding Wolfram MUnit testing package
* add MUnit wrapper functions `Mathematica_MUnit_ADD_TEST` and `Mathematica_MUnit_RESOLVE_SUITE`
* add support for generating *Mathematica* documentation with the DocumentationBuild package
* add new function `Mathematica_FIND_PACKAGE`
* add new function `Mathematica_GET_PACKAGE_DIR`
* FindMathematica module directory is now prepended to the *Mathematica* `$Path`
* add `CACHE` option to function `Mathematica_EXECUTE`
* add `KERNEL_OPTIONS` parameter to functions which launch the *Mathematica* kernel
* function `Mathematica_TO_NATIVE_PATH` now also handles a list of CMake paths
* function `Mathematica_ENCODE` now can encode multiple files at the same time
* pass `TEST_NAME` and `TEST_CONFIGURATION` environment variables to *Mathematica* test scripts
* use `exec` in UNIX test driver shell script upon launching test executable
* add `INPUT_FILE` option to function `Mathematica_EXECUTE`
* add `DEPENDS` option to function `Mathematica_ADD_CUSTOM_TARGET`
* add `MAIN_DEPENDENCY` option to function `Mathematica_ADD_CUSTOM_COMMAND`
* add `DEPENDS` option to function `Mathematica_GENERATE_C_CODE`
* install Wolfram Library without modifying `$LibraryPath` in `Mathematica_WolframLibrary_ADD_TEST`

## 1.2.6 (2011-12-03)

* fix debug output

## 1.2.5 (2011-12-02)

* fix bug in launch services database search code under OS X

## 1.2.4 (2011-11-17)

* preserve user defined overrides upon option initialization
* don't set `RUN_SERIAL` option in `Mathematica_SET_TESTS_PROPERTIES`

## 1.2.3 (2011-11-08)

* fix cache cleanup bug
* use functions instead of macros to work around the Windows backslash problem
* improve `Mathematica_ADD_CUSTOM_TARGET` documentation

## 1.2.2 (2011-11-07)

* properly document `SYSTEM_ID` option
* stricter *Mathematica* version checks
* fix bug in `Mathematica_EXECUTE` with handling of `SYSTEM_ID` option

## 1.2.1 (2011-11-04)

* Windows registry search fix
* add work-around for Windows cmd.exe quotation problem
* fix bug in function that sets up version variables
* make code more robust against exceptional usage cases

## 1.2.0 (2011-10-30)

* add `Mathematica_ENCODE` function
* add `Mathematica_ABSOLUTIZE_LIBRARY_DEPENDENCIES` function
* fixed use of `Mathematica_USERBASE_DIR` in examples
* fixed RPATH issues under Linux

## 1.1.2 (2011-10-26)

* option initialization fixes
* tested with *Mathematica* 8.0.4

## 1.1.1 (2011-09-24)

* file path conversion fixes for Cygwin and MinGW

## 1.1.0 (2011-09-17)

* add `Mathematica_BASE_DIR` and `Mathematica_USERBASE_DIR` variables
* fixed some character escaping issues

## 1.0.4 (2011-07-12)

* tested with Wolfram Lightweight Grid Manager 8.0
* fixed some uninitialized variables

## 1.0.3 (2011-07-07)

* work around `Splice::splict` message in `Mathematica_SPLICE_C_CODE`
* fix build failures when the build directory path contains space characters
* use CMake `option` command for user overridable boolean module variables

## 1.0.2 (2011-07-02)

* Fix *Mathematica* detection on PPC equipped Macs

## 1.0.1 (2011-04-03)

* Changes for undefined WIN32 variable under Cygwin with CMake 2.8.4
* Tested with *Mathematica* 8.0.1
* Code cleanup

## 1.0.0 (2010-12-05)

* First release
