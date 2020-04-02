clc ;
clear ;
disp('You can leave two following statements blank')
filename = input('Type a file_name to  Load and save your work. \n if your file is already configured, just tap ENTER ','s');
filepath = input('Where did you saved Watum files? type the folder address like this: \n "C:\\Users\\Windows_User\\Documents\\Watum " \n if your matlab file, configured excel file and all m files listed bellow are in the same path available then just tap ENTER ','s');

if isempty(filename)  ==  1
    [~,filename,~] = xlsread(filename,'Setting','B2:B2'); % excel filename % this happens to be tricky! don't forget to check excel filename with this line
end

if isempty(filepath)  ==  1
    [~,filepath,~] = xlsread(filename,'Setting','B6:B6'); % excel Address ; 
end

%% reading and making needed data
 
% RI = Reach Information (hydraulic and quality and...)

[ ~,ProjName,~]         = xlsread(filename,'Setting','b2:b2');
End_Reach    = xlsread(filename,'Reach Propertise','W:W');
[Reach_ID,~] = size (End_Reach );
l            = xlsread(filename,'Reach Propertise','Z:Z'); % Meters
s            = xlsread(filename,'Reach Propertise','J:J'); % dim less
q            = xlsread(filename,'Reach Propertise','D:D'); % M3/sec
y            = xlsread(filename,'Reach Propertise','K:K'); % Meters
w            = xlsread(filename,'Reach Propertise','L:L'); % Meters
zl           = xlsread(filename,'Reach Propertise','U:U'); % dim less
u            = xlsread(filename,'Reach Propertise','S:S');
sigma        = xlsread(filename,'Reach Propertise','AQ:AQ'); % Curvature factor
% zr    = xlsread(filename,'Reach Propertise','G:G'); % dim less
steper       = xlsread(filename,'Setting','B12:B12') ; % Decreases amount of report papers
dx      = xlsread(filename,'Setting','B9:B9'); % Meters or Meter
tt   = round(max(xlsread(filename,'Reach Propertise','f:f')) .* 3600) ; % seconds
length_river = (max(End_Reach)+ dx./1000 ) .* 1000 ; % Meters
%%

DL_X_START   = xlsread(filename,'Loading','F:F'); % Meters
DL_X_END     = xlsread(filename,'Loading','G:G'); % 
DL_num       = xlsread(filename,'Loading','H:H'); % # 
DL_T_START   = xlsread(filename,'Loading','K:K'); % seconds
DL_T_END     = xlsread(filename,'Loading','L:L'); % seconds
DL_mass      = xlsread(filename,'Loading','I:I'); % Grams 
DL_Decay     = xlsread(filename,'Setting','B13:B13');
%DLoad        = [DL_x ; DL_D ; DL_mass ; DL_Startime ; DL_Decay]; % Forms the point load matrix

PLI_Location = xlsread(filename,'Loading','A:A'); % Meters
PLI_mass     = xlsread(filename,'Loading','B:B'); % Grams
PLI_Decay    = xlsread(filename,'Setting','B13:B13'); % [1/Seconds]
PL_T_START   = xlsread(filename,'Loading','D:D'); 
%PL_T_END     = xlsread(filename,'Loading','E:E'); 
PL_initial_Matrix   = [PLI_Location , PLI_mass , PL_T_START , PLI_Decay]; % Forms the point load matrix

Ini_Con = xlsread(filename,'Initial Concentration','A:A');
Ini_Sta_Loc = xlsread(filename,'Initial Concentration','B:B');
Ini_End_Loc = xlsread(filename,'Initial Concentration','C:C');

%  *****    *****   *****   *****   *****   *****   *****

a      = w .* y ;
% u         = q ./ a ;
vol       = a .* dx;
Alpha        = xlsread(filename,'Setting','B14:B14') ; 
Betha        = 1 - Alpha ;
%% LDC maker
% chossing LDC
    %disp('.* is right');
    %disp('you can chosse your desired LDC by the List which is shown below');
    disp('In sheet "SETTING" in excel file, choose what Method you want, to calculate LDC ');
