function Dx = Dx_1966_Fischer(b, y, z, s, flow, u)
%% Doctor Fischer very first LDC formula release.
% This function calculate oldest Fischer Longitudinal Dispersion
% Coefficient. Not the famus Fischer's one, but the first one.
% I strongly recommend you, please provide a valid U vector before using this model.
% use meter and qubic meter as your dimentions
% Fischer, H.B. (1966) Longitudinal dispersion in laboratory and natural streams, National Defense Education Act, United states of America.

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
Dx=0.011.*((pow2(u).*pow2(w))./(y.*u_star));

end

