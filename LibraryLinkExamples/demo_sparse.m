(* Mathematica LibraryLink test script for demo_sparse.c *)

(* Hint: libPath is initialized in test init code *)
props=LibraryFunctionLoad[libPath,"sparse_properties",{"UTF8String",{LibraryDataType[SparseArray],"Constant"}},{_,_}];

s=SparseArray[{{1,0,0},{2,0,3}}]
Print@props["ExplicitValues",s]

pTable[s_] := Table[p->props[p,s],{p,{"ImplicitValue","ExplicitValues","RowPointers","ColumnIndices", "ExplicitPositions","Normal"}}]
Print@pTable[s]

s = SparseArray[{{1,0,0},{2 ,0,3}},Automatic,1.]
Print@pTable[s]

modifyValues=LibraryFunctionLoad[libPath,"sparse_modify_values",{{LibraryDataType[SparseArray,Real],"Shared"},{LibraryDataType[List,Real, 1],"Constant"}},LibraryDataType[SparseArray]]

s = SparseArray[{{1,1}->1.,{2,1}->-1.,{2,2}->3.}]
s1 = modifyValues[s,{-1,0,4}]
Print@pTable[s]
Print@pTable[s1]
