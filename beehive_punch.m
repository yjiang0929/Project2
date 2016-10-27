

%150 days = 3600 hours = 216,000 min = 12,960,000 seconds.
%86400 seconds = 1 day
%thickness_blue_foam=0.05;
%for thickness_bubble_wrap = 0:0.005:1
   %[t,T] = beehive_simulation (0,12960000, thickness_bubble_wrap, thickness_blue_foam); 
   % plot (t/86400, T-273.15,'DisplayName', num2str(thickness_bubble_wrap,2)) %x = day, T= kelvin.
%end;


numTimes = 100;

min_temp = zeros(numTimes, numTimes);

min_blue_foam_thickness = 0;  %meter
max_blue_foam_thickness = 0.1; %meter
thickness_blue_foam = linspace(min_blue_foam_thickness, max_blue_foam_thickness, numTimes);

min_bubble_wrap_thickness = 0;  %meter
max_bubble_wrap_thickness = 0.1; %meter
thickness_bubble_wrap = linspace(min_bubble_wrap_thickness, max_bubble_wrap_thickness, numTimes);
hold on

for i=1:numTimes    %bubble_wrap
    for j=1:numTimes  %blue_foam
    [t,T] = beehive_simulation (0,12960000, thickness_bubble_wrap(i), thickness_blue_foam(j)); 
    min_temp(i, j) = min(T) - 273.15;
    end;
end
contour(thickness_bubble_wrap, thickness_blue_foam, min_temp);
pcolor(thickness_bubble_wrap, thickness_blue_foam, min_temp);
shading interp
xlabel ('Thickness of Bubble Wrap (m)');
ylabel ('Thickness of Blue Foam (m)');
title ('Beehive over Winter'); 
cb = colorbar;
title(cb,'Temperature(Celcius)');
