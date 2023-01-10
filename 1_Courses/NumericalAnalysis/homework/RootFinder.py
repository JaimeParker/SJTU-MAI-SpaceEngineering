from math import exp
from math import log


class RootFinder:
    def __init__(self, func):
        self.f = func

    def bisect(self, start, end, tolerance):
        k = 1
        if self.f(start) * self.f(end) < 0:
            while abs(start - end) / 2.0 > tolerance:
                k = k + 1
                x_new = float(start + end) / 2.0
                if self.f(start) * self.f(x_new) < 0:
                    end = x_new
                else:
                    start = x_new
        else:
            print("f(a)*f(b) is non-negative, find another pair of input")
        return float(start + end) / 2.0, k

    def newton(self, df, x0, max_iter, tolerance):
        for i in range(max_iter):
            x1 = x0 - self.f(x0) / df(x0)
            if abs((x1 - x0) < tolerance):
                break
            if i == max_iter:
                print("meet max iter!")
            x0 = x1

        return x0

    def fix_point(self, x0, tolerance):
        x1 = self.f(x0)
        print(x1)
        while abs(x0 - x1) > tolerance:
            x0 = self.f(x1)
            x1 = self.f(x0)
            print(x0)

        return x1


k = 0.41
B = 5.1
rho = 1.25
u = 21
v = 1.5e-5
y = 0.01


def f_u_plus(u_plus):
    # y_plus=y * u / (v * u_plus), u_plus != 0
    return u_plus + exp(-k * B) * (exp(k * u_plus) - 1 - k * u_plus - 1 / 2 * pow(k * u_plus, 2) -
                                   1 / 6 * pow(k * u_plus, 3) - 1 / 24 * pow(k * u_plus, 4)) - y * u / (v * u_plus)


def f_fix_point(u_plus):
    return u_plus - f_u_plus(u_plus)


def trial(u_plus):
    return log((y * u / (v * u_plus) - u_plus) / exp(-k * B) + 1 + k * u_plus - 1 / 2 * pow(k * u_plus, 2)
               + 1 / 6 * pow(k * u_plus, 3) + 1 / 24 * pow(k * u_plus, 4)) / k


root = RootFinder(f_u_plus)
root.bisect(21, 22, 0.001)

root_fix = RootFinder(trial)
root_fix.fix_point(21, 0.001)
