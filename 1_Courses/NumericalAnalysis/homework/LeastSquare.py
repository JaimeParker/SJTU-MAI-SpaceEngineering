# import libs
import numpy as np
import matplotlib.pyplot as plt


# class for least square fitting
# only applied for small group data
class LeastSquare:
    # constructor function maybe
    def __init__(self, points):
        # points should be a numpy array
        self.points = points
        self.x = points[:, 0]
        self.y = points[:, 1]
        # or len(points) here
        self.n = points.shape[0]
        self.m_max = self.n - 2  # m < n-1

    # set m_max manually
    def set_m_max(self, max):
        self.m_max = max

    # fitting function
    # return a function
    def get_fitting_function(self, m):
        # check the m
        if m < 1:
            raise Exception("Invalid m<1, please check the m you choose!")

        A = np.ones((self.n, 1))

        for i in range(1, m + 1):
            A_plus = np.power(self.x, i).reshape(self.n, 1)
            A = np.hstack((A, A_plus))

        print(A)

        Y = self.y.reshape(self.n, 1)
        coef = np.linalg.inv(np.matmul(A.transpose(), A))
        coef = np.matmul(coef, A.transpose())
        coef = np.matmul(coef, Y)
        coef = coef.flatten()

        return coef

    def coef2function_value(self, coef, x):
        func = np.poly1d(coef)
        return func(x)

    def run(self):
        x_new = np.linspace(points[0, 0], points[self.n - 1, 0], num=100)
        m_range = np.arange(1, self.m_max + 1)  # from 1 to m_max, have to add 1 here

        # define labes list for matplotlib.pyplot
        m_values = ["m value={}".format(m) for m in m_range]

        # from 1 to m_max run the fitting process
        for i in range(1, self.m_max + 1):
            coef = self.get_fitting_function(i)
            print(coef)

            y_estimated = self.coef2function_value(np.flip(coef), x_new)
            plt.plot(x_new, y_estimated, label=m_values[i - 1])

        plt.scatter(self.x, self.y, label="original data")

        plt.xlabel("x")
        plt.ylabel("y")
        plt.title("least square fitting on different m")
        plt.legend()
        plt.show()

    def fit_determined_m(self, m):
        x_new = np.linspace(points[0, 0], points[self.n - 1, 0], num=100)
        coef = self.get_fitting_function(m)
        print(coef)

        y_estimated = self.coef2function_value(np.flip(coef), x_new)

        plt.scatter(self.x, self.y, label="original data")
        plt.plot(x_new, y_estimated, label="m value=%d" % (m))

        plt.xlabel("x")
        plt.ylabel("y")
        plt.title("least square fitting on m=%d" % (m))
        plt.legend()
        plt.show()


points = np.array([
    [0, 1.0],
    [0.25, 1.284],
    [0.5, 1.6487],
    [0.75, 2.117],
    [1.0, 2.7183]
])

solver1 = LeastSquare(points)
solver1.run()