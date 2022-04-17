clear
clc

x = [1 :1 :300];

%generate y array
for index = 1 : 300
    n = index;
    y(n) = rand;
    
end

%calculation z array
for index = 2: 299
    n = index;
    z(n) = 0.25 * y(n-1) + 0.5*y(n) + 0.25 * y(n+1);
end

z(1)   = 0 + 0.5 * y(1) + 0.25 * y(2);
z(300) = 0.25 * y(299) + 0.5 * y(300) + 0;

plot(x , y)
hold on
plot(x, z)
hold off

