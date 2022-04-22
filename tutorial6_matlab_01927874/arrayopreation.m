clear 
clc

x = [0 :0.5: 10] ;
y = [0:0.25:5];

for i = 1: length(x)
    for j = 1: length(y)  
    u(i,j)= y(j)+sin(x(i));
    
    v(i,j) = cos(x(i)+y(j));
    
  
    end
end
