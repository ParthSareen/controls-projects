clear; clc;


exp_data = load("Lab3 360 Data/velocity_response_1_5.mat");
t = exp_data.t;
u = exp_data.u;
Ts = 0.001;
v1 = exp_data.v1;
v2 = exp_data.v2;

m1 = 0.00026634;
m2 = 0.00014383;
mT=4.1017e-4;
wd = 18.69;
wn = 17.33;

c = 0;
b1 = 0.0085;
b2 = 8.4745e-04;
k = 0.0351;
zeta = 0.2669;
d1 = 0.5934;
d2 = 0.05934;
open('flexible_drive.mdl');
sim("flexible_drive.mdl")

figure
subplot(3, 1, 1)
plot(t, u);
ylabel('Voltage [V]');
subplot(3, 1, 2);
plot(t, exp_data.v1); hold on; plot(t, v1sim(1:8001));
ylabel('V1 [mm/s]');
legend('Exp', 'Sim');
subplot(3, 1, 3);
plot(t, exp_data.v2); hold on; plot(t, v2sim(1:8001));
ylabel('V2 [mm/s]');
xlabel('Time [s]');
legend('Exp', 'Sim');