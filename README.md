FindMathematica
===============

FindMathematica is a CMake module that tries to find a *Mathematica* installation and
provides CMake functions for *Mathematica*'s C/C++ interface.

Features
--------

* Works with Windows, Linux and OS X versions of *Mathematica*.
* Finds *Mathematica* versions from 5.2 to 10.0.
* Finds include directories and libraries for [LibraryLink][wll] (*Mathematica* 8 to 10).
* Finds include directories and libraries for [WSTP][wstp] (*Mathematica* 10).
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
* Supports building dynamic libraries loadable with [LibraryLink][wll] (*Mathematica* 8 to 10).
* Supports generating stand-alone C code from *Mathematica* code with [CCodeGenerator][ccg]
  (*Mathematica* 8 to 10).
* Provides CMake interface to *Mathematica*'s [Splice][splc] function.
* Provides CMake interface to *Mathematica*'s [Encode][encd] function.
* Supports generating *Mathematica* documentation with the DocumentationBuild package.
* Fully leverages CMake's [cross-compiling][ccrc] support.

Requirements
------------

* A Wolfram [*Mathematica*][wmma] product (*Mathematica* 5.2 to 10.0, gridMathematica 7.0 to 10.0
  or Wolfram Finance Platform).
* [CMake 2.8.9][cmk] or newer. The executable `cmake` should be on the system path.
* [Visual Studio C++][vslstd], [MinGW][mingw] or [Cygwin][cgwn] under Windows.
* [GCC][gcc] (including g++) under Linux.
* [Xcode][xcdt] developer tools package under OS X.

Installation
------------

Copy the directory `CMake/Mathematica` to the root directory of your CMake project. In the
top-level `CMakeList.txt` file, add the module directory to the CMake module search path:

    set (CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/CMake/Mathematica" ${CMAKE_MODULE_PATH})

Usage
-----

To find the newest *Mathematica* installation in a CMake listfile, run the `find_package`
command:

    find_package(Mathematica)

See the [FindMathematica manual][manual] for more information.

[ccg]:http://reference.wolfram.com/language/CCodeGenerator/guide/CCodeGenerator.html
[ccrc]:http://www.cmake.org/Wiki/CMake_Cross_Compiling
[cgwn]:http://www.cygwin.com/
[cmk]:http://www.cmake.org/cmake/resources/software.html
[encd]:http://reference.wolfram.com/language/ref/Encode.html
[gcc]:http://gcc.gnu.org/
[jlnk]:http://reference.wolfram.com/language/JLink/tutorial/Overview.html
[manual]:https://github.com/sakra/FindMathematica/blob/master/MANUAL.md
[mingw]:http://www.mingw.org/
[splc]:http://reference.wolfram.com/language/ref/Splice.html
[vslstd]:http://msdn.microsoft.com/vstudio/
[wll]:http://reference.wolfram.com/language/guide/LibraryLink.html
[wmma]:http://www.wolfram.com/mathematica/
[wstp]:http://reference.wolfram.com/language/tutorial/WSTPAndExternalProgramCommunicationOverview.html
[xcdt]:http://developer.apple.com/xcode/
