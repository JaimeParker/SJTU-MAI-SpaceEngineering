# homework 2

use `mosek` to solve a `QP` convex problem

consider the problem:

minimize
$$
x_1^2+0.15x_2^2+x_3^2-x_1x_3-x_2
$$
subject to
$$
1 \leq x_1+x_2+x_3-x_1^2-x_2^2-0.1x_3^2+0.2x_1x_3, \quad x\geq 0
$$
this is equivalent to

minimize
$$
\frac12x^TQ^ox+c^Tx
$$
subject to
$$
\frac12 x^T Q^0x+Ax \geq b, \quad x\geq 0
$$
where
$$
Q^o=\begin{bmatrix}
2 & 0 & -1\\
0 & 0.15 & 0\\
-1 & 0 & 2
\end{bmatrix},\quad
c=\begin{bmatrix}
0\\-1\\0
\end{bmatrix}
$$
and
$$
Q^0=\begin{bmatrix}
-2 & 0 & 0.2\\
0 & -2 & 0\\
0.2 & 0 & -0.2
\end{bmatrix}, \quad A=\begin{bmatrix}1&1&1\end{bmatrix}, \quad b = 1
$$
use revised example `cpp` executable

```
Problem
  Name                   :                 
  Objective sense        : minimize        
  Type                   : QCQO (quadratically constrained optimization problem)
  Constraints            : 1               
  Affine conic cons.     : 0               
  Disjunctive cons.      : 0               
  Cones                  : 0               
  Scalar variables       : 3               
  Matrix variables       : 0               
  Integer variables      : 0               

Optimizer started.
Quadratic to conic reformulation started.
Quadratic to conic reformulation terminated. Time: 0.00    
Presolve started.
Eliminator started.
Freed constraints in eliminator : 0
Eliminator terminated.
Linear dependency checker started.
Linear dependency checker terminated.
Eliminator started.
Freed constraints in eliminator : 0
Eliminator terminated.
Eliminator - tries                  : 2                 time                   : 0.00            
Lin. dep.  - tries                  : 1                 time                   : 0.00            
Lin. dep.  - number                 : 0               
Presolve terminated. Time: 0.00    
Problem
  Name                   :                 
  Objective sense        : minimize        
  Type                   : QCQO (quadratically constrained optimization problem)
  Constraints            : 1               
  Affine conic cons.     : 0               
  Disjunctive cons.      : 0               
  Cones                  : 0               
  Scalar variables       : 3               
  Matrix variables       : 0               
  Integer variables      : 0               

Optimizer  - threads                : 4               
Optimizer  - solved problem         : the primal      
Optimizer  - Constraints            : 5
Optimizer  - Cones                  : 2
Optimizer  - Scalar variables       : 11                conic                  : 10              
Optimizer  - Semi-definite variables: 0                 scalarized             : 0               
Factor     - setup time             : 0.00              dense det. time        : 0.00            
Factor     - ML order time          : 0.00              GP order time          : 0.00            
Factor     - nonzeros before factor : 15                after factor           : 15              
Factor     - dense dim.             : 0                 flops                  : 1.76e+02        
ITE PFEAS    DFEAS    GFEAS    PRSTATUS   POBJ              DOBJ              MU       TIME  
0   1.0e+00  1.8e+00  3.1e+00  0.00e+00   1.414213562e+00   -2.828427125e+00  1.0e+00  0.01  
1   2.4e-01  4.4e-01  3.6e-01  4.35e-01   1.770292557e-02   -1.230280685e+00  2.4e-01  0.01  
2   5.0e-02  9.1e-02  3.0e-02  1.02e+00   -4.895105575e-01  -7.501174562e-01  5.0e-02  0.01  
3   1.3e-03  2.3e-03  1.1e-04  1.07e+00   -5.131624792e-01  -5.199449081e-01  1.3e-03  0.01  
4   2.7e-05  5.0e-05  3.4e-07  1.01e+00   -5.137829543e-01  -5.139291461e-01  2.7e-05  0.01  
5   2.7e-06  5.0e-06  1.1e-08  1.00e+00   -5.138012848e-01  -5.138159186e-01  2.7e-06  0.01  
6   3.3e-07  6.1e-07  4.5e-10  1.00e+00   -5.138032183e-01  -5.138049909e-01  3.3e-07  0.01  
7   5.1e-08  9.3e-08  2.7e-11  1.00e+00   -5.138034523e-01  -5.138037227e-01  5.1e-08  0.01  
8   8.3e-09  1.5e-08  1.8e-12  1.00e+00   -5.138034878e-01  -5.138035317e-01  8.3e-09  0.01  
9   1.2e-10  2.1e-10  4.1e-15  1.00e+00   -5.138034946e-01  -5.138034951e-01  1.2e-10  0.01  
Optimizer terminated. Time: 0.01    


Interior-point solution summary
  Problem status  : PRIMAL_AND_DUAL_FEASIBLE
  Solution status : OPTIMAL
  Primal.  obj: -5.1380349464e-01   nrm: 1e+00    Viol.  con: 2e-10    var: 0e+00  
  Dual.    obj: -5.1381896040e-01   nrm: 1e+00    Viol.  con: 0e+00    var: 1e-05  
Optimal primal solution
x[0]: 4.535553e-01
x[1]: 9.457797e-01
x[2]: 6.856943e-01
```

which needs to be reminded

```
qcsubi (MSKint32t*) – Row subscripts for quadratic constraint matrix. (input)
qcsubj (MSKint32t*) – Column subscripts for quadratic constraint matrix. (input)
qcval (MSKrealt*) – Quadratic constraint coefficient values. (input)
```

