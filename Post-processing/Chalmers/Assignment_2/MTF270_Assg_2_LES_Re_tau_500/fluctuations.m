function[uf, vf, wf, pf] = fluctuations(u13d, v13d, w13d, p13d, u1mean, v1mean, w1mean, p1mean)

nj = size(u13d,1);
ni = size(u13d,2);
nk = size(u13d,3);

uf = zeros(nj, ni, nk);
vf = zeros(nj, ni, nk);
wf = zeros(nj, ni, nk);
pf = zeros(nj, ni, nk);

for k=1:nk
    for i=1:ni
        for j=1:nj
           uf(j,i,k)= u13d(j,i,k) - u1mean(j);
           vf(j,i,k)= v13d(j,i,k) - v1mean(j);
           wf(j,i,k)= w13d(j,i,k) - w1mean(j);
           pf(j,i,k)= p13d(j,i,k) - p1mean(j);
        end
    end
end
end