function [nash, aare, nmbe, nrmse , TT] = metrics(observed,modeled)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
% observed = input('observed ');
% modeled = input('modeled ');

n01 = length (observed) ; n02 = length(modeled);

if n02 >= n01
    dts2 = modeled(1:n01,1);
    dts1 = observed(1:n01,1);
    n03 = length (dts1);
else
    dts1 = observed(1:n02,1);
    dts2 = modeled(1:n02,1);
    n03 = length (dts1);
end

deltapow2 = (dts1 - dts2).^2;
deltaobsmeanpow2 = (dts1 - mean(dts1)) .^ 2;

nash  = 1 - (sum(deltapow2)/sum(deltaobsmeanpow2)) ;
aare  = mean((dts1 - dts2)./dts1) ;
nmbe  = (mean(dts2-dts1)/mean(dts1)) ;
nrmse = ((sqrt(mean((dts2-dts1).^2)))/(mean(dts1))) ;
TT    = sum(dts1 - dts2);
end