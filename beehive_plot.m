hold on
%150 days = 3600 hours = 216,000 min = 12,960,000 seconds.
%86400 seconds = 1 day
thickness_blue_foam=0.05;
for thickness_bubble_wrap = 0:0.005:0.05
   [t,T] = beehive_simulation (0,12960000, thickness_bubble_wrap, thickness_blue_foam); 
    plot (t/86400, T-273.15,'DisplayName', num2str(thickness_bubble_wrap,2)) %x = day, T= kelvin.
end;
thickness_bubble_wrap = 0.1;
    [t,T] = beehive_simulation (0,12960000, thickness_bubble_wrap, thickness_blue_foam);
    plot (t/86400, T-273.15,'DisplayName', num2str(thickness_bubble_wrap,2)) %x = day, T= kelvin.
xlabel ('Time(days)');
ylabel ('Tempearture (celsius)');
title ('Beehive over Winter(thickness of blue foam = 0.05m)'); 
l = legend('show');
title(l, 'Thickness of bubble wrap(m)')
l.Orientation = 'vertical';
l.Position = [0.7 0.75 0 0];
legend('boxoff');