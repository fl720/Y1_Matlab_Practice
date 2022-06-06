% clear
% clc

% INTRODUCTION: 
%
% AT_FIELD (Auto Tunning for PID and Filter Constant Device) combined AFCOF
% and PIDtunerautomated.mlx, aim to find the Kp, Ki, Kd for the PID
% controller in the control system, then tune the filter cut-off frequency
% accordingly. You can change paramters/value ranges in [ PLZ ] if needed. 
% 
% CALCULATION PROCESS : -> Sloving KP PRIMARY VALUE RANGE   (GAP of 50 as pre-set)
%                        -> Sloving KP SECONDARY VLAUE RANGE (GAP of 10 as pre-set)
%                        -> Sloving KP TERTIAY VALUES        (GAP of 1  as pre-set)
%                        -> Sloving KI PRIMARY VALUE RANGE   (GAP of 50 as pre-set)
%                        -> Sloving KI SECONDARY VALUE RANGE (GAP of 10 as pre-set)
%                        -> Sloving KI TERTIAY VALUES        (GAP of 1  as pre-set)                       
%                        -> Sloving KD PRIMARY VALUE RANGE   (GAP of 10 as pre-set)
%                        -> Sloving KD SECONDARY VALUES      (GAP of 1  as pre-set) 
%                        -> Sloving Filter Constant (N)      (From 5 to 10 as pre-set)                        
%                        -> Sloving Filter Cut-off Frequency (From 5 to 10 as pre-set) 
%
%                        -> RMS errors of each paramter will be ploted. 
%                        -> SIMULINK will be re-run with new parameter.




%% =============================== CHECKLIST ============================== 

%   1, !!! REMEMBER PUT "FROM WORKSPACE" IN FILTER SECTION !!!                              Y/N?:
%   2, !!! REMEMBER CHANGE PARAMETER TO "filter_constant" !!!                               Y/N?:
%   3, !!! REMEMBER PUT "TO WORKSPACE" NEXT TO FILTER ERROR, RENAME TO "RMSerror"           Y/N?:
%   4, !!! REMEMBER PUT "FROM WORKSPACE" NEXT TO ENERGY, RENAME TO "energy"                 Y/N?:
%   5, !!! CHECK IF THE TIME STEP IS DESIRED                                                Y/N?:
%   6, !!! REMEMBER PUT "TO WORKSPACE" NEXT TO TARGET HEIGHT, RENAME TO "Target_height"     Y/N?:
%   7, !!! REMEMBER PUT "TO WORKSPACE" NEXT TO ACTUAL HEIGHT, RENAME TO "height"            Y/N?:

%% ====================== PARAMETER LOADING ZONE [ PLZ ] =================================================================

% Kp testing range 
P_Pri_gap = 25 ; 
P_Sec_gap = 5 ; 
P_Ter_gap = 1  ;
P = [50:P_Pri_gap :175] ; 

% Ki testing range 
I_Pri_gap = 25  ;
I_Sec_gap = 5 ; 
I_Ter_gap = 1  ;
I = [50:I_Pri_gap :300] ; 

% Kd testing range
D_Pri_gap = 5           ;
D_Sec_gap = 1           ;
D = [10:D_Pri_gap:80]   ; 

% N testing range
N_Pri_gap = 1                   ;
N_range = [10 : N_Pri_gap : 45] ; 

% filter cut-off constant range
FCO = [10 : 1 : 80 ] ; 


Ki = 158                     ; % initial Ki prediction value

Kd = 50                      ; % initial Kd prediction value 
                    
N  = 12                      ; % initial filter constant in PID controller

filter_constant = [ 1 , 70 ] ; % initial filter cut-off constant 

error_factor  =  10e+10 ; 
energy_factor =  1      ; 


%% ====================== Kp Tunning Sector [ PTS ] ======================================================================
% use "run to end from above for changes made in [PLZ] after Run

E_kp     = [0 ; 0 ]  ;

error_Kp = [ 0 ; 0 ] ;

for i = P(1) : P_Pri_gap  : P(end)

    Kp = i ; 
    
    try
    out = sim( "better_controller.slx" ) ; 
    
    % live plot:
    figure(2)
    plot(out.height.Time , out.height.Data, 'r-' , out.Target_height.Time , out.Target_height.Data , 'b-')
    title(['Kp:',num2str(Kp) ,'Ki:',num2str(Ki) ,'Kd:',num2str(Kd), 'N:',num2str(N) , 'FC:',num2str(filter_constant(2)) ]) ; 
    ylim([0 1.44])

    E_kp = [ E_kp , [ Kp ; out.energy.Data(end) ] ] ; 

    error_Kp = [ error_Kp , [Kp ; out.RMSerror.Data(end) ] ] ; 

    progress = ( Kp - P(1) ) / (P(end) - P(1)) * 100           ; % <-- comment it if unnecessary
    form = '%3.1f percent of P primary calculation is done. '  ; % <-- comment it if unnecessary
    fprintf(form , progress)    ;                                % <-- comment it if unnecessary
    catch
    form = 'Function crashed at Kp = %f , skipped' ; 
    fprintf(form , Kp)
    end
end

error_Kp  = error_Kp(: , 2:end) ; 
E_kp      = E_kp( : , 2 : end ) ; 


%=========================
%
% Calculation of ( energy * error ) in future 
FACTOR_Kp = error_factor * error_Kp(2,:).^2 + energy_factor * E_kp(2,:).^2 ; 
%=========================

[ M , INDEX ] = min(FACTOR_Kp)  ;

