clc
clear
n=9;           %9 node
linkno=12;
OD=[0	0	0	0	0	0	0	0	6000
0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0
0	0	0	0	0	0	0	0	0];
link=[1,1,2;2,2,3;3,1,4;4,2,5;5,3,6;6,4,5;7,5,6;8,4,7;9,5,8;10,6,9;11,7,8;12,8,9];
capacity=5000.*ones(linkno,1);
lengtho=[40,46,36,38,32,28,34,48,40,52,16,36]'*5;
% lengtho=[40,46,36,38,32,28,34,48,40,52,16,36]';
t0=lengtho./120;
pci_begin=[83,91,92,86,85,95,93,84,88,93,89,90]';
% pci_begin=[85,90,90,80,80,85,90,90,80,80,90,90]';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%B=40*10^4;
z=zeros(linkno,4);
z(1:12,1)=1;z(1:10,2)=1;z(1:5,3)=1;z(1:10,4)=1;%1.5%
[TTori,v]=objAB(n,link,OD,capacity,t0,lengtho,z);
[lamda,miu]=multipliers(z,linkno,n,link,OD,capacity,t0,lengtho,TTori);
theta=-10^9;
[g_val,h_val,obj_val]=kp(z,linkno,lamda,miu,theta,lengtho,pci_begin,v);
        if obj_val >0
            return
        end
x1=0;x2=0;x3=0;


while obj_val~=0
    z=z+g_val-h_val;
    z=round(z);
    fai=obj_val;
    [TTiter,v]=objAB(n,link,OD,capacity,t0,lengtho,z);
     %TTiter
     %TTori;
     if TTiter<TTori
        TTori=TTiter;
        [lamda,miu]=multipliers(z,linkno,n,link,OD,capacity,t0,lengtho,TTori);
        [g_val,h_val,obj_val]=kp(z,linkno,lamda,miu,theta,lengtho,pci_begin,v);
        x3=x3+1
        if obj_val >0
            return
        end
     else
        z=z-g_val+h_val;
        z=round(z);
        theta=fai+200;
        [TT,v]=objAB(n,link,OD,capacity,t0,lengtho,z);
        [g_val,h_val,obj_val]=kp(z,linkno,lamda,miu,theta,lengtho,pci_begin,v);
        %x1=x1+1
        if obj_val >0
            return
        end
     end
end
price=z(:,1)*1+z(:,2)*2+z(:,3)*4+z(:,4)*8
[cost,liuliang]=objAB(n,link,OD,capacity,t0,lengtho,z)






