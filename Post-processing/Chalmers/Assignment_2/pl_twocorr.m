close all
clear all
format long
nk=98; %number of nodes in z direction
dx=6.542E-02; % distance between two nodes in the streamwise direction
dz=2*1.635E-02; % distance between two nodes in the spanwise direction (every 2nd node is used)
nk=25
viscos=1/500;
z=0:dz:(nk-1)*dz; %z denotes here the distance between the two points; hence z(1)=0


%load w_inst_k.dat
%save w_inst_k.mat w_inst_k
load w_inst_k.mat


load y_half_every_forth.dat
yc=y_half_every_forth;
nj=length(y_half_every_forth)

% yc is y at the face; compaute y at the cell centres
y(1)=0;
for j=2:nj
   y(j)=0.5*(yc(j)+yc(j-1));
end
y(nj)=yc(nj-1);

yplus=y/viscos;

nt=length(w_inst_k)/nj/nk;

wzyt=reshape(w_inst_k,nk,nj,nt); %make a 3D array: z, y direction and time

