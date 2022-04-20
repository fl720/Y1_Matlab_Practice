

function result = myPrimes(n)

 f=0;
 
if (n<=0) || (n>=10000) 
    disp('-1') ;
    %n can not be in two different region so not && here , 
    %should be ||
    
 elseif n == 1
     disp('result is 0') ;
     
     
else
    for index= 2:1:n-1
        d = mod(n , index) ;
        
       
        
        if d==0
            f=f+1;
        else d~=0;
            f=f;
        end
    end
    
    if f == 0
        disp('result is 1') ;
    else f~=0;
        disp('result is 0') ;
    end
    
end


end