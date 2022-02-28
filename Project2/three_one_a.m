clear; clc;
Kp = 1.27;
Kd = 0.0232;
Ki = 15.97966;
q2_1_a = load("MTE360_Project2_Dataset/q2_1_a.mat");
q2_1_b = load("MTE360_Project2_Dataset/q2_1_b.mat");
q2_2 = load("MTE360_Project2_Dataset/q2_2.mat");

exp_data = q2_1_b;
t = exp_data.t;
xr = exp_data.xr;

sim("one_pt_one_c.slx")
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

% plot(q2_1_a.t, q2_1_a.x, 'LineStyle','--', 'Color', 'r');
% plot(q2_1_b.t, q2_1_b.x, 'Color', 'b');
% hold off
% subplot(2,1,2);
% hold on
% plot(q2_1_a.t, q2_1_a.xr, 'LineStyle','--', 'Color', 'r');
% plot(q2_1_b.t, q2_1_b.xr, 'Color', 'b');
% hold off