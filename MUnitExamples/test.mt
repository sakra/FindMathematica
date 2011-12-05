(* Mathematica Test File *)

Test[
	1+1
	,
	2
	,
	TestID->"test-20111031-G8Y2K7"
]

Test[
	1 / 0
	,
	ComplexInfinity
	,
	{ Power::infy }
	,
	TestID->"test-20111031-M6O9A3"
]
