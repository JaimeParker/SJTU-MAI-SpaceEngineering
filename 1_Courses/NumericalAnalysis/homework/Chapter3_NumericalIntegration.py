# compose numerical integration

# import libs
import numpy as np
import math

class NumericalIntegration:
    def __init__(self, function):
        self.f = function

    def closed_newton_cotes(self, x_start, x_end):
        # n from 1 to 4
        # integration from x_start to x_end

        # results
        final = []

        # Trapezoidal rule, n = 1
        final1 = (x_end - x_start) / 2 * (self.f(x_end) + self.f(x_start))
        final.append(final1)

        # Simpson's rule, n = 2
        a = x_start
        b = x_end
        h = (b-a) / 2
        final2 = h / 3 * (self.f(a) + 4*self.f((a+b)/2) + self.f(b))
        final.append(final2)

        # Simpson's Three Eight rule, n = 3
        h = (b-a) / 3
        final3 = 3*h/8 * (self.f(a) + 3*self.f(a+h) + 3*self.f(b-h) + self.f(b))
        final.append(final3)

        # Rank 4, n = 4
        h = (b-a) / 4
        final4 = 2*h/45 * (7*self.f(a) + 32*self.f(a+h) + 12*self.f(a+2*h) + 32*self.f(b-h) + 7*self.f(b))
        final.append(final4)

        print(final)

    def open_newton_cotes(self, x_start, x_end):
        # n from 0 to 3
        a = x_start
        b = x_end
        final = []

        # n = 0, Midpoint rule
        n = 0
        h = (b-a) / (n+2)
        final1 = 2*h*self.f(a+h)
        final.append(final1)

        # n = 1
        n = 1
        h = (b-a) / (n+2)
        final2 = 3*h/2 * (self.f(a+h) + self.f(b-h))
        final.append(final2)

        # n = 2
        n = 2
        h = (b-a) / (n+2)
        final3 = 4*h/3 * (2*self.f(a+h) - self.f(a+2*h) + 2*self.f(b-h))
        final.append(final3)

        # n = 3
        n = 3
        h = (b-a) / (n+2)
        final4 = 5*h/24 * (11*self.f(a+h) + self.f(a+2*h) + self.f(b-2*h) + 11*self.f(b-h))
        final.append(final4)

        print(final)

    def composite_newton_cotes(self, x_start, x_end, n):
        a = x_start
        b = x_end
        final = []

        # for Trapezoidal rule
        h = (b-a) / n
        sum = 0
        for i in range(1, n-1+1, 1):
            # range(1, n+1) is from 1 to n
            sum += 2*self.f(a + i*h)
        sum = sum + self.f(a) + self.f(b)
        final1 = h/2*sum
        final.append(final1)

        # for Simpson's rule
        if n%2 != 0:
            raise Exception('n is not an even number, not for composite Simpsons rule')

        h = (b-a) / n
        xi0 = self.f(a) + self.f(b)
        xi1 = 0
        xi2 = 0
        for j in range(1, int(n/2-1)+1, 1):
            xi1 += self.f(a + 2*j*h)
        for j in range(1, int(n/2)+1, 1):
            xi2 += self.f(a + (2*j-1)*h)

        final2 = h/3 * (xi0 + 2*xi1 + 4*xi2)
        final.append(final2)

        print(final)



def func(x):
    return math.sin(x)

test = NumericalIntegration(func)
test.closed_newton_cotes(0, 3.1415/4)
test.open_newton_cotes(0, 3.1415/4)
test.composite_newton_cotes(0, 3.1415/4, 8)