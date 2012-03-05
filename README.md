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
* Finds installation directory and JAR file of [J/Link][jlnk].
* Finds installation directory of Wolfram MUnit testing package.
* Provides exact version information for *Mathematica*, MathLink, LibraryLink, J/Link and MUnit.
* Allows for running *Mathematica* code during CMake configure or build time.
* Allows for running *Mathematica* code as a pre-link, pre-build or post-build action.
* Allows for running *Mathematica* code in CMake test targets.
* Allows for running *Mathematica* MUnit test files and suites as CMake test targets.
* Supports generating C code from MathLink template files using [mprep][mprp].
* Supports building dynamic libraries loadable with [LibraryLink][wll] (*Mathematica* 8 only).
* Supports generating stand-alone C code from *Mathematica* code with [CCodeGenerator][ccg]
  (*Mathematica* 8 only).
* Provides CMake interface to *Mathematica*'s [Splice][splc] function.
* Provides CMake interface to *Mathematica*'s [Encode][encd] function.
* Supports generating *Mathematica* documentation with the DocumentationBuild package.
* Fully leverages CMake's [cross-compiling][ccrc] support.

Requirements
------------

* A Wolfram [*Mathematica*][wmma] product (*Mathematica* 5.2 to 8.0 or grid*Mathematica* 7.0 to 8.0).
* [CMake 2.8.4][cmk] or newer. The executable `cmake` should be on the system path.
* [Visual Studio C++][vslstd], [MinGW][mingw] or [Cygwin][cgwn] under Windows.
* [GCC][gcc] (including g++) under Linux.
* [Xcode][xcdt] developer tools package under Mac OS X.

Installation
------------

