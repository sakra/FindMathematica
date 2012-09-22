(* Mathematica J/Link test script for FormatArray.java *)

fmt = JavaNew["java.text.DecimalFormat", "#.0000"]
data = Range[10]
LoadJavaClass["FormatArray"]
Print[FormatArray`format[fmt, data]]
