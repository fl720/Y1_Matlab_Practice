clear
clc

a = input('please put an input for a:');
b = input('please put a value for b:');
c = input('please put a value for c:');


for index = 1 : 1 : 100
    x(index)=index ; 
    y(index) = a*(x(index)^2) + b * x(index) + c ; 

end
plot(x,y)
