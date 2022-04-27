clear
clc

m=input('please put number of patients for record');

for i=1:1:m
 
patientinfo(i).name=input('please put the name','s');
patientinfo(i).surmane=input('please put the surname','s');
patientinfo(i).DOB=input('please put the DOB');
patientinfo(i).age=input('please put the age');
patientinfo(i).weight=input('please put the weight');
patientinfo(i).height=input('please put the height');
test=zeros(1,10);
test(1)=20*rand(1)+50;
test(2)=20*rand(1)+50;
test(3)=randi([180,250],1,1);
test(4)=randi([180,250],1,1);
test(5)=randi([180,250],1,1);
for u=6:10
    test(u)=100*rand(1);
end
patientinfo(i).bloodarray=test;
end

a=input('Do you wish to add more? y/n','s');

if a=='y'

    k=input('please put number of patients for record');
for r=m+1:1:k+m
    
patientinfo(r).name=input('please put the name');
patientinfo(r).surmane=input('please put the surname');
patientinfo(r).DOB=input('please put the DOB');
patientinfo(r).age=input('please put the age');
patientinfo(r).weight=input('please put the weight');
patientinfo(r).height=input('please put the height');
BAR=input('please put the blood test results in array');
patientinfo(r).bloodarray=BAR;
end
else a='n';
end