% trend plot
figure(1)
subplot(5,1,1);
plot(error_Kp(1,:) , FACTOR_Kp , '-*') ; 
title("FACTOR_Kp-curve")  ;
xlabel("Kp") ;
ylabel("FACTOR_Kp")

P = [ error_Kp(1,INDEX) - P_Pri_gap  ; 1 ; error_Kp(1,INDEX) + P_Pri_gap  ] ;   % re-define P range

% ========================= Secondary calculation =========================

E_kp     = [0 ; 0 ]  ;

error_Kp = [ 0 ; 0 ] ;

for i = P(1) : P_Sec_gap : P(end)

    Kp = i ; 
    
    try
    out = sim( "better_controller.slx" ) ; 

    % live plot
    figure(2)
    plot(out.height.Time , out.height.Data, 'r-' , out.Target_height.Time , out.Target_height.Data , 'b-')
    title(['Kp:',num2str(Kp) ,'Ki:',num2str(Ki) ,'Kd:',num2str(Kd), 'N:',num2str(N) , 'FC:',num2str(filter_constant(2)) ]) ;
    ylim([0 1.44])

    E_kp = [ E_kp , [ Kp ; out.energy.Data(end) ] ] ; 

    error_Kp = [ error_Kp , [Kp ; out.RMSerror.Data(end) ] ] ; 

    progress = ( Kp - P(1) ) / (P(end) - P(1)) * 100             ; % <-- comment it if unnecessary
    form = '%3.1f percent of P secondary calculation is done. '  ; % <-- comment it if unnecessary
    fprintf(form , progress)    ;                                  % <-- comment it if unnecessary
    catch
    form = 'Function crashed at Kp = %f , skipped' ; 
    fprintf(form , Kp)
    end

end

error_Kp  = error_Kp(: , 2:end) ; 
E_kp      = E_kp( : , 2 : end ) ; 


%=========================
%
% Calculation of ( energy * error ) in future 
FACTOR_Kp = error_factor * error_Kp(2,:).^2 + energy_factor * E_kp(2,:).^2 ; 
%=========================

[ M , INDEX ] = min(FACTOR_Kp)  ;

% trnd plot
figure(1)
subplot(5,1,1);
plot(error_Kp(1,:) , FACTOR_Kp , '-*') ; 
title("FACTOR_Kp-curve")  ;
xlabel("Kp") ;
ylabel("FACTOR_Kp")

P = [ error_Kp(1,INDEX) - P_Sec_gap ; 1 ; error_Kp(1,INDEX) + P_Sec_gap ] ;   % re-define P range

% ======================Tertiary calculation ==============================

E_kp     = [0 ; 0 ]  ;

error_Kp = [ 0 ; 0 ] ;

for i = P(1) : P_Ter_gap : P(end)

    Kp = i ; 
    
    try
    out = sim( "better_controller.slx" ) ; 

    % live plot
    figure(2)
    plot(out.height.Time , out.height.Data, '-r' , out.Target_height.Time , out.Target_height.Data , '-b')
    title(['Kp:',num2str(Kp) ,'Ki:',num2str(Ki) ,'Kd:',num2str(Kd), 'N:',num2str(N) , 'FC:',num2str(filter_constant(2)) ]) ;
    ylim([0 1.44])

    E_kp = [ E_kp , [ Kp ; out.energy.Data(end) ] ] ; 

    error_Kp = [ error_Kp , [Kp ; out.RMSerror.Data(end) ] ] ; 

    progress = ( Kp - P(1) ) / (P(end) - P(1)) * 100             ; % <-- comment it if unnecessary
    form = '%3.1f percent of P tertiary calculation is done. '   ; % <-- comment it if unnecessary
    fprintf(form , progress)    ;                                  % <-- comment it if unnecessary
    catch
    form = 'Function crashed at Kp = %f , skipped' ; 
    fprintf(form , Kp)
    end

end

error_Kp  = error_Kp(: , 2:end) ; 
E_kp      = E_kp( : , 2 : end ) ; 


%=========================
%
% Calculation of ( energy * error ) in future 
FACTOR_Kp = error_factor * error_Kp(2,:).^2 + energy_factor * E_kp(2,:).^2 ; 
%=========================

[ M , INDEX ] = min(FACTOR_Kp)  ;

Kp = error_Kp(1,INDEX) ;                             % <-- Final define over Kp. 

% trend plot
figure(1)
subplot(5,1,1);
plot(error_Kp(1,:) , FACTOR_Kp , '-*') ; 
title("FACTOR_Kp-curve")  ;
xlabel("Kp") ;
ylabel("FACTOR_Kp")


%% ====================== Ki Tunning Sector [ ITS ] =====================================================================

E_ki     = [0 ; 0 ]  ;

error_Ki = [ 0 ; 0 ] ;

for i = I(1) : I_Pri_gap  : I(end)

    Ki = i ; 
    
    try
    out = sim( "better_controller.slx" ) ; 

    % live plot
    figure(2)
    plot(out.height.Time , out.height.Data, '-r' , out.Target_height.Time , out.Target_height.Data , '-b')
    title(['Kp:',num2str(Kp) ,'Ki:',num2str(Ki) ,'Kd:',num2str(Kd), 'N:',num2str(N) , 'FC:',num2str(filter_constant(2)) ]) ;
    ylim([0 1.44])

    E_ki = [ E_ki , [ Ki ; out.energy.Data(end) ] ] ; 

    error_Ki = [ error_Ki , [Ki ; out.RMSerror.Data(end) ] ] ; 

    progress = ( Ki - I(1) ) / (I(end) - I(1)) * 100           ; % <-- comment it if unnecessary
    form = '%3.1f percent of I primary calculation is done. '  ; % <-- comment it if unnecessary
    fprintf(form , progress)    ;                                % <-- comment it if unnecessary
    catch
    form = 'Function crashed at Ki = %f , skipped' ; 
    fprintf(form , Ki)
    end

