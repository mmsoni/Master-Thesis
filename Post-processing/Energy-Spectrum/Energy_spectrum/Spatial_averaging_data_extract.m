%% My case
clearvars;

p1 = 194;
p2 = 66;
p3 = 98; 

% Dimensions of the channel in m
L_x = 6;
L_y = 2;
L_z = 3;

%conversion parameters from the LB units to SI units for the dimensions
scaling = 0.03125;
translation = -0.03125;
kvis = 2e-05;

timeSteps = 26;
vx1mean(1:p2,1)=0;
vx1f2mean(1:p2,1)=0;
vx2f2mean(1:p2,1)=0;
vx3f2mean(1:p2,1)=0;
vx12f2mean(1:p2,1)=0;
visShear(1:p2,1)=0;

%Extracting the data
folder   = 'D:\MasterThesis\7_Post-processing\TurbulentChannelFlow\Re_tau_395\Mesh_1\resultsTurbulentChannelFlow_15_05\Data\AA2016Wale\Temporal_spatial_avg_rms';
filename = fullfile(folder, 'Spatial_averaging_.26.csv');
vx1_f    = permute(reshape(csvread(filename, 2, 5, [2, 5, 1254793, 5]), p1, p2, p3), [3, 1, 2]);
vx2_f    = permute(reshape(csvread(filename, 2, 6, [2, 6, 1254793, 6]), p1, p2, p3), [3, 1, 2]);
vx3_f    = permute(reshape(csvread(filename, 2, 7, [2, 7, 1254793, 7]), p1, p2, p3), [3, 1, 2]);
y1       = permute(reshape(csvread(filename, 2, 14, [2, 14, 1254793, 14]), p1, p2, p3), [3, 1, 2]);

%% Energy specturm calculation
N=p1;
%k_x = floor((2*pi*(1:N))/L_x);
k_x = (2*pi*(1:N))/L_x;
u_f = vx1_f(:,:,32);
ck = (fft(u_f));
E_k= (ck.*conj(ck));
loglog(mean(E_k,2))

%% Not necessary now
% vx3f2dt  = permute(reshape(csvread(filename, 2, 10, [2, 10, 1254793, 10]), p1, p2, p3), [2, 1, 3]);
% vx12f2dt = permute(reshape(csvread(filename, 2, 11, [2, 11, 1254793, 11]), p1, p2, p3), [2, 1, 3]);
% 
% for j=1:p2
%     for k=1:p3
%         for i=1:p1
%            vx1mean(j)   = vx1mean(j)   + vx1dt(j,i,k);
%            vx1f2mean(j) = vx1f2mean(j) + vx1f2dt(j,i,k);
%            vx2f2mean(j) = vx2f2mean(j) + vx2f2dt(j,i,k);
%            vx3f2mean(j) = vx3f2mean(j) + vx3f2dt(j,i,k);
%            vx12f2mean(j)= vx12f2mean(j)+ vx12f2dt(j,i,k);
%         end
%     end
% end
% 
% vx1mean    = vx1mean/p1/p3;
% vx1f2mean  = vx1f2mean/p1/p3;
% vx2f2mean  = vx2f2mean/p1/p3;
% vx3f2mean  = vx3f2mean/p1/p3;
% vx12f2mean = vx12f2mean/p1/p3;
% y1 = (y1(:,2,2).*scaling)+ translation;
% y1(1) = 0;y1(size(y1,1)) = 0;
% 
% for i=2:size(visShear,1)-1
%     if i == 2
%         visShear(i) = vx1mean(i)/y1(i);
%     elseif i==size(visShear,1)-1
%         visShear(i) = -vx1mean(i)/y1(i);   
%     else
%         visShear(i) = (vx1mean(i+1) - vx1mean(i-1))/(y1(i+1)-y1(i-1));
%     end
% end
% 
% utau_res = sqrt(visShear(2)*kvis);
% Re_tau_res = utau_res/kvis;
% 
% yplus1 = y1.*(utau_res/kvis);
% 
% visShear = visShear.*kvis;
% totShear = visShear + vx12f2mean;
% 
% save('vx1mean.mat','vx1mean')
% save('vx1f2mean.mat','vx1f2mean')
% save('vx2f2mean.mat','vx2f2mean')
% save('vx3f2mean.mat','vx3f2mean')
% save('vx12f2mean.mat','vx12f2mean')
% save('y1.mat','y1')
% save('utau_res.mat','utau_res')
% save('Re_tau_res.mat','Re_tau_res')
% save('yplus1.mat', 'yplus1')
% 
% 
% plot(vx1mean(2:65))
% hold on
% plot(visShear)
% plot(totShear)
% plot(vx12f2mean)
% hold off
% hold on
% plot(sqrt(vx1f2mean(2:65))./0.0069)
% plot(sqrt(vx2f2mean(2:65))./0.0069)
% plot(sqrt(vx3f2mean(2:65))./0.0069)
% plot(vx12f2mean(2:65)./0.0069^2)
% hold off

save('vx1_f.mat','vx1_f')
save('vx2_f.mat','vx2_f')
save('vx3_f.mat','vx3_f')
save('y1.mat','y1')