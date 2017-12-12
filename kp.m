function [g_val,h_val,obj_val]=kp(z,linkno,lamda,miu,theta,lengtho,pci_begin,v);
z=round(z);
g=binvar(linkno,4);
h=binvar(linkno,4);
g=round(g);
h=round(h);
lamda(lamda==0)=999999999999999;
miu(miu==0)=-999999999999999;
lamda=round(lamda);
miu=round(miu);
theta=round(theta);
pp=z+g-h;
pp=round(pp);
price=pp(:,1)*1+pp(:,2)*2+pp(:,3)*4+pp(:,4)*8;
B= budget(lengtho,pci_begin,v);
B=round(B);
F=[price'*v*24*365>=B];
% F=[F;price'*v*24*365<=B+4*10^7];
F=[F;sum(sum(lamda.*round(g)))-sum(sum(miu.*round(h)))>=theta];
obj=sum(sum(lamda.*round(g)))-sum(sum(miu.*round(h)));
%  ops=sdpsettings('solver','INTLINPROG');   
ops=sdpsettings('solver','cplex');   
% ops=sdpsettings('solver','gurobi');   
solvesdp(F,obj,ops);

% solvesdp(F,obj);
g_val=double(g);
g_val=round(g_val);
h_val=double(h);
h_val=round(h_val);
obj_val=double(obj)
% price_val=double(price);
% double(price)
end