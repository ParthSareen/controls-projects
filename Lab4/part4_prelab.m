m1 = 2.6634E-4; m2 = 1.4383E-4;
b1 = 0.0085; b2 = 8.4745E-4;
k = 0.0351;

a1 = (m1 * b2 + m2 * b1) / (m1 * m2);
a2 = (b1 * b2 + (m1 + m2) * k) / (m1 * m2);
a3 = (b1 + b2) * k / (m1 * m2);

num = [k / (m1 * m2)];
den = [1 a1 a2 a3];

G2 = tf(num, den);
sisotool(G2);