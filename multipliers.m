function [lamda,miu]=multipliers(z,linkno,n,link,OD,capacity,t0,lengtho,TTori)
[zerorow,zeroline]=find(z==0);
[onerow,oneline]=find(z==1);
zerono=length(zerorow);
oneno=length(onerow);
lamda=zeros(linkno,4);
miu=zeros(linkno,4);
if zerono~=0
   for i=1:zerono
    z(zerorow(i),zeroline(i))=1;
    lamda(zerorow(i),zeroline(i))=objAB(n,link,OD,capacity,t0,lengtho,z)-TTori;
    z(zerorow(i),zeroline(i))=0;
   end
end
if oneno~=0
   for i=1:oneno
    z(onerow(i),oneline(i))=0;
    miu(onerow(i),oneline(i))=-objAB(n,link,OD,capacity,t0,lengtho,z)+TTori;
    z(onerow(i),oneline(i))=1;
   end
end
end
