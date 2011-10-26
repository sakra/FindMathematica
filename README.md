FindMathematica
===============

FindMathematica is a CMake module that tries to find a *Mathematica* installation and
provides CMake functions for *Mathematica*'s C/C++ interface.

Features
--------

* Works with Windows, Linux and Mac OS X versions of *Mathematica*.
* Finds *Mathematica* versions from 5.2 to 8.0.
* Finds include directories and libraries for [MathLink][mtlnk].
* Finds include directories and libraries for [LibraryLink][wll] (*Mathematica* 8 only).
* Provides exact version information for *Mathematica*, MathLink and LibraryLink.
* Allows for running *Mathematica* code during CMake configure or build time.
* Allows for running *Mathematica* code as a pre-link, pre-build or post-build action.
* Allows for running *Mathematica* code in CMake test targets.
* Supports generating C code from MathLink template files using [mprep][mprp].
* Supports building dynamic libraries loadable with [LibraryLink][wll] (*Mathematica* 8 only).
* Supports generating stand-alone C code from *Mathematica* code with [CCodeGenerator][ccg]
  (*Mathematica* 8 only).
* Provides CMake interface to *Mathematica*'s [Splice][splc] function.
* Fully leverages CMake's [cross-compiling][ccrc] support.

Requirements
------------

* A Wolfram [*Mathematica*][wmma] product (*Mathematica* 5.2 to 8.0 or
  Lightweight Grid Manager 7.0 to 8.0).
* [CMake 2.8.4][cmk] or newer. The executable `cmake` should be on the system path.
* [Visual Studio C++][vslstd], [MinGW][mingw] or [Cygwin][cgwn] under Windows.
* [gcc][gcc] (including g++) under Linux.
* [Xcode][xcdt] developer tools package under Mac OS X.

Installation
------------

