

function mu = muCalc(T)

mu = (1.716*10^-5)*((T/273.15)^(1.5))*((273.15+110.4)/(T+110.4)) ; 
disp(mu)
end
