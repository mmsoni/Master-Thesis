
clearvars;

u = csvread('Data_over_line.csv', 1, 2, [1,2,10,2]);
v = csvread('Data_over_line.csv', 1, 3, [1,3,10,3]);
w = csvread('Data_over_line.csv', 1, 4, [1,4,10,4]);
visTurb = csvread('Data_over_line.csv', 1, 6, [1,6,10,6]);
y = csvread('Data_over_line.csv', 1, 10, [1,10,10,10]);
dudy_manu = zeros(size(u,1),1);

[dudy] = gradient(u, y);
[dvdy] = gradient(v, y);
[dwdy] = gradient(w, y);

for i=1:size(u,1)
    if i-1>0 && i+1<size(u,1)
        dudy_manu(i) = (u(i-1)+u(i)+u(i+1))/(y(i+1)-y(i-1));
    elseif i-1<=0
        dudy_manu(i) = (u(i)+u(i+1))/(y(i+1)- 0.1);
    elseif i+1> size(u,1)
        dudy_manu(i) = (u(i-1)+u(i))/(0.9 - y(i-1));
    end  
end

s2 = 0.5*dudy; s4 = s2;
s5 = dvdy; s6 = 0.5*dwdy;
s8 = s6;

r2 = 0.5*dudy; r4 = -1*r2;
r6 = 0.5*dwdy; r8 = -1*r6;

s1t = s2.*s4; s2t = s2.*s5;                    s3t = s2.*s6;
s4t = s5.*s4; s5t = (s4.*s2)+(s5.*s5)+(s6.*s8); s6t = s5.*s6;
s7t = s8.*s4; s8t = s8.*s5;                     s9t = s8.*s6;

r1t = r2.*r4; r2t = 0;                 r3t = r2.*r6;
r4t = 0;      r5t = (r2.*r4)+(r6.*r8); r6t = 0;
r7t = r8.*r4; r8t = 0;                 r9t = r8.*r6;

S_inner = 2.*(s2.*s2)+ 2.*(s6.*s6)+(s5.*s5);
R_inner = 2.*(r2.*r2)+ 2.*(r6.*r6);

traceTerm = 1/3.*(S_inner - R_inner);

S1 = s1t + r1t - traceTerm; S2 = s2t + r2t; S3 = s3t + r3t;
S4 = s4t + r4t;   S5 = s5t + r5t - traceTerm; S6 = s6t + r6t;
S7 = s7t + r7t;   S8 = s8t + r8t;  S9 = s9t + r9t-traceTerm;

Sd_inner = S1.^2 + S2.^2 + S3.^2 + S4.^2 + S5.^2 + S6.^2 + S7.^2 + S8.^2 + S9.^2 ; 

omega = (Sd_inner.^(3/2))./((S_inner.^(5/2))+(Sd_inner.^(5/4)));
turbVis = (.325^2*1^2).*omega;

plot (turbVis)