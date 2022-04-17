clear
clc


%n for the number for checking
n =input('please put a number for n');


for index = 2 : 1 : n -1
    numb = index ; 
 
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

   


%tells you the result

    if (any(x) ~= 0)
        d = [num2str(n) , 'is not a prime number!It has factors.'] ; 
        disp(d);        
        
    else 
        d = [num2str(n) , ' is  a prime number.'];
            disp(d)
    end
end
