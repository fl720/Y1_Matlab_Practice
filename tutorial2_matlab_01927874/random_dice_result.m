A = randi ([1,6],1,2)  %get a random number between 1 and 6
       
SUM = A(1)+A(2)    %sum of two results
if A(1) == A(2)    %if  the score of the ﬁrst dice equals the score of the second dice
    SUM=(A(1)+A(2))*2
end