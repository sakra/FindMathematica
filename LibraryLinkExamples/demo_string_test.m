(* Mathematica LibraryLink test script for demo_string.c *)

(* Hint: libPath is initialized in test init code *)
countSubstring=LibraryFunctionLoad[libPath, "countSubstring", {"UTF8String", "UTF8String"}, Integer]
encodeString=LibraryFunctionLoad[libPath, "encodeString", {"UTF8String", Integer}, "UTF8String"]
reverseString=LibraryFunctionLoad[libPath, "reverseString", {"UTF8String"}, "UTF8String" ]
Print[countSubstring["Mathematica","a"]]
Print[encodeString["Mathematica", 5]]
Print[reverseString["Mathematica"]]
