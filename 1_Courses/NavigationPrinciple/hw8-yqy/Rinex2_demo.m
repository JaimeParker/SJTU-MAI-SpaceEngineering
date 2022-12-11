close all;clc;
GM = 3.986005e14;% WGS84 gravitational constant*earth mass
Oe_dot = 7.2921151467e-5;%rad/s earth ratation rate
nav_file = ['brdc2750.22n'];
% read_brdc_gps(nav_file)
eph = [];
%open navigation file
fid = fopen(nav_file,'rt'); 
%read the header
header_end = [];
iono_loaded = 0;
while (isempty(header_end))
    %read the line and search the ionosphere labels
    lin = fgetl(fid);
    
    vers_found =  contains(lin,'RINEX VERSION / TYPE');
    iono_found = (contains(lin,'ION ALPHA') || contains(lin,'IONOSPHERIC CORR'));
    clock_found = contains(lin,'DELTA-UTC: A0,A1,T,W');

    %if the ionosphere parameters label was found
    if (vers_found)
        version = str2num(lin(1:9));
    end

    %if the ionosphere parameters label was found
    if (iono_found && ~iono_loaded)
        %change flag
        %         ioparam = 1;
        %save the 8 ionosphere parameters
        data = textscan(lin(5:end),'%f%f%f%f%*[^\n]');
        if ~isempty(data{4})
            iono(1) = data{1};
            iono(2) = data{2};
            iono(3) = data{3};
            iono(4) = data{4};
            lin = [];
            while isempty(lin)
                lin = fgetl(fid);
            end
            data = textscan(lin(5:end),'%f%f%f%f%*[^\n]');
            if ~isempty(data{4})
                iono(5) = data{1};
                iono(6) = data{2};
                iono(7) = data{3};
                iono(8) = data{4};
            else
                iono = zeros(8,1);
            end
        end
        iono_loaded = 1;
    end

    if (clock_found)
       data = textscan(lin(4:end),'%f%f%d%d*[^\n]');
       a0 = data{1};
       a1 = data{2};
       SOW = data{3};
       weeknum = data{4};
    end

    header_end = strfind(lin,'END OF HEADER');
end
wc = 0;
Xt = [];

%read the ephmeris
while (~feof(fid))    
    wc = wc + 1;
    lin1 = [];
    lin2 = [];
    lin3 = [];
    lin4 = [];
    lin5 = [];
    lin6 = [];
    lin7 = [];
    lin8 = [];
    
    %read the first line (containing system and time information)
    while isempty(lin1)
        lin1 = fgetl(fid);
    end
    if (lin1 == -1)
        break
    end

    while isempty(lin2)
        lin2 = fgetl(fid);
    end

    while isempty(lin3)
        lin3 = fgetl(fid);
    end
    while isempty(lin4)
        lin4 = fgetl(fid);
    end
    while isempty(lin5)
        lin5 = fgetl(fid);
    end
    while isempty(lin6)
        lin6 = fgetl(fid);
    end
    while isempty(lin7)
        lin7 = fgetl(fid);
    end
    while isempty(lin8)
        lin8 = fgetl(fid);
        lin8 = deblank(lin8);
    end

    % Line #1
    svprn  = str2num(lin1([1:2]));
    year   = str2num(lin1([3:6])); 
    month  = str2num(lin1([7:9]));
    day    = str2num(lin1([10:12]));
    hour   = str2num(lin1([13:15]));
    minute = str2num(lin1([16:18]));
    second = str2num(lin1([19:22]));
    af0    = str2num(lin1([23:41]));
    af1    = str2num(lin1([42:60]));
    af2    = str2num(lin1([61:79]));

    IODE   = str2num(lin2([4:22]));
    crs    = str2num(lin2([23:41]));
    deltan = str2num(lin2([42:60]));
    M0     = str2num(lin2([61:79]));

    cuc    = str2num(lin3([4:22]));
    ecc    = str2num(lin3([23:41]));
    cus    = str2num(lin3([42:60]));
    roota  = str2num(lin3([61:79]));

    toe    = str2num(lin4([4:22]));
    cic    = str2num(lin4([23:41]));
    Omega0 = str2num(lin4([42:60]));
    cis    = str2num(lin4([61:79]));

    i0       = str2num(lin5([4:22]));
    crc      = str2num(lin5([23:41]));
    omega    = str2num(lin5([42:60]));
    Omegadot = str2num(lin5([61:79]));

    idot       = str2num(lin6([4:22]));
    code_on_L2 = str2num(lin6([23:41]));%
    weekno     = str2num(lin6([42:60]));
    L2flag     = str2num(lin6([61:79]));%

    svaccur  = str2num(lin7([4:22]));%accuracy, 
    svhealth = str2num(lin7([23:41]));%health
    tgd     = str2num(lin7([42:60]));
    IODC     = str2num(lin7([61:79]));

    tom      = str2num(lin8([4:22])); %transition time of message
        %IODC     = str2num(lin8([23:41]));
    [~, toc] = date2gps([year month day hour minute second]);
%save ephemerides

e = ecc;
A = roota^2;
miu = GM;
n0 = sqrt(miu/power(A,3));
% tk = 60;
tk = 0;
dtsat = af0 + af1*tk + af2*tk*tk;
dtt(wc) = dtsat;
dtsat = dtsat+tk;
% dtsat = tk + dtsat;
% dtt(wc) = dtsat + tk;
n = n0+deltan;
% M0 = -0.7640576294E+000;

Mk = M0+n*dtsat;

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
ik = i0 + idot*dtsat + corr_i;
xpk = rk*cos(uk);
ypk = rk*sin(uk);

OmegaP = Omega0+Omegadot*dtsat-Oe_dot*(toe+dtsat);

i = ik;

Xtx = xpk*cos(OmegaP)-ypk*sin(OmegaP)*cos(i);
Xty = xpk*sin(OmegaP)+ypk*cos(OmegaP)*cos(i);
Xtz = ypk*sin(i);

Xt(wc,:) = [Xtx Xty Xtz];

if (wc == 32)
    break;
end

end

% i = 1;% only process one satellite here
% i = 1;
% eph(1,i)  = svprn;
% eph(2,i)  = af2;
% eph(3,i)  = M0;
% eph(4,i)  = roota;
% eph(5,i)  = deltan;
% eph(6,i)  = ecc;
% eph(7,i)  = omega;
% eph(8,i)  = cuc;
% eph(9,i)  = cus;
% eph(10,i) = crc;
% eph(11,i) = crs;
% eph(12,i) = i0;
% eph(13,i) = idot;
% eph(14,i) = cic;
% eph(15,i) = cis;
% eph(16,i) = Omega0;
% eph(17,i) = Omegadot;
% eph(18,i) = toe;
% eph(19,i) = af0;
% eph(20,i) = af1;
% eph(21,i) = toc;
% eph(22,i) = IODE;
% eph(23,i) = IODC;
% eph(24,i) = weekno;
% eph(25,i) = L2flag;
% eph(26,i) = svaccur;
% eph(27,i) = svhealth;
% eph(28,i) = tgd;
% eph(29,i) = weekno*7*86400 + tom;% transition time of message，这个参数用不到
% eph(30,i) = weekno*7*86400 + toe;%toe，这个参数在计算轨道的时候需要用到
% eph(31,i) = weekno*7*86400 + toc;%toc，这个参数在计算clock参数需要用到

%next please use eph to calculate the satellite position.





