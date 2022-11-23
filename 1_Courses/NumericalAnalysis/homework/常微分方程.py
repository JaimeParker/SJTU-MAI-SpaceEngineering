import numpy as np

pi = np.pi
E = np.exp(1)

itype=3
n=1  # 维度，一般为1维
nsteps=40
h=0.05
k0=np.zeros((n))
k1=np.zeros((n))
k2=np.zeros((n))
k3=np.zeros((n))
y=np.zeros((n))
x=0.0;y[:]=(1)

def f71(x,y):  # 设置常微分方程
    n=y.shape[0]
    f71=np.zeros((n))
    f71[0]=(y[0]*x+x**3)
    return f71

def Freal(x):
    y = (-2*E**((-x**2)/2)*(((x**2)/2)+1)+3)*(E**((x**2)/2))
    return y

print('常微分方程的一步法')
if itype==1:
    print('**欧拉法**')
    print('x(i)         y(i),i=0:', n, ' relative error')
    for j in range(0,nsteps+1):
        print('{:9.5e}'.format(x), end='  ')
        for i in range(1,n+1):
            print('{:9.5e}'.format(y[i-1]),end='  ')
        e = abs(y - Freal(x))/y
        print('{:9.5e}'.format(e[0]))
        k0=h*f71(x,y);y=y+k0;x=x+h
elif itype==2:
    print('**修正欧拉法**')
    print('x(i)         y(i),i=0:', n, ' relative error')
    for j in range(0,nsteps+1):
        print('{:9.5e}'.format(x), end='  ')
        for i in range(1,n+1):
            print('{:9.5e}'.format(y[i-1]),end='  ')
        e = abs(y - Freal(x))/y
        print('{:9.5e}'.format(e[0]))
        k0=h*f71(x,y);k1=h*f71(x+h,y+k0);y=y+(k0+k1)/2.0;x=x+h
elif itype==3:
    print('**中点法**')
    print('x(i)         y(i),i=0:', n, ' relative error')
    for j in range(0, nsteps+1):
        print('{:9.5e}'.format(x), end='  ')
        for i in range(1,n+1):
            print('{:9.5e}'.format(y[i-1]),end='  ')
        e = abs(y - Freal(x)) / y
        print('{:9.5e}'.format(e[0]))
        k0 = h*f71(x,y);k1=h*f71(x+h/2.0,y+k0/2.0);y=y+k1;x=x+h
elif itype == 4:
    print('**四阶龙格库塔法**')
    print('x(i)         y(i),i=0:', n, ' relative error')
    for j in range(0, nsteps+1):
        print('{:9.5e}'.format(x), end='  ')
        for i in range(1,n+1):
            print('{:9.5e}'.format(y[i-1]), end='  ')
        k0 = h*f71(x, y); k1 = h*f71(x+h/2.0, y+k0/2.0)
        k2 = h*f71(x+h/2.0, y+k1/2.0); k3 = h*f71(x+h, y+k2)
        e = abs(y - Freal(x))/y
        print('{:9.5e}'.format(e[0]))
        y=y+(k0+2.0*k1+2.0*k2+k3)/6.0
        x=x+h