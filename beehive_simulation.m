function [t, T] = beehive_simulation(initialTime, finalTime)

    %%Beehive Constants

    temp_hive = 308;                           % K, 34.85'C                         
    number_bees = 10000;
    efficiency_of_absorption = 0.9;
    projected_area = 0.1472;                            %m^2 (two surfaces)
    
    %beehive size = 51cm * 41cm * 16cm, thickness=1.5cm
    %sweep parameters
    thickness_bubble_wrap = 0.02;                  %m
    thickness_blue_foam = 0.05;                    %m
    
    thickness_wall = 0.015;                             %m;
    thermal_conductivity_bubble_wrap = 0.027;           %W/(m * K) 
    thermal_conductivity_blue_foam = 0.033;             %W/(m * K)
    thermal_conductivity_wall = 0.12 ;                  %W/(m * K)
    
    area_of_contact_top = 0.2091;                       %m^2;
    area_of_contact_side = 0.2944;                      %m^2;
    
    heat_transfer_coefficient_of_air = 30;              %W/m^2/K
    
    %heat_capacity calculation
    specific_heat_wax = 2900;                           %J/(kg*K)
    mass_behive = 36;                                   %kg
    heat_capacity = mass_behive * specific_heat_wax;    %J / K
    
    initial_energy_beehive = temperatureToEnergy(temp_hive, heat_capacity);
    
    %% Now invoke ode45 and convert the resulting energies to temperature.
    dUdt = @(ti, Ui) beehive_flow(ti, Ui, number_bees, ... 
    efficiency_of_absorption, projected_area, thickness_bubble_wrap, thickness_blue_foam, ...
    thickness_wall, thermal_conductivity_bubble_wrap, ...
    thermal_conductivity_blue_foam, thermal_conductivity_wall, ...
    area_of_contact_top, area_of_contact_side, ...
    heat_transfer_coefficient_of_air, heat_capacity);

    [t, U] = ode45(dUdt, [initialTime finalTime], initial_energy_beehive);
    T = energyToTemperature(U, heat_capacity);
end