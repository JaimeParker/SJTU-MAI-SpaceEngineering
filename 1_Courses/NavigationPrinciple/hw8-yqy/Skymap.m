function [] = Skymap(cordA, cordB,count)
    %cordA = LLA_to_ECEF(121.438957, 31.036641, 33);
    %cordB = LLA_to_ECEF(121.455899, 31.036321, 100);
    cord = cordB - cordA;
    ecc = 0.017; a = 6378136.49;
    lambda = atan2(cordA(2),cordA(1));
    p = sqrt(cordA(1)^2 + cordA(2)^2);
    phi = atan2(cordA(3),(1-ecc^2)*p);
    for i = 1:100
        N = a/(sqrt(1-ecc^2*(sin(phi)^2)));
        h = p/cos(phi) - N;
        phi = atan2(cordA(3),(p*(1-ecc^2*N/(N+h))));
    end
    Rotation1 = [1 0 0; 0 cos(pi/2-phi) sin(pi/2-phi); 0 -sin(pi/2-phi) cos(pi/2-phi)];
    Rotation3 = [cos(pi/2+lambda) sin(pi/2+lambda) 0; -sin(pi/2+lambda) cos(pi/2+lambda) 0; 0 0 1];
    %RL = [-sin(lambda) cos(lambda) 0; ...
    %    -sin(phi)*cos(lambda) -sin(phi)*sin(lambda) cos(phi); ...
    %    cos(phi)*cos(lambda) cos(phi)*sin(lambda) sin(phi)];
    cord_ENU = Rotation1 * Rotation3 * cord;
    %cord_ENU = RL * cord;
    xE = cord_ENU(1); xN = cord_ENU(2); xU = cord_ENU(3);

    %draw the base
    x1 = []; x2 = []; x3 = [];
    y1 = []; y2 = []; y3 = [];
    for a = -3.5:0.1:3.5
        x1(end+1) = 0; y2(end+1) = 0;
        y1(end+1) = a; x2(end+1) = a;
    end
    plot(x1,y1,'b-');hold on;
    plot(x2,y2,'b-');
    
    x1 = []; x2 = []; x3 = [];
    y1 = []; y2 = []; y3 = [];
    for a = 0:0.1:360
        x1(end+1) = 1*cos(a/180*pi); y1(end+1) = 1*sin(a/180*pi);
        x2(end+1) = 2*cos(a/180*pi); y2(end+1) = 2*sin(a/180*pi);
        x3(end+1) = 3*cos(a/180*pi); y3(end+1) = 3*sin(a/180*pi);
    end
    plot(x1,y1,'k-');
    plot(x2,y2,'k-');
    plot(x3,y3,'k-');
    
    %calculate and plot the pointB in skymap
    el = asin(xU/sqrt(xE^2+xN^2+xU^2))/pi*180;
    rou = (90-el) / 90 * 3;
    x_star = xE / sqrt(xE^2+xN^2) * rou;
    y_star = xN / sqrt(xE^2+xN^2) * rou;
    az = atan2(xE,xN)/pi*180;
    
    plot(x_star,y_star,'pentagram','LineWidth',2)

    %plot the dashed line
    %line([0,x_star],[0,y_star],'linestyle','--','linewidth',2);

    %add label and comments
%     global count ;
    index = [02 03 04 06 09 11 16 22 26 29 31];

    tem = index(count);
    xlabel('Sky map')
    text1 = 'el=90°'; text2 = 'el=60°'; text3 = 'el=30°'; text4 = 'el=0°'; 
    text5 = 'North'; text6 = 'East'; text7 = 'Baker Lake'; text8 = strcat('PRN-', num2str(index(count)));
    text9 = ['az=' num2str(az) '°'];
    text10 = ['el=' num2str(el) '°'];

    text(0,0.2,text1,'HorizontalAlignment','center');
    text(sqrt(2)/2,sqrt(2)/2,text2,'HorizontalAlignment','center');
    text(2*sqrt(2)/2,2*sqrt(2)/2,text3,'HorizontalAlignment','center');
    text(3*sqrt(2)/2,3*sqrt(2)/2,text4,'HorizontalAlignment','center');
    text(0,3.3,text5,"HorizontalAlignment","center");
    text(3.5,0,text6,"HorizontalAlignment","center");
    text(0,-0.2,text7,'HorizontalAlignment','center');
    text(x_star,y_star-0.2,text8,"HorizontalAlignment","center");
    %text(x_star,y_star-0.5,text9,"HorizontalAlignment","center");
    %text(x_star,y_star-0.8,text10,"HorizontalAlignment","center");
    
    count = count + 1;

    xlim auto
    ylim auto
    
    axis equal;

end