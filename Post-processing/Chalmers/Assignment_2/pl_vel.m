close all
clear all
format long
nj=98; %number of nodes in y direction


load uvw_inst_small.mat
load y.dat
yc=y;
uvw=uvw_inst_small;

y(1)=0;
for j=2:nj
   y(j)=0.5*(yc(j)+yc(j-1));
end
y(nj)=yc(nj-1);


u=uvw(:,1); %don't use this array
v=uvw(:,2); %don't use this array
w=uvw(:,3); %don't use this array
nt=length(u)/nj; %number of time steps 


uyt=reshape(u,nj,nt); %this is v_1, a 2D array: x_2 direction and time
vyt=reshape(v,nj,nt); %this is v_2, a 2D array: x_2 direction and time
wyt=reshape(w,nj,nt); %this is v_3, a 2D array: x_2 direction and time

u1d=mean(uyt,2); %time average
v1d=mean(vyt,2); %time average 
w1d=mean(wyt,2); %time average 

dt=0.0033*5; %time step (every 10th time step)
t=0:dt:(nt-1)*dt; %time 

yplus = zeros(size(u1d,1),1);
uplus = zeros(size(u1d,1),1);
uplus_n = zeros(size(u1d,1),1);

for i=1:size(u1d,1)
    yplus(i) = y(i) * 500;
    uplus(i) = yplus(i);
end
%
%*************************
% plot u
figure(1)
%hold on
%plot(u1d,y,'o','linewidth',2)
%semilogx(yplus(1:50),u1d(1:50),'o',yplus(1:25), uplus(1:25), '.');

for i=1:size(u1d,1)
    uplus_n(i) = (1/0.41) * log(yplus(i)) + 5.2;
end

% plot(yplus(1:50),uplus(1:50),'--');
semilogx(yplus(1:50),u1d(1:50),'o',yplus(1:25), uplus(1:25), '.', yplus,uplus_n,'--');

% hold
% xlabel('x')
% ylabel('y')
% %axis([0 25 0 2])
% title('umean')
% %
% h=gca;
% set(h,'fontsize',[20])
% print umean.ps  -depsc
%


%%
% Computing the fluctuating component fields and it will be followed by the
% product of them and later averaged

u_fluc = zeros(size(uyt));
v_fluc = zeros(size(vyt));
w_fluc = zeros(size(wyt));

u_u_fluc = zeros(size(uyt)); u_v_fluc = zeros(size(uyt)); u_w_fluc = zeros(size(uyt));
                             v_v_fluc = zeros(size(uyt)); v_w_fluc = zeros(size(uyt));
                                                          w_w_fluc = zeros(size(uyt));

for c=1:size(uyt,2)
   
    u_fluc(:,c) = uyt(:,c) - u1d(:,1);
    v_fluc(:,c) = vyt(:,c) - v1d(:,1);
    w_fluc(:,c) = wyt(:,c) - w1d(:,1);
    
    u_u_fluc(:,c) = u_fluc(:,c) .* u_fluc(:,c);
    u_v_fluc(:,c) = u_fluc(:,c) .* v_fluc(:,c);
    u_w_fluc(:,c) = u_fluc(:,c) .* w_fluc(:,c);
    
    v_v_fluc(:,c) = v_fluc(:,c) .* v_fluc(:,c);
    v_w_fluc(:,c) = v_fluc(:,c) .* w_fluc(:,c);
    
    w_w_fluc(:,c) = w_fluc(:,c) .* w_fluc(:,c);
    
end

uu_fluc_mean = mean(u_u_fluc,2);
uv_fluc_mean = mean(u_v_fluc,2);
uw_fluc_mean = mean(u_w_fluc,2);
vv_fluc_mean = mean(v_v_fluc,2);
vw_fluc_mean = mean(v_w_fluc,2);
ww_fluc_mean = mean(w_w_fluc,2);

plot(yplus, uu_fluc_mean, '-.');
% semilogx(yplus, uu_fluc_mean, '-.', yplus, uv_fluc_mean, '-o', yplus, uw_fluc_mean, '-x', yplus, vv_fluc_mean, '-+', yplus, vw_fluc_mean, '-*', yplus, ww_fluc_mean, '-^');



