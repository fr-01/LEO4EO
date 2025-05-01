clc;
clear;

R = 6371;
%% Problem 1a
altitudes = [384000, 35800, 20200, 1200, 400];
labels = {'Lunar Distance', 'Geosynchronous Orbit', 'GPS', 'Remote Sensing', 'Space Station'};

A_total = 4 * pi * R^2;

cap_area = zeros(size(altitudes));
percent_area = zeros(size(altitudes));

for i = 1:length(altitudes)
    h_sat = altitudes(i);
    h_cap = R * (1 - (R / (R + h_sat)));  % height of spherical cap
    cap_area(i) = 2 * pi * R * h_cap;     % surface area of spherical cap
    percent_area(i) = 100 * cap_area(i) / A_total;  % percent of Earth's surface
end

% Disp
fprintf('%-25s %-15s %-25s %-25s\n', 'Altitude Label', 'Altitude (km)', 'Cap Area (km^2)', 'Percent of Earth (%)');
for i = 1:length(altitudes)
    fprintf('%-25s %-15.0f %-25.2e %-25.2f\n', labels{i}, altitudes(i), cap_area(i), percent_area(i));
end

%% Problem 1b
labels = {'Geosynchronous Orbit', 'GPS', 'Remote Sensing', 'Space Station'};

fprintf('\n%-25s %-15s %-20s\n', 'Orbit Label', 'Altitude (km)', 'Min Satellites Needed');
for i = 2:length(altitudes)
    h = altitudes(i);
    theta0 = acos(R / (R + h)); % Rads
    N = ceil(pi / theta0); 
    fprintf('%-25s %-15.0f %-20d\n', labels{i-1}, h, N);
end
%% Problem 2c
R = 6371;        
h = 1200;      
Reff = R + h;     
theta_deg = 3;    
theta = deg2rad(theta_deg);

eta_deg = linspace(0, 90 - theta_deg, 500);
eta = deg2rad(eta_deg);  

look_angle = @(delta) asin(R * sin(delta) ./ ...
    sqrt(R^2 + Reff^2 - 2 * R * Reff .* cos(delta)));

vertex_angle_deg = zeros(size(eta));
for i = 1:length(eta)
    delta1 = eta(i) - theta;
    delta2 = eta(i) + theta;
    alpha1 = look_angle(delta1);
    alpha2 = look_angle(delta2);
    vertex_angle_deg(i) = rad2deg(alpha2 - alpha1);
end

% Plots
figure;
plot(eta_deg, vertex_angle_deg, 'LineWidth', 1.5);
xlabel('Look Angle \eta (degrees)');
ylabel('Cone Vertex Angle \phi (degrees)');
title('Cone Vertex Angle vs. Look Angle \eta (Arc-Radius = 3°)');
grid on;
