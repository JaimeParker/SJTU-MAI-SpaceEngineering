function [acqresult]= AcqL1(settings,DATA)
%------输入输出参数说明--------%
%AcqResult:捕获结果，结构体，五个成员变量。
%AcqResult.AcqedSatNum：捕获卫星数;
%AcqResult.PRN：捕获卫星的伪码编号列表;
%AcqResult.CodeDelay：捕获结果的码延时列表;
%AcqResult.Doppler：多普勒估计列表;
%AcqResult.CN0：载噪比估计列表;
%dataFile：数据文件，结构体，五个成员
%datafile.fs：采样率;
%IF=datafile.if：中频;
%datafile.name：文件路径;
%datafile.format：量化位数;
%datafile.byteshift：忽略开始的字节数;
%settings.acqsat:指定待捕卫星伪码编号；取值0-32整数；0，执行所有卫星遍历搜索；1-32，搜索指定卫星
%Nonnum:非相干累加次数
%------算法说明--------%
%基于IFFT的 m*Nnci 捕获算法
%--------------------data config--------------%
fs = settings.fs;%采样率
IF = settings.IF;%中频
ts = 1/fs;
tc = 1/1.023e6;%L1码周期
blocksamples = fs/1000;
pfa = 0.001;%虚警率
dopplerrange = 10000;%多普勒范围+-10K
fstep = 500/settings.inttime;%多普勒分辨率500
fnum = dopplerrange/fstep;

acqresult.AcqedSatNum=0;
acqresult.PRN=[];
acqresult.CodeDelay=[];
acqresult.Doppler=[];
acqresult.CN0=[];
acqresult.phi=[];
%--------------------------------------------------------------------------%
load L1code.mat;%导入CA码序列

if (settings.acqsat==0)
    settings.acqsat = 1:32;
end

%--------------------------------------------------------------------------%
%%% -- yqy
f_IF = IF;
t_Coh = 1e-3;

n_Blocks = 1; % Number of blocks generated
block_Length = 1e-3; % Block length (1ms)
n_Samples = fs * block_Length;

signal_Rx = DATA';
signal_Rx = signal_Rx(:,1);
clear DATA;
for i= settings.acqsat
PRN = i;
code_In = code(PRN,:);
code_In = code_In';

chip_Fraction_In = 1e-7;
chip_Index_In = 1;
chip_Rate=1.023e6;
code_Out = [];

for k = 1:n_Blocks
    [code_Out_Block, chip_Fraction_Out] = SampleCode( fs, code_In, chip_Index_In, chip_Rate, chip_Fraction_In);
    code_Out = [code_Out code_Out_Block];
    chip_Fraction_In = chip_Fraction_Out;
end

delta_Fd = 2/(3*t_Coh); % Resolution in the doppler domain
fd_Min = -5000; % Minimum doppler (-3 MHz)
fd_Max = 5000; % Maximum doppler (+3 MHz)

carrier_Fraction_In = 0;
phase_In = 0;
carrier = [];
carrier_Cos = [];
carrier_Sin = [];

fd = fd_Min:delta_Fd:fd_Max;

n_Bins_Fd = length(fd);
L = length(code_Out);

caf_Cos = zeros(n_Bins_Fd, L);
caf_Sin = zeros(n_Bins_Fd, L);
caf = zeros(n_Bins_Fd, L);

for k = 1:n_Bins_Fd
    [carrier, ~, carrier_Cos, carrier_Sin, ~ ] = GenerateCarriers( fs, f_IF + fd(k), phase_In, n_Samples, carrier_Fraction_In); % the carrier_Fraction_Out and the phase_Out are not needed since we are generating just one block of the carrier
    
    signal_BB = signal_Rx(1:L)' .* carrier;
    caf(k,:) = abs(CirCorrFFT(signal_BB, code_Out)).^2;

end
[max_Caf_fd fd_Est] = max(max(caf,[],2)); % Estimated doppler frequency
[max_Caf_tau tau_Est] = max(max(caf,[],1));% Estimated code delay


[tem,index] = max(caf(:,tau_Est));
caftem = caf(:,tau_Est);
caftem(index) = 0;
% pause;
tem1 = tem/(sum(caftem)/length(caftem));
snr = 10*log10(tem1);
cn0 = snr+30;
fprintf("The %d PRN's snr is %d, cn0 is %d \n",i,snr,cn0);

% 3D CAF
% figure
% mesh((1:L),fd,caf);
% set(gca, 'FontSize',12);
% xlabel('$\bar{\tau}$','Interpreter','Latex','FontSize',20);
% ylabel('${\bar{f_d}}$','Interpreter','Latex','FontSize',20)
% zlabel('$\left|R(\bar{\tau},\bar{f_d})\right|^2$','Interpreter','Latex','FontSize',20)
% % axis([0.001 0.01 fd(1) fd(end) 0 100000]);
% str = ['CAF',num2str(i)];
% title(['CAF',num2str(i)],'FontSize',18)
% % saveas(gcf, str, 'fig');
% saveas(gcf,['Figures/CAF',num2str(i)], 'png');
% pause;
% 
% % 2D CAF - Code delay
% figure
% plot(caf(fd_Est,:));
% set(gca, 'FontSize',12);
% xlabel('$\bar{\tau}$','Interpreter','Latex','FontSize',20);
% ylabel('$\left|R(\bar{\tau},\hat{f_d})\right|^2$','Interpreter','Latex','FontSize',20)
% title('Code delay domain 2D CAF','FontSize',18);
% saveas(gcf, 'Figures/PCAFCode', 'fig');
% saveas(gcf, 'Figures/PCAFCode', 'png');
% 
% % 2D CAF - Doppler frequency
% figure
 plot(fd,caf(:,tau_Est),'-*');
%  pause;
% set(gca, 'FontSize',12);
% xlabel('$\bar{f_d}$','Interpreter','Latex','FontSize',20);
% ylabel('$\left|R(\hat{\tau},\bar{f_d})\right|$','Interpreter','Latex','FontSize',20)
% title('Doppler domain 2D CAF','FontSize',18);
% saveas(gcf, 'Figures/PCAFDoppler', 'fig');
% saveas(gcf, 'Figures/PCAFDoppler', 'png');
% % for i= settings.acqsat
% % %     fprintf("%d \n",i);
% %     
% % end
end

fprintf('AcqIfftL1 finished');

