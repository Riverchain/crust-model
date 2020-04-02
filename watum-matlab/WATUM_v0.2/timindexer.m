function [ Start_indx , End_indx ] = timindexer( delta, START, END )
% this function gets total time and delta time steps and ssigns an indexed
% number to each step of finite volume time steps.


Start_indx  = 0 .* START;
End_indx  = 0 .* END;
for i = 1 : length(START)
    
     
    Start_indx(i) = floor( START(i) ./ delta ) +1 ;
    
    
     
    End_indx(i) = floor( END(i) ./ delta ) +1 ;
    

end

