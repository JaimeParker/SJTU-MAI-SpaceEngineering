function [s,phis,k,ds,dphi,S]=qmin(phi,a,b,delta,epsilon)
%����: ��ȷ������֮�����߷�
%����: phi ��Ŀ�꺯��, a��b����������Ķ˵�
%         delta,epsilon���������
%���: s�ǽ��Ƽ�С��, phis�Ƕ�Ӧ�Ľ��Ƽ�Сֵ;
%          ds, dphi�ֱ���s, phis������;  S�ǵ�������
s0=a; maxj=20; maxk=30; big=1e6; err=1; k=1;
S(k)=s0; cond=0;  h=1; ds=0.00001;
if (abs(s0)>1e4), h=abs(s0)*(1e-4); end
while (k<maxk & err>epsilon &cond~=5)
    f1=(feval(phi,s0+ds)-feval(phi,s0-ds))/(2*ds);
    if(f1>0), h=-abs(h); end
    s1=s0+h;     s2=s0+2*h;      bars=s0;
    phi0=feval(phi,s0);  phi1=feval(phi,s1);  phi2=feval(phi,s2);
    barphi=phi0; cond=0;  j=0;
    %ȷ��hʹ��phi1<phi0��phi1<phi2 
    while(j<maxj&abs(h)>delta&cond==0)
        if (phi0<=phi1),
            s2=s1; phi2=phi1; h=0.5*h;
            s1=s0+h; phi1=feval(phi,s1);
        else if (phi2<phi1),
                s1=s2; phi1=phi2; h=2*h;
                s2=s0+2*h; phi2=feval(phi,s2);
            else
                cond=-1;
            end
        end
        j=j+1;
        if(abs(h)>big|abs(s0)>big), cond=5; end
    end
    if(cond==5)
        bars=s1; barphi=feval(phi,s1);
    else
        %���β�ֵ��phis
        d=2*(2*phi1-phi0-phi2);
        if(d<0),
            barh=h*(4*phi1-3*phi0-phi2)/d;
        else
            barh=h/3; cond=4;
        end
        bars=s0+barh;   barphi=feval(phi,bars);
        h=abs(h);  h0=abs(barh); 
        h1=abs(barh-h);  h2=abs(barh-2*h);
        %ȷ����һ�ε�����hֵ
        if(h0<h), h=h0; end
        if(h1<h), h=h1; end
        if(h2<h), h=h2; end
        if(h==0), h=barh; end
        if(h<delta), cond=1; end
        if(abs(h)>big|abs(bars)>big), cond=5; end
        %������ֹ�б�
        err=abs(phi1-barphi);
        %e0=abs(phi0-barphi); e1=abs(phi1-barphi); e2=abs(phi2-barphi);
        %if(e0~=0 & e0<err), err=e0; end
        %if(e1~=0 & e1<err), err=e1; end
        %if(e2~=0 & e2<err), err=e2; end
        %if(e0~=0 & e1==0 & e2==0), err=0; end
        %if(err<epsilon), cond=2; end
        s0=bars;  k=k+1; S(k)=s0;
    end
    if(cond==2&h<delta), cond=3; end
end
s=s0;  phis=feval(phi,s);
ds=h;  dphi=err;
         
        
        
               
    