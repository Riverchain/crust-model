function Dx = Dx_1988_Koussis_and_Rodriguez_Mirasol(b, y, z, s, flow, u)
%% Koussis, A.D. and Rodríguez-Mirasol, J. (1988) LDC formula
% Koussis, A.D. and Rodríguez-Mirasol, J. (1988) Hydraulic estimation of dispersion coefficient for streams. Journal of Hydraulic Engineering 124(3), 317-320.

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
Dx=0.6.*pow2(w./y).*y.*u_star;
end



