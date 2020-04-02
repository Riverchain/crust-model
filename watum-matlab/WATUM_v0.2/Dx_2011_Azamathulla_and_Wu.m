function Dx = Dx_2011_Azamathulla_and_Wu(b, y, z, s, flow, u)
%% Dx_2011_Azamathulla_and_Wu
% Azamathulla, H.M. and Wu, F.-C.J.A.S.C. (2011) Support vector machine approach for longitudinal dispersion coefficients in natural streams.  11(2), 2902-2905.

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
e = exp(1);
u_star= sqrt (g .* r .* s);
Dx=(((power(e,power(e,cos(u./u_star)+(pow2(u./u_star)./((w./y)+3.956)))))) + ...
   ((sin((w./y).*(u./u_star)).*(w./y).*(u./u_star))./power(e,sin(w./y))) + ...
   ((u./u_star)./1.037) - ...
   (10.76.*(w./y)./((u./u_star)-11.38))).*y.*u_star;
end