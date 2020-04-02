function Ex = Dx_1959_Elder(b, y, z, s, ~, ~)
%% Elder Longitudinal dispersion coefficient 1959
% This function calculate Elder Longitudinal Dispersion Coefficient
% I strongly recommend you, please provide a valid U vector before using this model.
% use meter and qubic meter as your dimentions
%Elder, J. (1959) The dispersion of marked fluid in turbulent shear flow. Journal of Fluid Mechanics 5(4), 544-560.

a   = y .* ( b + z .* y);
%w = a ./ y;
T   =b + 2 .* z .* y;
p   =b + 2 .* y .* sqrt(1+z .^ 2);
r   =a ./ p;
D   =a ./ T; %#ok

switch nargin   
    case 5
    %u   = flow ./ a;
end
g   =9.81;
u_star= sqrt (g .* r .* s);
Ex= 5.93 .* y .* u_star ;

end