end

error_Ki  = error_Ki(: , 2:end) ; 
E_ki      = E_ki( : , 2 : end ) ; 


%=========================
%
% Calculation of ( energy * error ) in future 
FACTOR_Ki = error_factor * error_Ki(2,:).^2 + energy_factor * E_ki(2,:).^2 ; 
%=========================

[ M , INDEX ] = min(FACTOR_Ki)  ;

% trend plot
figure(1)
subplot(5,1,2);
plot(error_Ki(1,:) , FACTOR_Ki , '-*') ;
title("FACTOR_Ki-curve,kp" )  ;
xlabel("Ki") ;
ylabel("FACTOR_Ki")

I = [ error_Ki(1,INDEX) - I_Pri_gap  ; 1 ; error_Ki(1,INDEX) + I_Pri_gap  ] ;   % re-define I range

% ========================= Secondary calculation =========================

E_ki     = [0 ; 0 ]  ;

error_Ki = [ 0 ; 0 ] ;

for i = I(1) : I_Sec_gap : I(end)

    Ki = i ; 
    
    try
    out = sim( "better_controller.slx" ) ; 

    % live plot
    figure(2)
    plot(out.height.Time , out.height.Data, '-r' , out.Target_height.Time , out.Target_height.Data , '-b')
    title(['Kp:',num2str(Kp) ,'Ki:',num2str(Ki) ,'Kd:',num2str(Kd), 'N:',num2str(N) , 'FC:',num2str(filter_constant(2)) ]) ;
    ylim([0 1.44])

    E_ki = [ E_ki , [ Ki ; out.energy.Data(end) ] ] ; 

    error_Ki = [ error_Ki , [Ki ; out.RMSerror.Data(end) ] ] ; 

    progress = ( Ki - I(1) ) / (I(end) - I(1)) * 100             ; % <-- comment it if unnecessary
    form = '%3.1f percent of I secondary calculation is done. '  ; % <-- comment it if unnecessary
    fprintf(form , progress)    ;                                  % <-- comment it if unnecessary
    catch
    form = 'Function crashed at Ki = %f , skipped' ; 
    fprintf(form , Ki)
    end

    

end

error_Ki  = error_Ki(: , 2:end) ; 
E_ki      = E_ki( : , 2 : end ) ; 


%=========================
%
% Calculation of ( energy * error ) in future 
FACTOR_Ki = error_factor * error_Ki(2,:).^2 + energy_factor * E_ki(2,:).^2 ; 
%=========================

[ M , INDEX ] = min(FACTOR_Ki)  ;

% trend plot
figure(1)
subplot(5,1,2);
plot(error_Ki(1,:) , FACTOR_Ki , '-*') ;
title("FACTOR_Ki-curve")  ;
xlabel("Ki") ;
ylabel("FACTOR_Ki")

I = [ error_Ki(1,INDEX) - I_Sec_gap ; 1 ; error_Ki(1,INDEX) + I_Sec_gap ] ;   % re-define I range

% ======================Tertiary calculation ==============================

E_ki     = [0 ; 0 ]  ;

error_Ki = [ 0 ; 0 ] ;

for i = I(1) : I_Ter_gap : I(end)

    Ki = i ; 
    
    try
    out = sim( "better_controller.slx" ) ; 

    % live plot
    figure(2)
    plot(out.height.Time , out.height.Data, '-r' , out.Target_height.Time , out.Target_height.Data , '-b')
    title(['Kp:',num2str(Kp) ,'Ki:',num2str(Ki) ,'Kd:',num2str(Kd), 'N:',num2str(N) , 'FC:',num2str(filter_constant(2)) ]) ;
    ylim([0 1.44])

    E_ki = [ E_ki , [ Ki ; out.energy.Data(end) ] ] ; 

    error_Ki = [ error_Ki , [Ki ; out.RMSerror.Data(end) ] ] ; 

    progress = ( Ki - I(1) ) / (I(end) - I(1)) * 100             ; % <-- comment it if unnecessary
    form = '%3.1f percent of I tertiary calculation is done. '   ; % <-- comment it if unnecessary
    fprintf(form , progress)    ;                                  % <-- comment it if unnecessary
    catch
    form = 'Function crashed at Ki = %f , skipped' ; 
    fprintf(form , Ki)
    end

end

error_Ki  = error_Ki(: , 2:end) ; 
E_ki      = E_ki( : , 2 : end ) ; 


%=========================
%
% Calculation of ( energy * error ) in future 
FACTOR_Ki = error_factor * error_Ki(2,:).^2 + energy_factor * E_ki(2,:).^2 ; 
%=========================

[ M , INDEX ] = min(FACTOR_Ki)  ;

Ki = error_Ki(1,INDEX) ;                             % <-- Final define over Ki. 

% trend plot
figure(1)
subplot(5,1,2);
plot(error_Ki(1,:) , FACTOR_Ki , '-*') ;
title("FACTOR_Ki-curve")  ;
xlabel("Ki") ;
ylabel("FACTOR_Ki")

%% ====================== Kd Tunning Sector [ DTS ] =====================================================================

E_kd     = [0 ; 0 ]  ;

error_Kd = [ 0 ; 0 ] ;

