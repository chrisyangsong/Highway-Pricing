%模型参数
% n:节点数目
% start:路径起点
% terminal:路径终点
% a:权重矩阵
% x:路段流量
% f:路径上一个点（逆序查找）
% label:最短距离
% s:审查过的点集合
% min:最短距离
% path:路径
% X:循环流量集合
% i:循环参数
% ii:循环参数
% iii:循环参数
% j:循环参数
function[x]=UEy(n,link,OD,capacity,t0,price,lengtho)%x0p是一个矩阵，最后一列是ue状态下的流量分配结果，行数是link_num
link_num=length(link);
x(:,1)=zeros(link_num,1);%流量，初始状态
%初始化过程
a=BPRy(link,capacity,x(:,1),t0,n,price,lengtho);%9*9的cost矩阵
y=zeros(link_num,1);%各link储存流量的矩阵
for il=1:n
    for ik=1:n
        if OD(il,ik)~=0
            path=dijstray(a,il,ik);%al点到ik点在a矩阵下的最短路径
            lpath=length(path)-1;%path包含的link数
            y=volumexy(lpath,path,link,OD,il,ik,y);%al点到ik点间流量分配到link上的
        end
    end
end
x(:,2)=y;%所有分配完的流量
%最速下降法
error=inf;
ip=2;%就是用x(:,2)=y作为初始解
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



    





