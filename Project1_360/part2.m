kps = [0.15; 0.25; 0.5];
kp_015 = load("2_2_Kp_0.15.mat");
kp_025 = load("2_2_Kp_0.25.mat");
kp_05 = load("2_2_Kp_0.5.mat");

kps_collected = [kp_015; kp_025; kp_05];
% kp = 0.15;
kv = 94.737;
tau_v = 0.071;


% output_sig = out.plot
% output_sig = out.getElement('output');
% time = output_sig.Values.Time;
% output = output_sig.Values.Data;


for i = 1:length(kps)
    
    kp = kps(i);
    kp_data = kps_collected(i);

    figure
    subplot(2,1,1);
    hold on
    title('Command, Measured Output, and Control for kp=',num2str(kp))
    plot(kp_data.t, kp_data.xr, 'LineStyle','--', 'Color', 'r');
    plot(kp_data.t, kp_data.x, 'Color', 'b');
    
%     tr = 
%     fprintf('tr= ',)
    ylabel('Position [mm]')
    grid on
    legend('Command', 'Measured')
    hold off
    subplot(2,1,2)
    plot(kp_data.t, kp_data.u)
    ylabel('Control [V]')
    xlabel('Time [s]')
end

% for i = 1:length(kps)
%     kp = kps(i);
%     kp_data = kps_collected(i);
%     
    sim("part2controller.slx")
    output = ans.yout.getElement('output');
    control_sig = ans.yout.getElement('control');
    input = ans.yout.getElement('input');

    figure
    subplot(2,1,1);
    hold on
    title('Experimental, Simulated Output, and Control for kp=',num2str(kp))
    plot(output.Values.Time, output.Values.Data, 'LineStyle','--', 'Color', 'r');
    plot(kp_data.t, kp_data.x, 'Color', 'b');
    ylabel('Position [mm]')
    grid on
    legend('Simulated', 'Experimental')
    hold off
% 
% 
%     subplot(2,1,2)
%     hold on
%     plot(control_sig.Values.Time, control_sig.Values.Data, 'LineStyle','--', 'Color', 'r');
%     plot(kp_data.t, kp_data.u, 'Color', 'b');
%     ylabel('Control [V]')
%     xlabel('Time [s]')
%     legend('Simulated', 'Experimental')
%     hold off
% end
% Part A
for i = 1:length(kps)
    kps(i)
    wn = sqrt(kv*kps(i)/tau_v)
    zeta = 1/(2*tau_v*wn)
end