Copy the directory `CMake/Mathematica` to the root directory of your CMake project. In the
top-level `CMakeList.txt` file add the module directory to the CMake module search path:

    set (CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/CMake/Mathematica" ${CMAKE_MODULE_PATH})

Usage
-----

If you are new to CMake, check out the [CMake tutorial][cmtut] first.

To find the default *Mathematica* installation in a CMake listfile, run the `find_package`
command:

    find_package(Mathematica)

To find a specific version of *Mathematica*, run the `find_package` command with a version
argument:

    find_package(Mathematica 8.0)

The comment section of `FindMathematica.cmake` contains documentation for all the variables
that the module provides along with the functions that wrap *Mathematica*'s C/C++ interface.

The package ships as a fully functional CMake project that demonstrates how to use functionality
provided by the FindMathematica module:

* `MathematicaExamples` show how to run plain *Mathematica* code as part of the build process.
* `MathLinkExamples` build all standard MathLink example files (e.g., `addtwo.tm`, `bitops.tm`,
  `factor.c`).
* `LibraryLinkExamples` build all standard LibraryLink example files (e.g., `demo.c`,
  `demo_shared.c`, `demo_string.c`).
* `CodeGenerationExamples` builds binaries from *Mathematica* compiled functions exported to C.

### Windows Usage Hints

To build the FindMathematica project with Visual Studio C++ 2010 for 32-bit Windows, open a Visual
Studio command prompt, change directory to the `FindMathematica` root directory and run the
following commands:

    D:\FindMathematica>mkdir build
    D:\FindMathematica>cd build
    D:\FindMathematica\build>cmake -G "Visual Studio 10" ..

Then open the generated Visual Studio solution file with Visual Studio C++ 2010:

    D:\FindMathematica\build>start Mathematica-project.sln

Alternatively, you can build and test the project from the command prompt:

    D:\FindMathematica\build>cmake --build . --config Debug
    D:\FindMathematica\build>ctest --build-config Debug

To build the FindMathematica project with Visual Studio C++ 2010 for 64-bit Windows, open a Visual
Studio x64 cross tools command prompt in the `FindMathematica` build directory:

    D:\FindMathematica\build>cmake -G "Visual Studio 10 Win64" ..

FindMathematica supports building 32-bit and 64-bit MathLink executables and LibraryLink dynamic
libraries using the appropriate link libraries that ship with the Windows version of *Mathematica*.
If you are using a 32-bit version of Windows, you can run the *Mathematica* kernel only in
32-bit mode, though. If you are using a 64-bit version of Windows, you can run the *Mathematica*
kernel both as a 64-bit native executable or as a 32-bit executable under WoW64.

To build the FindMathematica project with [MinGW][mingw] run the following commands from a command
prompt:

    D:\FindMathematica\build>cmake -G "MinGW Makefiles" ..
    D:\FindMathematica\build>mingw32-make
    D:\FindMathematica\build>ctest

Under [Cygwin][cgwn] the FindMathematica module requires the Cygwin version of CMake, which
is different to the regular Windows CMake version.
To build the FindMathematica project open a Cygwin shell prompt and run the the following
commands in the `FindMathematica` root directory:

    $ mkdir build
    $ cd build
    $ cmake ..
    $ make
    $ ctest

The module has been tested with *Mathematica* versions 5.2 to 8.0 and Visual Studio C++ 2008 under
Windows XP, with *Mathematica* versions 7.0 to 8.0 and Visual Studio C++ 2010 under Windows 7,
with *Mathematica* versions 5.2 to 8.0 and MinGW under Windows XP and with *Mathematica*
versions 5.2 to 8.0 and Cygwin 1.7 under Windows XP.

### Linux Usage Hints

To build the FindMathematica project with the CMake makefile generator, open a shell session
in the `FindMathematica` root directory and enter the following commands:

    $ mkdir build
    $ cd build
    $ cmake ..
    $ make
    $ ctest

FindMathematica supports building 32-bit and 64-bit MathLink executables and LibraryLink shared
libraries using the appropriate link libraries that ship with the Linux version of *Mathematica*.
If you are using a 64-bit version of Linux, you can run the *Mathematica* kernel both as a 64-bit
executable or as a 32-bit executable.

To cross-compile to 32-bit Linux under 64-bit Linux, the packages `ia32-libs` and `libc6-dev-i386`
need to be installed. To force a 32-bit build then, run:

    $ cmake -DCMAKE_C_FLAGS=-m32 -DCMAKE_CXX_FLAGS=-m32 ..

The module has been tested with *Mathematica* versions 7.0 and 8.0 and gcc 4.4 under 32-bit and
64-bit versions of Ubuntu 10.

### Mac OS X Usage Hints

To build the FindMathematica project with the CMake makefile generator, open Terminal.app,
change to the `FindMathematica` root directory and enter the following commands:

    $ mkdir build
    $ cd build
    $ cmake ..
    $ make
    $ ctest

To build the FindMathematica project with the Xcode project generator, run CMake with the
following arguments:

    $ cmake -G "Xcode" ..

Then open the generated Xcode project file `Mathematica-project.xcodeproj` with Xcode.app.

FindMathematica supports building MathLink executables and LibraryLink shared libraries for any
Mac OS X architecture type supported by the installed *Mathematica* version (x86_64 and i386 as
of *Mathematica* 8.0). To select the build target architecture types, set the CMake
`CMAKE_OSX_ARCHITECTURES` variable.

E.g., to build a 32/64-bit Intel universal binary use the following setting:

    $ cmake "-DCMAKE_OSX_ARCHITECTURES=i386;x86_64" ..

If you are running *Mathematica* 5.2 on a 64-bit capable Intel Mac, note that 5.2 does not
support x86_64. To get a workable project set CMake's target architecture to 32-bit by running:

    $ cmake "-DCMAKE_OSX_ARCHITECTURES=i386" ..

The module has been tested with with *Mathematica* versions 5.2 to 8.0 and Xcode 4.0 under
Snow Leopard (10.6) on an Intel Mac and with *Mathematica* version 7.0 and Xcode 3.1 under
Leopard (10.5) on a PowerMac G4.

Known Issues
------------

* On Windows Cygwin generated LibraryLink DLLs cannot be loaded by the *Mathematica* 8 kernel.
* On Windows linking to the `WolframRTL_Static_Minimal.lib` library under Cygwin or MinGW fails.

[ccg]:http://reference.wolfram.com/mathematica/CCodeGenerator/guide/CCodeGenerator.html
[ccrc]:http://www.cmake.org/Wiki/CMake_Cross_Compiling
[cgwn]:http://www.cygwin.com/
[cmk]:http://www.cmake.org/cmake/resources/software.html
[cmtut]:http://www.cmake.org/cmake/help/cmake_tutorial.html
[gcc]:http://gcc.gnu.org/
[mingw]:http://www.mingw.org/
[mprp]:http://reference.wolfram.com/mathematica/ref/program/mprep.html
[mtlnk]:http://reference.wolfram.com/mathematica/guide/MathLinkAPI.html
[splc]:http://reference.wolfram.com/mathematica/ref/Splice.html
[vslstd]:http://msdn.microsoft.com/vstudio/
[wll]:http://reference.wolfram.com/mathematica/guide/LibraryLink.html
[wmma]:http://www.wolfram.com/mathematica/
[xcdt]:http://developer.apple.com/tools/xcode/
