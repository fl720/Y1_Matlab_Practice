
function c = check4numbers(A,b)

%
%A is the array 
%b is the number for checking
%

if b-min(A)>=0 && max(A)-b >= 0 
    
    for index =1:1:length(A)
        n = index;
        if A(n) == b
            B(n) = 1 ;
        else A(n)~= b ; 
            B(n)= 0 ; 
        end
        
    end
    disp(B)
else 
    disp('number for checking is not in the range')
end
end