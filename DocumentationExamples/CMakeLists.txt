# FindMathematica documentation build examples

file (GLOB_RECURSE _docuFiles "${CMAKE_CURRENT_SOURCE_DIR}/*.nb")

Mathematica_ADD_DOCUMENTATION(documentation
	APPLICATION_NAME "MyApp"
	DOCUMENTATION_TYPE "Notebook"
	SOURCES ${_docuFiles}
	CHECK_TIMESTAMPS)

Mathematica_ADD_DOCUMENTATION(documentation-html
	APPLICATION_NAME "MyApp"
	DOCUMENTATION_TYPE "HTML"
	SOURCES ${_docuFiles}
	CHECK_TIMESTAMPS)

set_target_properties(documentation documentation-html PROPERTIES FOLDER "Documentation" )
