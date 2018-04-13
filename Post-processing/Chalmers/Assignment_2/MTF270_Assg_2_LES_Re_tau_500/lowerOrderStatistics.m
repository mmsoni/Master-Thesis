function[u1f2_avg, v1f2_avg, w1f2_avg, uv1f2_avg] = lowerOrderStatistics(u1f, v1f, w1f,p1f)

nj = size(u1f,1);
ni = size(u1f,2);
nk = size(u1f,3);

u1f2 = u1f .* u1f;
v1f2 = v1f .* v1f;
w1f2 = w1f .* w1f;
uv1f2 = u1f .* v1f;

u1f2_avg(1:nj)=0;
v1f2_avg(1:nj)=0;
w1f2_avg(1:nj)=0;
uv1f2_avg(1:nj)=0;

for j=1:nj
    for k=1:nk
        for i=1:ni
           u1f2_avg(j) = u1f2_avg(j) + u1f2(j,i,k);
           v1f2_avg(j) = v1f2_avg(j) + v1f2(j,i,k);
           w1f2_avg(j) = w1f2_avg(j) + w1f2(j,i,k);
           uv1f2_avg(j) = uv1f2_avg(j) + uv1f2(j,i,k);
        end
    end
end

u1f2_avg = u1f2_avg/ni/nk;
v1f2_avg = v1f2_avg/ni/nk;
w1f2_avg = w1f2_avg/ni/nk;
uv1f2_avg = uv1f2_avg/ni/nk;

end