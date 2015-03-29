side = 171.77 * 10^(-3); % length of a side
l = 121.07 * 10^(-3);    % 113.34 mm (corner to center)
lb = 0.90 * l;           % guessing here
mb = (20 + 252.8 + 141) * 10^(-3); % holder + frame + motor
mw = (110) * 10^(-3);    % mass of wheel
Km = 36.9*10^(-3);       % from manual
rw = 69.52 * 10^(-3);    % radius of wheel
Iw = mw * rw^2; % I = mr^2 (moment of intertia for cylindrical shell, 
                % rotating around the center)
Ib = (mb + mw)*(2*side^2)/12 + (mb + mw)*l^2; % moment of plate 
                                              % + parallel axis theorem
                                              % this looks way off
                                              % may need to do system ID
g = 9.81;                                              
Cb =  1.02 * 10^(-3); % Lifted from paper (may need to do system ID)
Cw = 0.05 * 10^(-3);  % Lifted from paper (may need to do system ID)

A = [0 1 0; 
    (mb*lb + mw*l)*g/(Ib + mw*l^2) -(Cb)/(Ib + mw*l^2) Cw/(Ib + mw*l^2);
    -(mb*lb + mw*l)*g/(Ib + mw*l^2) Cb/(Ib + mw*l^2) -Cw*(Ib + Iw + mw*l^2)/(Iw*(Ib + mw*l^2))];
B = [0; -Km/(Ib + mw*l^2); Km*(Ib + Iw + mw*l^2)/(Iw*(Ib + mw*l^2))];
C = [1 0 0];
[num, den] = ss2tf(A, B, C, 0);