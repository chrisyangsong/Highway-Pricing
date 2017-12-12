function[path]=dijstray(a,start,terminal)
%n=8;
n=9;
f(start)=start;
label(1:n)=inf;
label(start)=0;
s(1)=start;
u=start;
while length(s)<n
    v1=0;
    k=inf;
    for i=1:n
        ins=0;
        for j=1:length(s)
            if i==s(j)
                ins=1;
            end
        end
        if ins==0
            v=i;
            if label(v)>(label(u)+a(u,v))
                label(v)=(label(u)+a(u,v));
                f(v)=u;
            end
        end
    end
    for i=1:n
        ins=0;
        for j=1:length(s)
            if i==s(j)
                ins=1;
            end
        end
        if ins==0
            v=i;
            if k>label(v)
                k=label(v);
                v1=v;
            end
        end
    end
    s(length(s)+1)=v1;
    u=v1;
end
min=label(terminal);
path(1)=terminal;
ni=1;
while path(ni)~=start
    path(ni+1)=f(path(ni));
    ni=ni+1;
end
path(ni)=start;
end


        