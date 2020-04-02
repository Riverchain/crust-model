function Ex = Dx_2012_Etemadshahidi_and_Taghipour( b, y, z, s, flow, u )
%% "EtemadShahidi and Taghipour" Longitudinal dispersion coefficient 
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



if mean(w./y) <= 30.6
    Ex = 15.49 .* ((w./y).^0.78) .* ((u./ustar).^0.11) .* y .* ustar;
else
    Ex = 14.12 .* ((w./y).^0.61) .* ((u./ustar).^0.85) .* y .* ustar;
end