for i = D(1) : D_Pri_gap : D(end)

    Kd = i ; 

    try
    out = sim( "better_controller.slx" ) ; 

    % live plot
    figure(2)
    plot(out.height.Time , out.height.Data, '-r' , out.Target_height.Time , out.Target_height.Data , '-b')
    title(['Kp:',num2str(Kp) ,'Ki:',num2str(Ki) ,'Kd:',num2str(Kd), 'N:',num2str(N) , 'FC:',num2str(filter_constant(2)) ]) ;
    ylim([0 1.44])

    E_kd = [ E_kd , [ Kd ; out.energy.Data(end) ] ] ; 

    error_Kd = [ error_Kd , [Kd ; out.RMSerror.Data(end) ] ] ; 

    progress = ( Kd - D(1) ) / (D(end) - D(1)) * 100           ; % <-- comment it if unnecessary
    form = '%3.1f percent of D primary calculation is done. '  ; % <-- comment it if unnecessary
    fprintf(form , progress)    ;                                % <-- comment it if unnecessary

    catch
    form = 'Function crashed at Kd = %f , skipped' ; 
    fprintf(form , Kd)
    end
    

end

error_Kd  = error_Kd(: , 2:end) ; 
E_kd      = E_kd( : , 2 : end ) ; 


%=========================
%
% Calculation of ( energy * error ) in future 
FACTOR_Kd = error_factor * error_Kd(2,:).^2 * 10 + energy_factor * E_kd(2,:).^2 ; 
%=========================

[ M , INDEX ] = min(FACTOR_Kd)  ;

% trend plot
figure(1)
subplot(5,1,3);
plot(error_Kd(1,:) , FACTOR_Kd , '-*') ;
title("FACTOR_Kd-curve")  ;
xlabel("Kd") ;
ylabel("FACTOR_Kd")

D = [ error_Kd(1,INDEX) - D_Pri_gap ; 1 ; error_Kd(1,INDEX) + D_Pri_gap ] ;   % re-define I range

% ========================= Secondary calculation =========================

E_kd     = [0 ; 0 ]  ;

error_Kd = [ 0 ; 0 ] ;

for i = D(1) : D_Sec_gap : D(end)

    Kd = i ; 
    
    try
    out = sim( "better_controller.slx" ) ; 

    % live plot
    figure(2)
    plot(out.height.Time , out.height.Data, '-r' , out.Target_height.Time , out.Target_height.Data , '-b')
    title(['Kp:',num2str(Kp) ,'Ki:',num2str(Ki) ,'Kd:',num2str(Kd), 'N:',num2str(N) , 'FC:',num2str(filter_constant(2)) ]) ;
    ylim([0 1.44])

    E_kd = [ E_kd , [ Kd ; out.energy.Data(end) ] ] ; 

    error_Kd = [ error_Kd , [Kd ; out.RMSerror.Data(end) ] ] ; 

    progress = ( Kd - D(1) ) / (D(end) - D(1)) * 100             ; % <-- comment it if unnecessary
    form = '%3.1f percent of D secondary calculation is done. '  ; % <-- comment it if unnecessary
    fprintf(form , progress)    ;                                  % <-- comment it if unnecessary
    catch
    form = 'Function crashed at Kd = %f , skipped' ; 
    fprintf(form , Kd)
    end

end

error_Kd  = error_Kd(: , 2:end) ; 
E_kd      = E_kd( : , 2 : end ) ; 


%=========================
%
% Calculation of ( energy * error ) in future 
FACTOR_Kd = error_factor * error_Kd(2,:).^2  + energy_factor * E_kd(2,:).^2 ; 
%=========================

[ ~ , INDEX ] = min(FACTOR_Kd)  ;

% trend plot
figure(1)
subplot(5,1,3);
plot(error_Kd(1,:) , FACTOR_Kd , '-*') ;
title("FACTOR_Kd-curve")  ;
xlabel("Kd") ;
ylabel("Factor_Kd")

Kd = error_Kd(1,INDEX) ;                             % <-- Final define over Ki. 

%% ====================== Auto Filter Constant (N) Navigator [ ANN ] =====================================================

E_N     = [0 ; 0 ]  ;

error_N = [ 0 ; 0 ] ;

for j = N_range(1) : N_Pri_gap : N_range(end) 

    N = j ; 

    try
    out      = sim( "better_controller.slx" ) ; 

    % live plot
    figure(2)
    plot(out.height.Time , out.height.Data, '-r' , out.Target_height.Time , out.Target_height.Data , '-b')
    title(['Kp:',num2str(Kp) ,'Ki:',num2str(Ki) ,'Kd:',num2str(Kd), 'N:',num2str(N) , 'FC:',num2str(filter_constant(2)) ]) ;
    ylim([0 1.44])

    E_N     = [ E_N , [ N ; out.energy.Data(end) ] ] ; 

    error_N = [ error_N , [N ; out.RMSerror.Data(end) ] ] ; 

    progress = ( N - N_range(1) ) / (N_range(end) - N_range(1)) * 100    ; % <-- comment it if unnecessary
    form = '%3.1f percent of N primary calculation is done. '            ; % <-- comment it if unnecessary
    fprintf(form , progress)    ;                                          % <-- comment it if unnecessary
    catch
    form = 'Function crashed at N = %f , skipped' ; 
    fprintf(form , N)
    end
    

end

error_N  = error_N(: , 2:end) ; 
E_N      = E_N( : , 2 : end ) ; 

FACTOR_N = error_factor * error_N(2,:).^2 + energy_factor * E_N(2,:).^2 ; 

[ M , INDEX ] = min(FACTOR_N ) ; 

N = error_N(1,INDEX) ;                              % <-- Final define over Ki. 

% trend plot
figure(1)
subplot(5,1,4);
plot(error_N(1,:) , FACTOR_N , '-*') ;
title("FACTOR_N-curve")  ;
xlabel("N") ;
ylabel("FACTOR_N")


