function Ex = Dx_2009_Sahay_and_Dutta( b, y, z, s, flow, u )
%% "Rajeev and Dutta 2009" Longitudinal dispersion coefficient 
% This function calculate Rajeev and Dutta 2009 LDC
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
w   =a ./ y;
ustar =sqrt(g .* r .* s);
Ex =2 .* y .* ustar .* (w ./ y) .^ 0.96  .*  (u ./ ustar) .^ 1.25;
end

