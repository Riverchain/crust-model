function Ex = Dx_2014_Zeng_and_Huai( b, y, z, s, flow, u )
%% "Zeng and Huai (2014)" Longitudinal dispersion coefficient
% Zeng, Y. and Huai, W. (2014) Estimation of longitudinal dispersion coefficient in rivers. Journal of Hydro-environment Research 8(1), 2-8.
% use meter and qubic meter as your dimentions
a   = y .* ( b + z .* y);
T   =b + 2 .* z .* y;
p   =b + 2 .* y .* sqrt(1+z .^ 2);
r   =a  ./  p;
D   =a  ./  T; %#ok
switch nargin   
    case 5
    u   = flow ./ a;
end
g   =9.81;
w   =a  ./  y;
ustar   =sqrt(g .* r .* s);
Ex      = y .* ustar .* 5.4 .* ((u ./ ustar) .^ 0.13) .* ((w  ./  y) .^ 0.7);
end