close all
clear all
format long
ni=98; %number of nodes in x direction
nj=98; %number of nodes in y direction
nk=98; %number of nodes in z direction
dx=6.542E-02; % distance between two nodes in the streamwise direction
dz=1.635E-02; % distance between two nodes in the spanwise direction
dt=0.0033*5; %time step (every 10th time step)


load p_inst_small.mat

load y.dat
yc=y;
y(1)=0;
for j=2:nj
   y(j)=0.5*(yc(j)+yc(j-1));
end
y(nj)=yc(nj-1);


uvwp=p_inst_small;


p=uvwp(:,1); %don't use this array
p_im1=uvwp(:,2); %don't use this array
p_ip1=uvwp(:,3); %don't use this array
p_km1=uvwp(:,4); %don't use this array
p_kp1=uvwp(:,5); %don't use this array
nt=length(p_im1)/nj; %number of time steps 


pyt=reshape(p,nj,nt);         %this is p at x_1,x_2,x_3,      a 2D array: x_2 direction and time
pyt_im1=reshape(p_im1,nj,nt); %this is p at x_1-dx_1,x_2,x_3, a 2D array: x_2 direction and time
pyt_ip1=reshape(p_ip1,nj,nt); %this is p at x_1+dx_1,x_2,x_3, a 2D array: x_2 direction and time
pyt_km1=reshape(p_km1,nj,nt); %this is p at x_1,x_2,x_3-dx_3, a 2D array: x_2 direction and time
pyt_kp1=reshape(p_kp1,nj,nt); %this is p at x_1,x_2,x_3+dx_3, a 2D array: x_2 direction and time

% how to comnpute spatial derivatives (note that these are derivative of the instantaneous
% pressure, not the fluctuating)

dpdx=(pyt_ip1-pyt_im1)/2/dx;
dpdz=(pyt_kp1-pyt_km1)/2/dz;
[dpdt dpdy]=gradient(pyt,dt,y); %dpdt is not needed, but the function 'gradient' computes all derivatives

t=0:dt:(nt-1)*dt; %time 

