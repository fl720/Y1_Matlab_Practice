n = input('please put a number for prime check')  ;

function result = myPrimes(n)
 
if n<0 && n>10000
    disp('-1') ;
elseif n == 1
    disp('0') ;
elseif 
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
end
   


%tells you the result

    if (any(x) ~= 0)
        d = ['0'] ; 
        disp(d);        
        
    else 
        d = ['1'];
            disp(d)
    end
end
end