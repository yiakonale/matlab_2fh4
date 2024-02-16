%Ioannis Papaspyridis
clc; %clear the command line
clear; %remove all previous variables

%set4

Epsilono=(1e-9)/(36*pi); %use permittivity of air
D=2e-6; %the surface charge density
P=[0 0 1]; %the position of the observation point
E=[0 0 0]; %initialize E=0;

Number_of_rho_Steps=1000;%initialize discretization in the rho direction
Number_of_phi_Steps=1000;%initialize discretization in the phi direction

rho_lower=0; %the lower boundary of rho
rho_upper=1; %the upper boundary of rho

phi_lower=0; %the lower boundary of phi
phi_upper=2*pi; %the upper boundary of phi

drho=(rho_upper- rho_lower)/Number_of_rho_Steps; %the rho increment or the width of a grid
dphi=(phi_upper- phi_lower)/Number_of_phi_Steps; %The phi increment or the length of a grid

for j=1: Number_of_rho_Steps
    for i=1: Number_of_phi_Steps
        rho = rho_lower + drho/2 + (j-1)*drho;
        phi = phi_lower + dphi/2 + (i-1)*dphi;
        ds=rho*drho*dphi; %the area of a single grid
        dQ=D*ds; % the charge on a single grid
        R=P-[0 0 0];

        RMag=sqrt(1+rho^2); % magnitude of vector R
        sintheta=1/RMag;

        E=E+(dQ/(4*Epsilono*pi* RMag^2))*(R/RMag); % get contribution to the E field
    end
end