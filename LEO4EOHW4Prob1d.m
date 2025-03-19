clc;
clear;

mu = 398600.4418;
r_e = 6378.1363;

satellites = {
    'Cryosat-2', 717, 0.0003565, 92.0194; 
    'TOPEX/Poseidon', 1336, 0.0007665, 66.0425;
    'Starlette', 812, 0.0205681, 49.8242
};

figure;
hold on;
title('β Angle Variation for Satellites');
xlabel('Time (Days)');
ylabel('β Angle (Degrees)');
grid on;

for i = 1:size(satellites, 1)
    sat_name = satellites{i, 1};
    delta_a = satellites{i, 2};
    e = satellites{i, 3};
    i_angle = satellites{i, 4};

    a = delta_a + r_e;
    
    n = sqrt(mu / a^3);
    
    J2 = 1082.64e-6;
    OM = -3/2 * n * (r_e/a)^2 * J2 * (1/(1-e^2)^2) * cos(i_angle);
    
    if abs(OM) ~= 0
        OM_day = OM * 86400;
        OM_s = 0.0172;
        
        Cs = 2 * pi / (OM_day - OM_s);
        
        if Cs < 0
            continue;
        end
        
        time = linspace(0, 3 * Cs, 1000);
        
        beta_angle = i_angle + 0.1 * cos(2 * pi * time / Cs);
        
        plot(time, beta_angle, 'LineWidth', 2, 'DisplayName', sat_name);
    end
end

legend show;
legend('Position', [0.75, .3, 0.2, 0.2]);
hold off;
