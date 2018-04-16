clearvars;

nu=1/500;
dx=6.542E-02; dz=1.635E-02;
ni=96; nj=49; nk=96;

% read u1 & transform u1 to a 3D array
load u1.mat, load v1.mat, load w1.mat, load p1.mat
u13d=permute(reshape(u1,ni,nj,nk),[2, 1, 3]);
v13d=permute(reshape(v1,ni,nj,nk),[2, 1, 3]);
w13d=permute(reshape(w1,ni,nj,nk),[2, 1, 3]);
p13d=permute(reshape(p1,ni,nj,nk),[2, 1, 3]);

% x coordinate direction = index i, first index
% y coordinate direction = index j, second index
% z coordinate direction = index k, third index

%% Co-ords

% node coordinates
load y.dat
% face coordinates
load yc.dat

for j=2:nj-1
   dy(j)=yc(j)-yc(j-1);% dy = cell width
end

x=0:dx:(dx*ni);

% compute average u by averaging in x (i) and z (k) directions

[u1mean, v1mean, w1mean, p1mean] = meanValues(u13d, v13d, w13d, p13d, ni, nj, nk);

%% fluctutions
[u1f, v1f, w1f, p1f] = fluctuations(u13d, v13d, w13d, p13d, u1mean, v1mean, w1mean, p1mean);

%% variances and covariances
[u1f2_avg, v1f2_avg, w1f2_avg, uv1f2_avg] = lowerOrderStatistics(u1f, v1f, w1f, p1f);

%% production and pressure strain

[Pk] = productionPressureStrain(u1mean, y, uv1f2_avg, v1f2_avg,u1f, v1f, p1f, dx);


%% plotting

figure(1)
plot(y,u1mean)
axis([0 1 0 22])
xlabel('y','fontsize',[20])
ylabel('U+','fontsize',[20])
handle=gca;
set(handle,'fontsize',[20])
print u.ps  -depsc
figure(2)
plot(y, sqrt(u1f2_avg), y, sqrt(v1f2_avg), y, sqrt(w1f2_avg))
% 
% figure(3)
% plot(y, uv1f2_avg)
% 
figure(4)
semilogx(yplus, Pk)

%% Filtering

yplus=y/nu;
fu13d = zeros(nk,1);
fu13d2 = zeros(nk,1);
%avg_u = zeros(nk,1);
test_u = u13d(3,:,nk/3);
plot(x(2:97),test_u)
% fu13d(1) = 0.25*(test_u(2) + 2*test_u(1) + test_u(nk));
% for i=2:nk-1
%     fu13d(i) = 0.25*(test_u(i+1) + 2*test_u(i) + test_u(i-1));
% end
% fu13d(nk) = 0.25*(test_u(1) + 2*test_u(nk) + test_u(nk-1));

fu13d(1) = 0.33*(test_u(2) + test_u(1) + test_u(nk));
for i=2:nk-1
    fu13d(i) = 0.33*(test_u(i+1) + test_u(i) + test_u(i-1));
end
fu13d(nk) = 0.33*(test_u(1) + test_u(nk) + test_u(nk-1));

fu13d2(1) = 0.33*(fu13d(2) + fu13d(1) + fu13d(nk));
for i=2:nk-1
    fu13d2(i) = 0.33*(fu13d(i+1) + fu13d(i) + fu13d(i-1));
end
fu13d2(nk) = 0.33*(fu13d(1) + fu13d(nk) + fu13d(nk-1));

% fu13d(1) = 0.11*(test_u(3) + test_u(2) + test_u(1) + test_u(nk) + test_u(nk-1));
% fu13d(2) = 0.11*(test_u(4) + test_u(3) + test_u(2) + test_u(nk)+ test_u(1));
% for i=3:nk-2
%     fu13d(i) = 0.11*(test_u(i+2) +test_u(i+1) + test_u(i) + test_u(i-1) + test_u(i-2));
% end
% fu13d(nk-1) = 0.11*(test_u(1) +test_u(nk) + test_u(nk-1) + test_u(nk-2) + test_u(nk-3));
% fu13d(nk) = 0.11*(test_u(2) + test_u(1) + test_u(nk) + test_u(nk-1) + test_u(nk-2));

avg_u = mean(test_u);
resid = test_u' - fu13d;
plot(x(2:97),test_u,'--r', x(2:97),fu13d,'--g', x(2:97), resid,'.k', x(2:97), avg_u,'.b',  x(2:97),fu13d2,'-gx')
% plot(x(2:97),test_u,'--r', x(2:97),fu13d2,'--g', x(2:97), resid,'.k', x(2:97), avg_u,'.b')
