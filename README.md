FindMathematica
===============

FindMathematica is a CMake module that tries to find a *Mathematica* installation and
provides CMake functions for *Mathematica*'s C/C++ interface.

Features
--------

* Works with Windows, Linux and OS X versions of *Mathematica*.
* Finds *Mathematica* versions from 5.2 to 12.0.
* Finds include directories and libraries for [LibraryLink][wll] (*Mathematica* 8 or later).
* Finds include directories and libraries for [WSTP][wstp] (*Mathematica* 10 or later).
* Finds installation directory and JAR file of [J/Link][jlnk].
* Finds include directories and libraries for MathLink (obsolete as of *Mathematica* 10).
* Finds installation directory of Wolfram MUnit testing package.
* Provides exact version info for *Mathematica*, LibraryLink, WSTP, MathLink, J/Link and MUnit.
* Allows for running *Mathematica* code during CMake configure or build time.
* Allows for running *Mathematica* code as a pre-link, pre-build or post-build action.
* Allows for running *Mathematica* code in CMake test targets.
* Allows for running *Mathematica* MUnit test files and suites as CMake test targets.
* Supports generating C code from WSTP template files using `wsprp` executable.
* Supports generating C code from MathLink template files using `mprep` executable.
* Supports building dynamic libraries loadable with [LibraryLink][wll] (*Mathematica* 8 or later).
* Supports generating stand-alone C code from *Mathematica* code with [CCodeGenerator][ccg]
  (*Mathematica* 8 or later).
* Provides CMake interface to *Mathematica*'s [Encode][encd] function.
* Supports generating *Mathematica* documentation with the DocumentationBuild package.
* Fully leverages CMake's [cross-compiling][ccrc] support.

Requirements
------------

* A Wolfram [*Mathematica*][wmma] product (*Mathematica*, gridMathematica, Wolfram Finance Platform).
* [CMake 2.8.12][cmk] or newer. The executable `cmake` should be on the system path.
* [Visual Studio C++][vslstd], [MinGW][mingw] or [Cygwin][cgwn] under Windows.
* [GCC][gcc] or [Clang][clang] under Linux or OS X.
* [Xcode][xcdt] application or Xcode Command Line Tools under OS X.
* [libuuid][uuid] under Linux.
* [Apache Ant][aant] is required for generating *Mathematica* documentation. 

Installation
------------

Copy the directory `CMake/Mathematica` to the root directory of your CMake project. In the
top-level `CMakeList.txt` file, add the module directory to the CMake module search path:

    set (CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/CMake/Mathematica" ${CMAKE_MODULE_PATH})

Usage
-----

To find the newest *Mathematica* installation in a CMake list file, run the `find_package`
command:

    find_package(Mathematica)

See the [FindMathematica manual][manual] for more information.

[aant]:https://ant.apache.org/
[ccg]:https://reference.wolfram.com/language/CCodeGenerator/guide/CCodeGenerator.html
[ccrc]:https://gitlab.kitware.com/cmake/community/wikis/doc/cmake/CrossCompiling
[clang]:https://clang.llvm.org/
[cgwn]:https://www.cygwin.com/
[cmk]:https://cmake.org/download/
[encd]:https://reference.wolfram.com/language/ref/Encode.html
[gcc]:https://gcc.gnu.org/
[jlnk]:https://reference.wolfram.com/language/JLink/tutorial/Overview.html
[libuuid]:https://linux.die.net/man/3/libuuid
[manual]:https://github.com/sakra/FindMathematica/blob/master/MANUAL.md
[mingw]:http://www.mingw.org/
[vslstd]:https://visualstudio.microsoft.com/
[wll]:https://reference.wolfram.com/language/guide/LibraryLink.html
[wmma]:https://www.wolfram.com/mathematica/
[wstp]:https://reference.wolfram.com/language/tutorial/WSTPAndExternalProgramCommunicationOverview.html
[xcdt]:https://developer.apple.com/xcode/
