clear; clc;
Kp = 1.27;
Kd = 0.0232;
Ki = 15.97966;
m = 749.44e-6;
b = 10.556e-3;
kv = 94.737;
tau_v = 0.071;

exp_data = load("MTE360_Project2_Dataset/q2_2.mat");
t = exp_data.t;
xr = exp_data.xr;

sim("three_one_f.slx")
output = ans.yout.getElement('Output');
input = ans.yout.getElement('Input');
control = ans.yout.getElement('Control');
tracking = ans.yout.getElement('TrackingE');

figure
title('Position Trajectory, Tracking Error, and Control Signal vs. Time');

subplot(3,1,1);
hold on
% sim data
plot(output.Values.Time, output.Values.Data, 'Color', 'r');
plot(input.Values.Time, input.Values.Data, 'Color', 'b');
% exp data
plot(exp_data.t, exp_data.x,"Color",'g');
plot(exp_data.t, exp_data.xr,"Color",'m');
legend('Simulated x', 'Simulated xr', 'Experimental x', 'Experimental xr')
xlabel('Time (s)')
ylabel('Position (mm)')
hold off

subplot(3,1,2);
hold on
plot(tracking.Values.Time, (input.Values.Data - output.Values.Data), 'Color', 'b');
e = exp_data.xr - exp_data.x;
plot(exp_data.t, e, "Color", 'r');
xlabel('Time (s)')
ylabel('Tracking Error (mm)')
legend('Simulated e', 'Experimental e')
hold off

subplot(3,1,3);
hold on
plot(control.Values.Time, control.Values.Data, 'Color', 'b');
plot(exp_data.t, exp_data.u, "Color", 'r');
legend('Simulated u', 'Experimental u')
xlabel('Time (s)')
ylabel('Control (V)')
hold off

