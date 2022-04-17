clear
clc

n = input('please put a number to find factorial:')
f = n;
while n > 1
    n = n-1;
    f = f*n;
end
disp(['n! = ' num2str(f)])