function settings = initSettings
%% Processing settings ====================================================
settings.msToProcess        = 1000;
settings.byteshift          = 0;
settings.block              = 1000;
%% Raw signal parameter ===================================================
settings.fileName           = 'GPS_L1.dat';
settings.format             = 'ubit2';
settings.fileType           = 2;
settings.IF                 = 0;
settings.fs                 = 30.69e6;
settings.codeFreqBasis      = 1.023e6;
settings.codeLength         = 1023;
settings.carrierfre         = 1575.42e6;
settings.isLabSat           = 1;
%% Acquisition settings ===================================================
settings.acqsat             = 0; %0-acquire 32 satellites, or the corresponding satellite number
settings.inttime            = 10; %acquisition coherent intgeration time = 1ms
settings.acqnon             = 2; %noncoherent accumulation time
settings.fineinit           = 2;%fine acquisition coherent intgeration time = 5ms
settings.finenon            = 5;