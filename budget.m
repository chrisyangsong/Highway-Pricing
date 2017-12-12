function [ cost_yanghu_luwang ] = budget(lengtho,pci_begin,v )
%BUDGT 
% 
% linkno=12;
% for li=1:linkno
%     if v(li,1)<=500
%         A(li,1)=26.64;
%         B(li,1)=1.21;
%     elseif v(li,1)>500 && v(li,1)<=1200
%         A(li,1)=19.47;
%         B(li,1)=1.17;
%     elseif v(li,1)>1200 && v(li,1)<=2500
%         A(li,1)=16.41;
%         B(li,1)=1.15;
%     elseif v(li,1)>2500 && v(li,1)<=4000
%         A(li,1)=14.19;
%         B(li,1)=1.14;
%     elseif v(li,1)>4000 && v(li,1)<=6000
%         A(li,1)=12.76;
%         B(li,1)=1.12;
%     elseif v(li,1)>6000
%         A(li,1)=11.75;
%         B(li,1)=1.11;
%     end
% end
% luling=[2,3,1,2,3,1,2,3,1,2,3,1]';
% for i=1:linkno
% deterior(i,1)=(1-exp(-(A(i,1)/(luling(i,1)+1))^B(i,1)))/(1-exp(-(A(i,1)/luling(i,1))^B(i,1)));
% cost_yanghu_link(i)=2198*(pci_begin(i)-deterior(i)*pci_begin(i))*lengtho(i)*1000;
% end
% cost_yanghu_luwang=sum(cost_yanghu_link);


esal=v;
namida=15.72*20^0.5861*esal.^-0.2064;
yita=119.66*20^-0.1124*esal.^-0.1053;
xi=1.5247*20^-0.1016*esal.^-0.0986;
A=namida.*(1-exp(-(yita./12).^xi));  
B=0.6536*20^0.3349*esal.^-0.0255*12^-0.0981;
A(esal==0)=240;
B(esal==0)=1.57;
luling_begin=A./(log(ones(size(pci_begin))*100./(ones(size(pci_begin))*100-pci_begin))).^(1./B);
pci_end=ones(size(pci_begin))*100.*(1-exp(-(A./(luling_begin+1)).^B));
cost_yanghu=27.72*(pci_begin-pci_end)*2*6;  
cost_yanghu_link=cost_yanghu.*lengtho*1000;
cost_yanghu_luwang=sum(cost_yanghu_link);

end

