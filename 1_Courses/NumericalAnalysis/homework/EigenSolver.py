import numpy as np


class EigenSolver:
    def __init__(self, np_matrix):
        self.mat = np_matrix

    def power_iteration(self, tolerance, max_iterations):
        n = len(self.mat)
        u = np.ones([n, 1])
        iteration = 0
        eigen_value = 0
        vector = self.mat.dot(u)
        residual = 10000

        while iteration < max_iterations and residual > tolerance:
            vector = self.mat.dot(u)
            eigen_value = max(vector, key=abs)
            vector = vector / max(abs(vector))

            residual = np.linalg.norm(u - vector, ord=2)
            u = vector
            iteration += 1

        return eigen_value, vector

    def rayleigh_quotient(self, tolerance, max_iterations, vector_guess, value_guess):
        # https://en.wikipedia.org/wiki/Rayleigh_quotient_iteration
        n = len(self.mat)
        mat_i = np.eye(n)
        iteration = 0
        residual = 10000
        value_predict = 0

        while iteration < max_iterations and residual > tolerance:
            b = np.dot(np.linalg.inv(self.mat - value_guess * mat_i), vector_guess)
            b = b / np.linalg.norm(b)
            # update eigen vector
            vector_guess = b

            # update eigen value
            value_predict = np.dot(b.transpose(), self.mat)
            value_predict = np.dot(value_predict, b)

            # update residual
            residual = abs(value_predict - value_guess)
            value_guess = value_predict

            # update iter
            iteration += 1

        return value_predict

    def qr_decomposition(self, tolerance, max_iterations):
        q, r = np.linalg.qr(self.mat)
        iteration = 0
        a1 = self.mat
        residual = 10000

        while iteration < max_iterations and residual > tolerance:
            q_new, r_new = np.linalg.qr(a1)
            diag_a1 = np.diag(a1)

            a1 = np.dot(r_new, q_new)
            diag_a1_new = np.diag(a1)

            residual = np.linalg.norm(diag_a1 - diag_a1_new)
            iteration += 1

        return q, r, np.diag(a1)


A = np.array([
    [52, 30, 49, 28],
    [30, 50, 8, 44],
    [49, 8, 46, 16],
    [28, 44, 16, 22]
])

vector_init = np.array([
    [1], [0.8], [0.8], [0.7]
])

example = EigenSolver(A)
power_iter_value, power_iter_vector = example.power_iteration(0.01, 100)
print("Power iteration: Max eigen value = ", power_iter_value)
rayleigh_value = example.rayleigh_quotient(0.01, 100, vector_init, 130)
print("Rayleigh quotient: Max eigen value = ", rayleigh_value)
mat_Q, mat_R, QR_diag = example.qr_decomposition(0.01, 100)
print("QR decomposition, eigen values = ", QR_diag)
