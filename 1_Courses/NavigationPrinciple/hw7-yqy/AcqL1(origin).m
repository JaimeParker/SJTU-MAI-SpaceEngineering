function [acqresult]= AcqL1(settings,DATA)
%------�����������˵��--------%
%AcqResult:���������ṹ�壬�����Ա������
%AcqResult.AcqedSatNum������������;
%AcqResult.PRN���������ǵ�α�����б�;
%AcqResult.CodeDelay��������������ʱ�б�;
%AcqResult.Doppler�������չ����б�;
%AcqResult.CN0������ȹ����б�;
%dataFile�������ļ����ṹ�壬�����Ա
%datafile.fs��������;
%IF=datafile.if����Ƶ;
%datafile.name���ļ�·��;
%datafile.format������λ��;
%datafile.byteshift�����Կ�ʼ���ֽ���;
%settings.acqsat:ָ����������α���ţ�ȡֵ0-32������0��ִ���������Ǳ���������1-32������ָ������
%Nonnum:������ۼӴ���
%------�㷨˵��--------%
%����IFFT�� m*Nnci �����㷨
%--------------------data config--------------%
fs = settings.fs;%������
IF = settings.IF;%��Ƶ
ts = 1/fs;
tc = 1/1.023e6;%L1������
blocksamples = fs/1000;
pfa = 0.001;%�龯��
dopplerrange = 10000;%�����շ�Χ+-10K
fstep = 500/settings.inttime;%�����շֱ���500
fnum = dopplerrange/fstep;

acqresult.AcqedSatNum=0;
acqresult.PRN=[];
acqresult.CodeDelay=[];
acqresult.Doppler=[];
acqresult.CN0=[];
acqresult.phi=[];
%--------------------------------------------------------------------------%
load L1code.mat;%����CA������

if (settings.acqsat==0)
    settings.acqsat = 1:32;
end

for i= settings.acqsat
    %�Լ�ʵ�ֲ���
    
end
fprintf('AcqIfftL1 finished');

