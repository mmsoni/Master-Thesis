clearvars;

N = 2^11;
t_s = 0.001;
t=0:t_s:(N*t_s);

%u=1*sin(2*pi*80*t);% fluctuating velocity
%u=4*sin(2*pi*100*t)+10*rand(size(t));
u=0.01*sin(2*pi*80*t);
u = u + 10*rand(size(t));

figure(1)
plot(1000*t(1:200),u(1:200),'.-')% plotting the fluctuating velocity
xlabel('Zeit [m/s]');ylabel('u [m/s]')

% filtering the fluctuating velocity signal
f_fLP = 50;
u = filter(t_s*f_fLP, [1 t_s*f_fLP-1], u);
f_fLP = 100;
u = filter(t_s*f_fLP, [1 t_s*f_fLP-1], u);
f_fLP = 250;
u= filter(t_s*f_fLP, [1 t_s*f_fLP-1], u);

figure(2)
plot(1000*t(1:200),u(1:200),'.-')% plotting the fluctuating velocity
xlabel('Zeit [m/s]');ylabel('u [m/s]')


%Energy spectrum from the generated fluctuating velocity
c_k = fft(u,N);% coefficients from the fourier transform

E_k = c_k.*conj(c_k)/N;% energy spectum values

f=1/t_s*(0:(N/2))/N;%frequency

figure(3)
plot(f, E_k(1:(N/2+1)), '.-')
xlabel('Frequenz [Hz]');ylabel('E(u) [m^2/s]');


% Parsevals equation

u_rms_01=mean(u.^2); % from the fluctuating velocity

u_rms_02 = mean(E_k);% from the energy spectrum

u_rms_03 = trapz(E_k)/N;

% korrelationsfunktion

%direkt aus dem Zeitverlauf u(t)

for i=1:(N/2)
   tau(i) = t(i);
   R_01(i) = mean( u(1:N/2) .*  u(i:N/2+i-1) )/u_rms_01;
end

% aus Spektrum (Wiene-Chintschin-Gl.)
for i=1:(N/2)
    for j = 1:(N/2+1)
        Integrand(j) = E_k(j)*cos(2*pi*f(j)*t(i));
    end
    R_02(i)= trapz(Integrand)/(N/2+1)/u_rms_01;
end


figure(4)
plot(tau(1:end), R_01(1:end),'-ko',tau(1:100), R_01(1:100),'-r')
xlabel('\tau [m/s]');ylabel('R_{tau} [-]');
legend('aus Zeitverlauf', 'aus Spektrum')

