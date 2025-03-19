clc
clear
%% RAAN rate of change calculation 
J2 = 1082.64e-6; 
r_e = 6378.1363; 
mu = 398600.4415; 

a = 812 + r_e; 
n = sqrt(mu/a^3); 
e = .0205681; 
i = 49.8242; 

OM = -3/2 * n * (r_e/a)^2 * J2 * (1/(1-e^2)^2) * cos(i); 
disp(OM)

%% Sun cycle 
OM_day = OM * 86400; 
OM_s = .0172; 

Cs = (2*pi)/ (OM_day - OM_s); %Sun cycle
disp(['Sun cycle period: ', num2str(Cs), ' days']);

%% Period table 
T = 2*pi / n; %Kepler period

M = n * (1 - (3/4) * (r_e / a)^2 * J2 * (1 / (1 - e^2)^(3/2)) * (1 - 3 * cos(i)^2));
Ta = 2*pi / M; %Anomalistic period 

om = -3/4 * n * (r_e/a)^2 * J2 * (1/(1-e^2)^2) * (1 - 5*cos(i)^2); 
u = om + M; 
Td = 2*pi / u; %Nodal Period 

PeriodNames = {'Keplerian Period (T)', 'Anomalistic Period (Ta)', 'Draconitic Period (Td)'}; % Without Sun Cycle
PeriodsInSeconds = [T, Ta, Td];
SunCycleInDays = repmat(Cs, 1, 3);  % Repeat Sun cycle value for each row in the table

% Create the table
PeriodTable = table(PeriodNames', PeriodsInSeconds', SunCycleInDays', ...
    'VariableNames', {'Period', 'Time (Seconds)', 'Sun Cycle (Days)'});

% Display the table
disp(PeriodTable);