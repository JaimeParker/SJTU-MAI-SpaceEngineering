# Lecture 1 homework 1-3

## homework 1

**whether a set of curved lines through the origin of $\bf R^2$ is a subspace of $\bf R^2$ ?**

define a set $W$ as a set of curved lines through the origin of $\bf R^2$:
$$
W=\lbrace (x,y)|y=\sum_{j=0}^{n}a_jx^{j+1}, x,y \in {\bf R^2}, a_0, a_1,...a_n \in R \rbrace
$$
according to the definition of subspaces, if $W$ is a subspace of $\bf R^2$, then:
$$
\begin{cases}
 (x_1, y_1),(x_2,y_2) \in W, \implies (x_1+x_2,y_1+y_2)\in W\\
x_1,y_1) \in W, k\in F, \implies (kx_1,ky_1)\in W
\end{cases}
$$

* $y_1=\sum_{j=0}^{n}a_jx_1^{j+1}$, $y_2=\sum_{j=0}^{n}b_jx_2^{j+1}$, $y_1+y_2=\sum_{j=0}^nc_j(x_1+x_2)^{j+1}$
* $y_1+y_2=a_0x_1+b_0x_2+a_1x_1^2+b_1x_2^2$

$\implies$ $c_1x_1x_2\equiv 0$

while $x_1,x_2$ can't be 0 forever, so $c_1=0$

As the same way, it can be concluded that $c_2,c_3,...,c_n=0$

so a set of straight lines are subspace of $\bf R^2$. However, curved lines are not.

## homework 2

**let $v_1,v_2\in {\bf R^3}$, $W=\lbrace av_1+bv_2|a,b\in {\bf R} \rbrace$. Is $W$ a subspace of $\bf R^3$?**

According to the definition of subspace, if $W$ is a subspace of $\bf R^3$, then:

for $\alpha, \beta\in W$,

* $\alpha=av_1+bv_2, a, b \in R$
* $\beta = cv_1+dv_2, c,d\in R$

$\implies \alpha+\beta=(a+c)v_1+(b+d)v_2\in W$

*  $\alpha=av_1+bv_2,k\in F$

$\implies k\alpha=kav_1+kbv_2\in W$

In conclusion, $W$ is a subspace of $\bf R^2$

## homework 3

**let $W_2={B|B\in R^{n\times n}.\det(B) \neq 0}$. Is $W_2$ a subspace of $R^{n \times n}$?**

$\det(B) \neq0 \implies 0\notin W_2$

In conclusion, $W_2$ is not a subspace of $R^{n\times n}$
