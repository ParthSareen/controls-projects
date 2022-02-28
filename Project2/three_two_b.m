clc; clear;

m = 749.44e-6;
b = 10.556e-3;

Kp = 1.27;
Ki = 15.97966;
Kd = 0.0232;


pd_tf = tf([Kd/m Kp/m], [1 (b+Kd)/m Kp/m]);
pid_tf = tf([Kd/m Kp/m Ki/m], [1 (b+Kd)/m Kp/m Ki/m]);

figure
hold on
pzmap(pd_tf);
damp(pd_tf); 
pzmap(pid_tf);
damp(pid_tf);
legend('PD Poles, Zeroes', 'PID Poles, Zeroes');
grid on
hold off
