(* Mathematica Test File *)

Test[
	ConvertTemperature[10, Centigrade, Fahrenheit]
	,
	50
	,
	TestID->"UnitsTests-20111103-H2G1N1"
]

NTest[
	N[First[Convert[130 Kilo Meter/Hour, Mile/Hour]]]
	,
	80.7783
	,
	PrecisionGoal -> 6
	,
	TestID->"UnitsTests-20111103-Z1G3A9"
]


NTest[
	Convert[100 Kilo Meter/(7 Liter), Mile/Gallon] // First
	,
	33.602
	,
	PrecisionGoal -> 5
	,
	TestID->"UnitsTests-20111103-J7K1X5"
]
