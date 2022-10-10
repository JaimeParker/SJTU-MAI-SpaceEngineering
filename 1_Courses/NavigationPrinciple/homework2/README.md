# Homework2 Coordinate Conversion

* Coordinate conversion: find a point A on SJTU campus, marked on the Baidu/Google Map to obtain the geodetic coordinate(l,l,h), and convert it to ECEF, and ECI (optional).
* Given a point B (121.455899°, 31.036321°，100m), calculate the ENU of point B relative to your own Point A. Plot the skymap marked with  elevation and azimuth.

## LLA to ECEF

given latitude $\phi$, longitude $\lambda$, height $h$;
$$
X=(N(\phi)+h)\cos \phi \cos \lambda\\
Y=(N(\phi)+h)\cos \phi \sin \lambda\\
Z = ((1-e^2)N(\phi)+h)\sin \phi
$$
where
$$
N(\phi)=\frac{a}{\sqrt{1-e^2\sin^2\phi}}
$$
set $A(31.036, 121.455, 0)$, the coordinate in `ECEF` is $(-2.8437*10^6, 4.66613*10^6, 3.26931*10^6)$

## ENU

* get the `ECEF` position of point A
* get the `ECEF` position of point B
* using transferring matrix

the vector in `ENU` coordinate from `r` to `p` is:
$$
\begin{bmatrix}
x \\ y \\ z
\end{bmatrix}=
\begin{bmatrix}
-\sin\lambda_r & \cos\lambda_r & 0\\
-\sin\phi_r\cos\lambda_r & -\sin\phi_r\sin\lambda_r & \cos\phi_r\\
\cos\phi_r\cos\lambda_r & \cos\phi_r\sin\lambda_r & \sin\phi_r
\end{bmatrix}
\begin{bmatrix}
X_p-X_r\\
Y_p-Y_r\\
Z_p-Z_r
\end{bmatrix}
$$
so the vector $r\rightarrow p$ will be the vector in sky map.

<img src="sky map.jpg" alt="sky map" style="zoom:50%;" />

