#include <stdio.h>
#include "WolframRTL.h"
#include "functions.m.h"

int main(int argc, char *arg[])
{
	double num1 = 20.4;
	double num2;
	WolframLibraryData libData = WolframLibraryData_new(WolframLibraryVersion);
	Initialize_functions(libData);
	square(libData, num1, &num2);
	printf("square %5.2f\n", num2);
	cube(libData, num1, &num2);
	printf("cube %5.2f\n", num2);
	WolframLibraryData_free(libData);
	return 0;
}
