n = input('please put an interger for n');
A = randi([-100 , 100], 1,n );
B = sum(A);

if (B>100)
    disp('false');
elseif (any(A) > 20)
    disp('false');
else (all(A) <-10);
    disp('false');
end