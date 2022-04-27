clear
clc

A = [1 1 2 3 5 8; 0 2 4 6 8 10; -1 -3 -5 -7 -9 -11;2 4 8 16 32 64;13 21 34 55 89 144]; 

[M,N]=size(A);

a=A;
B= A<0;
b=B;
b=B.*a;
A=A>0;
A=a.*A;
B=B*999;
B=A+B;

A=a;


C=A>0;
C=C.*A;
C=C.^(0.5);
C=C+b;

A=a;


F = A ==-1;
T=sum(sum(F));
T=ones(1,T).*-1;
G = A ==0;
U=sum(sum(G));
U=ones(1,U).*0;
H = A ==1;
V=sum(sum(H));
V=ones(1,V).*1;

D=[ T , U , V ]
D=D'

