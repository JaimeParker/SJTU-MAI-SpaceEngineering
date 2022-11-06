# compose interpolation

# import libs
import numpy as np
from fractions import Fraction


def multiply(a, b, m, n):
    prod = [0] * (m + n - 1)

    # Multiply two polynomials term by term

    # Take ever term of first polynomial
    for i in range(m):

        # Multiply the current term of first
        # polynomial with every term of
        # second polynomial.
        for j in range(n):
            prod[i + j] += a[i] * b[j]

    return prod


def print_poly(poly, n):
    for i in range(n):
        print(poly[i], end="")
        if i != 0:
            print("x^%d" % i, end="")
        if i != n - 1:
            print(" + ", end="")


class Interpolation:
    def __init__(self, np_points):
        self.points = np_points
        # get rows and cols of points
        self.rows = self.points.shape[0]
        self.cols = self.points.shape[1]
        # check the dimension of the array (points)
        if self.cols != 2:
            print("considering using reshape() to revise your points")
            raise Exception("Error! The column number of your points \
            array is not 2, please check it out!")

    def change_data(self, new_np_points):
        new_cols = new_np_points.shape[1]
        # check the dimension of the array (points)
        if new_cols != 2:
            print("considering using reshape() to revise your points")
            raise Exception("Error! The column number of your points \
            array is not 2, please check it out!")
        # send data to self
        self.points = new_np_points
        self.rows = new_np_points.shape[0]
        self.cols = new_np_points.shape[1]

    def get_lagrange_den(self, index):
        point = self.points
        length = self.rows

        den = 1
        for i in range(length):
            if index != i:
                den = den * (point[index, 0] - point[i, 0])

        return den

    def get_lagrange_num(self, index):
        length = self.rows

        prod = [1]

        # start from the highest rank, which is len - 1
        for i in range(length):
            if i != index:
                m = len(prod)
                n = 2
                b = [-data[i, 0], 1]
                prod = multiply(prod, b, m, n)

        return prod

    def lagrange_interpolation(self):
        length = self.rows
        coefficient_list = []
        # get coefficient
        for i in range(length):
            coefficient = Fraction(1 / self.get_lagrange_den(i)).limit_denominator() \
                   * Fraction(data[i, 1]).limit_denominator()
            coefficient_list.append(coefficient)

        print("coefficients: ", coefficient_list)

        final = [Fraction(0, 1)] * length

        # get nums
        print("each polynomial without coefficients: ")
        for i in range(length):
            # on index
            num = self.get_lagrange_num(i)
            print_poly(num, length)
            print(" ")
            for j in range(length):
                final[j] += Fraction(num[j]).limit_denominator() * coefficient_list[i]

        return final

    def lagrange_polynomial(self):
        final = self.lagrange_interpolation()
        print("final polynomial: ")
        print_poly(final, self.rows)




data = np.array([[0, 1], [1, 2], [3, 6], [5, 7]])
test_interpolation = Interpolation(data)
test_interpolation.lagrange_polynomial()
