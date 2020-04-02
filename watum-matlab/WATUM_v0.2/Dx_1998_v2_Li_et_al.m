function Dx = Dx_1998_v2_Li_et_al(b, y, z, s, flow, u)
%% Dx_1998_v2_Li_et_al
% Liu, H. (1977) Predicting Dispersion Coefficient of Streams. Journal of the Environmental Engineering Division 103(1), 59-69.

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
Dx=0.55.*((w.*u_star)./(pow2(y)));
end