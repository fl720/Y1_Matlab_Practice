d = input('please put a date','s');


switch d
    
    case 'Sunday'
        x = 0;
    case 'Monday'
        x = 1;
    case 'Tuesday'
     x = 2;
    case 'Wednesday'
     x = 3;
    case 'Thursday'
     x = 4;
case 'Friday'
    x = 5;
case 'Saturday'
     x = 6;
    otherwise 
        disp('Sorry, I do not know what date it is.')
%somehow 'else' part did not work
end 


%set of words on views
a = ('enjoy and relax');
b = ('dreadful');
c = ('fatiged');
d = ('tried');
e = ('pleased');
f = ('joy');
g = ('satisfied');


% random the outcome of Monday
if x == 1
    x = randi([0,6],1,1);
end

%give output
switch mod (x ,7)
    case 0
        disp(a);
    case 1 
        disp(b);
    case 2
        disp(c);
    case 3
        disp(d);
    case 4 
        disp(e);
    case 5
        disp(f);
    case 6
        disp(g);
    otherwise
        disp('Sorry, I do not know what date it is.')
end