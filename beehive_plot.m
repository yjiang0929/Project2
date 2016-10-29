hold on
%150 days = 3600 hours = 216,000 min = 12,960,000 seconds.
%86400 seconds = 1 day
%thickness_bubble_wrap=0.01;
%for thickness_blue_foam = 0:0.02:0.1
%   [t,T] = beehive_simulation (0,12960000, thickness_bubble_wrap, thickness_blue_foam); 
%    plot (t/86400, T-273.15,'DisplayName', num2str(thickness_blue_foam,2)); %x = day, T= kelvin.
%end;
%thickness_blue_foam = 10;
%[t,T] = beehive_simulation (0,12960000, thickness_bubble_wrap, thickness_blue_foam); 
%plot (t/86400, T-273.15,'r-.','DisplayName', num2str(thickness_blue_foam,2)); %x = day, T= kelvin.
thickness_blue_foam=0.02;
for thickness_bubble_wrap = 0:0.005:0.05
   [t,T] = beehive_simulation (0,12960000, thickness_bubble_wrap, thickness_blue_foam); 
   plot (t/86400, T-273.15,'DisplayName', num2str(thickness_bubble_wrap,2)); %x = day, T= kelvin.
end;
thickness_bubble_wrap = 0.2;
[t,T] = beehive_simulation (0,12960000, thickness_bubble_wrap, thickness_blue_foam);
plot (t/86400, T-273.15,'r-.','DisplayName', num2str(thickness_bubble_wrap,2)) %x = day, T= kelvin.
for i = 1:150
    envir(i) = temp_environment(i*86400);
    time(i) = i;
end;
plot (time, envir-273.15, 'k--','DisplayName','Environment Temperature');
xlabel ('Time(days)');
ylabel ('Tempearture (celsius)');
%title ('Beehive over Winter(thickness of bubble wrap = 0.01m)'); 
title ('Beehive over Winter(thickness of blue foam = 0.02m)'); 
l = legend('show');
%title(l, 'Thickness of blue foam(m)')
title(l, 'Thickness of bubble wrap(m)')
l.Orientation = 'vertical';
l.Position = [0.7 0.75 0 0];
legend('boxoff');