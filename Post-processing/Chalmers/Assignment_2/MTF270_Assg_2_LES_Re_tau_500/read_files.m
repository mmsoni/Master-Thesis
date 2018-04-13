close all
clear all

nu=1/500;
dx=6.542E-02;
dz=1.635E-02;
ni=96;
nj=49;
nk=96;

% read u1 & transform u1 to a 3D array
load u1.mat
u3d=reshape(u1,ni,nj,nk);
% x coordinate direction = index i, first index
% y coordinate direction = index j, second index
% z coordinate direction = index k, third index
u3dt = permute(u3d,[2, 1, 3]);
% compute average u by averaging in x (i) and z (k) directions
umean(1:nj)=0;
for k=1:nk
for j=1:nj
for i=1:ni
   umean(j)=umean(j)+u3d(i,j,k)/ni/nk;
end
end
end

% node coordinates
load y.dat

% face coordinates
load yc.dat

for j=2:nj-1
% dy = cell width
   dy(j)=yc(j)-yc(j-1);
end

figure(1)
% plot u
plot(y,umean)
axis([0 1 0 22])
xlabel('y','fontsize',[20])
ylabel('U+','fontsize',[20])
handle=gca;
set(handle,'fontsize',[20])
print u.ps  -depsc




%% My version

umeant(1:nj)=0;
for j=1:nj
for k=1:nk
for i=1:ni
   umeant(j)=umeant(j)+u3dt(j,i,k);
end
end
end

umeant = umeant/ni/nk;

%% fluctutions
uf = zeros(nj, ni, nk);

for k=1:nk
for i=1:ni
for j=1:nj
   uf(j,i,k)= u3dt(j,i,k) - umeant(j);
end
end
end



