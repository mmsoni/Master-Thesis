function[u1mean, v1mean, w1mean, p1mean] = meanValues(u13d, v13d, w13d, p13d, ni, nj, nk)

u1mean(1:nj)=0; v1mean(1:nj)=0; w1mean(1:nj)=0; p1mean(1:nj)=0;

for j=1:nj
    for k=1:nk
        for i=1:ni
            u1mean(j)=u1mean(j)+u13d(j,i,k);
            v1mean(j)=v1mean(j)+v13d(j,i,k);
            w1mean(j)=w1mean(j)+w13d(j,i,k);
            p1mean(j)=p1mean(j)+p13d(j,i,k);
        end
    end
end

u1mean = u1mean/ni/nk;
v1mean = v1mean/ni/nk;
w1mean = w1mean/ni/nk;
p1mean = p1mean/ni/nk;

end