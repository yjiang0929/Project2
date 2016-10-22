hold on
[t,T] = beehive_simulation (0,12960000); 
%150 days = 3600 hours = 216,000 min = 12,960,000 seconds.
%86400 seconds = 1 day
plot (t/86400, T-273.15) %x = day, T= kelvin.

xlabel ('Time(days)');
ylabel ('Tempearture (celsius)');
title ('Beehive over Winter'); 
legend ( 'Ode45');
