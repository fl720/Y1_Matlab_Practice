clear
clc
l = input('What is the length of the cuboid in meter = ')
w = input('What is the width of the cuboid in meter = ')
h = input('What is the height of the cuboid in meter = ')
pc = input('What is the desity of the cuboid in kilogram per cubic meter = ')
pfluid = input('What is the density of the fluid in kilogram per cubic meter = ')

if ((w > h) & ( l > h))
%calculation of the draught
 draught = ((pc*h*l*w)/pfluid)/(w*l)
disp(['The result is ',num2str(draught),'m'])
else (w<h | l<h )
    disp('!!!WARNING!!!two longer axis are NOT parallel to the horizone!')
    draught = ((pc*h*l*w)/pfluid)/(w*l)
disp(['The result is ',num2str(draught),'m'])
end
