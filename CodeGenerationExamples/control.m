(* Generate code for for control system expression *)

ss = StateSpaceModel[TransferFunctionModel[z/((z - 0.9)*(z + 0.8)), z, SamplingPeriod -> 1]]

(* explicitly generate source file by using Export *)
Export[ "control.c", ss, "C"]