%     disp(' (1) Fischer 1975'                );
%     disp(' (2) Seo & Cheong 1998'           );
%     disp(' (3) Deng 2001'                   );
%     disp(' (4) Kashefipour & Falconer 2002' );
%     disp(' (5) Rajeev and Dutta 2009'       );
%     disp(' (6) Jhang 2015'                  );
%     disp(' (7) Qiasi  2015 '                );
%     disp(' (8) if you want study on a non_dispersive model ' );
%     
       [ndata, LCD_num , alldata] = xlsread(filename,'Setting','B11:B11');
      
       % numerical disspersion occurs: error_n = u .* dx * (Alpha- 0.5) - (0.5 .* (u.*u.*dt));
       
if          strcmp(LCD_num,'Elder (1959)') ==1
        LCD0 = Dx_1959_Elder(w,y,zl,s,q,u);
    
elseif     strcmp(LCD_num,'Fischer (1966)') == 1
        LCD0 = Dx_1966_Fischer(w,y,zl,s,q,u);

elseif     strcmp(LCD_num,'McQuivey and Keefer (1974)') == 1
        LCD0 = Dx_1974_McQuivey_and_Keefer(w,y,zl,s,q,u);

elseif strcmp(LCD_num,'Fischer (1975)') == 1
        LCD0 = Dx_1975_Fischer(w,y,zl,s,q,u);

elseif strcmp(LCD_num,'Liu (1977)') == 1
        LCD0 = Dx_1977_Liu(w,y,zl,s,q,u);

elseif strcmp(LCD_num,'Koussis and Rodríguez-Mirasol (1988)') == 1
        LCD0 = Dx_1988_Koussis_and_Rodriguez_Mirasol(w,y,zl,s,q,u);

elseif strcmp(LCD_num,'Iwasa and Aya (1991)') == 1
        LCD0 = Dx_1991_Iwasa_and_Aya(w,y,zl,s,q,u);

elseif strcmp(LCD_num,'Seo and Cheong (1998)') == 1
        LCD0 = Dx_1998_Seo_and_Cheong(w,y,zl,s,q,u);

elseif strcmp(LCD_num,'Li et al (1998)') == 1
        LCD0 = Dx_1998_Li_et_al(w,y,zl,s,q,u);

elseif strcmp(LCD_num,'Li et al 2 (1998)') == 1
        LCD0 = Dx_1998_v2_Li_et_al(w,y,zl,s,q,u);

elseif strcmp(LCD_num,'Deng et al (2001)') == 1
        LCD0 = Dx_2001_Deng_et_al(w,y,zl,s,q,u);

elseif strcmp(LCD_num,'Kashefipour and Falconer (2002)') == 1
        LCD0 = Dx_2002_Kashefipour_and_Falconer(w,y,zl,s,q,u);

elseif strcmp(LCD_num,'Tavakollizadeh and Kashefipur (2007)') == 1
        LCD0 = Dx_2007_Tavakollizadeh_and_Kashefipur(w,y,zl,s,q,u);

elseif strcmp(LCD_num,'Sahay and Dutta (2009)') == 1
        LCD0 = Dx_2009_Sahay_and_Dutta(w,y,zl,s,q,u) ;

elseif strcmp(LCD_num,'Azamathulla and Wu (2011)') == 1
        LCD0 = Dx_2011_Azamathulla_and_Wu(w,y,zl,s,q,u) ;

elseif strcmp(LCD_num,'Etemadshahidi and Taghipour (2012)') == 1
        LCD0 = Dx_2012_Etemadshahidi_and_Taghipour(w,y,zl,s,q,u);
        
elseif strcmp(LCD_num,'Zeng and Huai (2014)') == 1
        LCD0 = Dx_2014_Zeng_and_Huai(w,y,zl,s,q,u);

elseif strcmp(LCD_num,'Noori et al (2017)') == 1
        LCD0 = Dx_2017_Noori_et_al(w,y,zl,s,q,u);
               
elseif strcmp(LCD_num,'Disley et al (2015)') == 1
                    
        LCD0 = Dx_2015_Disley(w,y,zl,s,q,u);

