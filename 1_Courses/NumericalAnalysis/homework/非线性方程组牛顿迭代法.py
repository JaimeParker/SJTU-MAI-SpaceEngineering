from sympy import *


def fun():
    """
    求解方程的符号定义
    :return:方程
    error:这里不能用math库中的函数，pow()需要调用符号库中的函数，即sympy.pow()
    或者用from sympy import * 来导入sympy中的所有函数，之后直接写pow()函数即
    是默认的sympy中的函数。
    """
    x = symbols('x')  # 符号变量的定义
    # return 2 * exp(-x) * sin(x) + 2 * cos(x) - 0.25
    return 4*pow(x, 4) - 6 * pow(x, 2) - 11/4  # 返回函数的值


def diffFun():
    """
    求解方程的一阶导数
    :return: 一阶导数
    """
    return fun().diff()


def newtonIterative(x0, eps, maxIter):
    """
    牛顿迭代函数的作用，求解非线性方程的根，采用逼近法的思想
    :param x0:迭代初值
    :param eps:误差精度要求
    :param maxIter:最大迭代次数
    :return:返回值为None
    """
    # x1 = x0 - f(x0)/f'(x0)==>x1 = x2 - f(x1)/f'(x1)...
    x = symbols('x')
    fh = fun()  # 引用方程
    dfh = diffFun()  # 引用方程的一阶导数
    x_n = x0
    k = 0
    errval = 0
    print('%3s %10s %18s %18s' % ('迭代次数', '方程近似值', '迭代误差', 'xn'))
    # 利用牛顿迭代法的思想逐步逼近精确解
    for k in range(maxIter):
        x_b = x_n  # 代表x(n)
        fx = fh.evalf(subs={x: x_b})  # 方程在x_n处的数值
        dfx = dfh.evalf(subs={x: x_b})  # 一阶导数方程在x_n处的方程
        x_n = x_b - fx / dfx  # 牛顿迭代公式
        errval = abs(fh.evalf(subs={x: x_n}))  # 第k次迭代误差的大小
        print('%3d %22.15f %22.15f' % (k + 1, x_n, errval))
        if errval <= eps:
            break
    if k + 1 <= maxIter - 1:
        print('方程在满足精度' + str(eps) + '的条件下，近似解为：'
              + str(x_n) + ',误差为：' + str(errval))
    else:
        print('牛顿迭代法求解数值逼近，已经达到最大迭代次数，也可能不收敛或精度过高...')
    # print(x0, eps, maxIter)
    return None


if __name__ == '__main__':
    fh = fun()
    dfh = diffFun()
    plot(fh)
    plot(dfh)
    x0 = float(input('请输入迭代初值：'))  # input函数总是以字符串的形式返回
    eps = float(input('请输入误差精度要求：'))  # 方程解的精度要求是近似解与真值之间的误差
    maxIter = int(input('请输入最大迭代次数：'))  # 方程一般会迭代无数次，必须定义其迭代的次数，以求收敛
    newtonIterative(x0, eps, maxIter)
    print('方程为：', '%30s' % (str(fun())))
    print('方程的导数为：' '%22s' % (str(diffFun())))