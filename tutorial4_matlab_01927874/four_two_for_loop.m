clear
clc
%for-loop

n = input('please put the number for n:')

numb = 1

for index = 1 : n
    
    numb = numb* index
   
end

d = ['factorial of' , num2str(n),' will be ',num2str(numb)];
disp(d)