elseif strcmp(LCD_num,'Qiasi 01 (2017)') == 1
                    
        LCD0 = Dx_2017_Qiasi_et_al_01(w,y,zl,s,q,u,sigma);

elseif strcmp(LCD_num,'Qiasi 02 (2017)') == 1
                    
        LCD0 = Dx_2017_Qiasi_et_al_02(w,y,zl,s,q,u,sigma);
        
elseif strcmp(LCD_num,'None Dispersive Model') == 1
        LCD0 = 0 ;        
        
end 

All_LDC = [ Dx_1959_Elder(w,y,zl,s,q,u),...
Dx_1966_Fischer(w,y,zl,s,q,u),...
Dx_1974_McQuivey_and_Keefer(w,y,zl,s,q,u),...
Dx_1975_Fischer(w,y,zl,s,q,u),...
Dx_1977_Liu(w,y,zl,s,q,u),...
Dx_1988_Koussis_and_Rodriguez_Mirasol(w,y,zl,s,q,u),...
Dx_1991_Iwasa_and_Aya(w,y,zl,s,q,u),...
Dx_1998_Seo_and_Cheong(w,y,zl,s,q,u),...
Dx_1998_Li_et_al(w,y,zl,s,q,u),...
Dx_1998_v2_Li_et_al(w,y,zl,s,q,u),...
Dx_2001_Deng_et_al(w,y,zl,s,q,u),...
Dx_2002_Kashefipour_and_Falconer(w,y,zl,s,q,u),...
Dx_2007_Tavakollizadeh_and_Kashefipur(w,y,zl,s,q,u),...
Dx_2009_Sahay_and_Dutta(w,y,zl,s,q,u),...
Dx_2011_Azamathulla_and_Wu(w,y,zl,s,q,u),...
Dx_2012_Etemadshahidi_and_Taghipour(w,y,zl,s,q,u),...
Dx_2014_Zeng_and_Huai(w,y,zl,s,q,u),...
Dx_2015_Disley(w,y,zl,s,q,u),...
Dx_2017_Noori_et_al(w,y,zl,s,q,u),...
Dx_2017_Qiasi_et_al_01(w,y,zl,s,q,u,sigma),...
Dx_2017_Qiasi_et_al_02(w,y,zl,s,q,u,sigma)];


xlswrite(filename,All_LDC,'LDC'); 

% end LDC maker
%% time specification
dt   = (dx .^ 2) ./ (u .* dx .* (Alpha-Betha) + 2 .* LCD0 + PLI_Decay(1) .* (dx .^ 2)) %#ok
prompt = input('Calc dt press enter \n read dt press r ','s');

if strcmp( prompt , 'r' ) == 1
    dt   = xlsread(filename,'Setting','B10:B10');
else
    dt   = (dx .^ 2) ./ (u .* dx .* (Alpha-Betha) + 2 .* LCD0 + PLI_Decay(1) .* (dx .^ 2))  ;
    xlswrite(filename,min(dt),'Setting','B10:B10');
    dt   = xlsread(filename,'Setting','B10:B10'); % I call this the new Delta Time steps.
end
pause()
%dt = 0.12; % MATLAB will waits here and you can change the dt with the value in excel setting sheet.


if isempty(tt) == 1 
    tt   = mean(floor(length_river./ u)) +1 ;
end

nT= floor(tt ./ dt)+1;
nX= floor(length_river./dx)+1;
TX_Cells= zeros(nT,nX); % makes the main matrix
cn= u .* (dt ./ dx) ; 
Landa= (LCD0 .* dt) ./ (dx .^ 2) ;
%% LDC modification
if Alpha == 1
    en = u .* dx * (Alpha- 0.5) - (0.5 .* (u.*u.*dt));
else
    en = - (0.5 .* (u.*u.*dt));
end

LCD0 = LCD0 - en;

epr = (LCD0 .* a) ./ dx  ; % assign E' value
%% making Diffusive Load Matrix
DLoad = TX_Cells;
[ DLTST_indx , DLTEN_indx ] = timindexer( dt, DL_T_START, DL_T_END );
[ DLXST_indx , DLXEN_indx ] = timindexer( dx, DL_X_START, DL_X_END );

