function Ex = Dx_1998_Seo_and_Cheong( b, y, z, s, flow, u )
%% "Seo & Cheong 1998" Longitudinal dispersion coefficient
% This function calculate "Seo and Cheong 1998"  LDC
% use meter and qubic meter as your dimentions
a   = y .* ( b + z .* y);
T   =b+2 .* z .* y;
p   =b+2 .* y .* sqrt(1+z.^2);
r   =a ./ p;
D   =a ./ T;
switch nargin   
    case 5
    u   = flow ./ a;
end
g   =9.81;
w   =a ./ y;
ustar=sqrt(g .* r .* s);
Ex=5.195  .*  y .* ustar .* (w ./ y) .^ 0.62  .*  (u ./ ustar) .^ 1.428;
end

