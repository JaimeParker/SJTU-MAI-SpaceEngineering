e = 0.1200914383E-001;
A = 5153.616211^2;
miu = 3.986005e14;
n = sqrt(miu/power(A,3));
M0 = -0.7640576294E+000;
t = 61440.0000;
t1 = t+60;
M = M0+n*(t1-t);
somega = 0.944318348;
OmegaE = 7.2921151467e-5;
i = 0.9889106755;
OmegaP = (0.2426539643E+000)-OmegaE*t1;

E0 = M0;
tem = 1;
while(abs(tem)>1e-4)
    E1 = E0+(M-E0+e*sin(E0))/(1-e*cos(E0));
    tem = E1-E0;
    E0 = E1;
end
ek = E0;
tem = sqrt((1+e)/(1-e))*tan(E0/2);
vk = 2*atan(tem);
phik = vk+somega;

%  cus =  0.177137553692e-05; 
%  cuc =  0.457651913166e-05; 
%  crs =  88.6875000000; 
%  crc =  344.968750000; 
%  cis = -0.856816768646e-07;
%  cic =  0.651925802231e-07; 

% corr_u = cus*sin(2.0*phik) + cuc*cos(2.0*phik);
% uk = phik + corr_u;
rk = A*(1.0-e*cos(ek));
% ik = i0 + idot*tk + corr_i;

xpk = rk*cos(phik);
ypk = rk*sin(phik);

Xtx = xpk*cos(OmegaP)-ypk*sin(OmegaP)*cos(i);
Xty = xpk*sin(OmegaP)+ypk*cos(OmegaP)*cos(i);
Xtz = ypk*sin(i);
Xt = [Xtx Xty Xtz];

disp("############################");
disp("Here is the output position of Yuma")
fprintf("The Time we chose is 1 min later than the origin time\n");
fprintf("The positin in orbital coordinates is [%.2f %.2f]\n",xpk,ypk);
fprintf("The positin in ECEF coordinates is [%.2f %.2f %.2f]\n",Xt(1),Xt(2),Xt(3));


