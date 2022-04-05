clear; clc;

load('Lab4/Lab 4 360 Data/trajectory_data.mat');
exp_data = load('Lab4/Lab 4 360 Data/double_lag_notch.mat');

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

% open("Lab4/flex2.slx")
% set_param('flex2', 'SimulationCommand', 'start')
model = sim('flex2.slx');
x1_sim = model.yout.getElement('x1_sim');
x2_sim = model.yout.getElement('x2_sim');
t_sim = t;


% x1_exp = exp_data.x1;
% x2_exp = exp_data.x2;
% t_exp = exp_data.t;
% 
% figure
% hold on 
% plot(x1_sim, t_sim, 'Color', 'b')
% plot(x1_exp, t_exp)