import numpy as np


class EquationSolver:
    def __init__(self, A, b):
        self.A = A
        self.b = b

    def guassian_elimination(self):
        n = len(self.b)
        m = np.zeros(shape=(n, n+1))
        m[0:n, 0:n] = self.A
        m[0:n, n] = self.b.reshape(1, n)

        # start elimination
        for col in range(0, n - 1):
            for row in range(col + 1, n):
                coefficient = m[row, col] / m[col, col]
                m[row, col:n+1] -= coefficient * m[col, col:n+1]

        # back substitution
        x = np.zeros(n)
        x[n-1] = m[n-1, n] / m[n-1, n-1]
        for row in range(n-2, -1, -1):
            x[row] = (m[row, n] - m[row, row + 1:n].dot(x[row + 1:n])) / m[row, row]

        return x

    def lu_decomposition(self):
        n = len(self.b)
        mat_l = np.zeros(shape=[n, n])
        mat_u = np.zeros(shape=[n, n])

        # set diagonals of L
        for i in range(n):
            mat_l[i, i] = 1.0

        # set first row of u
        for j in range(n):
            mat_u[0, j] = self.A[0, j]

        # set first column of L
        for i in range(1, n):
            mat_l[i, 0] = self.A[i, 0] / mat_u[0, 0]

        # interactively compute k-th row of U and k-th col of L
        for k in range(1, n):
            for j in range(k, n):
                mat_u[k, j] = self.A[k, j] - (mat_l[k, 0:k]).dot(mat_u[0:k, j])

            for i in range(k+1, n):
                mat_l[i, k] = (self.A[i, k] - (mat_l[i, 0:k]).dot(mat_u[0:k, k])) / mat_u[k, k]

        # back substitution
        y = np.zeros(n)
        y[0] = self.b[0] / mat_l[0, 0]
        for i in range(1, n):
            y[i] = (self.b[i] - (mat_l[i, 0:i]).dot(y[0:i])) / mat_l[i, i]

        x = np.zeros(n)

        x[n - 1] = y[n - 1] / mat_u[n - 1, n - 1]
        for i in range(n - 2, -1, -1):
            x[i] = (y[i] - mat_u[i, i + 1:n].dot(x[i + 1:n])) / mat_u[i, i]

        return mat_l, mat_u, y, x

    def gauss_seidel(self, tolerance, max_iterations, x):
        # https://stackoverflow.com/questions/5622656/python-library-for-gauss-seidel-iterative-solver

        # x is the initial condition
        iter1 = 0
        # Iterate
        for k in range(max_iterations):
            iter1 = iter1 + 1
            # print("The solution vector in iteration", iter1, "is:", x)
            x_old = x.copy()

            # Loop over rows
            for i in range(self.A.shape[0]):
                x[i] = (self.b[i] - np.dot(self.A[i, :i], x[:i])
                        - np.dot(self.A[i, (i + 1):], x_old[(i + 1):])) / self.A[i, i]

            # Stop condition
            # L norm Inf corresponds to the absolute value of the greatest element of the vector.

            l_norm_inf = max(abs((x - x_old))) / max(abs(x_old))
            # print("The L infinity norm in iteration", iter1, "is:", l_norm_inf)
            if l_norm_inf < tolerance:
                break

        return x

    def sor_method(self, omega, tolerance, max_iterations, x):
        # https://stackoverflow.com/questions/53251299/successive-over-relaxation

        iter1 = 0
        # Iterate
        for k in range(max_iterations):
            iter1 = iter1 + 1
            # print("The solution vector in iteration", iter1, "is:", x)
            x_old = x.copy()

            # Loop over rows
            for i in range(self.A.shape[0]):
                x[i] = x[i] * (1 - omega) + (omega / self.A[i, i]) * (
                            self.b[i] - np.dot(self.A[i, :i], x[:i]) - np.dot(self.A[i, (i + 1):], x_old[(i + 1):]))

            # Stop condition
            # L norm Inf corresponds to the absolute value of the greatest element of the vector.

            l_norm_inf = max(abs((x - x_old))) / max(abs(x_old))
            # print("The L infinity norm in iteration", iter1, "is:", l_norm_inf)
            if l_norm_inf < tolerance:
                break

        return x


A = np.array([
    [2, 1, 1],
    [1, 3, 2],
    [1, 2, 2]
])

b = np.array([
    [2],
    [3],
    [1]
])

x0 = np.array([
    [1.1],
    [2.1],
    [-2.1],
])

example1 = EquationSolver(A, b)
gauss = example1.guassian_elimination()
L, U, y, x = example1.lu_decomposition()
gauss_seidel = example1.gauss_seidel(0.01, 100, x0)
sor = example1.sor_method(1, 0.01, 100, x0)

print("gauss elimination:", gauss)
print("LU decomposition: ", L, U, y, x)
print("gauss seidel: ", gauss_seidel)
print("sor: ", sor)
