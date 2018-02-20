close all
clear all
% ***** read u
load u_v_time_4nodes.dat
u1=u_v_time_4nodes(:,1);
v1=u_v_time_4nodes(:,2);
u2=u_v_time_4nodes(:,3);
v2=u_v_time_4nodes(:,4);
u3=u_v_time_4nodes(:,5);
v3=u_v_time_4nodes(:,6);
u4=u_v_time_4nodes(:,7);
v4=u_v_time_4nodes(:,8);

u1_fluct = zeros(size(u_v_time_4nodes(:,3)));

% time step=0.0033
dt=0.0033;
n=length(u1);
% compute time array
t=dt:dt:n*dt;

%%%%%%%%%%%%%%%% plotting section %%%%%%%%%%%%%%%%%%%%%%%%%%
% plot u
figure(1)
plot(t,u1, 'b-o')
hold on
plot(t,u2,'c-+')
plot(t,u3,'g-x')
plot(t,u4,'m-*')
% axis([10 11 3 21]);
xlabel('t','fontsize',20)
ylabel('v_1','fontsize',20)
legend('u1', 'u2', 'u3', 'u4', 'Location', 'Northeast');
handle=gca
set(handle,'fontsize',[20])
print u_time.ps -deps
hold off
%

%plot v
figure(2)
plot(t,v1, 'b-o')
hold on
plot(t,v2,'c-+')
plot(t,v3,'g-x')
plot(t,v4,'m-*')
% axis([10 11 3 21]);
xlabel('t','fontsize',20)
ylabel('v_2','fontsize',20)
legend('v1', 'v2', 'v3', 'v4', 'Location', 'Northeast');
handle=gca
set(handle,'fontsize',[20])
print u_time.ps -deps
hold off


%%%% Computing the mean of the x-component of the velocity using the actual
%%%% number of samples

u1_mean = mean(u1);
min_u1 = min(u1);
max_u1 = max(u1);
for i=1:size(u_v_time_4nodes(:,3))
   u1_fluct(i) = u1(i) - u1_mean;
end
figure(3)
yyaxis left
plot(t, u1_fluct, 'r-.',  t, u1, 'g--');

yyaxis right
plot(t, u1_mean, 'b-o');


u2_mean = mean(u2);
min_u2 = min(u2);
max_u2 = max(u2);

u3_mean = mean(u3);
min_u3 = min(u3);
max_u3 = max(u3);

u4_mean = mean(u4);
min_u4 = min(u4);
max_u4 = max(u4);

