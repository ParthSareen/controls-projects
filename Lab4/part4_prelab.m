clear;clc;
load('Lab4/Lab 4 360 Data/trajectory_data.mat');
c = 0;
m1 = 2.6634E-4; m2 = 1.4383E-4;
b1 = 0.0085; b2 = 8.4745E-4;
k = 0.0351;
a1 = (m1 * b2 + m2 * b1 + (m1 + m2) * c) / (m1 * m2);
a2 = (b1 * b2 + (b1 + b2) * c + (m1 + m2) * k) / (m1 * m2);
a3 = (b1 + b2) * k / (m1 * m2);

num = [c / (m1 * m2), k / (m1 * m2)];
den = [1 a1 a2 a3 0];

G2 = tf(num, den);
% sisotool(G2);

wn = 17.33; % rad/sec
zeta = 0.2669;
zeta_den = 1;

Gnotch = tf([1 2 * zeta * wn wn^2], [1 2 * zeta_den * wn wn^2]);
[amp, phase] = bode(G2 * Gnotch, 25);
desired_phase = -180 + 30 + 10 - (phase);
lead_filter_phi_max = desired_phase / 2
kp_notch = 1/amp

% set_param('double_lead_notch', 'SimulationCommand', 'start')
% set_param('double_lead_notch','SimulationMode','start')
% ans = sim("double_lead_notch.slx")
% x1 = ans.yout.getElement('x1_data');
% x2 = ans.yout.getElement('x2_data');
% control = ans.yout.getElement('u');
% 
% figure
% hold on
% plot(x1_data.)


a = 8.8741;
b = 70.4295;
Glead = tf([1 a], [1 b]);
[amp, phase] = bode(G2 * Gnotch * Glead * Glead, 25)
kp_leads = 1/amp
c = 4.2;
d = 0.01 * c;
Glag = tf([1 c], [1 d]);
[amp, phase] = bode(G2 * Gnotch * Glead * Glead * Glag, 25)
kp_full = 1/amp


kp = 1/(Gnotch)
