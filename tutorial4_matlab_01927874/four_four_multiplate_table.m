clear
clc

b = [1 2 3 4 5 6 7 8 9 10;] ;

i = [b;b;b;b;b;b;b;b;b;b] ;
for count = 1 : size(i,2)
    
   for var = 1 : size(i,1)
    j(var,count) = i(var,count)*var;
   end
end

disp([0,b;b',j])