%Ioannis Papaspyridis
clc;
clear;

%set 2

V=0;    %initialize volume of the closed surface to 0
%S3=S4=S5
S1=0;   %initialize the area of S1 to 0
S2=0;   %initialize the area of S2 to 0
S3=0;   %initialize the area of S3 to 0
S4=0;   %initialize the area of S4 to 0
S5=0;   %initialize the area of S5 to 0

r=0;            %initialize rho to the its lower boundary
phi=pi/4;       %initialize phi to the its lower boundary
theta=pi/4;     %initialize theta to the its lower boundary

Number_of_r_Steps=100;    %initialize the r discretization
Number_of_phi_Steps=100;    %initialize the phi discretization
Number_of_theta_Steps=100;      %initialize the theta discretization

dr=(2-0)/Number_of_r_Steps;             %The r increment
dphi=(pi/2-pi/4)/Number_of_phi_Steps;   %The phi increment
dtheta=(pi/2-pi/4)/Number_of_theta_Steps;         %The theta increment

%%the following routine calculates the volume of the enclosed surface
for k=1:Number_of_phi_Steps
    for j=1:Number_of_r_Steps
        for i=1:Number_of_theta_Steps
            V=V+(r^2)*sin(theta)*dphi*dr*dtheta;%add contribution to the volume
            theta=theta+dtheta;
        end
        theta=pi/4;
        r=r+dr;%r increases each time when theta has been traveled from its lower boundary to its upper boundary
    end
    r=0;%reset r to its lower boundary
end


%%the following routine calculates the area of S1
r=2;
theta=pi/4;
for k=1:Number_of_theta_Steps
    for i=1:Number_of_phi_Steps
        S1=S1+(r^2)*sin(theta)*dphi*dtheta;%get contribution to the the area of S1
    end
    theta=theta+dtheta;
end

%%the following routine calculates the area of S2
r=0;
theta=pi/4;
for k=1:Number_of_r_Steps
    for i=1:Number_of_phi_Steps
        S2=S2+r*sin(theta)*dphi*dr;%get contribution to the the area of S1
    end
    r=r+dr;
end


%%the following routing calculate the area of S3, S4 and S5
r=0;%reset rho to it's lower boundary
theta=pi/2;
for j=1:Number_of_r_Steps
    for i=1:Number_of_phi_Steps
        S3=S3+r*sin(theta)*dphi*dr;%get contribution to the the area of S3
    end
    r=r+dr;%r increases each time when phi has been traveled from it's lower boundary to it's upper boundary
end


S4=S3;%the area of S5 and S4 is equal to the area of S3
S5=S3;
S=S1+S2+S3+S4+S5;%the area of the enclosed surface

