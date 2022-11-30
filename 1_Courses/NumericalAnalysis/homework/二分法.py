import numpy as np
def devide_two_way(f, a, b, eps):
    n = 1
    fa = f(a)
    fb = f(b)
    while True:
        if fa*fb > 0:
            print("不能用二分法求解!")
            break
        c=(a+b)/2
        fc=f(c)
        l=abs(b-a)  # 计算区间(a,b)长度
        print('二分次数：', "{0:.0f}".format(n),
              'c：', "{0:.6f}".format(c),
              'a：', "{0:.6f}".format(a),
              'b：', "{0:.6f}".format(b),
              '区间(a,b)长度：', "{0:.6f}".format(l))
        n=n+1
        if f(c) == 0:
            print('方程的根:', c)
            break
        elif fa*fc <0:
            b=c
            fb=fc
        else:
            a=c
            fa=fc
        if b-a<eps:
            print('最终区间长度：', abs(b-a))
            break
    return c

# 定义函数f(x)
def f(x):
    return np.cos(x)-x

eps = 10**-5  #确定误差范围
a=0    # a为左端点
b=1    # b为右端点
x = devide_two_way(f, a, b, eps)
print('方程的根为x=',"{0:.5f}".format(x))