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
* Linear dependence and linear independence，
* Basis
* Extension to a basis
* Dimension
* Isomorphism

**Definition-Vector Spaces:**

A *vector space* $V$ over a field $\bf{F}$ is a set $V$ of objects (*vectors*) that is closed under a binary operation ('addition') and scalar multiplication of vectors by elements of the scalar field $\bf{F}$, with the following properties, for all $a, b \in \bf{F}$ and all $x,y \in V$ :

* $a(x+y)=ax+ay$
* $(a+b)x=ax+bx$
* $a(bx)=(ab)x$
* $ex=x$ for the multiplicative identity $e \in \bf{F}$

**线性空间的定义：**（也可以是向量空间）

设$V$是一个以$\alpha, \beta, \gamma ...$为元素的非空集合，$F$是一个数域。在其中定义两种运算，加法：$\forall \alpha,\beta\in V$，有$\alpha+\beta \in V$；另一种为数量乘法（数乘）：$\forall \ k\in F,\ \alpha\in V$，有$k \alpha\in V$，并且满足以下八条运算法则：

