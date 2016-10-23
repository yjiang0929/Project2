function res = beehive_flow(time,current_energy_beehive, number_bees, ...
    efficiency_of_absorption, projected_area, ...
    thickness_bubble_wrap, thickness_blue_foam, thickness_wall, ...
    thermal_conductivity_bubble_wrap, thermal_conductivity_blue_foam, ...
    thermal_conductivity_wall, area_of_contact_top, area_of_contact_side, ...
    heat_transfer_coefficient_of_air, heat_capacity)

    %initializing environmental Temperature(Needham)
    %lets assume temperature changes every other month for now
    %source : https://weather.com/weather/monthly/l/Needham+MA+02492:4:US
    
    %86400 seconds = 1 day
    function res = temp_environment(time)
        if(time <= 30*86400) %% November 34'F -> 274 K
        res = 278 - time / 86400 / 30 * 8;

        elseif(time > 30*86400 && time <= 60*86400) %% December 24'F, -> 269K
        res = 270 - (time / 86400 - 30) / 30 * 3;  
     
        elseif(time > 60*86400 && time <= 90*86400) %% January 17'F, -> 265K
        res = 267 + (time / 86400 - 60) / 30 * 4;

        elseif(time > 90*86400 && time <= 120*86400) %% Feburary 19'F, -> 266K
        res = 271 + (time / 86400 - 90) / 30 * 4;

        elseif(time > 120*86400 && time <= 150*86400) %% March 27'F, -> 270K
        res = 275 + (time / 86400 - 120) / 30 * 6;
        end
    end

    function res = heat_production_single(temp) %temp in kelvin
        temperature = temp - 273.15; %converts input into celsius
        if(temperature < 0)
            res = -0.0001 * temperature + 0.002;       %W (J/s)
        elseif (temperature >= 0)
            res = 0.002;                         %W (J/s)
        end
    end
 
    %source : http://solarenergylocal.com/states/massachusetts/boston/
    function res=insolation(i)
        if(i <= 30*86400) %% November 3.13 kWh/m^2/day
                          %% 3130Wh/m^2/day
                          %% 3130/86400 Wh/m^2/sec
            res = 3130/86400;
        elseif(i > 30*86400 && i <= 60*86400) %% December 2.94 kWh/m^2/day
            res = 2940/86400;        
        elseif(i > 60*86400 && i <= 90*86400) %% January 3.36 kWh/m^2/day
            res = 3360/86400;
        elseif(i > 90*86400 && i <= 120*86400) %% Feburary 4.23 kWh/m^2/day
            res = 4230/86400;
        elseif(i > 120*86400 && i <= 150*86400) %% March 4.76 kWh/m^2/day
            res = 4760/86400;
        end
    end
    
    current_temp_beehive = energyToTemperature(current_energy_beehive , heat_capacity);

    temp_delta = current_temp_beehive - temp_environment(time);
    
    %The heat generated by bees. Heat produced by a single bee is measured
    %in seconds.
    heat_production_total = heat_production_single(temp_environment(time)) * number_bees;
    
    %The heat generated by solar radiation
    solar_radiation = efficiency_of_absorption * insolation(time) * projected_area;
    
    %The heat lost by conduction through the top wall, the blue foam and 
    %convection to the air
    conduction_top = temp_delta / (thickness_wall / thermal_conductivity_wall / ...
        area_of_contact_top + thickness_blue_foam / thermal_conductivity_blue_foam / ...
        area_of_contact_top + 1 / heat_transfer_coefficient_of_air / area_of_contact_top);
    
    %The heat lost by conduction through the side wall, the blue foam and
    %convection to the air
    conduction_side = temp_delta / (thickness_wall / thermal_conductivity_wall / ...
        area_of_contact_side + thickness_bubble_wrap / thermal_conductivity_bubble_wrap / ...
        area_of_contact_side + 1 / heat_transfer_coefficient_of_air / area_of_contact_side);
    
    
    %The total flow function for the beehive model
    res = heat_production_total + solar_radiation - conduction_top - conduction_side;
    
end