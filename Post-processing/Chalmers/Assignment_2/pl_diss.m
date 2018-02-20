close all
clear all
format long
ni=98; %number of nodes in x direction
nk=98; %number of nodes in z direction
dx=6.542E-02; % distance between two nodes in the streamwise direction
dz=1.635E-02; % distance between two nodes in the spanwise direction
viscos=1/500;
dt=0.0033*5; %time step (every 10th time step)


%load diss_inst.dat
%save diss_inst.mat diss_inst
load diss_inst.mat


load y_half.dat
yc=y_half;
nj=length(y_half);

% yc is y at the face; compaute y at the cell centres
y(1)=0;
for j=2:nj
   y(j)=0.5*(yc(j)+yc(j-1));
end
y(nj)=yc(nj-1);

yplus=y/viscos;

uvw=diss_inst;;

u=uvw(:,1); %don't use this array
u_im1=uvw(:,2); %don't use this array
u_ip1=uvw(:,3); %don't use this array
u_km1=uvw(:,4); %don't use this array
u_kp1=uvw(:,5); %don't use this array

v=uvw(:,6); %don't use this array
v_im1=uvw(:,7); %don't use this array
v_ip1=uvw(:,8); %don't use this array
v_km1=uvw(:,9); %don't use this array
v_kp1=uvw(:,10); %don't use this array

w=uvw(:,11); %don't use this array
w_im1=uvw(:,12); %don't use this array
w_ip1=uvw(:,13); %don't use this array
w_km1=uvw(:,14); %don't use this array
w_kp1=uvw(:,15); %don't use this array

nt=length(u_im1)/nj; %number of time steps 


uyt=reshape(u,nj,nt);         %this is v_1 at x_1,x_2,x_3,      a 2D array: x_2 direction and time
uyt_im1=reshape(u_im1,nj,nt); %this is v_1 at x_1-dx_1,x_2,x_3, a 2D array: x_2 direction and time
uyt_ip1=reshape(u_ip1,nj,nt); %this is v_1 at x_1+dx_1,x_2,x_3, a 2D array: x_2 direction and time
uyt_km1=reshape(u_km1,nj,nt); %this is v_1 at x_1,x_2,x_3-dx_3, a 2D array: x_2 direction and time
uyt_kp1=reshape(u_kp1,nj,nt); %this is v_1 at x_1,x_2,x_3+dx_3, a 2D array: x_2 direction and time

vyt=reshape(v,nj,nt); %v_2
vyt_im1=reshape(v_im1,nj,nt); 
vyt_ip1=reshape(v_ip1,nj,nt); 
vyt_km1=reshape(v_km1,nj,nt); 
vyt_kp1=reshape(v_kp1,nj,nt); 

wyt=reshape(w,nj,nt); %v_3
wyt_im1=reshape(w_im1,nj,nt); 
wyt_ip1=reshape(w_ip1,nj,nt); 
wyt_km1=reshape(w_km1,nj,nt); 
wyt_kp1=reshape(w_kp1,nj,nt); 


