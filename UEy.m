%ģ�Ͳ���
% n:�ڵ���Ŀ
% start:·�����
% terminal:·���յ�
% a:Ȩ�ؾ���
% x:·������
% f:·����һ���㣨������ң�
% label:��̾���
% s:�����ĵ㼯��
% min:��̾���
% path:·��
% X:ѭ����������
% i:ѭ������
% ii:ѭ������
% iii:ѭ������
% j:ѭ������
function[x]=UEy(n,link,OD,capacity,t0,price,lengtho)%x0p��һ���������һ����ue״̬�µ�������������������link_num
link_num=length(link);
x(:,1)=zeros(link_num,1);%��������ʼ״̬
%��ʼ������
a=BPRy(link,capacity,x(:,1),t0,n,price,lengtho);%9*9��cost����
y=zeros(link_num,1);%��link���������ľ���
for il=1:n
    for ik=1:n
        if OD(il,ik)~=0
            path=dijstray(a,il,ik);%al�㵽ik����a�����µ����·��
            lpath=length(path)-1;%path������link��
            y=volumexy(lpath,path,link,OD,il,ik,y);%al�㵽ik����������䵽link�ϵ�
        end
    end
end
x(:,2)=y;%���з����������
%�����½���
error=inf;
ip=2;%������x(:,2)=y��Ϊ��ʼ��
while error>0.001
    a=BPRy(link,capacity,x(:,ip),t0,n,price,lengtho);
    y=zeros(link_num,1);
    for il=1:n
        for ik=1:n
            if OD(il,ik)~=0
                path=dijstray(a,il,ik);
                lpath=length(path)-1;
                y=volumexy(lpath,path,link,OD,il,ik,y);
            end
        end
    end
    direction=y-x(:,ip);
    %alpha=fsolve(@(alpha)sum(direction.*(t0.*(1+0.15.*((x(:,ip)+alpha.*direction)./capacity).^4)+price)),0);
    x(:,ip+1)=x(:,ip)+1/ip.*direction;
    error=sqrt(sum((x(:,ip+1)-x(:,ip)).^2))/sum(x(:,ip));
    ip=ip+1;
end
end



    





