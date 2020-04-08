%Opgave 1.1.1
f = 1;
ox = 0;%0.5;
oy = 0;%0.5;
A = [f 0 ox;
     0 f oy;
     0 0 1 ];
 
t1 = [0;0;0]
t2 = [-5;0;2]
t3 = [0.1; 0 ; 0.1]

R = [1 0 0; 
     0 1 0; 
     0 0 1];
 
R1 = R;
R2 = R;
R3 = R;

P1 = A*[R1 t1];
P2 = A*[R2 t2];
P3 = A*[R3 t3];

%Opgave 1.1.2
Q1 = [2; 4; 10; 1];
q1 = P1*Q1;
q2 = P2*Q1;
q3 = P3*Q1;
% converthomtoin(P1*Q1)
% converthomtoin(P2*Q1)
% converthomtoin(P3*Q1)

%Opgave 1.1.3
%As R1-R3 is I the direction is the same (long the Z axis)
%The Positions ot the pinhole t1 and t2 are fairly close to each other

%why does the point move to the "left" when moving the camera to the "left"

%Opgave 1.2.1
pinv([P1;P2])*[q1;q2]
pinv([P1;P2;P3])*[q1;q2;q3]

