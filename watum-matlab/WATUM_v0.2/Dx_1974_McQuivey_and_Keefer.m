function Dx = Dx_1974_McQuivey_and_Keefer(b, y, z, s, flow, u)
%% McQuivey_and_Keefer 1974 Longitudinal dispersion coefficient 1959
% McQuivey, R.S. and Keefer, T.N. (1974) Simple Method for Predicting Dispersion in Streams. Journal of the Environmental Engineering Division 100(4), 997-1011.

a   = y .* ( b + z .* y);
w = a ./ y;
T   =b + 2 .* z .* y;
p   =b + 2 .* y .* sqrt(1+z .^ 2);
r   =a ./ p;
D   =a ./ T; %#ok

switch nargin   
    case 5
    u   = flow ./ a;
end
g   =9.81;
u_star= sqrt (g .* r .* s);
Dx= 0.058.*(y./u_star).*u;

end