Copy the directory `CMake/Mathematica` to the root directory of your CMake project. In the
top-level `CMakeList.txt` file add the module directory to the CMake module search path:

    set (CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/CMake/Mathematica" ${CMAKE_MODULE_PATH})

Optional CMake MUnit testing support requires the installation of the Wolfram MUnit package. MUnit
ships with [Wolfram*Workbench*][wwkb] 2.0. The JAR file `com.wolfram.eclipse.testing_2.0.126.jar`
in the `plugins` subfolder of the Workbench installation folder contains different MUnit package
versions for *Mathematica* versions 5.2 to 8.0.

Extract the MUnit package version appropriate for your installed *Mathematica* version from the
JAR file to a directory on the *Mathematica* `$Path` (e.g., `$BaseDirectory/Applications` or
`$UserBaseDirectory/Applications`). Alternatively you can copy the MUnit package to the
FindMathematica module directory which is automatically prepended to `$Path` when the *Mathematica*
kernel is launched through the FindMathematica module.

If you plan on generating *Mathematica* documentation with CMake, the installation of two Wolfram
documentation build packages, which also ship with [Wolfram*Workbench*][wwkb] 2.0, is required.
The JAR file `com.wolfram.eclipse.paclet.develop_2.0.138.jar` in the `plugins` subfolder of the
Workbench installation folder contains the package folders `DocumentationBuild` and `Transmogrify`.
These must be copied to a directory on the *Mathematica* `$Path`.

The DocumentationBuild package also requires the installation of [Apache Ant][aant]. In order for
Apache Ant to be found by CMake, the environment variable `ANT_HOME` needs to point to Apache Ant's
installation directory.

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
* `MUnitExamples` demonstrate how to run *Mathematica* MUnit test files as CMake tests.
* `DocumentationExamples` demonstrate how to build *Mathematica* documentation.

### Windows Usage Hints

The module has been tested with *Mathematica* versions 5.2 to 8.0 and Visual Studio C++ 2008 under
Windows XP, with *Mathematica* versions 7.0 to 8.0 and Visual Studio C++ 2010 under Windows 7,
with *Mathematica* versions 5.2 to 8.0 and MinGW under Windows XP and with *Mathematica*
versions 5.2 to 8.0 and Cygwin 1.7 under Windows XP.

#### Visual Studio

To build the FindMathematica project with Visual Studio C++ 2010 for 32-bit Windows, open a Visual
Studio command prompt, change directory to the `FindMathematica` root directory and run the
following commands:

    D:\FindMathematica>mkdir build
    D:\FindMathematica>cd build
    D:\FindMathematica\build>cmake -G "Visual Studio 10" ..

Then open the generated Visual Studio solution file with Visual Studio C++ 2010:

    D:\FindMathematica\build>start Mathematica-project.sln

Alternatively, you can build and test the project's "Debug" configuration from the command prompt:

    D:\FindMathematica\build>cmake --build . --config Debug
    D:\FindMathematica\build>ctest --build-config Debug

To build the "Release" configuration and install the built files to your *Mathematica* user base
directory, run:

    D:\FindMathematica\build>cmake --build . --target install --config Release

To build the *Mathematica* documentation in notebook format, run:

    D:\FindMathematica\build>cmake --build . --config Debug --target documentation

To build the FindMathematica project with Visual Studio C++ 2010 for 64-bit Windows, open a Visual
Studio x64 cross tools command prompt in the `FindMathematica` build directory:

    D:\FindMathematica\build>cmake -G "Visual Studio 10 Win64" ..

FindMathematica supports building 32-bit and 64-bit MathLink executables and LibraryLink dynamic
libraries using the appropriate link libraries that ship with the Windows version of *Mathematica*.
If you are using a 32-bit version of Windows, you can run the *Mathematica* kernel only in
32-bit mode, though. If you are using a 64-bit version of Windows, you can run the *Mathematica*
kernel both as a 64-bit native executable or as a 32-bit executable under WoW64.

#### MinGW

To build the FindMathematica project with [MinGW][mingw] run the following commands from a command
prompt:

    D:\FindMathematica\build>cmake -G "MinGW Makefiles" ..
    D:\FindMathematica\build>mingw32-make

#### Cygwin

Under [Cygwin][cgwn] the FindMathematica module requires the Cygwin version of CMake, which is
different to the regular Windows CMake version.
To build the FindMathematica project open a Cygwin shell prompt and run the the following
commands in the `FindMathematica` root directory:

    $ mkdir build
    $ cd build
    $ cmake ..
    $ make

The *Mathematica* 8 kernel cannot load a Cygwin generated LibraryLink DLL that has been linked with
the Cygwin runtime library. As a work-around, the FindMathematica module suppresses linking with the
Cygwin runtime library by adding the `-mno-cygwin` flag when a LibraryLink target is added.
This flag is supported by Cygwin GCC version 3.x, but not by the default Cygwin GCC version 4.x.
To force the use of GCC version 3.x under Cygwin, run:

    $ cmake -DCMAKE_CXX_COMPILER=/usr/bin/g++-3.exe -DCMAKE_C_COMPILER=/usr/bin/gcc-3.exe ..

### Linux Usage Hints

To build the FindMathematica project with the CMake makefile generator, open a shell session
in the `FindMathematica` root directory and enter the following commands:

    $ mkdir build
    $ cd build
    $ cmake ..
    $ make

Optionally, you can run all tests and install the built files to your *Mathematica* user base
directory:

    $ make test
    $ make install

To build the *Mathematica* documentation in notebook format, run:

    $ make documentation

FindMathematica supports building 32-bit and 64-bit MathLink executables and LibraryLink shared
libraries using the appropriate link libraries that ship with the Linux version of *Mathematica*.
If you are using a 64-bit version of Linux, you can run the *Mathematica* kernel both as a 64-bit
executable or as a 32-bit executable.

To cross-compile to 32-bit Linux under 64-bit Linux, the packages `ia32-libs` and `libc6-dev-i386`
need to be installed. To force a 32-bit build then, run:

    $ cmake -DCMAKE_C_FLAGS=-m32 -DCMAKE_CXX_FLAGS=-m32 ..

The module has been tested with *Mathematica* versions 7.0 and 8.0 and GCC 4.4 under 32-bit and
64-bit versions of Ubuntu 10.

### Mac OS X Usage Hints

To build the FindMathematica project with the CMake makefile generator, open Terminal.app,
change to the `FindMathematica` root directory and enter the following commands:

    $ mkdir build
    $ cd build
    $ cmake ..
    $ make

Optionally, you can run all tests and install the built files to your *Mathematica* user base
directory:

    $ make test
    $ make install

To build the *Mathematica* documentation in notebook format, run:

    $ make documentation

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

* On Windows linking to the `WolframRTL_Static_Minimal.lib` library under Cygwin or MinGW fails.

[aant]:http://ant.apache.org/
[ccg]:http://reference.wolfram.com/mathematica/CCodeGenerator/guide/CCodeGenerator.html
[ccrc]:http://www.cmake.org/Wiki/CMake_Cross_Compiling
[cgwn]:http://www.cygwin.com/
[cmk]:http://www.cmake.org/cmake/resources/software.html
[cmtut]:http://www.cmake.org/cmake/help/cmake_tutorial.html
[encd]:http://reference.wolfram.com/mathematica/ref/Encode.html
[gcc]:http://gcc.gnu.org/
[jlnk]:http://www.wolfram.com/solutions/mathlink/jlink/
[mingw]:http://www.mingw.org/
[mprp]:http://reference.wolfram.com/mathematica/ref/program/mprep.html
[mtlnk]:http://reference.wolfram.com/mathematica/guide/MathLinkAPI.html
[splc]:http://reference.wolfram.com/mathematica/ref/Splice.html
[vslstd]:http://msdn.microsoft.com/vstudio/
[wll]:http://reference.wolfram.com/mathematica/guide/LibraryLink.html
[wmma]:http://www.wolfram.com/mathematica/
[wwkb]:http://www.wolfram.com/products/workbench/
[xcdt]:http://developer.apple.com/tools/xcode/
