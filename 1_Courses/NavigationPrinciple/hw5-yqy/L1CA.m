code1 = codegen_L1CA(1);
code2 = codegen_L1CA(2);
% fprintf("cross-correlation %d/1023 \n",sum(code1.*code2))
codegen_prn1(code1);
codegen_cor(code1,code2);

function codegen_cor(code1,code2)
    g1 = code1;
    g2 = code2;
    cond1 = 0;
    cond65 = 0;
    cond63 = 0;
    cond1023 = 0;
    for i=1:1023
        gi = i;
        g1tmp(1, 1:gi)      = g1(1, 1023-gi+1:1023);
        g1tmp(1, gi+1:1023) = g1(1, 1:1023-gi);
        cor = sum(g2.*g1tmp);

        switch(cor)
            case -1
                cond1 = cond1 +1;
            case -65
                cond65 = cond65 +1;
            case 63
                cond63 = cond63 +1;
            case 1023
                cond1023 = cond1023 +1;
            otherwise
                fprintf("error is %d \n",cor)
        end
    end
    disp("#################################")
    disp("The outcomes of two prn codes cross-correlation are list below(\1023):")
    fprintf("Num of -1：%d\nNum of -65:%d\nNum of 63: %d\nNum of 1024: %d\n",cond1,cond65,cond63,cond1023)
end


function codegen_prn1(code1)
    g1 = code1;
    cond1 = 0;
    cond65 = 0;
    cond63 = 0;
    cond1023 = 0;

    for i=1:1023
        gi = i;
        g1tmp(1, 1:gi)      = g1(1, 1023-gi+1:1023);
        g1tmp(1, gi+1:1023) = g1(1, 1:1023-gi);
        cor = sum(g1.*g1tmp);

        switch(cor)
            case -1
                cond1 = cond1 +1;
            case -65
                cond65 = cond65 +1;
            case 63
                cond63 = cond63 +1;
            case 1023
                cond1023 = cond1023 +1;
            otherwise
                fprintf("error is %d \n",cor)
        end
    end
    disp("#################################")
    disp("The outcomes of one prn code autocorrelation are list below(\1023):")
    fprintf("Num of -1：%d\nNum of -65:%d\nNum of 63: %d\nNum of 1024: %d\n",cond1,cond65,cond63,cond1023)
end 

function code = codegen_L1CA(svnum)
%==========================================================================
% 
%--------------------------------------------------------------------------
% Obtained from Scott Gleason's book "GNSS Applications and Methods"
% (ISBN-13: 978-1596933293)
% Copyright 2000 D. Akos
% License: GNU GPL
%==========================================================================
    
    % the g2s vector holds the appropriate shift of the g2 code to generate
    % the C/A code (ex for SV#19 - use a G2 shift of g2s(19)=471)    
    g2s = [   5;   6;   7;   8;  17;  18; 139; 140; 141; 251; ...
        252; 254; 255; 256; 257; 258; 469; 470; 471; 472; ...
        473; 474; 509; 512; 513; 514; 515; 516; 859; 860; ...
        861; 862];

    g2shift = g2s(svnum,1);

    % ****** Generate G1 code ******
    % load shift register
    reg = -1*ones(1,10);
    g1 = zeros(1,1023);
    for i=1:1023
        g1(i) = reg(10);
        save1 = reg(3)*reg(10);
        reg(1, 2:10) = reg(1:1:9);
        reg(1) = save1;
    end

    % ****** Generate G2code ******
    % load shift register
    reg = -1*ones(1,10);
    for i=1:1023
        g2(i) = reg(10);
        save2 = reg(2)*reg(3)*reg(6)*reg(8)*reg(9)*reg(10);
        reg(1, 2:10) = reg(1:1:9);
        reg(1) = save2;
    end

    % ****** Shift G2 code ******
    g2tmp(1, 1:g2shift)      = g2(1, 1023-g2shift+1:1023);
    g2tmp(1, g2shift+1:1023) = g2(1, 1:1023-g2shift);
    g2 = g2tmp;

    % ****** Form single sample C/A code by multiplying G1 and G2 ******
    code = g1 .* g2;
end
