% Estimate steady state velocity for +/- 1.5 V input
load velocity_response_1_5.mat t u v1 v2
vss_avg = mean(v1(1500:2000));
vss_avg = vss_avg + mean(v2(1500:2000));
vss_avg = vss_avg + mean(v1(3500:4000));
vss_avg = vss_avg + mean(v2(3500:4000));
vss1 = vss_avg / 4;

% Estimate steady state velocity for +/- 2.0 V input
load velocity_response_2.mat t u v1 v2
vss_avg = mean(v1(1500:2000));
vss_avg = vss_avg + mean(v2(1500:2000));
vss_avg = vss_avg + mean(v1(3500:4000));
vss_avg = vss_avg + mean(v2(3500:4000));
vss2 = vss_avg / 4;

% Solve for x = [b_T; d_T]
A = [vss1 1; vss2 1];
b = [1.5; 2.0];
x = inv(A) * b

b1 = 1 / 1.1 * x(1)
b2 = 1 / 11 * x(1)

d1 = 1 / 1.1 * x(2)
d2 = 1 / 11 * x(2)

% Estimate tau using +/- 2.0 V excitation
tau = (1.074 - 1.073) / (93.184 - 88.5248) * (91.8302 - 88.5248) + 1.073

mt = (b1 + b2) / tau;
m1 = mt / 1.54
m2 = 0.54 / 1.54 * mt

% Damping frequency measured from peak periods of step response
wd = 21.2989;

% Iteratively determine damping ratio and spring constant
zeta = [1 0.02 0.02];
for i = [1:10]
    wn2 = wd^2 / (1 - zeta(2)^2);
    k = m1 * m2 * wn2 / mt;
    den = [1 (m1 * b2 + m2 * b1) / (m1 * m2),...
        (b1 * b2 + mt * k) / (m1 * m2),...
        (b1 + b2) * k / (m1 * m2)];
    [wn, zeta, p] = damp(tf([1], den))
end

k
zeta

