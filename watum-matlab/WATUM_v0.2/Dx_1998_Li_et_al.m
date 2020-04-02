function Dx = Dx_1998_Li_et_al(b, y, z, s, flow, u)
%% Dx_1998_Li_et_al
% Li, Z.H., Huang, J. and Li, J. (1998) Preliminary study on longitudinal dispersion coefficient for the gorges reservoir.

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
Dx=0.2.*power(w./y,1.3).*power(u./u_star,1.2).*y.*u_star;
end