
function Dx = Dx_2007_Tavakollizadeh_and_Kashefipur(b, y, z, s, flow, u)
%% Dx_2007_Tavakollizadeh_and_Kashefipur
% Tavakollizadeh, A. and Kashefipur, S. (2007) Effects of dispersion coefficient on quality modeling of surface waters, p. 6778Tayfour.

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
Dx=7.428+1.775.*(power(w./y,0.62)).*(power(u./u_star,1.752)).*y.*u;
end