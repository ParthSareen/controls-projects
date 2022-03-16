freq = [0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 8 12 16 20];
files = dir('velocity_response_sine_*.mat');

mag_resp1 = zeros(size(freq, 1));
phase_resp1 = zeros(size(freq, 1));
mag_resp2 = zeros(size(freq, 1));
phase_resp2 = zeros(size(freq, 1));

i = 1;
for f = freq
    load(files(i).name);

    [A1, phi1] = fit_sine_wave(t, v1, 2 * pi * f);
    [A2, phi2] = fit_sine_wave(t, v2, 2 * pi * f);

    mag_resp1(i) = A1;
    phase_resp1(i) = phi1;
    mag_resp2(i) = A2;
    phase_resp2(i) = phi2;

    i = i + 1;
end

phase_resp1 = 180 / pi * phase_resp1;
phase_resp2(12:14) = phase_resp2(12:14) - 2 * pi;
phase_resp2 = 180 / pi * phase_resp2;

m1 = 2.6634E-4; m2 = 1.4383E-4;
b1 = 0.0085; b2 = 8.4745E-4;
k = 0.0351;

wlog = logspace(-1, 3, 1000);

figure(1);
num1 = [1/m1 b2/(m1*m2) k/(m1*m2)];
den1 = [1 (m1*b2+m2*b1)/(m1*m2) (b1*b2+(m1+m2)*k)/(m1*m2) (b1+b2)*k/(m1*m2)];
sys1 = tf(num1, den1);
[mag1, phase1, wout1] = bode(sys1, wlog);

ax1 = subplot(2, 1, 1);
hold on;
title('Cart 1 Velocity Frequency Response');
plot(2 * pi * freq, mag_resp1, 'x');
plot(wlog, mag1(1,1:end));
ax1.XScale = 'log';
ax1.YScale = 'log';
xlabel('Frequency [rad]');
ylabel('Magnitude');
hold off;

ax2 = subplot(2, 1, 2);
hold on;
plot(2 * pi * freq, phase_resp1, 'x');
plot(wlog, phase1(1,1:end));
ax2.XScale = 'log';
hold off;
title('Cart 1 Velocity Phase Response');
xlabel('Frequency [rad]');
ylabel('Phase [deg]');

figure(2);
num2 = [k/(m1*m2)];
den2 = [1 (m1*b2+m2*b1)/(m1*m2) (b1*b2+(m1+m2)*k)/(m1*m2) (b1+b2)*k/(m1*m2)];
sys2 = tf(num2, den2);
[mag2, phase2, wout2] = bode(sys2, wlog);

ax3 = subplot(2, 1, 1);
hold on;
plot(2 * pi * freq, mag_resp2, 'x');
plot(wlog, mag2(1,1:end));
hold off;
ax3.XScale = 'log';
ax3.YScale = 'log';
title('Cart 2 Velocity Frequency Response');
xlabel('Frequency [rad]');
ylabel('Magnitude');

ax4 = subplot(2, 1, 2);
hold on;
plot(2 * pi * freq, phase_resp2, 'x');
plot(wlog, phase2(1,1:end));
hold off;
ax4.XScale = 'log';
title('Cart 2 Velocity Phase Response');
xlabel('Frequency [rad]');
ylabel('Phase [deg]');
