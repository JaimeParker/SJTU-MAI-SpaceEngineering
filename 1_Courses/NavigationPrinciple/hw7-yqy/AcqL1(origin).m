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

for i= settings.acqsat
    %自己实现捕获
    
end
fprintf('AcqIfftL1 finished');