%% ====================== Auto Filter Constant Finder [ AFCOF ] ==========================================================

error_FCO   = [ 0 ; 0 ] ;              % PRE-generate array for error value to fill in. 
E_FCO       = [ 0 ; 0 ] ; 

for count = 1 : 1 : length(FCO)

    filter_constant = [ 1 , FCO(count) ] ;    % Used for "From Workspace" to fill the variable in. 
                                            % NOTICE ONLY the second value count.
    try
    out = sim("better_controller.slx")  ;   % Excute control system

    % live plot
    figure(2)
    plot(out.height.Time , out.height.Data, '-r' , out.Target_height.Time , out.Target_height.Data , '-b')
    title(['Kp:',num2str(Kp) ,'Ki:',num2str(Ki) ,'Kd:',num2str(Kd), 'N:',num2str(N) , 'FC:',num2str(filter_constant(2)) ]) ;    
    ylim([0 1.44])

    error_FCO = [ error_FCO , [ FCO(count) ; out.RMSerror.Data(end) ] ]  ; % Fill the last value of the DATA into error
    
    E_FCO     = [ E_FCO     , [ FCO(count) ; out.energy.Data(end)   ] ]  ; 

    progress = ( filter_constant(2) - FCO(1) ) / (FCO(end) - FCO(1)) * 100             ; % <-- comment it if unnecessary
    form = '%3.1f percent of filter cut off frequency primary calculation is done. '   ; % <-- comment it if unnecessary
    fprintf(form , progress)    ;                                                        % <-- comment it if unnecessary
    catch
    form = 'Function crashed at FC = %f , skipped' ; 
    fprintf(form , FCO(count))
    end

   
end

% ================ AUTOMATION FILLING ZONE [ AFZ ] =======================

error_FCO = error_FCO(: , 2:end) ; 
E_FCO      = E_FCO( : , 2 : end ) ; 

FACTOR_FCO = error_factor * error_FCO(2,:).^2 + energy_factor * E_FCO(2,:).^2 ; 

[M , INDEX ]        = min(FACTOR_FCO) ;              % Identify Minimium value(M) and the corresponding position(I)

filter_constant = [1 , error_FCO(1,INDEX)] ;         % RE-write filter constant.


% HERE TO EXCUTE THE SIMULINK WITH NEW FILTER CONSTANT (WITH MINIMIUM ERROR)

out = sim("better_controller.slx") ;
% final plot
figure(2)
plot(out.height.Time , out.height.Data, '-r' , out.Target_height.Time , out.Target_height.Data , '-b')
title(['Kp:',num2str(Kp) ,'Ki:',num2str(Ki) ,'Kd:',num2str(Kd), 'N:',num2str(N) , 'FC:',num2str(filter_constant(2)) ]) ;    
ylim([0 1.44])

% trend plot
figure(1)
subplot(5,1,5);
plot(error_FCO(1,:) , FACTOR_FCO , '-*') ;
title("FACTOR_FCO-curve")  ;
xlabel("FC") ;
ylabel("FACTOR_FCO")



%% ====================== DRAFT ZONE [ LOG ]===========================
% when initial Ki = 180 , Kd = 50 , N = 34 , Filter cut-off constant = 20 :
% Error roughly 0.09 , FLYMODE = 4
% Kp = 110 ; 
% Ki = 60  ;
% Kd = 50  ; 
% N  = 34  ;
% filter_constant =[ 1, 32 ] ; 
% sim("better_controller.slx")

% when initial Ki = 60 , Kd = 50 , N = 34 , Filter cut-off constant = 32 :
% Error = 0.05808 , FLYMODE = 4
% * NOTICE, during calculation, range of P has to mannually changed as
% script frequently halt for simulation (guess just toke too long). 
% Kp = 298 ; 
% Ki = 290 ;
% Kd = 85  ; 
% N  = 34  ;
% filter_constant =[ 1, 32 ] ; 
% sim("better_controller.slx")

% when initial Ki = 290 , Kd = 85 , N = 34 , Filter cut-off constant = 32 :
% Error = 0.0572 , FLYMODE = 4
% Kp = 430 ; 
% Ki = 330 ;
% Kd = 85  ; 
% N  = 34  ;
% filter_constant =[ 1, 32 ] ; 
% sim("better_controller.slx")

% when initial Ki = 330 , Kd = 85 , N = 34 , Filter cut-off constant = 32 :
% Error = 0.0572 , FLYMODE = 4
% Kp = 430 ; 
% Ki = 330 ;
% Kd = 85  ; 
% N  = 34  ;
% filter_constant =[ 1, 32 ] ; 
% sim("better_controller.slx")

% when initial Ki = 300 , Kd = 90 , N = 34 , Filter cut-off constant = 32 :
% Error = 0.09405 , FLYMODE = 1 , samplingtime =>30s
% Kp = 407 ; 
% Ki = 300 ;
% Kd = 90  ; 
% N  = 34  ;
% filter_constant =[ 1, 32 ] ; 
% sim("better_controller.slx")

