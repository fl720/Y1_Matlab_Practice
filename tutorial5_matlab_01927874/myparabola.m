
function y = myparabola(x,a)

n = length(x) ; 
for i = 1:n
    y(i) = a(1)*x(i)^2 +a(2)*x(i)+a(3) ; 
end
end



