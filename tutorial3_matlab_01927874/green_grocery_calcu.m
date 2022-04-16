[rootCondition, rootValues] = quadraticSolver([2 -4 5]) 

function [rootCondition, rootValues] = quadraticSolver(abc)
%Enter the commands for your function here.  

disc = ((abc(2))^2-4*abc(1)*abc(3))

abc(1)
abc(2)
abc(3)



if (disc>0);
    rooCondition = uint8(2)
   
elseif(disc == 0);
    rootCondition = uint8(1)
    
else (disc<0);
    rootCondition = uint8(0);
    
end

x1 = (-abc(2)+sqrt(disc))/(2*abc(1))
x2 = (-abc(2)-sqrt(disc))/(2*abc(1))

if ((rootCondition == 2) & (x1>x2));
    rootValues =[x2 x1];
elseif (rootCondition == 2)&(x2>x1);
    rootValues =[x1 x2];
elseif (rootCondition == 1)
    rootValues = [x1 x2];
else (rootCondition == 0);
    rootValues = ('complex roots')
end
end