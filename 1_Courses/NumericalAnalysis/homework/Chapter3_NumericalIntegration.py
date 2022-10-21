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
        h = (b - a) / 2
        final2 = h / 3 * (self.f(a) + 4 * self.f((a + b) / 2) + self.f(b))
        final.append(final2)

        # Simpson's Three Eight rule, n = 3
        h = (b - a) / 3
        final3 = 3 * h / 8 * (self.f(a) + 3 * self.f(a + h) + 3 * self.f(b - h) + self.f(b))
        final.append(final3)

        # Rank 4, n = 4
        h = (b - a) / 4
        final4 = 2 * h / 45 * (
                7 * self.f(a) + 32 * self.f(a + h) + 12 * self.f(a + 2 * h) + 32 * self.f(b - h) + 7 * self.f(b))
        final.append(final4)

        print(final)

    def open_newton_cotes(self, x_start, x_end):
        # n from 0 to 3
        a = x_start
        b = x_end
        final = []

        # n = 0, Midpoint rule
        n = 0
        h = (b - a) / (n + 2)
        final1 = 2 * h * self.f(a + h)
        final.append(final1)

        # n = 1
        n = 1
        h = (b - a) / (n + 2)
        final2 = 3 * h / 2 * (self.f(a + h) + self.f(b - h))
        final.append(final2)

        # n = 2
        n = 2
        h = (b - a) / (n + 2)
        final3 = 4 * h / 3 * (2 * self.f(a + h) - self.f(a + 2 * h) + 2 * self.f(b - h))
        final.append(final3)

        # n = 3
        n = 3
        h = (b - a) / (n + 2)
        final4 = 5 * h / 24 * (11 * self.f(a + h) + self.f(a + 2 * h) + self.f(b - 2 * h) + 11 * self.f(b - h))
        final.append(final4)

        print(final)

    def composite_newton_cotes(self, x_start, x_end, n):
        a = x_start
        b = x_end
        final = []

        # for Trapezoidal rule
        h = (b - a) / n
        sum = 0
        for i in range(1, n - 1 + 1, 1):
            # range(1, n+1) is from 1 to n
            sum += 2 * self.f(a + i * h)
        sum = sum + self.f(a) + self.f(b)
        final1 = h / 2 * sum
        final.append(final1)

        # for Simpson's rule
        if n % 2 != 0:
            raise Exception('n is not an even number, not for composite Simpsons rule')

        h = (b - a) / n
        xi0 = self.f(a) + self.f(b)
        xi1 = 0
        xi2 = 0
        for j in range(1, int(n / 2 - 1) + 1, 1):
            xi1 += self.f(a + 2 * j * h)
        for j in range(1, int(n / 2) + 1, 1):
            xi2 += self.f(a + (2 * j - 1) * h)

        final2 = h / 3 * (xi0 + 2 * xi1 + 4 * xi2)
        final.append(final2)

        print(final)

    def romberg(self, x_start, x_end, n):
        # Romberg Integration
        romberg_matrix = np.zeros((n, n))

        # init parameters
        a = x_start
        b = x_end
        h = b - a
        temp_sum = 0

        # R11 should be defined before circle
        r11 = h / 2 * (self.f(a) + self.f(b))
        romberg_matrix[0][0] = r11

        # fill the first column of matrix
        # define k from 2 to n
        for k in range(2, n + 1, 1):
            # define i from 1 to 2^(k-2)
            for i in range(1, int(np.power(2, k - 2)) + 1, 1):
                # i = 1, temp_sum = f((a+b)/2)
                # ...
                # i = 2^(k-2), temp_sum = f(a+(k-0.5)hk)
                temp_sum += self.f(a + (2 * i - 1) * (b - a) / (np.power(2, k - 1)))

            # be advised that h is being updated with time
            rn1 = 0.5 * romberg_matrix[(k - 1) - 1][0] + 0.5 * (b - a) / (np.power(2, k - 2)) * temp_sum
            romberg_matrix[(k - 1)][0] = rn1

            # update template variable to 0 for the next trial
            temp_sum = 0

        # it seems obvious that rest elements of the matrix can be calculated
        # get R_{j, k} here, noted that k and j is more than 1, k >= j
        # define j from 2 to n
        for j in range(2, n + 1, 1):
            # define k from j to n
            for k in range(j, n + 1, 1):
                r_kj = romberg_matrix[k - 1][j - 2]
                r_kj += 1 / (np.power(4, j - 1) - 1) * (romberg_matrix[k - 1][j - 2] - romberg_matrix[k - 2][j - 2])
                # transfer data to matrix
                romberg_matrix[k - 1][j - 1] = r_kj

        print(romberg_matrix)

    def simpson(self, x_start, x_end):
        a = x_start
        b = x_end
        h = (b - a) / 2

        result = self.f(a) + self.f(b) + 4 * self.f(a + h)
        result = h / 3 * result
        return result

    def trapezoidal(self, x_start, x_end):
        a = x_start
        b = x_end
        h = (b - a) / 2

        return h * (self.f(a) + self.f(b))

    def adaptive_simpson(self, x_start, x_end, eps):
        # reference
        # https://en.wikipedia.org/wiki/Adaptive_Simpson%27s_method
        # https://cloud.tencent.com/developer/article/1637426
        # https://www.math.usm.edu/lambers/mat460/fall09/lecture30.pdf
        a = x_start
        b = x_end
        m = (a + b) / 2

        simpson_ans = self.simpson(a, b)
        left = self.simpson(a, m)
        right = self.simpson(m, b)
        print("ans of simpson's method on [%f, %f] is %f" % (a, b, simpson_ans))
        print("ans of simpson's method on [%f, %f] is %f" % (a, m, left))
        print("ans of simpson's method on [%f, %f] is %f" % (m, b, right))
        print("error is %f" % (abs(left + right - simpson_ans)))

        # a traditional way is to replace 15 by 10
        # to make the algorithm more conservative
        # seems a serious bug due to no limitation
        if abs(left + right - simpson_ans) <= 15 * eps:
            print("[%f, %f] meet the error" % (a, b))
            return left + right + (left + right - simpson_ans) / 15
        else:
            print("[%f, %f] exceed the error" % (a, b))
            return self.adaptive_simpson(a, m, eps / 2) + \
                self.adaptive_simpson(m, b, eps / 2)

    def adaptive_trapezoidal(self, x_start, x_end, eps):
        a = x_start
        b = x_end
        m = (a + b) / 2

        trapezoidal_ans = self.trapezoidal(a, b)
        left = self.trapezoidal(a, m)
        right = self.trapezoidal(m, b)
        print("ans of trapezoidal method on [%f, %f] is %f" % (a, b, trapezoidal_ans))
        print("ans of trapezoidal method on [%f, %f] is %f" % (a, m, left))
        print("ans of trapezoidal method on [%f, %f] is %f" % (m, b, right))
        print("error is %f" % (abs(left + right - trapezoidal_ans)))

        if abs(left + right - trapezoidal_ans) <= 15 * eps:
            print("[%f, %f] meet the error" % (a, b))
            return left + right + (left + right - trapezoidal_ans) / 15
        else:
            print("[%f, %f] exceed the error" % (a, b))
            return self.adaptive_trapezoidal(a, m, eps / 2) + \
                self.adaptive_trapezoidal(m, b, eps / 2)

    def gaussian_legendre(self, x_start=-1, x_end=1):
        # only design for n = 3(for now)
        print(5 / 9 * self.f(0.774596692) + 8 / 9 * self.f(0) + 5 / 9 * self.f(-0.774596692))
        return 5 / 9 * self.f(0.774596692) + 8 / 9 * self.f(0) + 5 / 9 * self.f(-0.774596692)


def func(x):
    return math.sin(x)


def func3_5(x):
    return 1 + math.sin(math.exp(3 * x))


def func3_7(x):
    return math.log(x)


def func3_8_1(x):
    return math.exp(x)


def func3_8_2(x):
    return 0.5 * math.log((x + 3) / 2)


test3_5 = NumericalIntegration(func3_5)
test3_5.adaptive_trapezoidal(-1, 1, 0.005)
test3_5.adaptive_simpson(-1, 1, 0.005)

test3_7 = NumericalIntegration(func3_7)
test3_7.romberg(1, 2, 3)

test_3_8_1 = NumericalIntegration(func3_8_1)
test_3_8_1.gaussian_legendre()

test_3_8_2 = NumericalIntegration(func3_8_2)
test_3_8_2.gaussian_legendre()
