n = input ('What is the maximum value in the array');

for i = 2:n
    if mod(i,3)*mod(i,5) == 0
        x(i-1)=1;
    else 
        x(i-1)=i;
    end
end

disp(x)