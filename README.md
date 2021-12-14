FindMathematica
===============

FindMathematica is a CMake module that tries to find a Wolfram Language installation and
provides CMake functions for its C/C++ interface.

Features
--------

* Works with Windows, Linux and OS X versions of the [Wolfram Language][wlang].
* Supports Wolfram Language versions from 5.2 to 13.0.
* Supports Wolfram Language implementations [Wolfram Mathematica][wmma],
  [Wolfram|One][wone], [Wolfram Engine][weng] and [Wolfram gridMathematica][wgrid].
* Finds include directories and libraries for [LibraryLink][wll] (version 8 or later).
* Finds include directories and libraries for [WSTP][wstp] (version 10 or later).
* Finds installation directory and JAR file of [J/Link][jlnk].
* Finds include directories and libraries for MathLink.
* Finds installation directory of Wolfram MUnit testing package.
* Provides exact version info for the Wolfram Language, LibraryLink, WSTP, MathLink, 
  J/Link and MUnit.
* Allows for running Wolfram Language code during CMake configure or build time.
* Allows for running Wolfram Language code as a pre-link, pre-build or post-build action.
* Allows for running Wolfram Language code in CMake test targets.
* Allows for running Wolfram Language MUnit test files and suites as CMake test targets.
* Supports generating C code from WSTP template files using `wsprp` executable.
* Supports generating C code from MathLink template files using `mprep` executable.
* Supports building dynamic libraries loadable with [LibraryLink][wll].
* Supports generating stand-alone C code from Wolfram Language code with [CCodeGenerator][ccg].
* Provides CMake interface to Wolfram Language's [Encode][encd] function.
* Supports generating Wolfram Language documentation with the DocumentationBuild package.
* Fully leverages CMake's [cross-compiling][ccrc] support.

Requirements
------------

* A [Wolfram Language][wlang] product (Wolfram Mathematica, Wolfram|One, Wolfram Engine, 
  Wolfram gridMathematica).
* [CMake 2.8.12][cmk] or newer. The executable `cmake` should be on the system path.
* [Visual Studio C++][vslstd], [MinGW][mingw] or [Cygwin][cgwn] under Windows.
* [GCC][gcc] or [Clang][clang] under Linux or OS X.
* [Xcode][xcdt] application or Xcode Command Line Tools under OS X.
* [libuuid][uuid] under Linux.
* [Apache Ant][aant] is required for generating Wolfram Language documentation. 

Installation
------------

Copy the directory `CMake/Mathematica` to the root directory of your CMake project. In the
top-level `CMakeList.txt` file, add the module directory to the CMake module search path:

    set (CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/CMake/Mathematica" ${CMAKE_MODULE_PATH})

Usage
-----

To find the newest Wolfram Language installation in a CMake list file, run the `find_package`
command:

    find_package(Mathematica)

See the [FindMathematica manual][manual] for more information.

Alternatives
------------

In October 2020, Wolfram Research have released [LibraryLinkUtilities][wllu] as an open source
project that provides modern C++ wrappers for conveniently wrapping Wolfram LibraryLink code.

[aant]:https://ant.apache.org/
[ccg]:https://reference.wolfram.com/language/CCodeGenerator/guide/CCodeGenerator.html
[ccrc]:https://gitlab.kitware.com/cmake/community/wikis/doc/cmake/CrossCompiling
[cgwn]:https://www.cygwin.com/
[clang]:https://clang.llvm.org/
[cmk]:https://cmake.org/download/
[encd]:https://reference.wolfram.com/language/ref/Encode.html
[gcc]:https://gcc.gnu.org/
[jlnk]:https://reference.wolfram.com/language/JLink/tutorial/Overview.html
[manual]:https://github.com/sakra/FindMathematica/blob/master/MANUAL.md
[mingw]:http://www.mingw.org/
[uuid]:https://linux.die.net/man/3/libuuid
[vslstd]:https://visualstudio.microsoft.com/
[weng]:https://www.wolfram.com/engine
[wgrid]:https://www.wolfram.com/gridmathematica/
[wlang]:https://www.wolfram.com/language
[wllu]:https://github.com/WolframResearch/LibraryLinkUtilities
[wll]:https://reference.wolfram.com/language/guide/LibraryLink.html
[wmma]:https://www.wolfram.com/mathematica/
[wone]:https://www.wolfram.com/wolfram-one/
[wstp]:https://reference.wolfram.com/language/tutorial/WSTPAndExternalProgramCommunicationOverview.html
[xcdt]:https://developer.apple.com/xcode/
