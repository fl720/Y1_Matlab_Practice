clear
clc

%making player put an input of Paper,Rock, Scissor

x = input('Rock-r , Paper-p , Scissor-s' , 's')

%random generator!
a = rand
%which is between 0 and 1.

%let0<=a<0.3333 be Rock.
%let0.3333<=a<0.6666 be Paper.
%let0.6666<=a<=1 be Scissor.

if ( (( 0 <= a) && (a < 0.3333 )) && ( x == 'r') )
    disp('The computer has chosen ROCK, you have chosen ROCK. THE SAME');
elseif ( (( 0 <= a) && (a < 0.3333 )) && ( x == 'p' ) )
    disp('The computer has chosen ROCK, you have chosen PAPER. You WIN');
elseif ( ( ( 0 <= a ) && ( a < 0.3333 )) && ( x == 's' ) )
    disp('The computer has chosen ROCK, you have chosen SCISSORS. You LOSE');
elseif ( ( ( 0.3333 <= a) && (a < 0.6666 )) && ( x == 'r' ) )
    disp('The computer has chosen PAPER, you have chosen ROCK. You LOSE');
elseif ( ( ( 0.3333 <= a) && (a < 0.6666 )) && ( x == 'p' ) )
    disp('The computer has chosen PAPER, you have chosen PAPER. THE SAME ')
elseif ( (( 0.3333 <= a) && (a < 0.6666 )) && ( x == 's' ) )
    disp('The computer has chosen PAPER, you have chosen SCISSORS. You WIN');
elseif (( ( 0.6666 <= a) && (a <= 1 )) && ( x == 'r' ) )
    disp('The computer has chosen SCISSORS, you have chosen ROCK. You WIN');
elseif ( (( 0.6666 <= a) && (a <= 1 )) && ( x == 'p' ) )
    disp('The computer has chosen SCISSORS, you have chosen PAPER. You LOSE');
elseif ( (( 0.6666 <= a) && (a <= 1 )) && ( x == 's' ) )
    disp('The computer has chosen SCISSORS, you have chosen SCISSORS. THE SAME');
else
    disp('unknow');
end