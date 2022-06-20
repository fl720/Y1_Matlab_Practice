# Y2_Summer_Project

This file is for codes being used in Year 2 undergraduate summer term group project. 
=============================================================================================================================================

**PROJECT NAME:** Duocoputer Design 

**AIM         :** Design a simulation system to simualate posible scenario for the drone and having it as close to test condition as possible. Then using the simualtion system to tune the paramters in the PID controller and parameters for the constant. 


## CONTENT 

 - Auto_Filter_Constant_Finder_Script.m

 - Auto_Filter_Constant_N_Navigator.m

 - Auto_Tunning_for_PID_and_Filter_Constant_Device.m

 - better_controller.slx

 - samplemission.mat

## Auto_Filter_Constant_Finder_Script.m

**ABBREVIATION:** AFCOF

**DISCRIPTION:** First generation of the script to find filter cut-off frequency for the discrete low pass filter in the control system. 

**FEATURES:** Able to plot the simulated RMS error against filter cut-off frequencies (inputs) at the end at given Kp, Ki, Kd and PID filter constant (N) values.

**PRECAUTIONS:** 
 - 1, Need to manually press "ctrl + c" to stop current simulation process when the simualtion is crashed/paused. Then, input subsequent number range into the initial values (a). Restart the process by using section break to prevent previous data being cleared from the working space. 

 - 2, Read the checklist and type Y at each requirement to comfirm before running the AFCOF.

## Auto_Filter_Constant_N_Navigator.m

**ABBREVIATION:** ANN

**DISCRIPTION:** Auto-filling filter constant in the PID controller within given range. Upgraded from AFCOF, contaning more features as required by group.

**FEATURES:** Able to plot the simulated RMS error against filter constant (inputs) at the end at given Kp, Ki, Kd and filter cut-off frequency values. It will also give energy consumption in the output data. However, plot of energy consumption against filter constant is not provided. 

**PRECAUTIONS:** 
 - 1, Need to manually press "ctrl + c" to stop current simulation process when the simualtion is crashed/paused. Then, input subsequent number range into the initial values (a). Restart the process by using section break to prevent previous data being cleared from the working space. 

 - 2, Read the checklist and type Y at each requirement to comfirm before running the ANN.

## Auto_Tunning_for_PID_and_Filter_Constant_Device.m

**ABBREVIATION:** ATFIELD

**DISCRIPTION:** Combination of AFCOF, ANN and auto tunning system of Kp, Ki and Kd values at the PID controller. 

**FEATURES:** Final version of the auto tunning script.
 - 1, No need to mannually press "ctrl + c" when the simulation crashed. The script will escape this perticullar number.

 - 2, A running plots will show a cost function result against the input values. Illustrate the trend of changing the parameters in the range being given. 

 - 3, A log book (DRAFT ZONE) is attached at the last section for recording simulation results and running any given values for testing under different conditions (mass, noise constants, different flying paths etc).

 - 4, All parameters can be set in the Parameter Loading Zone (PLZ). 

**PRECAUTIONS:** 
 - 1, Read the checklist and type Y at each requirement to comfirm before running the ANN.

 - 2, Running time need to be set in the better_controller.slx for different flying modes.

 - 3, Although the script will no longer crash due to smaller interation gap being applied, the script would be "paused" for long time. Just simply press "ctrl + c" scape current number would be fine.

## better_controller.slx

**DISCRIPTION:** THE CORE OF THE ENTIRE PROJECT. MADE BY STUDENT IN THE GROUP. CONSISTING OF **SIMULATION SYSTEM** AND **CONTROL LAW**. 

## samplemission.mat

**DISCRIPTION:** MADE BY STUDENT IN THE GROUP. TESTING PATH FOR THE **"better_controller.slx"**. AIM TO ASSIST TUNNING THE PARAMETERS IN THE CONTROL LAW.
