

%150 days = 3600 hours = 216,000 min = 12,960,000 seconds.
%86400 seconds = 1 day
%thickness_blue_foam=0.05;
%for thickness_bubble_wrap = 0:0.005:1
   %[t,T] = beehive_simulation (0,12960000, thickness_bubble_wrap, thickness_blue_foam); 
   % plot (t/86400, T-273.15,'DisplayName', num2str(thickness_bubble_wrap,2)) %x = day, T= kelvin.
%end;
numTimes = 1000;
min_thickness = 0;  %meter
max_thickness = 0.2; %meter

min_temp = zeros(1, numTimes);
thickness_blue_foam = linspace(min_thickness, max_thickness, numTimes);
hold on

for thickness_bubble_wrap=0:0.01:0.05;
    for i=1:numTimes
   [t,T] = beehive_simulation (0,12960000, thickness_bubble_wrap, thickness_blue_foam(i)); 
   min_temp(i) = min(T);
    end;
    plot (thickness_blue_foam, min_temp-273.15,'DisplayName', num2str(thickness_bubble_wrap,2)) %x = day, T= kelvin.
end
xlabel ('Thickness of Blue Foam (m)');
ylabel ('Minimum Temperature(celsius)');
title ('Beehive over Winter (punchline 1)'); 
l = legend('show');
title(l, 'Thickness of bubble wrap(m)')
l.Orientation = 'vertical';
l.Position = [0.7 0.75 0 0];
legend('boxoff');