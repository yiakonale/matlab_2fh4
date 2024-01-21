%Ioannis Papaspyridis - 400363946 - papaspyi
clear;
clc;

%set1

r1 = [1 2 3];
r2 = [3 2 1];

%a
r1_dot_r2 = dot(r1,r2);
str = "a) The dot product of R1 and R2 is " + r1_dot_r2;
disp(str);

%b
r1_projon_r2 = (r1_dot_r2/(dot(r2,r2)))*r2;
str = "b) The projection of R1 on R2 is " + r1_projon_r2(1) + "ax + " + r1_projon_r2(2) + "ay + " + r1_projon_r2(3) + "az";
disp(str);

%c
magR1 = norm(r1);
magR2 = norm(r2);
cos_theta = r1_dot_r2/(magR1*magR2);
theta = acos(cos_theta);

str = "c) The angle betweeν R1 and R2 (θ) is " + theta + " radians";
disp(str);