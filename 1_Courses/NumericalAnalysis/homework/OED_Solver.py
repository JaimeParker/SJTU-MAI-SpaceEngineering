# compose solution for ODEs problems by numerical method
# reference of ODEs from wiki
# https://en.wikipedia.org/wiki/Ordinary_differential_equation#General_definition
# and reference of OEDs' numerical solution
# https://en.wikipedia.org/wiki/Numerical_methods_for_ordinary_differential_equations

# import libs


# class solver for ODEs
class ODESolver:
    def __init__(self, df):
        """init function
        :param df need to be a function with 2 params, like f(t, y)"""
        self.df = df  # df is the derivative function (rank 1, 一阶导数)

    def forward_euler(self, init_y, start, end, len_step):
        """compose forward euler method for a well-posed initial value problem
        :param init_y the function value at start point, namely y(start)
        :param start the value of left interval
        :param end the value of right interval
        :param len_step the length of step"""

        if end <= start:
            raise Exception('Error! Bad interval input')

        num_steps = int((end - start) / len_step)
        # init t and w in f(t, w), avoid using y for misunderstanding
        t = start
        w = init_y
        print("w0 = %f" % w)

        for i in range(num_steps):
            w += len_step * self.df(t, w)
            t += len_step
            index = int(i + 1)
            print("w%d = %f" % (index, w))

        return w

    def two_order_taylor(self, d2f, init_y, start, end, num_step):
        """compose forward euler method for a well-posed initial value problem
        :param d2f f'(t, w)
        :param init_y the function value at start point, namely y(start)
        :param start the value of left interval
        :param end the value of right interval
        :param num_step the number of step"""

        if end <= start:
            raise Exception('Error! Bad interval input')

        len_step = (end - start) / num_step
        # init t and w in f(t, w), avoid using y for misunderstanding
        t = start
        w = init_y
        print("w0 = %f" % w)

        for i in range(num_step):
            w += len_step * (self.df(t, w) + len_step / 2 * d2f(t, w))
            t += len_step
            index = i + 1
            print("w%d = %f" % (index, w))
        return w

    def modified_euler(self, init_y, start, end, num_step):
        len_step = (end - start) / num_step
        t = start
        w = init_y

        for i in range(num_step):
            k0 = len_step * self.df(t, w)
            k1 = len_step * self.df(t + len_step, w + k0)
            w = w + (k0 + k1) / 2.0
            t = t + len_step

        return w

    def runge_kutta_4(self, init_y, start, end, num_step):
        len_step = (end - start) / num_step
        t = start
        w = init_y

        for i in range(num_step):
            k0 = len_step * self.df(t, w)
            k1 = len_step * self.df(t + len_step / 2.0, w + k0 / 2.0)
            k2 = len_step * self.df(t + len_step / 2.0, w + k1 / 2.0)
            k3 = len_step * self.df(t + len_step, w + k2)
            w = w + (k0 + 2.0 * k1 + 2.0 * k2 + k3) / 6.0
            t = t + len_step

        return w


def func4_2(t, y):
    return y - t * t + 1


def func4_3_2(t, y):
    return y - t * t + 1 - 2 * t


test4_2 = ODESolver(func4_2)
test4_2.forward_euler(0.5, 0, 2, 0.2)
test4_2.two_order_taylor(func4_3_2, 0.5, 0, 2, 10)
