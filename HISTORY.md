## 1.2.6 (2011-12-03)

* fix debug output

## 1.2.5 (2011-12-02)

* fix bug in launch services database search code under Mac OS X

## 1.2.4 (2011-11-17)

* preserve user defined overrides upon option initialization
* don't set `RUN_SERIAL` option in `Mathematica_SET_TESTS_PROPERTIES`

## 1.2.3 (2011-11-08)

* fix cache cleanup bug
* use functions instead of macros to work around Windows backslash problem
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
* fix build failures when build directory path contains white space characters
* use CMake `option` command for user overridable boolean module variables

## 1.0.2 (2011-07-02)

* Fix *Mathematica* detection on PPC equipped Macs

## 1.0.1 (2011-04-03)

* Changes for undefined WIN32 variable under Cygwin with CMake 2.8.4
* Tested with *Mathematica* 8.0.1
* Code cleanup

## 1.0.0 (2010-12-05)

* First release
