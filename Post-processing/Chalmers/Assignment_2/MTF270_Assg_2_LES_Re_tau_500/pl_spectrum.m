close all
clear all
% ***** read u
load u_v_time_4nodes.dat
% plot u
u1=u_v_time_4nodes(:,1);
v1=u_v_time_4nodes(:,2);
u2=u_v_time_4nodes(:,3);
v2=u_v_time_4nodes(:,4);
u3=u_v_time_4nodes(:,5);
v3=u_v_time_4nodes(:,6);
u4=u_v_time_4nodes(:,7);
v4=u_v_time_4nodes(:,8);

% time step=0.0033
dt=0.0033;
n=length(u1);
% compute time array
t=dt:dt:n*dt;

umean=mean(u3);

% subtract the mean
u3=u3-umean;

% number of points in the fft
nmax=1024;

% compute RMS
n=length(u3);
urms=0;
for i=1:n
   urms=urms+u3(i)^2/n;
end
urms=urms^0.5;

% time step (gives the right freq. on the x-axis)
dt=0.0033;
[px,f]=pwelch(u3,nmax,[],[],1/dt);

plot(f,px)
hold

% add line with -5/3 slope
x=[1 10];
ynoll=1;
y(1)=ynoll;
y(2)=y(1)*(x(2)/x(1))^(-5/3);
plot(x,y,'r--','linew',4)


axis([0.5 200 1e-7 1])
title('spectrum of u','fontsize',20)
xlabel('f','fontsize',20)
ylabel('E(u)','fontsize',20)
handle=gca;
set(handle,'yscale','log','xscale','log')
%set(h,'xscale','log')
set(handle,'fontsi',[20])
print u_spectum.ps -deps
%
