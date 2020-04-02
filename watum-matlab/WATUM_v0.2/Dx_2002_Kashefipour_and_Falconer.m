function Ex = Dx_2002_Kashefipour_and_Falconer( b, y, z, s, flow, u )

%% "Kashefipour & Falconer 2002" Longitudinal dispersion coefficient 
% This function calculate Kashefipour & Falconer LDC
% use meter and qubic meter as your dimentions
a   = y .* ( b + z .* y);
T   =b+2 .* z .* y;
p   =b+2 .* y .* sqrt(1+z .^ 2);
r   =a ./ p;
D   =a ./ T; %#ok
switch nargin   
    case 5
    u   = flow ./ a;
end
g   =9.81;
ustar =sqrt(g .* r .* s);


if mean (b./y) >= 50
    Ex    =10.612 .* y .* ustar .* (u ./ ustar) .^ 2;
else
    Ex = (7.428 + 1.775 .*((b./y).^0.62) .* ((ustar ./ u).^ 0.572)) .* (u ./ ustar) .* y .*u;
end

