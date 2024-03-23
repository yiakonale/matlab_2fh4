%Ioannis Papaspyridis
clc; %clear the command window
clear; %clear all variables

%set16

NumberOfTurns=200; %Number of turns of the solenoid
Rin=1.5e-2; %inner radius of toroid
Rout=2.5e-2; %outer radius of toroid
Ravg=(Rin+Rout)/2;
r=(Rout-Rin)/2; %internal radius of toroid

Phimin=0; %coordinate of the lowest angle on the solenoid
Phimax=2*pi; %coordinate of the highest angle on the solenoid
t_min=0; %lowest value of the curve parameter t
t_max=NumberOfTurns*2.0*pi; %for every turn we have an angle increment of 2*pi

NumberOfSegments=NumberOfTurns*360; %we divide the toroid into this number of segments (360 degrees per turn)
t_values=linspace(t_min,t_max,(NumberOfSegments+1))'; %these are the values of the parameter t
phi_values=Phimin+((Phimax-Phimin)/(t_max-t_min))*(t_values-t_min); %phi values increment with t values

x_values=(Ravg+r*cos(t_values)).*cos(phi_values);
y_values=(Ravg+r*cos(t_values)).*sin(phi_values);
z_values=r*sin(t_values);
I=5; %value of current

NumberOfXPlottingPoints=20; %number of plotting points along the x axis
NumberOfYPlottingPoints=20; %number of plotting points along the y axis

PlotXmin=-4.0e-2; %lowest x value on the plot plane
PlotXmax=4.0e-2; %maximum x value on the plot plane
PlotYmin=-4.0e-2; %lowest y value on the plot plane
PlotYmax=4.0e-2; %maximum y value on the plot plane
PlotZ=0; %all points on observation plane have zero z coordinate

PlotStepX=(PlotXmax-PlotXmin)/(NumberOfXPlottingPoints-1);%plotting step in the x direction
PlotStepY=(PlotYmax-PlotYmin)/(NumberOfYPlottingPoints-1); %plotting step in the y direction
[XData,YData]=meshgrid(PlotXmin:PlotStepX:PlotXmax, PlotYmin:PlotStepY:PlotYmax); %build arrays of plot plane

Bx=zeros(NumberOfXPlottingPoints,NumberOfYPlottingPoints); %x component of field
By=zeros(NumberOfXPlottingPoints, NumberOfYPlottingPoints);%y component of field

for m=1:NumberOfXPlottingPoints %repeat for all plot points in the x direction
    for n=1:NumberOfYPlottingPoints %repeat for all plot points in the y direction
        PlotX=XData(m,n); %x coordinate of current plot point
        PlotY=YData(m,n); %y coordinate of current plot point
        Rp=[PlotX PlotY PlotZ]; %position vector of observation points

        for i=1:NumberOfSegments %repeat for all line segments of the solenoid
            XStart=x_values(i,1); %x coordinate of the start of the current line segment
            XEnd=x_values(i+1,1); %x coordinate of the end of the current line segment
            YStart=y_values(i,1); %y coordinate of the start of the current line segment
            YEnd=y_values(i+1,1); %y coordinate of the end of the current line segment
            ZStart=z_values(i,1); %z coordinate of the start of the current line segment
            ZEnd=z_values(i+1,1); %z coordinate of the end of the current line segment

            dl=[(XEnd-XStart) (YEnd-YStart) (ZEnd-ZStart)]; %the vector of diffential length

            Rc=0.5*[(XStart+XEnd) (YStart+YEnd) (ZStart+ZEnd)];%position vector of center of segment
            R=Rp-Rc; %vector pointing from current subsection to the current observation point
            norm_R=norm(R); %get the distance between the current surface element and the observation point
            R_Hat=R/norm_R; %unit vector in the direction of R

            dH=(I/(4*pi*norm_R*norm_R))*cross(dl,R_Hat); %this is the contribution from current element

            Bx(m,n)=Bx(m,n)+dH(1,1); %increment the x component at the current observation point
            By(m,n)=By(m,n)+dH(1,2); %increment the y component at the current observation point

        end %end of i loop
    end %end of n loop
end % end of m loop

quiver(XData, YData, Bx, By);
xlabel('x(m)');%label x axis
ylabel('y(m)');%label y axis
