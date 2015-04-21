(* Mathematica LibraryLink test script for demo_managed.cxx *)

(* Hint: libPath is initialized in test init code *)
setInstanceState = LibraryFunctionLoad[libPath,"setInstanceState",{Integer, {Integer, 1}},"Void"];
getInstanceState = LibraryFunctionLoad[libPath, "getInstanceState",{{Integer}}, {Integer, 1}];
releaseInstance = LibraryFunctionLoad[libPath, "releaseInstance", {{Integer}},"Void"];
generateFromInstance = LibraryFunctionLoad[libPath, "generateFromInstance",{Integer,{Integer, _}},{Real,_}];
getAllInstanceIDs = LibraryFunctionLoad[libPath, "getAllInstanceIDs", {},{Integer,1}];

LCGQ[e_] := ManagedLibraryExpressionQ[e,"LCG"];

instanceID[inst_] := ManagedLibraryExpressionID[inst,"LCG"];

CreateLCG[a_Integer, c_Integer, m_Integer, x_Integer] := Module[{res},
	res = CreateManagedLibraryExpression["LCG", LCG];
	setInstanceState[instanceID[res],{a,c,m,x}];
	res
];

ListLCGs[]:=Map[LCG[#]->getInstanceState[#]&,getAllInstanceIDs[]]

LCGRandom[inst_?LCGQ] := LCGRandom[inst,{}];
LCGRandom[inst_?LCGQ, len_Integer]:= LCGRandom[inst,{len}];
LCGRandom[inst_?LCGQ, dims:{(_Integer?Positive)...}]:= Module[{id = instanceID[inst]},
	generateFromInstance[id, dims]
];

g = CreateLCG[1664525, 1013904223, 2^($SystemWordLength/2), 0]
Print@LCGQ[g]
Print@LCGRandom[g]

g1 = CreateLCG[1664525, 1013904223, 2^($SystemWordLength/2), 0]
Print@LCGRandom[g1, 2]
Print@ListLCGs[]
Print@LCGRandom[LCG[1]]

g2 = CreateLCG[1664525, 1013904223, 2^($SystemWordLength/2), 0]; LCGRandom[g2, {2, 2}]
releaseInstance[2];
Print@ListLCGs[]

g2 =.
Print@ListLCGs[]
Print@LCGQ[g]
