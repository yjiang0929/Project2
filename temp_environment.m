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
