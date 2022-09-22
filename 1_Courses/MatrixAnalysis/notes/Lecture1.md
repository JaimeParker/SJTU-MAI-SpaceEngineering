# Lecture 1 Vector Spaces and Vector Norms

the structure is based on slides by the teacher and book [Matrix Analysis](https://www.booksfree.org/wp-content/uploads/2022/06/Matrix-Analysis-2nd-Edition-by-Roger-A-Horn-and-Charles-R-Johnson-pdf-free-download-booksfree.org_.pdf)

| ID                                | School        | Teacher | Campus | Language | Date                            |
| --------------------------------- | ------------- | ------- | ------ | -------- | ------------------------------- |
| MATH6005-矩阵理论（MATH6005-M02） | (000)研究生院 | 邓大萌  | 闵行   | 中文     | 2-17周 星期一[6-8节]东上院415   |
| MATH6005-矩阵理论（MATH6005-M01） | (000)研究生院 | 郑骋    | 闵行   | 中文     | 2-17周 星期一[6-8节]东中院2-206 |

## 1.1 Vector Spaces

contents vital:

* Scalar field，数域，直译为标量场，其量均为标量（无量纲）
* Vector spaces，向量空间，但在此可能为线性空间，它是一个由向量空间出发来推广建立的（也有说两者是一回事，见同济线代）
* Subspaces, span, and linear combinations，线性子空间，列空间和
* Linear dependence and linear independence，线性无关和线性相关
* Basis，基
* Extension to a basis
* Dimension
* Isomorphism



**Definition-Vector Spaces:**

A *vector space* $V$ over a field $\bf{F}$ is a set $V$ of objects (*vectors*) that is closed under a binary operation ('addition') and scalar multiplication of vectors by elements of the scalar field $\bf{F}$, with the following properties, for all $a, b \in \bf{F}$ and all $x,y \in V$ :

* $a(x+y)=ax+ay$
* $(a+b)x=ax+bx$
* $a(bx)=(ab)x$
* $ex=x$ for the multiplicative identity $e \in \bf{F}$

**定义-线性空间：**（也可以是向量空间）

设$V$是一个以$\alpha, \beta, \gamma ...$为元素的非空集合，$F$是一个数域。在其中定义两种运算，加法：$\forall \alpha,\beta\in V$，有$\alpha+\beta \in V$；另一种为数量乘法（数乘）：$\forall \ k\in F,\ \alpha\in V$，有$k \alpha\in V$，（即上文的对加法和乘法封闭）并且满足以下八条运算法则：

* 加法交换律：$\alpha+\beta=\beta+\alpha$
* 加法结合律：$(\alpha+\beta)+\gamma=\alpha+(\beta+\gamma)$
* $V$中存在零元素：$\exists \alpha_0 \in V, \forall \alpha \in V, \alpha+\alpha_0 = \alpha$，记$\alpha_0=0$
* 负元素存在
* 存在$1\in F, 1 \cdot \alpha=\alpha$
* 分配律
* 分配律

则称$V$为数域$F$上的线性空间，$V$中的元素称为向量；数域可以是实数域或复数域；



some examples（一些特殊的线性空间）:

* ${\bf{R^2}} =\lbrace (a_1,a_2)|a_1, a_2 \in {\bf{R^2}} \rbrace$, 2 dimension space.
* ${\bf{R^n}} =\lbrace (a_1,a_2,...,a_n)|a_1, a_2,...a_n \in {\bf{R^n}} \rbrace$, $n$ dimension space. $(a_1,a_2,...,a_n)$ is called `n-tuple`
* $\bf{C^n}$ and $\bf{R^n}$ shows whose underlying field in $\bf{C}$ or $\bf{R}$
* $P_n=\lbrace {\sum_{j=0}^{n} a_jx^j|a_0, a_1,...,a_n \in {\bf R}} \rbrace$, *polynomial space*，在多项式加法和数乘多项式的运算下构成线性空间，称为多项式空间$P_n[x]$

## 1.2 Subspaces, span and linear combinations

**definition-Subspaces:**

A *Subspace* of a *vector space* $V$ over a field $\bf F$ is a subset of $V$, that is, by itself, a vector space over $\bf F$ using the same operations of vector addition and scalar multiplication as in $V$.

A subset of $V$ is a subspace precisely when it is closed under these two operations (vector addition and scalar multiplication).

**定义-子空间：**

设$V_n(F)$为线性空间，$W$为$V$的非空子集合；若$W$的元素关于$V$中加法与数乘向量法运算也构成线性空间，则称$W$为$V$的一个子空间。



而子集的包含关系使得$V_n(F)$的一个子集合是否为子空间的判别比较方便；

**定理-子空间的充分必要条件**

设$W$是线性空间$V_n(F)$的非空子集合，则$W$是$V_n(F)$的子空间的充分必要条件是：

* if $\alpha,\beta\in W$, then $\alpha+\beta\in W$
* if $\alpha\in W, k\in F$, then $k\alpha\in W$

必要性显然，则需证明其充分性（满足上述8个条件）；



