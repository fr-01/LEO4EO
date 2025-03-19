clear; clc; close all;

mu = 4.2828e13;
R  = 3396.2e3;
J2 = 1.955e-3;

nodal_orbits = [2000 2000 0; 100 100 0; 100 200 0.008; 100 400 0.023; 100 600 0.037; 100 1000 0.065; 100 2000 0.128];
apsidal_orbits = [100 100 0; 100 500 0.030; 100 1000 0.065; 100 2000 0.128; 100 3000 0.183; 100 4000 0.231; 4000 4000 0];

num_nodal_orbits = size(nodal_orbits, 1);
num_apsidal_orbits = size(apsidal_orbits, 1);

inc = linspace(0, 180, 100);
inc_rad = deg2rad(inc);

nodal_regression = zeros(num_nodal_orbits, length(inc));
apsidal_regression = zeros(num_apsidal_orbits, length(inc));

colors = lines(max(num_nodal_orbits, num_apsidal_orbits));

for j = 1:num_nodal_orbits
    rp = (nodal_orbits(j,1) + R);
    ra = (nodal_orbits(j,2) + R);
    a = (rp + ra) / 2;
    e = nodal_orbits(j,3);
    n = sqrt(mu / a^3);
    nodal_regression(j, :) = -(3/2) * J2 * (R/a)^2 * n * cos(inc_rad);
    nodal_regression(j, :) = rad2deg(nodal_regression(j, :)) * 86400;
    nodal_regression(j, :) = nodal_regression(j, :) * (1 + e * 5);
end

for j = 1:num_apsidal_orbits
    rp = (apsidal_orbits(j,1) + R);
    ra = (apsidal_orbits(j,2) + R);
    a = (rp + ra) / 2;
    e = apsidal_orbits(j,3);
    n = sqrt(mu / a^3);
    apsidal_regression(j, :) = (3/4) * J2 * (R/a)^2 * n * (5 * cos(inc_rad).^2 - 1);
    apsidal_regression(j, :) = rad2deg(apsidal_regression(j, :)) * 86400;
    apsidal_regression(j, :) = apsidal_regression(j, :) * (1 + e * 7);
end

figure;
hold on; grid on;
for j = 1:num_nodal_orbits
    plot(inc, nodal_regression(j, :), 'LineWidth', 2, 'Color', colors(j, :));
end
xlabel('Inclination (°)'); ylabel('\Omegȧ (°/day)');
title('Daily Nodal Regression around Mars (Scaled)');
xlim([0 180]);
ylim([min(nodal_regression(:)) * 1.1, max(nodal_regression(:)) * 1.1]);
legend(arrayfun(@(x) sprintf('%d × %d km, e = %.3f', nodal_orbits(x,1), nodal_orbits(x,2), nodal_orbits(x,3)), 1:num_nodal_orbits, 'UniformOutput', false), 'Location', 'best');
hold off;

figure;
hold on; grid on;
for j = 1:num_apsidal_orbits
    plot(inc, apsidal_regression(j, :), 'LineWidth', 2, 'Color', colors(j, :));
end
xlabel('Inclination (°)'); ylabel('\omegȧ (°/day)');
title('Daily Apsidal Regression around Mars (Scaled)');
xlim([0 180]);
ylim([min(apsidal_regression(:)) * 1.1, max(apsidal_regression(:)) * 1.1]);
legend(arrayfun(@(x) sprintf('%d × %d km, e = %.3f', apsidal_orbits(x,1), apsidal_orbits(x,2), apsidal_orbits(x,3)), 1:num_apsidal_orbits, 'UniformOutput', false), 'Location', 'northeast');
hold off;
