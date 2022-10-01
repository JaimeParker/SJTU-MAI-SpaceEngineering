# Lecture 2 homework 4-5

ID: 122431910061

Name: `Liu Zhaohong`

## homework 4

For a set of vectors $S=\lbrace v_1,v_2,...v_n \rbrace$.  Prove that span $\lbrace S \rbrace$ is the intersection of all subspaces that contain $S$.

>Hint: for $M=\cap_{S\subseteq V} V$, $V$ is any subspace contains $S$, prove that span $\lbrace S \rbrace \subseteq M$ and $M\subseteq$ span $\lbrace S \rbrace$

**Situation 1: if $S$ is nonempty**

According to the definition of span, 

span $\lbrace S \rbrace=\lbrace a_1v_1+a_2v_2+...+a_kv_k|\ v_1,v_2...v_k\in S,a_1,a_2..a_k \in F, \text{and} \ k = 1,2,... \rbrace$ 

$S$ is a subset of a vector space $V$ over a field $\bf{F}$.

to prove span $(S)=\cap\lbrace M, \text{a subspace of } V | S\subseteq M \rbrace$;

* span$(S)$ is a vector space that contains all of $S$, so it's one of spaces $M$ in the intersection
* span$(S)$ only has linear combinations of vectors in $S$, so every vector in span$(S)$ has to be in every vector space $M$ that contains all of $S$
* therefore span$(S)$ is a subset of all the spaces $M$ in the intersection

**Situation 2: if $S$ is empty**

* if $S$ is empty, it is contained in every subspace of $V$
* the intersection of every subspace of $V$ is the subspace $\lbrace 0 \rbrace$ 
* so the definition ensures that span$\lbrace S\rbrace=0$

**In conclusion,** span $\lbrace S \rbrace$ is the intersection of all subspaces that contain $S$.

## homework 5

For any $A=[a_{ij}]\in M_{m,n}(C)$, show that tr $A^{*}A=0$ if and only if $A=0$.

noticed that $A=[a_{ij}]\in M_{m,n}(C)$, so $A^*=A^T$

if tr $A^TA=\sum_{i=1,j=1}^{m,n}a_{ij}^2=0$ , then every $a_{ij}$ should equal to $0$, which means $A=0$

