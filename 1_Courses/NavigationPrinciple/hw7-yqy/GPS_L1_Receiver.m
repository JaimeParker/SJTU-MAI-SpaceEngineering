%% GPS L1 acquisition Demo
clc; clear; close all;
tic
settings=initSettings;
global point msbyte
point=settings.byteshift;
msbyte=0;
DATA=Readdata(settings);
Acq = AcqL1(settings,DATA);
%Acq = AcqL1_ifft_DTA(settings,DATA);
toc;   