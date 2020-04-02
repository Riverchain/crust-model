function Ex = Dx_2017_Noori_et_al(b, y, z, s, flow, u)
             %Dx_2017_Noori_et_al
%% Dx_2017_Noori_et_al
% Noori, R., Ghiasi, B., Sheikhian, H. and Adamowski, J.F.J.J.o.H.E. (2017) Estimation of the dispersion coefficient in natural rivers using a granular computing model. Journal of Hydraulic Engineering 143(5).

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
Ex=power(u./u_star,1.125).*(w./y).*y.*u_star;
end