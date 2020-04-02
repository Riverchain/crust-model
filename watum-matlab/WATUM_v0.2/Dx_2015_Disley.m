function Ex = Dx_2015_Disley( b, y, z, s, flow, u )
                             
%% "Disley et al. (2015)" Longitudinal dispersion coefficient
% Disley, T., Gharabaghi, B., Mahboubi, A. and McBean, A. (2015) Predictive equation for longitudinal dispersion coefficien. HYDROLOGICAL PROCESSES 29, 161-172.
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
Ex      = y .* ustar .* 3.563 .* ((u ./  (sqrt(g .* y))) .^ -0.4117) .* ((w  ./  y) .^ 0.6776) .* ((u  ./  ustar) .^ 1.0132);
end