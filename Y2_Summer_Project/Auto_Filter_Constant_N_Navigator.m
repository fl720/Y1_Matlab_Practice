% clear
% clc

%   1, !!! REMEMBER SET PARAMETER OF FILTER TO N IN PID CONTROLLER !!!      Y/N?:
%   2, !!! REMEMBER PUT "TO WORKSPACE" NEXT TO FILTER ERROR !!!             Y/N?:
%   3, !!! REMEMBER RENAME OUTSIM TO "RMSerror" !!!                         Y/N?:
%   4, !!! REMEMBER PUT "TO WORKSPACE" NEXT TO ENERGY DISPAY !!!            Y/N?:
%   5, !!! REMEMBER RENAME OUTSIM TO "energy" !!!                           Y/N?:


% ANN ( Auto Filter Constant (N) Navigator ) aim to tune the Filter
% Constant in PID CONTROLLER (N).


%% =========================== HANGER =====================================

Kp = 110 ;
Ki = 60  ;
Kd = 50  ;
filter_constant = [1 ,20]  ; 


%% ================ SEARCHING THRESHOLD-VALUE ZONE [ STZ ] ================        

E_N     = [0 ; 0 ]  ;

error_N = [ 0 ; 0 ] ;

for N = 5 : 1 : 50 

    N = N ; 

    out      = sim( "better_controller.slx" ) ; 

    E_N     = [ E_N , [ N ; out.energy.Data(end) ] ] ; 

    error_N = [ error_N , [N ; out.RMSerror.Data(end) ] ] ; 

    disp(N) 

end

%% ================ AUTOMATION FILLING ZONE [ AFZ ] =======================

error_N  = error_N(: , 2:end) ; 

[M , I ] = min(error_N(2,: ) ) ; 

N = error_N(1,I) ; 

sim("better_controller.slx" ) ; 

%% ================ DATA VISUALLISING ZONE [ DVZ ] ========================


plot(error_N(1,:) , error_N(2,:) , '-*' , error_N(1,I) , error_N(2,I) , ' r*') ;
xlabel('values of the contant for filter')
ylabel('RMS error')

title('Kp = WF , Ki = WF , Kd = WF , Filter Cut-off Frequency = WF ; FLYINGMODE = wf  ')  % <-- Fill the numbers if apply
grid on ;
grid minor ; 





