#include <stdio.h>
#include "WolframRTL.h"
#include "compute.h"

int main(int argc, char *arg[])
{
	double num1 = 20.4;
	double num2;
	WolframLibraryData libData = WolframLibraryData_new(WolframLibraryVersion);
	Initialize_compute(libData);
	compute(libData, num1, &num2);
	printf("compute %5.2f\n", num2);
	WolframLibraryData_free(libData);
	return 0;
}
