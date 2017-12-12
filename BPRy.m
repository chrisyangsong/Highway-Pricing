function[a]=BPRy(link,capacity,x,t0,n,price,lengtho)
a=inf(n,n);%9*9
linknum=length(link);
for ii=1:linknum
    a(link(ii,2),link(ii,3))=19.010*t0(ii)*(1+0.15*(x(ii)/capacity(ii))^4)+price(ii);
end  
for iii=1:n
    a(iii,iii)=0;
end
