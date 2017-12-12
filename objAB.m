function [total_cxsj,v]=objAB(n,link,OD,capacity,t0,lengtho,z)
price=z(:,1)*1+z(:,2)*2+z(:,3)*4+z(:,4)*8;
x=UEy(n,link,OD,capacity,t0,price,lengtho);
v(:,1)=x(:,end);
linknum=length(link);
for ii=1:linknum
    cxsj(ii)=v(ii)*t0(ii)*(1+0.15*(v(ii)/capacity(ii))^4);
end
total_cxsj=sum(cxsj);

end