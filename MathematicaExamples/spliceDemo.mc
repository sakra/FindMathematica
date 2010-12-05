#include <math.h>
#include "mdefs.h"

double f(double x)
{
	double y;

	y = <* Integrate[Cos[x]^5, x] *>;

	return (2*y - 1);
}
