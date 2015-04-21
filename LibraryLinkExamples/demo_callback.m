(* Mathematica LibraryLink test script for demo_callback.c *)

(* Hint: libPath is initialized in test init code *)
applyCallback = LibraryFunctionLoad[libPath,"apply_callback",{{Real,_}},{Real,_}];

cfSin = Compile[{{x, _Real}}, Sin[x]]

ConnectLibraryCallbackFunction["demo_callback_manager", cfSin]

array = RandomReal[1, 5]; applyCallback[array]

applySin = LibraryFunctionLoad[libPath,"apply_sin",{{Real,_}},{Real,_}];

testdata = RandomReal[{-Pi,Pi},{1000,1000, 10}];

testsin = applySin[testdata]

testcallback = applyCallback[testdata]

Print@SameQ[testsin,testcallback]

cfSinC= Compile[{{x,_Real}},Sin[x],CompilationTarget->"C"];

ConnectLibraryCallbackFunction["demo_callback_manager",cfSinC]

testcallback = applyCallback[testdata]

Print@SameQ[testsin,testcallback]
