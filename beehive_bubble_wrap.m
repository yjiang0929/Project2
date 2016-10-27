hold on;
clear;
for thickness_blue_foam = 0:0.05:0.3
    i = 1;
    for thickness_bubble_wrap = 0:0.001:0.03
        x(i) = thickness_bubble_wrap;
        [t,T] = beehive_simulation (0,12960000, thickness_bubble_wrap, thickness_blue_foam); 
        y(i) = min(T);
        i = i+1;
    end;
    plot (x,y-273.15,'DisplayName', num2str(thickness_blue_foam,2)) %x = thickness of bubble wrap, T= minimum temperature in the winter.
end;
xlabel ('Thickness of Bubble Wrap(meters)');
ylabel ('Minimum Tempearture (celsius)');
title ('Beehive over Winter (punchline 2)'); 
l = legend('show');
title(l, 'Thickness of blue foam(meters)')
l.Orientation = 'vertical';
l.Position = [0.7 0.75 0 0];
legend('boxoff');