clear 
clc
%input of the values here
%l means the numerical length of the cubiod 
%w means the numerical width of the cuboid
%h means the numerical height of the cuboid
%pc means the numerical density of the cuboid 
%pfluid means the numerical dencity of the fluid 
l = input('What is the length of the cuboid in meter = ')
w = input('What is the width of the cuboid in meter = ')
h = input('What is the height of the cuboid in meter = ')
pc = input('What is the desity of the cuboid in kilogram per cubic meter = ')
pfluid = input('What is the density of the fluid in kilogram per cubic meter = ')

%calculation of the draught
draught = ((pc*h*l*w)/pfluid)/(w*l)


disp(['The result is ',num2str(draught),'m'])