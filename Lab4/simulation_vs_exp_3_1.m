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
d1 = 0.5934;
d2 = 0.05934;
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

a = 8.8741;
b = 70.4295;
Glead = tf([1 a], [1 b]);
[amp, phase] = bode(G2 * Gnotch * Glead * Glead, 25)
kp_leads = 1/amp
% c = 4.2;
% d = 0.01 * c;
% Glag = tf([1 c], [1 d]);
% [amp, phase] = bode(G2 * Gnotch * Glead * Glead * Glag, 25)
% kp_full = 1/amp
% 
% 
% kp = 1/(Gnotch)


% open("Lab4/flex2.slx")
% set_param('flex2', 'SimulationCommand', 'connect')
% set_param('flex2', 'Simulation', 'start')
model = sim('flex2', 'SimulationMode', 'normal');
x1_sim = model.ScopeData_x1;
x1_test = model.x1_sims;


x2_sim = model.ScopeData_x2;
t_sim = t;


x1_exp = exp_data.x1;
x2_exp = exp_data.x2;
t_exp = exp_data.t;

figure
subplot(4,1,1)
hold on
% x1_sim.time
% x1_sim.signals.values
plot(x1_sim.time, x1_test.Data, 'Color', 'b')
plot(x1_sim.time, x1_exp)
legend('x1 sim', 'x1 exp')
hold off
ylabel("Position [mm]")

subplot(4,1,2)
hold on
% xr vs x2
plot(x1_sim.time, x2_exp)
plot(x1_sim.time, exp_data.xr)

plot(x1_sim.time, model.ScopeData_x2.signals.values)
plot(x1_sim.time, model.ScopeData_xr.signals.values)
ylabel("Position [mm]")
legend("x2 exp", "xr exp", "x2 sim", "xr sim")
hold off

subplot(4,1,3)
hold on
plot(x1_sim.time, model.ScopeData1.signals.values)
plot(x1_sim.time, (exp_data.xr-exp_data.x2))
ylabel("Position [mm]")
legend("sim e", "exp e")
hold off


subplot(4,1,4)
hold on
plot(x1_sim.time, model.ScopeData_u.signals.values)
plot(x1_sim.time, exp_data.u)
legend("sim u", "exp u")
ylabel("Position [mm]")
hold off
xlabel("Time [s]")
