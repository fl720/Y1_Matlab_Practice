



function M=machnumber(v,c)

%v is the velocity in ms^-1
%c is the local speed of sound in ms^-1

M=v/c ; 
disp(['mach',num2str(M)])
end
