function [t, T] = beehive_simulation(initialTime, finalTime)

    %%Beehive Constants

    temp_hive = 308;                           % K, 34.85'C
    temp_environment = zeros(150);             % K, column vector, daily;
                                               % 1 month = 30 days
    %initializing environmental Temperature(Needham)
    %lets assume temperature changes every other month for now
    %source : https://weather.com/weather/monthly/l/Needham+MA+02492:4:US
    for i=0:150
        if(i <= 30) %% November 34'F -> 274 K
        temp_environment(i) = 274;

        elseif(i > 30 && i <= 60) %% December 24'F, -> 269K
        temp_environment(i) = 269;   
     
        elseif(i > 60 && i <= 90) %% January 17'F, -> 265K
        temp_environment(i) = 265;

        elseif(i > 90 && i <= 120) %% Feburary 19'F, -> 266K
        temp_environment(i) = 266;

        elseif(i > 120 && i <= 150) %% March 27'F, -> 270K
        temp_environment(i) = 270;
        end
    end     
                                      
    number_bees = 10000;
    
    function res = heat_production_single(temp) %temp in kelvin
        temperature = temp - 273.15; %converts input into celsius
        if(temperature < 0)
            res = -0.0001 * temperature + 0.002;       %W (J/s)
        elseif (temperature => 0)
            res = 0.002                         %W (J/s)
        end
    end

    insolation = zeros(150);                   %insolation over 150 days
    %initialization, 
    %source : http://solarenergylocal.com/states/massachusetts/boston/
    for i=0:150
        if(i <= 30) %% November 3.13 kWh/m^2/day
        insolation(i) = 3.13;

        elseif(i > 30 && i <= 60) %% December 2.94 kWh/m^2/day
        insolation(i) = 2.94;   
     
        elseif(i > 60 && i <= 90) %% January 3.36 kWh/m^2/day
        insolation(i) = 3.36;

        elseif(i > 90 && i <= 120) %% Feburary 4.23 kWh/m^2/day
        insolation(i) = 4.23;

        elseif(i > 120 && i <= 150) %% March 4.76 kWh/m^2/day
        insolation(i) = 4.76;
        end
    end
    efficiency_of_absorption = 0.9;
    projected_area = 0.1472;                            %m^2 (two surfaces)
    
    %beehive size = 51cm * 41cm * 16cm, thickness=1.5cm
    %sweep parameters
    thickness_bubble_wrap = 0.01;                       %m
    thickness_blue_foam = 0.05;                         %m
    
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
    dUdt = @(ti, Ui) beehive_flow(ti, Ui, temp_environment(ti), number_bees, ...
    heat_production_single(energyToTemperature(Ui,heat_capacity)),... 
    insolation(ti), efficiency_of_absorption, ...
    projected_area, thickness_bubble_wrap, thickness_blue_foam, ...
    thickness_wall, thermal_conductivity_bubble_wrap, ...
    thermal_conductivity_blue_foam, thermal_conductivity_wall, ...
    area_of_contact_top, area_of_contact_side, ...
    heat_transfer_coefficient_of_air, heat_capacity);

    [t, U] = ode45(dUdt, [initialTime finalTime], initial_energy_beehive);
    T = energyToTemperature(U, heat_capacity);
end