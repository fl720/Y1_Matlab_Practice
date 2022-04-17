clear 
clc

inputs
min = input('please put a minimum valve: ')
max = input('please put a maximum valve: ')

%the loop part

sumval = min

for index = min + 1 : 1 : max
    sumval = sumval^2 + index
    
end

disp(sumval)

 