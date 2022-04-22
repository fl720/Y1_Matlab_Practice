clear 
clc

a = input('please give a minimum number:');
b = input('please give a maximum number:');

X = [a:1:b];
Y=0;

for n = 1:1:length(X)
    f = 2:1:X(n)-1;
   
    left = mod(X(n),f);
    c=0;

    for lc=1:1:length(left)
    if left(lc)==0
        c=c+1;
    else
        c=c;
    end
    end
  if c==0
      Y(n)=1;
  else
      Y(n)=0;
  end
end
    
disp(Y)
plot(X,Y,'r*')