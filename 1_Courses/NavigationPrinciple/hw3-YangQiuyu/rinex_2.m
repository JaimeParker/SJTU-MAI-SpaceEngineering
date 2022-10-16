% eph(1,i)  = svprn;
% eph(2,i)  = af2;
% eph(3,i)  = M0;
% eph(4,i)  = roota;
% eph(5,i)  = deltan;b n
% eph(6,i)  = ecc; 
% eph(7,i)  = omega;%%%%%%%%%%%%%%%%%
% eph(8,i)  = cuc;
% eph(9,i)  = cus;
% eph(10,i) = crc;
% eph(11,i) = crs;
% eph(12,i) = i0;
% eph(13,i) = idot;
% eph(14,i) = cic;
% eph(15,i) = cis;
% eph(16,i) = Omega0;%%%%%%%%%%%%%%%%%
% eph(17,i) = Omegadot;%%%%%%%%%%%%%%%%%
% eph(18,i) = toe;%%%%?
% eph(19,i) = af0;
% eph(20,i) = af1;
% eph(21,i) = toc;%%%%?
% eph(22,i) = IODE;
% eph(23,i) = IODC;
% eph(24,i) = weekno;
% eph(25,i) = L2flag;
% eph(26,i) = svaccur;
% eph(27,i) = svhealth;
% eph(28,i) = tgd;%%%%?
% eph(29,i) = weekno*7*86400 + tom;% transition time of message，这个参数用不到
% eph(30,i) = weekno*7*86400 + toe;%toe，这个参数在计算轨道的时候需要用到
% eph(31,i) = weekno*7*86400 + toc;%toc，这个参数在计算clock参数需要用到
% 
% %next please use eph to calculate the satellite position.
e = ecc;
A = roota^2;
miu = GM;
n0 = sqrt(miu/power(A,3));
tk = 60;
n = n0+deltan;
% M0 = -0.7640576294E+000;

Mk = M0+n*tk;

E0 = Mk;
tem = 1;
while(abs(tem)>1e-4)
    E1 = E0+(Mk-E0+e*sin(E0))/(1-e*cos(E0));
    tem = E1-E0;
    E0 = E1;
end
Ek = E0;
tem = sqrt((1+e)/(1-e))*tan(Ek/2);
vk = 2*atan(tem);
somega = omega;
% somega = 0.944318348;
% OmegaE = 7.2921151467e-5;
% i = 0.9889106755;
% OmegaP = 0.2426539643E+000-OmegaE*(t1-t);
phik = vk+somega;
ek = Ek;
corr_u = cus*sin(2.0*phik) + cuc*cos(2.0*phik);
corr_r = crs*sin(2.0*phik) + crc*cos(2.0*phik);
corr_i = cis*sin(2.0*phik) + cic*cos(2.0*phik);

uk = phik + corr_u;
rk = A*(1.0-e*cos(ek)) + corr_r;
ik = i0 + idot*tk + corr_i;
xpk = rk*cos(uk);
ypk = rk*sin(uk);

OmegaP = Omega0+Omegadot*tk-Oe_dot*(toe+tk);
i = ik;

Xtx = xpk*cos(OmegaP)-ypk*sin(OmegaP)*cos(i);
Xty = xpk*sin(OmegaP)+ypk*cos(OmegaP)*cos(i);
Xtz = ypk*sin(i);
Xt = [Xtx Xty Xtz];
disp("############################");
disp("Here is the output position of Rinex")
fprintf("The Time we chose is 1 min later than the origin time\n");
fprintf("The positin in orbital coordinates is [%.2f %.2f]\n",xpk,ypk);
fprintf("The positin in ECEF coordinates is [%.2f %.2f %.2f]\n",Xt(1),Xt(2),Xt(3));
