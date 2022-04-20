
function A = makeList(f,n,s)

%
%array = makeList(f,s,n)
%f = first number 
%s = seperation 
%n = last
%

c = 1  ;
d = round((n-f)/s) ;
while c <= d+1
    A(c) = f+(c-1)*s ; 
    c = c+1 ; 
end
disp(A)
end