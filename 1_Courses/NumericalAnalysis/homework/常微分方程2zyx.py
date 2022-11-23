import numpy as np
pi = np.pi
E = np.exp(1)

itype = 2
nsteps = 10
h = 0.2

k0 = 0
k1 = 0
k2 = 0
k3 = 0
xi = [0 for _ in range(nsteps+1)]
yi = [0 for _ in range(nsteps+1)]

# 初值
xi[0] = 0
yi[0] = 1

def f(x, y):
    f = (-3*y)
    return f

def freal(x):
    f = np.exp(-3*x)
    return f

# use 龙格库塔法 to get yn
# print('**四阶龙格库塔法计算初始值**')
# print('x(i)         y(i),i=0:', nsteps, ' relative error')
# for j in range(0, nsteps+1):
#     print('{:9.5e}'.format(xi[j]), end='  ')
#     print('{:9.5e}'.format(yi[j]))
#     k0 = h*f(xi[j], yi[j])
#     k1 = h*f(xi[j]+h/2.0, yi[j]+k0/2.0)
#     k2 = h*f(xi[j]+h/2.0, yi[j]+k1/2.0)
#     k3 = h*f(xi[j]+h, yi[j]+k2)
#     # e = abs(y - Freal(x))/y
#     # print('{:9.5e}'.format(e[0]))
#     if (j+1) in range(nsteps+1):
#         yi[j+1] = yi[j]+(k0+2.0*k1+2.0*k2+k3)/6.0
#         xi[j+1] = xi[j]+h
# print(xi)
# print(yi)

# use real function to get yn
for j in range(0, nsteps+1):
    yi[j] = freal(xi[j])
    if (j+1) in range(nsteps+1):
        xi[j + 1] = xi[j]+h
print(xi)
print(yi)



y = [0 for _ in range(nsteps+1)]
x = [0 for _ in range(nsteps+1)]

if itype == 1:
    k = 2
    for num in range(k):
        y[num] = yi[num]
        x[num] = xi[num]
    print('** Adams-Bashforth two-step explicit method **')
    print('x(i)         y(i),i=0:', nsteps, ' relative error')
    for j in range(0, nsteps + 1):
        if (j + 2) in range(nsteps + 1):
            y[j+2] = y[j+1]+h/2*(3*f(x[j+1], y[j+1])-f(x[j], y[j]))
            x[j+2] = x[0]+(j+2)*h
            e = abs(y[j + 2] - freal(x[j + 2])) / freal(x[j + 2])
            print('{:9.5e}'.format(x[j+2]), end='  ')
            print('{:9.5e}'.format(y[j+2]), end='  ')
            print('{:9.5e}'.format(e))

if itype == 2:
    k = 2
    for num in range(k):
        y[num] = yi[num]
        x[num] = xi[num]
    print('** 4.56 method **')
    print('x(i)         y(i),i=0:', nsteps, ' relative error')
    for j in range(0, nsteps + 1):
        if (j + 2) in range(nsteps + 1):
            y[j + 2] = -y[j + 1] + 2*y[j]+h*((5/2)*f(x[j+1], y[j+1])+(1/2)*f(x[j], y[j]))
            x[j + 2] = x[0] + (j + 2) * h
            e = abs(y[j + 2] - freal(x[j + 2])) / freal(x[j + 2])
            print('{:9.5e}'.format(x[j + 2]), end='  ')
            print('{:9.5e}'.format(y[j + 2]), end='  ')
            print('{:9.5e}'.format(e))