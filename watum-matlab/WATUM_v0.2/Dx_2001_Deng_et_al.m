function Ex = Dx_2001_Deng_et_al( b, y, z, s, flow, u )
%% "Deng et al 2001" Longitudinal dispersion coefficient
% This function calculate "Deng et al 2001"  LDC
% use meter and qubic meter as your dimentions
a   = y .* ( b + z .* y);
T   =b + 2 .* z .* y;
p   =b + 2 .* y .* sqrt(1 + z .^ 2);
r   =a ./ p;
D   =a ./ T; %#ok
switch nargin   
    case 5
    u   = flow ./ a;
end
g   =9.81;
w   =a ./ y;
ustar   =sqrt(g .* r .* s);
epsilon =145e-3 + (1 ./ 3520)  .*  (w ./ y) .^ 1.38  .*  (u ./ ustar);
Ex=15e-2  .*  y  .*  ustar  .*  (1 ./ (8 .* epsilon)) .* (w ./ y) .^ 1.667  .*  (u ./ ustar) .^ 2;
end

