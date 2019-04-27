(* Mathematica LibraryLink test script for demo_shared.c *)

(* Hint: libPath is initialized in test init code *)
loadFun=LibraryFunctionLoad[libPath,"loadArray",{{Real,_,"Shared"}},Integer];
unloadFun=LibraryFunctionLoad[libPath,"unloadArray",{},Integer];
getFunVector=LibraryFunctionLoad[libPath,"getElementVector",{Integer},Real];

array = Range[1., 20];
loadFun[array]
Print@getFunVector[10]
Print@getFunVector[15]
Print@getFunVector[20]
unloadFun[ ]
