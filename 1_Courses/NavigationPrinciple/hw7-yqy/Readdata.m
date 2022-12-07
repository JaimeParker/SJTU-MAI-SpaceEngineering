function dat= Readdata(settings)
%���ݶ�ȡ������Ҫ�����ļ�������read=0�����״ζ����ݣ�read=1��������������
%shift������ָ�룬�����ϴζ�ȡ���ݵ�λ��
%----check whether the datafile is available-----%
global point

blocksamples = settings.fs/1000;
dat=zeros(settings.block,blocksamples);%ÿ�ζ�ȡ���ݿ�Ĵ�С 40ms
fid=fopen(settings.fileName,'r');%%%%%%% not (settings.fileName,'r','b')
if (fid==-1)
    fprintf('error : Can not open data file\n');
    return;
end

fseek(fid, 0, 'bof');
Status=fseek(fid,point,'bof');%�����ݿ�ʼλSKIP ����
m1=ftell(fid);
% fprintf('skip : %d\n',m1);
if (Status==-1)
    fprintf('error : Data byes shift failed\n');
    return;
else
    for k = 1:settings.block
        [databuff,count]=fread(fid,settings.fileType*blocksamples,settings.format);
        
%         Status=fseek(fid,point,'bof');%�����ݿ�ʼλSKIP ����
%         [databuff2,count]=fread(fid,settings.fileType*blocksamples,'uint8');
        
        if k==1
            m2=ftell(fid)-m1;
            %             fprintf('1ms : %d byte\n',m2);
            msbyte=m2;
        end
        point=ftell(fid);
        if (count~= settings.fileType*blocksamples)
            fprintf('error : Data reading failed\n');
            %uncomplete %���ݶ�ȡ��־λ��������ݿ�С��20ms��˵�����ݽ������������г���
            return;
        else
            if settings.fileType ==1%BUAA data
                %                 dat(k,:)= 2*databuff'-1;
                dat(k,:)= databuff';
            else%I,Q data
                if settings.isLabSat
                    databuff(databuff==3) = -3;
                    databuff(databuff==2) = -1;
                    databuff(databuff==1) = 3;
                    databuff(databuff==0) = 1;
                end
%                 load('H:\pygnsstest.mat');
%                 rawdata = rawdata';
%                 databuff(:, 2) = rawdata(1:61380);
%                 databuff(:, 3) = databuff(:, 1) - databuff(:, 2);
                
                
                data1=databuff(1:2:end);
                data2=databuff(2:2:end);
                DATA=data1 + 1i .* data2;
                dat(k,:)= DATA.';
            end
        end
        
    end
end
fclose(fid);

%-----------start reading data--------------------------------%



