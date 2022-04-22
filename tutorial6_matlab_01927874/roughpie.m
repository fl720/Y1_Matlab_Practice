function pie = roughpie(n)

M=randi([-100,100],2,n)/100;

x = M(1,:);
y = M(2,:);

c=0;

    
r= x.^2+y.^2;
    
c=sum(r<1);


pie =4*c/(n);
disp(pie)
end

