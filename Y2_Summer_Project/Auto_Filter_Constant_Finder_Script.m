% clc
% clear    <<--- COMMENT IT TO PREVENT CLEAR OF PID VALUES

%   1, !!! REMEMBER PUT "FROM WORKSPACE" IN FILTER SECTION !!!      Y/N?:
%   2, !!! REMEMBER CHANGE PARAMETER TO "filter_constant" !!!       Y/N?:
%   3, !!! REMEMBER PUT "TO WORKSPACE" NEXT TO FILTER ERROR !!!     Y/N?:

% AFCOF(Auto Filter Constant Finder) aim to find filter constant with
% minimium error within given range. 

%% ================ SEARCHING THRESHOLD-VALUE ZONE [ STZ ] ================


a       = [ 10 : 1 : 80]    ;               % inputs of filter constant 
                                            % [INITIAL VALUE : INTERVAL : FINAL VALUE]

error_N   = zeros(length(a),1) ;              % PRE-generate array for error value to fill in. 

for count = 1 : 1 : length(a)

    filter_constant = [ 1 , a(count) ] ;    % Used for "From Workspace" to fill the variable in. 
                                            % NOTICE ONLY the second value count.
    
    out = sim("better_controller.slx")  ;   % Excute control system

    error_N(count) = out.RMSerror.Data(end) ; % Fill the last value of the DATA into error
   
end

%% ================ AUTOMATION FILLING ZONE [ AFZ ] =======================

[M , INDEX ]        = min(error_N) ;              % Identify Minimium value(M) and the corresponding position(I)

filter_constant = [1 , a(INDEX)] ;              % RE-write filter constant.


% HERE TO EXCUTE THE SIMULINK WITH NEW FILTER CONSTANT (WITH MIN ERROR)

sim("better_controller.slx") ;

%% ================ DATA VISUALLISING ZONE [ DVZ ] ========================
figure(3)
plot( a , error_N, '-*' , a(I) , error_N(I) , 'r* ')
xlabel('values of the contant for filter')
ylabel('RMS error')
title('Kp = 180 , Ki = 140 , Kd = 50 , N = 34 ; FLYINGMODE = 1  ')  % <-- Fill the numbers if apply
grid on ; 
grid minor ;                                              % increase grid density
legend('Error for N from 10 to 60' , 'Minimium Error')
