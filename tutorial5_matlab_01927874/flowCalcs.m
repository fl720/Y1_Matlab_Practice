
function [Re,mach] = flowCalcs(h,v,l)
%h is th height in meters 
%v is the velocity of the flow in meter per second
%l is the length in meters
[T,a,P,rho]=atmosisa(h)  ;

mach=v/a ;
disp(mach)
%mu = (1.716*10^-5)*((T/273.15)^(1.5))*((273.15+110.4)/(T+110.4)) ;
mu = muCalc(T);
disp(mu)
Re = rho*v*l/mu   ;
disp(['the Reynolds Number is :',num2str(Re)])
end

