function[x]=volumexy(lpath,path,link,OD,il,ik,x)
     for ih=1:lpath%lpath=path-1£¬pathÖĞlinkÊı
         ig=ih+1;
         tail=find(link(:,3)==path(ih));
         head=find(link(:,2)==path(ig));
         same=intersect(tail,head);
         x(same)=x(same)+OD(il,ik);
     end
end
