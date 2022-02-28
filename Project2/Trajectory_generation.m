% MTE360 Tutorial 01
% Example 01: Plotting a trajectory versus time
% Presented Friday January 5, 2007

% clear all % clears the workspace
% close all % closes all figure windows

Ts = 0.001;
% Given:
A=500; % acceleration mm/sec^2
D=-500; % deceleration mm/sec^2
F=100; % feedrate (velocity) mm/sec
L=50; % travel length mm
% Ts=0.01; % sampling period sec

t_dwell = 0.3;
K_dwell = t_dwell / Ts;
T1=F/A; % from equation 2
T3=-F/D; % from equation 3
T2=L/F - (T1+T3)/2; % from equation 4

if T1<0 || T2<0 || T3<0 % kinematic compatibility conditions
    disp('Error: acceleration, deceleration and travel length are not kinematically compatible.');
else
    tau1=0:Ts:T1; % create row vector for time, initial time : step size : final time
    tau2=0:Ts:T2;
    tau3=0:Ts:T3;
    
    % preallocate array for speed
    s1=zeros(1,length(tau1));    sd1=zeros(1,length(tau1));    sdd1=zeros(1,length(tau1));
    s2=zeros(1,length(tau2));    sd2=zeros(1,length(tau2));    sdd2=zeros(1,length(tau2));
    s3=zeros(1,length(tau3));    sd3=zeros(1,length(tau3));    sdd3=zeros(1,length(tau3));
    
   % from equation 1
    for index=1:length(tau1)
        s1(index)=F*tau1(index)*tau1(index)/2/T1; 
        sd1(index)=F*tau1(index)/T1; % first derivative: velocity
        sdd1(index)=A; % second derivative: acceleration
    end
    for index=1:length(tau2)
        s2(index)=F*tau2(index) + F*T1/2; 
        sd2(index)=F;
        sdd2(index)=0;
    end
    for index=1:length(tau3)
        s3(index)=-F*tau3(index)*tau3(index)/2/T3 + F*tau3(index) + L - F*T3/2; 
        sd3(index)=-F*tau3(index)/T3 + F;
        sdd3(index)=D;
    end
end

t1=tau1'; % change tau1 from a row vector to a column vector tau1'
t2=tau2(2:end)' + T1; % shift bounds and drop first vector element
t3=tau3(2:end)' + T1 + T2; 
t = [t1;t2;t3]; % concatenation of time vector 

s1=s1'; 
s2=s2(2:end)'; 
s3=s3(2:end)'; 
s = [s1;s2;s3]; % concatenation of trajectory vector 

sd1=sd1'; 
sd2=sd2(2:end)'; 
sd3=sd3(2:end)'; 
sd = [sd1;sd2;sd3]; % concatenation of feedrate vector 

sdd1=sdd1'; 
sdd2=sdd2(2:end)'; 
sdd3=sdd3(2:end)';
sdd = [sdd1;sdd2;sdd3]; % concatenation of feedrate vector 

%%
s = [s ; s(end)*ones(K_dwell,1) ; flip(s) ];
s = [s ; s(end)*ones(K_dwell-1,1) ];
sd = [sd ; sd(end)*ones(K_dwell,1) ; -flip(sd) ; sd(end)*ones(K_dwell-1,1)];
sdd = [sdd ; zeros(K_dwell,1) ; flip(sdd) ; zeros(K_dwell-1,1)];

t = (0:(length(s)-1))';
t = t * 0.01;


%%
figure(1); % opens a figure window
subplot(3,1,1); % subplot(rows, columns, position)
  plot(t,s); % plots trajectory versus time
  title('A Simple Trajectory'); % creates a title for the plot
  ylabel('displacement [mm]'); % labels the y-axis
grid on;
  subplot(3,1,2); 
  plot(t,sd); % plots feedrate versus time
  ylabel('feedrate [mm/sec]');grid on;
subplot(3,1,3); 
  plot(t,sdd); % plots acceleration versus time
  ylabel('acceleration [mm/sec^2]');grid on;
  xlabel('Time [msec]') % labels the x-axis
% 
% % save data to file
% data = [t s sd sdd]; % t,s,sd,sdd should be column vectors
% save ex1_data.txt -ASCII -DOUBLE data

%-- End of File --%