%Ioannis Papaspyridis
clc; %clear the command line
clear; %remove all previous variables

%set3

Q1=8e-9;%charges on Q1
Q2=8e-9;%charges on Q2
pL=4e-9;%charge density of the line
Epsilono=8.8419e-12;%Permitivity of free space

O=[0 0 0];%coordinates of observation point
A=[0 1 1];%coordinates of Q1
B=[0 -1 1];%coordinates of Q2
L1=[7 0 0];%coordinates of one end of the line charge
L2=[0 7 0];%coordinates of the other end of the line charge
Number_of_L_Steps=100000;%the steps of L

%%the following routine calculates the electric fields at the
%%observation point generated by the point charges
R1=O-A; %the vector pointing from Q1 to the observation point
R2=O-B; %the vector pointing from Q2 to the observation point
R1Mag=norm(R1);%the magnitude of R1
R2Mag=norm(R2);%the magnitude of R1
E1=Q1/(4*pi*Epsilono*R1Mag^3)*R1;%the electric field generated by Q1
E2=Q2/(4*pi*Epsilono*R2Mag^3)*R2;%the electric field generated by Q2

%%the following routine calculates the electric field at the
%%observation point generated by the line charge
L=L1-L2;
length=norm(L);%the length of the line
unit_vect=L/length;
dL_V=(length/Number_of_L_Steps)*unit_vect;%vector of a segment
dL=norm(dL_V);%length of a segment
EL=[0 0 0];%initialize the electric field generated by EL
C_segment=L2+dL_V/2;%the center of the first segment

for i=1: Number_of_L_Steps
    R=O-C_segment;%the vector seen from the center of the first segment to the observation point
    RMag=norm(R);%the magnitude of the vector R
    EL=EL+dL*pL/(4*pi*Epsilono*RMag^3)*R;%get contibution from each segment
    C_segment=C_segment+dL_V;%the center of the i-th segment
end

E=E1+E2+EL;% the electric field at P