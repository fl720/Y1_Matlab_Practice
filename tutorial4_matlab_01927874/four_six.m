clear
clc


%n for the number for checking
for index1 = 2 : 1 :100000000
    n = index1
if index1 == 2
    disp('2 is a prime number.')
    n = 3 : 1 :  10
else

end
for index2 = 2 : 1 : n -1
    numb = index2 ; 
 
%     a=['i=',num2str(i)]
%     disp(a)
    
    left = mod( n , numb) ;
    
%     b = ['left=',num2str(left)]
%     disp(b)
    
    x(numb)=[0];
    if (left == 0 )
        x(numb) =  2;
       
    else 
 
    end
    
%     c = ['when i = ',num2str(index), ',  x=',num2str(x)]
%   disp(c)
end
   


%tells you the result

    if (any(x) > 0)
        d = [num2str(n) , 'is not a prime number!It has factors.'] ; 
        disp(d);        
        
    else 
        d = [num2str(n) , ' is  a prime number.'];
            disp(d)
    end
end