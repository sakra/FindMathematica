(* Generate code for single function *)

cFun = Compile[{{x}}, x^2 + Sin[x^2]];

(* return compiled function that shall be exported to C code *)
{cFun, "compute"}