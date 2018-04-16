
clearvars;
i=-1:.025:1;
% x = zeros(size(i',1),1);
j = 0;
x = sin(i.*pi/0.25)/(i.*pi); 
%j= j+1;

plot(x)