% when initial Ki = 140 , Kd = 50 , N = 34 , Filter cut-off constant = 32 :
% Error = 0.09405 , FLYMODE = 4 , samplingtime =>70s
% Kp = 130 ; 
% Ki = 140 ;
% Kd = 8   ; 
% N  = 6   ;
% filter_constant =[ 1, 20 ] ; 
% sim("better_controller.slx"）

% testing data
% Kp = 254 ; 
% Ki = 251 ;
% Kd = 46   ; 
% N  = 16   ;
% filter_constant =[ 1, 79 ] ; 
% sim("better_controller.slx")
%     figure(2)
%     plot(out.height.Time , out.height.Data, '-r' , out.Target_height.Time , out.Target_height.Data , '-b')
%     title(['Kp:',num2str(Kp) ,'Ki:',num2str(Ki) ,'Kd:',num2str(Kd), 'N:',num2str(N) , 'FC:',num2str(filter_constant(2)) ]) ; 


% when Ki = 125 , Kd = 50 , N =34 , FC = 32 ; NEW MASS:
% ERROR = 0.06149, FLYMODE: 1
% Kp = 209 ; 
% Ki = 186 ; 
% Kd = 38  ;
% N  = 36  ;
% filter_constant = [1, 32] ; 
% sim("better_controller.slx")
% figure(2)
% plot(out.height.Time , out.height.Data, '-r' , out.Target_height.Time , out.Target_height.Data , '-b')
% title(['Kp:',num2str(Kp) ,'Ki:',num2str(Ki) ,'Kd:',num2str(Kd), 'N:',num2str(N) , 'FC:',num2str(filter_constant(2)) ]) ; 

% when Ki = 125 , Kd = 50 , N =34 , FC = 32 ; NEW MASS:
% ERROR = 0.06242 ,FLYMODE: 1
% Kp = 180 ; 
% Ki = 130 ; 
% Kd = 35  ;
% N  = 38  ;
% filter_constant = [1 , 32] ; 
% sim("better_controller.slx")
% figure(2)
% plot(out.height.Time , out.height.Data, '-r' , out.Target_height.Time , out.Target_height.Data , '-b')
% title(['Kp:',num2str(Kp) ,'Ki:',num2str(Ki) ,'Kd:',num2str(Kd), 'N:',num2str(N) , 'FC:',num2str(filter_constant(2)) ]) ; 

% using old data with NEW MASS other flymode:
% ERROR = 0.07176 ,FLYMODE: 1
% Kp = 430 ; 
% Ki = 330 ;
% Kd = 85  ; 
% N  = 34  ;
% filter_constant =[ 1, 32 ] ; 
% sim("better_controller.slx")
% figure(2)
% plot(out.height.Time , out.height.Data, '-r' , out.Target_height.Time , out.Target_height.Data , '-b')
% title(['Kp:',num2str(Kp) ,'Ki:',num2str(Ki) ,'Kd:',num2str(Kd), 'N:',num2str(N) , 'FC:',num2str(filter_constant(2)) ]) ; 

% using old data with NEW MASS:
% ERROR = 0.07217 ,FLYMODE:4
% Kp = 430 ; 
% Ki = 330 ; 
% Kd = 85  ;
% N  = 34  ;
% filter_constant = [1 , 32] ; 
% out = sim("better_controller.slx") ; 
% figure(2)
% plot(out.height.Time , out.height.Data, '-r' , out.Target_height.Time , out.Target_height.Data , '-b')
% title(['Kp:',num2str(Kp) ,'Ki:',num2str(Ki) ,'Kd:',num2str(Kd), 'N:',num2str(N) , 'FC:',num2str(filter_constant(2)) ]) ; 

% when Ki = 130 , Kd = 35 , N =38 , FC = 32 ; NEW MASS:
% ERROR = 0.06157 ; change kp to 172 prevent overshot with slightly higher error
% Kp = 178 ; 
% Ki = 188 ; 
% Kd = 35  ;
% N  = 38  ;
% filter_constant = [1 ,  32] ; 
% out = sim("better_controller.slx") ; 
% figure(2)
% plot(out.height.Time , out.height.Data, '-r' , out.Target_height.Time , out.Target_height.Data , '-b')
% title(['Kp:',num2str(Kp) ,'Ki:',num2str(Ki) ,'Kd:',num2str(Kd), 'N:',num2str(N) , 'FC:',num2str(filter_constant(2)) ]) ; 

% when Ki = 186 , Kd = 38 , N =36 , FC = 32 ; NEW MASS:
% ERROR = 0.
% Kp = 256 ; 
% Ki = 188 ; 
% Kd = 50  ;
% N  = 32  ;
% filter_constant = [1 , 32 ] ; 
% out = sim("better_controller.slx") ; 
% figure(2)
% plot(out.height.Time , out.height.Data, '-r' , out.Target_height.Time , out.Target_height.Data , '-b')
% title(['Kp:',num2str(Kp) ,'Ki:',num2str(Ki) ,'Kd:',num2str(Kd), 'N:',num2str(N) , 'FC:',num2str(filter_constant(2)) ]) ;

% when Ki = 186 , Kd = 38 , N =36 , FC = 32 ; NEW MASS: STOP TIME: 10S
% ERROR = 0.1517
% Kp = 195 ; 
% Ki = 150 ; 
% Kd = 37  ;
% N  = 37  ;
% filter_constant = [1 , 32 ] ; 
% out = sim("better_controller.slx") ; 
% figure(2)
% plot(out.height.Time , out.height.Data, '-r' , out.Target_height.Time , out.Target_height.Data , '-b')
% title(['Kp:',num2str(Kp) ,'Ki:',num2str(Ki) ,'Kd:',num2str(Kd), 'N:',num2str(N) , 'FC:',num2str(filter_constant(2)) ]) ;

% when Ki = 150 , Kd = 37 , N =37 , FC = 32 ; NEW MASS: STOP TIME: 10S
% ERROR = 0.1505 ; with significant overshot in FLYMODE 4, ST:70S, ERR:0.06809
% Kp = 195 ; 
% Ki = 199 ; 
% Kd = 37  ;
% N  = 37  ;
% filter_constant = [1 , 32 ] ; 
% out = sim("better_controller.slx") ; 
% figure(2)
% plot(out.height.Time , out.height.Data, '-r' , out.Target_height.Time , out.Target_height.Data , '-b')
% title(['Kp:',num2str(Kp) ,'Ki:',num2str(Ki) ,'Kd:',num2str(Kd), 'N:',num2str(N) , 'FC:',num2str(filter_constant(2)) ]) ;

% when Ki = 199 , Kd = 37 , N =37 , FC = 32 ; NEW MASS: STOP TIME: 10S ---> GIVE THE SAME PID, N, FC values.
% ERROR = 0. ; play around only
% Kp = 195 ; 
% Ki = 199 ; 
% Kd = 45  ;
% N  = 37  ;
% filter_constant = [1 , 45 ] ; 
% out = sim("better_controller.slx") ; 
% figure(2)
% plot(out.height.Time , out.height.Data, '-r' , out.Target_height.Time , out.Target_height.Data , '-b')
% title(['Kp:',num2str(Kp) ,' Ki:',num2str(Ki) ,' Kd:',num2str(Kd), ' N:',num2str(N) , ' FC:',num2str(filter_constant(2)) ]) ;

% when Ki = 199 , Kd = 37 , N =37 , FC = 32 ; NEW MASS
% ERROR = 0.06651 , E = 12650 ; FLYMODE:4 , ST:70S
% Kp = 88  ; 
% Ki = 146 ; 
% Kd = 21  ;
% N  = 24  ;
% filter_constant = [1 , 33 ] ; 
% out = sim("better_controller.slx") ; 
% figure(2)
% plot(out.height.Time , out.height.Data, '-r' , out.Target_height.Time , out.Target_height.Data , '-b')
% title(['Kp:',num2str(Kp) ,' Ki:',num2str(Ki) ,' Kd:',num2str(Kd), ' N:',num2str(N) , ' FC:',num2str(filter_constant(2)) ]) ;

% when Ki = 146 , Kd = 21 , N =24 , FC = 33 ; NEW MASS
% ERROR = 0.06650 , E = 12580 ; FLYMODE:4 , ST:70S
% Kp = 66  ; 
% Ki = 125 ; 
% Kd = 21  ;
% N  = 15  ;                       % when n=24 , error:0.6554 , E:12600
% filter_constant = [1 , 33 ] ; 
% out = sim("better_controller.slx") ; 
% figure(2)
% plot(out.height.Time , out.height.Data, '-r' , out.Target_height.Time , out.Target_height.Data , '-b')
% title(['Kp:',num2str(Kp) ,' Ki:',num2str(Ki) ,' Kd:',num2str(Kd), ' N:',num2str(N) , ' FC:',num2str(filter_constant(2)) ]) ;

% when Ki = 146 , Kd = 28 , N =32 , FC = 33 ; NEW MASS:0.05549
% ERROR = 0.1506 , E = 1891  ; FLYMODE:1 , ST:10S
% Kp = 156 ;
% Ki = 155 ; 
% Kd = 26  ;
% N  = 22  ;                       
% filter_constant = [1 , 29 ] ; 
% out = sim("better_controller.slx") ; 
% figure(2)
% plot(out.height.Time , out.height.Data, '-r' , out.Target_height.Time , out.Target_height.Data , '-b')
% title(['Kp:',num2str(Kp) ,' Ki:',num2str(Ki) ,' Kd:',num2str(Kd), ' N:',num2str(N) , ' FC:',num2str(filter_constant(2)) ]) ;

% testing propose(initial data from others work) ; NEW MASS:0.05549
% ERROR = 0.06788 , E = 13300  ; FLYMODE:4 , ST:71S
% Kp = 165 ;
% Ki = 143 ; 
% Kd = 50  ;
% N  = 35  ;                       
% filter_constant = [1 , 57 ] ; 
% out = sim("better_controller.slx") ; 
% figure(2)
% plot(out.height.Time , out.height.Data, '-r' , out.Target_height.Time , out.Target_height.Data , '-b')
% title(['Kp:',num2str(Kp) ,' Ki:',num2str(Ki) ,' Kd:',num2str(Kd), ' N:',num2str(N) , ' FC:',num2str(filter_constant(2)) ]) ;

% when Ki = 143 , Kd = 50 , N =34 , FC = 57 ;  NEW MASS:0.05794
% ERROR = 0.5707 , E = 13130  ; FLYMODE:4 , ST:71S      %when FC = 66 , error = 0.05482 , E = 13440
% Kp = 285 ;
% Ki = 265 ; 
% Kd = 50  ;
% N  = 34  ;                       
% filter_constant = [1 , 29 ] ;     % FC = 29 When error_factor is 10e+9 , FC = 66 when that is 10e+10 
% out = sim("better_controller.slx") ; 
% figure(2)
% plot(out.height.Time , out.height.Data, '-r' , out.Target_height.Time , out.Target_height.Data , '-b')
% title(['Kp:',num2str(Kp) ,' Ki:',num2str(Ki) ,' Kd:',num2str(Kd), ' N:',num2str(N) , ' FC:',num2str(filter_constant(2)) ]) ;

% when Ki = 143 , Kd = 50 , N =34 , FC = 57 ;  NEW MASS:0.05794
% ERROR = 0.05751 , E = 12830  ; FLYMODE:4 , ST:71S
% Kp = 128 ;
% Ki = 225 ; 
% Kd = 50  ;
% N  = 12  ;                       
% filter_constant = [1 , 70 ] ;     
% out = sim("better_controller.slx") ; 
% figure(2)
% plot(out.height.Time , out.height.Data, '-r' , out.Target_height.Time , out.Target_height.Data , '-b')
% title(['Kp:',num2str(Kp) ,' Ki:',num2str(Ki) ,' Kd:',num2str(Kd), ' N:',num2str(N) , ' FC:',num2str(filter_constant(2)) ]) ;

% when Ki = 143 , Kd = 50 , N =34 , FC = 57 ;  NEW MASS:0.05794
% ERROR = 0.05561 , E = 12770  ; FLYMODE:4 , ST:71S
% Kp = 115 ;
% Ki = 175 ; 
% Kd = 50  ;
% N  = 12  ;                       
% filter_constant = [1 , 70 ] ;     
% out = sim("better_controller.slx") ; 
% figure(2)
% plot(out.height.Time , out.height.Data, '-r' , out.Target_height.Time , out.Target_height.Data , '-b')
% title(['Kp:',num2str(Kp) ,' Ki:',num2str(Ki) ,' Kd:',num2str(Kd), ' N:',num2str(N) , ' FC:',num2str(filter_constant(2)) ]) ;

% testing from other's data;  NEW MASS:0.05794 !!!NEW VARIENCE!!!
% ERROR = 0.0 , E =   ; FLYMODE:4 , ST:71S
% Kp = 157 ;
% Ki = 83  ; 
% Kd = 61  ;
% N  = 35  ;                       
% filter_constant = [1 , 32 ] ;     
% out = sim("better_controller.slx") ; 
% figure(2)
% plot(out.height.Time , out.height.Data, '-r' , out.Target_height.Time , out.Target_height.Data , '-b')
% title(['Kp:',num2str(Kp) ,' Ki:',num2str(Ki) ,' Kd:',num2str(Kd), ' N:',num2str(N) , ' FC:',num2str(filter_constant(2)) ]) ;


% when Ki = 175 , Kd = 50 , N =12 , FC = 70 ;  NEW MASS:0.05794 
% ERROR = 0.05667 , E = 12870  ; FLYMODE:4 , ST:71S
% Kp = 151 ;
% Ki = 158 ; 
% Kd = 50  ;
% N  = 12  ;                       
% filter_constant = [1 , 70 ] ;     
% out = sim("better_controller.slx") ; 
% figure(2)
% plot(out.height.Time , out.height.Data, '-r' , out.Target_height.Time , out.Target_height.Data , '-b')
% title(['Kp:',num2str(Kp) ,' Ki:',num2str(Ki) ,' Kd:',num2str(Kd), ' N:',num2str(N) , ' FC:',num2str(filter_constant(2)) ]) ;
% ylim([0 1.44])

% when Ki = 158 , Kd = 50 , N =12 , FC = 70 ;  NEW MASS:0.05794 
% ERROR = 0.05546 , E = 12900  ; FLYMODE:4 , ST:71S
% Kp = 144 ;
% Ki = 275 ; 
% Kd = 50  ;
% N  = 15  ;                       
% filter_constant = [1 ,  51] ;     
% out = sim("better_controller.slx") ; 
% figure(2)
% plot(out.height.Time , out.height.Data, '-r' , out.Target_height.Time , out.Target_height.Data , '-b')
% title(['Kp:',num2str(Kp) ,' Ki:',num2str(Ki) ,' Kd:',num2str(Kd), ' N:',num2str(N) , ' FC:',num2str(filter_constant(2)) ]) ;
% ylim([0 1.44])

% TESTING FROM OTHER'S DATA ;  NEW MASS:0.05794  ; THROTTLE UPPER LIMIT: 100
% ERROR = 0.05546 , E = 12900  ; FLYMODE:4 , ST:71S
% Kp = 105 ;
% Ki = 145 ; 
% Kd = 26  ;
% N  = 35  ;                       
% filter_constant = [1 , 36] ;     
% out = sim("better_controller.slx") ; 
% figure(2)
% plot(out.height.Time , out.height.Data, '-r' , out.Target_height.Time , out.Target_height.Data , '-b')
% title(['Kp:',num2str(Kp) ,' Ki:',num2str(Ki) ,' Kd:',num2str(Kd), ' N:',num2str(N) , ' FC:',num2str(filter_constant(2)) ]) ;
% ylim([0 1.44])

% TESTING FROM OTHER'S DATA ;  NEW MASS:0.05794 ; THROTTLE UPPER LIMIT: 93
% ERROR = 0.0 , E =   ; FLYMODE:4 , ST:71S
Kp = 63  ;
Ki = 122 ; 
Kd = 25  ;
N  = 25  ;                       
filter_constant = [1 ,65 ] ;     
out = sim("better_controller.slx") ; 
figure(2)
plot(out.height.Time , out.height.Data, '-r' , out.Target_height.Time , out.Target_height.Data , '-b')
title(['Kp:',num2str(Kp) ,' Ki:',num2str(Ki) ,' Kd:',num2str(Kd), ' N:',num2str(N) , ' FC:',num2str(filter_constant(2)) ]) ;
ylim([0 1.44])


%   mass    |    mu     |   static friction  |   RMS error   |   Energy
%  1.1*M    |   0.17    |        + 10 %      |    0.05946    |   13805
%  1.1*M    |   0.17    |        - 10 %      |    0.05946    |   13805
%  1.1*M    |   0.11    |        + 10 %      |    0.05988    |   13807
%  1.1*M    |   0.11    |        - 10 %      |    0.05988    |   13807
%  0.9*M    |   0.17    |        + 10 %      |    0.05423    |   10945  
%  0.9*M    |   0.17    |        - 10 %      |    0.05423    |   10945
%  0.9*M    |   0.11    |        + 10 %      |    0.05202    |   10953
%  0.9*M    |   0.11    |        - 10 %      |    0.05202    |   10953 

