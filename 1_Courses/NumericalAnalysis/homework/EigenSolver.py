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


A = np.array([
    [52, 30, 49, 28],
    [30, 50, 8, 44],
    [49, 8, 46, 16],
    [28, 44, 16, 22]
])

example = EigenSolver(A)
power_iter_value, power_iter_vector = example.power_iteration(0.01, 100)
print("Power iteration: Max eigen value = ", power_iter_value)
