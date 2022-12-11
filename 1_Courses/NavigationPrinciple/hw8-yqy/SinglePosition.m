clc;ifmap = 0;
% global index;
index = [02 03 04 06 09 11 16 22 26 29 31];
Sate = [];
Rdis = [];
dR = [];
Ru = 0;
dtime = 0;
ttem = [25691439.195
25691436.073
23221471.505
23221474.634
20645426.940
20645426.350
23822832.909
23822835.600
22542796.300
22542797.680
23884133.981
23884133.064
22240309.278
22240307.949
24706685.082
24706686.285
20883492.281
20883493.703
23387166.132
23387163.581
22372130.010
22372127.005
21070242.393
21070241.372
22702197.598
22702196.491
22219222.676
22219218.623
19321188.875
19321185.658
23120838.307
23120835.588];
ref = ttem(1:2:21);
% init user as 0 0 0
Ru = [0,0,0];
deltaRou = [];
for i=1:11
    tem = index(i);
    Sate(i,:) = Xt(tem,:);
    dttv2(i) = dtt(tem);
end


ref = ref'+(3e8*dttv2);

% calc
for wc=1:1000
A = [];
for i = 1:11 
    Rdis(i) = sqrt(power((Sate(i,1)-Ru(1)),2)+power((Sate(i,2)-Ru(2)),2)+power((Sate(i,3)-Ru(3)),2))+dtime;
    temR = Rdis(i)-dtime;
    dx(i) =  (Sate(i,1)-Ru(1))/temR;
    dy(i) =  (Sate(i,2)-Ru(2))/temR;
    dz(i) =  (Sate(i,3)-Ru(3))/temR;
    deltaRou(i) = Rdis(i)-ref(i);
    A(i,:) = [dx(i) dy(i) dz(i) 1];
end

dR = inv(A'*A)*(A')*deltaRou';
Ru = Ru + dR(1:3)';
dtime = dR(4);
end
real_cord = [-289833.9300 -2756501.0600  5725162.2200];
finalcol = Ru - real_cord;

if ifmap == 1
for con = 1:11
    sat_cord = Sate(con,:);
    Skymap(real_cord, sat_cord',con);hold on;
end
end
B = inv(A'*A);
GDOP = sqrt(B(1,1)+B(2,2)+B(3,3)+B(4,4));
disp("######################################################")
disp("The time we choose is at 00:00:00")
disp("Via Least Square Method, the final converted value as follow:")
fprintf("[%.2f %.2f %.2f]\n",Ru(1),Ru(2),Ru(3));
disp("The distance between code outcome and accurate value is:")
fprintf("[%.2f %.2f %.2f]\n",finalcol(1),finalcol(2),finalcol(3));
finalcol = abs(finalcol);
disp("The mean & rms error of outcome is")
fprintf("mean error:%.2f m\nrms error:%.2f m\n",mean(finalcol),rms(finalcol));
fprintf("The GDOP of our choice is %.2f\n",GDOP);


