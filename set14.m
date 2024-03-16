%Ioannis Papaspyridis
clc; %clear the command line
clear; %remove all previous variables

%set14

VTop=50;%voltage on top two conductor
VIn=100;%voltage on inner conductor
VOut=0;%voltage on outer conductors

NumberOfXPoints=50; %number of points in the x direction
NumberOfYPoints=NumberOfXPoints; %number of points in the y direction
NumberOfUnKnowns=NumberOfXPoints*NumberOfYPoints; %this is the total number of unknowns

A=zeros(NumberOfUnKnowns, NumberOfUnKnowns); %this is the matrix of coefficients
b=zeros(NumberOfUnKnowns,1);%this is the right hand side vector

jmid=NumberOfXPoints/2;%index of inner conductor side

ibottom=NumberOfYPoints/2;%index of middle conductor Bottom side
itop=NumberOfYPoints;%index of middle conductor Top side

EquationCounter=1; %this is the counter of the equations
for i=1:NumberOfYPoints %repeat for all rows
    for j=1:NumberOfXPoints %repeat for all columns
        if((i>=ibottom&&i<itop)&&(j==jmid)) %V=100 for all points inside the inner conductor
            A(EquationCounter, EquationCounter)=1;
            b(EquationCounter,1)=VIn;
        elseif(i==itop&&j==jmid) %one point in the middle of the 100V and 50V conductors
            A(EquationCounter, EquationCounter)=-4;
            A(EquationCounter, EquationCounter+1)=1;
            A(EquationCounter, EquationCounter-1)=1;
            A(EquationCounter, EquationCounter-NumberOfXPoints)=1;
            b(EquationCounter,1)=0;
        elseif(i==1) %bottom conductor
            A(EquationCounter, EquationCounter)=1;
            b(EquationCounter,1)=VOut;
        elseif(i==itop) %top conductors
            A(EquationCounter, EquationCounter)=1;
            b(EquationCounter,1)=VTop;
        elseif(j==1&&i<(itop-1)) %left conductor
            A(EquationCounter, EquationCounter)=1;
            b(EquationCounter,1)=VOut;
        elseif(j==NumberOfXPoints&&i<(itop-1)) %right conductor
            A(EquationCounter, EquationCounter)=1;
            b(EquationCounter,1)=VOut;
        else %all points in between
            A(EquationCounter, EquationCounter)=-4;
            A(EquationCounter, EquationCounter+1)=1;
            A(EquationCounter, EquationCounter-1)=1;
            A(EquationCounter, EquationCounter+NumberOfXPoints)=1;
            A(EquationCounter, EquationCounter-NumberOfXPoints)=1;
            b(EquationCounter,1)=0;
        end
        EquationCounter=EquationCounter+1;
    end
end

V=A\b; %obtain the vector of voltages
V_Square=reshape(V, NumberOfXPoints, NumberOfYPoints);%convert values into a rectangular matrix

surf(V_Square','FaceColor','interp'); %obtain the surface figure
xlabel('x-axis')
ylabel('y-axis')
zlabel('potential')
zlim([0 100])
figure;
[C,h] = contour(V_Square');% obtain the contour figure
set(h,'ShowText','on','TextStep',get(h,'LevelStep')*2)
colormap cool;
figure;
contour(V_Square');
[px,py] = gradient(V_Square');
hold on, quiver(-px,-py), hold off %obtain the electric field map by using E=-Gradient(V)