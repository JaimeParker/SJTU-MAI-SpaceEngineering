# Chapter 3

Name: Liu Zhaohong

Student ID: 122431910061

## Exercise 3.1

Compare the results of the closed($n=1,2,3,4$) and open (n=0,1,2,3) Newton-Cotes formulas when approximating
$$
\int_0^{\pi/4} \sin x {\rm d}x=1-\frac{\sqrt{2}}{2} \approx 0.29289322
$$
(**a**) For closed Newton-Cotes formula
$$
\begin{align}
&\int_0^{\pi/4} \sin x {\rm d}x \approx \frac{\pi}{8}[f(\frac{\pi}{4})-f(0)]=0.27768017\\
&\int_0^{\pi/4} \sin x {\rm d}x \approx \frac{\pi}{24}[f(0)+f(\frac{\pi}{8})+f(\frac{\pi}{4})] = 0.29293268\\
&\int_0^{\pi/4} \sin x {\rm d}x \approx  \frac{3\pi / 12}{8} [f(0)+3f(\frac{\pi}{6})+3f(\frac{\pi}{12}+f(\frac{\pi}{4}))]=0.29289432\\
&\int_0^{\pi/4} \sin x {\rm d}x \approx \frac{2\pi / 16}{45} [7f(0)+32f(\frac{\pi}{16})+12f(\frac{\pi}{8})+32f(\frac{\pi}{16}))+7f(\frac{\pi}{4}))]=0.29289432\\
\end{align}
$$
(**b**) For open Newton-Cotes formula
$$
\begin{align}
n=0,&\int_0^{\pi/4} \sin x {\rm d}x \approx 0.30055885\\
n=1,&\int_0^{\pi/4} \sin x {\rm d}x \approx 0.29798753\\
n=2,&\int_0^{\pi/4} \sin x {\rm d}x \approx 0.29285864\\
n=3,&\int_0^{\pi/4} \sin x {\rm d}x \approx 0.29286921\\

\end{align}
$$

## Exercise 3.2

Use Trapezoidal rule and Simpson's rule to compute
$$
\int_0^1 \frac{\sin x}{x} {\rm d}x
$$
Note that
$$
\lim_{x\rightarrow0}\frac{\sin x}{x}=1
$$
(**a**) For Trapezoidal rule
$$
\int_0^1 \frac{\sin x}{x} {\rm d}x\approx\frac12 [f(0)+f(1)]=0.92073549
$$
(**b**) For Simpson's rule
$$
\int_0^1 \frac{\sin x}{x} {\rm d}x\approx\frac16[f(0)+4f(0.5)+f(1)]=0.94614588
$$

## Exercise 3.3

Use composite Trapezoidal rule and composite Simpson's rule to approximate
$$
\int_0^1 \frac{1}{1+x^3} {\rm d}x
$$
and
$$
\int_0^1 \frac{x}{\ln(1+x)} {\rm d}x
$$
set $n=4$

(**a**)

For composite Trapezoidal rule
$$
\int_0^1 \frac{1}{1+x^3} {\rm d}x \approx 0.83170024
$$
For composite Simpson's rule
$$
\int_0^1 \frac{1}{1+x^3} {\rm d}x \approx 0.83578551
$$
(**b**) Note that
$$
\lim_{x\rightarrow0}\frac{x}{\ln (1+x)}=1
$$
For composite Trapezoidal rule
$$
\int_0^1 \frac{x}{\ln(1+x)} {\rm d}x\approx1.228764875
$$
For composite Simpson's rule
$$
\int_0^1 \frac{x}{\ln(1+x)} {\rm d}x \approx 1.22926996
$$

## Exercise 3.4

Determine values of $h$ that will ensure an approximation error of less than 0.00002 when approximating
$$
\int_0^{\pi}\sin x {\rm d}x
$$
and employing

* Composite Trapezoidal rule
* Composite Simpson's rule

(**a**) The error from the Composite Trapezoidal rule for $f(x)=\sin x$ on $[0, \pi]$ is
$$
\left| \frac{b-a}{6}h^2f''(\mu) \right|=
\left| \frac{\pi h^2}{12}f''(\mu) \right|=
\left| \frac{\pi h^2}{12}(-\sin \mu) \right|=
\frac{\pi h^2}{12} \left| \sin\mu \right|
$$
To ensure sufficient accuracy with this technique, we need to have
$$
\frac{\pi h^2}{12} \left| \sin\mu \right| \leq \frac{\pi h^2}{12} < 0.00002
$$
Since $h=\pi/n$, we need
$$
\frac{\pi^3}{12n^2}< 0.00002
$$
which implies that
$$
n> \left( \frac{\pi^3}{12(0.00002)} \right)^{1/2} \approx359.44
$$
and the Composite Trapezoidal rule requires $n \geq 360$, $h \leq 0.0087$

(**b**) The error form for the Composite Simpson's rule for $f(x) = \sin x$ on $[0, \pi]$ is
$$
\left| \frac{b-a}{180}h^4f^{(4)}(\mu) \right|=
\frac{\pi h^4}{180} \left| \sin\mu \right|
\leq \frac{\pi h^4}{180} < 0.00002
$$
Since $h=\pi/n$, we need
$$
\frac{\pi^5}{180 n^4} < 0.00002
$$
which implies that
$$
n> \left( \frac{\pi^5}{180(0.00002)} \right)^{1/2} \approx 17.07
$$
So, the Composite Simpson's rule requires only $n\geq 18$, $h\leq 0.1840$