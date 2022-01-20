kps = [0.15; 0.25; 0.5];
kp_025 = load("2_2_Kp_0.25.mat");
% kp = 0.15;
kv = 94.737;
tau_v = 0.071;

sim("part2controller.slx")
% output_sig = out.plot
% output_sig = out.getElement('output');
% time = output_sig.Values.Time;
% output = output_sig.Values.Data;

kp = 0.15;
sig = out.yout.getElement('output');
time = sig.Values.Time;
output = sig.Values.Data;

figure
plot(time, output);
grid on
hold on
plot(kp_025.t, kp_025.x);
hold off


% for kp = 1:length(kps)
%     wn = sqrt(kv*kp/tau_v)
%     zeta = 1/(2*tau_v*wn)
%     
% 
% end

