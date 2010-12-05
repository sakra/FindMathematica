(* Generate code for multiple functions *)

square = Compile[ {{x}}, x^2];
cube = Compile[ {{x}}, x^3];

(* return compiled functions that shall be exported to C code *)
{{square,cube},{"square","cube"}}