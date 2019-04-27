(* Mathematica LibraryLink test script for demo_numericarray.cxx *)

(* Hint: libPath is initialized in test init code *)
numericArrayReverse=LibraryFunctionLoad[
	libPath, "numericArrayReverse",
	{{LibraryDataType[NumericArray],"Constant"}},
	{LibraryDataType[NumericArray]}];
numericArrayComplexConjugate=LibraryFunctionLoad[
	libPath, "numericArrayComplexConjugate",
	{{LibraryDataType[NumericArray],"Constant"}},
	{LibraryDataType[NumericArray]}];
readBytesFromFile=LibraryFunctionLoad[
	libPath, "readBytesFromFile",
	{"UTF8String"},
	{LibraryDataType[ByteArray]}];

na = NumericArray[Range[5], "Integer32"]
Print@Normal@numericArrayReverse[na]

na1 = NumericArray[RandomComplex[2 + 3 I, 3], "ComplexReal32"]
Print@Normal@numericArrayComplexConjugate[na1]

na2 = NumericArray[Range[5], "Integer32"]
Print@Normal@numericArrayComplexConjugate[na2]

ba = readBytesFromFile[FindFile["ExampleData/rose.gif"]]
Print@Length@ba