for i = 1 : length(DL_num)

    for t = DLTST_indx(i)   :   DLTEN_indx(i)
       
        
        for dx = DLXST_indx(i)  : DLXEN_indx(i)
        
        
        DLoad(t,dx) = DL_mass(i);
   
        end
    
    end

end

%************************************
%% **********************************
PLoad = TX_Cells;


for i = 1 : length(PLI_Location)
     
    nX_i = floor(PLI_Location(i) ./ dx)+1;
    nT_i = floor(PL_T_START(i) ./ dt)+1;
    PLoad(nT_i,nX_i) = PLI_mass(i);

end



%% initial Condition
[ ini_ST_indx , ini_Ed_indx ] = timindexer( dx, Ini_Sta_Loc, Ini_End_Loc );

for i = 1 : length(Ini_Con)

        t = 1; 
        for x = ini_ST_indx(i)  : ini_Ed_indx(i)
        TX_Cells(t,x) = Ini_Con(i);
        end
end

%% Boundary      
                            % TX_Cells(:,1) = 0  ; 

%% Loading
% Instant Point Load
% Diffusive Load



%% inform user
% etha = PLI_Decay .* LCD0 ./ ( RI_u .^ 2 );
% 
% if etha > 1 
%    disp('Diffusion dominates')
% elseif etha <=1
%     disp('Advection dominates')
% end

formatSpec = '  Total Time number is %8.1f \n   nT number is %8.1f \n  nX number is %8.1f \n  Courant Number is %8.1f \n  Landa is %8.5f \n  delta_T is %8.2f \n  delta_X is %8.1f \n  E is %8.3f \n  E'' is %8.3f \n  Press any key to continue';
fprintf(formatSpec,tt,nT,nX,cn,Landa,dt,dx,LCD0(1),epr(1))



%% main solver

% disp('press enter to start hydraulic sub-model')

tic

%% Quantity

       
            % This section is needed for my second journal paper InshaALLah
            % fprintf('\n  Hydro sub-model is finished in: %8.1f seconds',toc)

            
%% Quality

for i =  1 : Reach_ID 
   
    for  t = 1  : nT -1
        
        for     x = 2 : nX -1
          
              TX_Cells(t+1,x) = ... 
              ...
              PLoad(t,x) ./ vol(i) +     ( DLoad(t,x) .*  dt) ./ vol(i) - ...
              ...
              (dt ./ vol(i)) .* ( -q(i) .* Alpha - epr(i) ) .* TX_Cells(t,x-1) + ...
              ...
              (1-(dt ./ vol(i)) .* (-q(i) * Betha + q(i) .* Alpha + 2 .* epr(i) + DL_Decay .* vol(i) ) ) .* TX_Cells(t,x) - ...
              ...
              (dt ./ vol(i)) .* (q(i)*Betha-epr(i)).*TX_Cells(t,x+1);
          
        end
    end

end

fprintf('\n  solver Time %8.1f ',toc)

%% presentation
disp(ProjName)

c0 = TX_Cells; c1 = c0'; lcd = LCD0;
  %% statistics
%    c_peak_anal = zeros(floor(nT/steper),1);
    cp  = zeros(nX,1);
    
  for i = 1 : nX
          
          cp(i,1)  = max(c1(i,:));
  end 
  
  %% timer
  fprintf('\n  statisitcs is finished in: %8.1f seconds',toc)
  
  %% plotter
  string = input(' plot? insert y or just enter ','s');
  if (strcmp(string,'y')==1)
  grid on
  hold on
  subplot(1,2,1);plot(TX_Cells(:,1:steper:end))
  grid on
  hold on
  subplot(1,2,2);plot(cp(:,1:steper:end))
  end
  %% timer
  fprintf('\n  results ploted in: %8.1f seconds',toc)
 
  %% file generator
         
% xlswrite ( filename, c_peak_num, 'peak_num' )
 
 %% timer
 fprintf('\n  making report files is finished in: %8.1f seconds',toc)
 