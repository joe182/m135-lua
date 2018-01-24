-- Load the module
s = require("mq135")
s.setRLoad(1.0)

-- Calibrate (only need to do this once for any new sensor)
-- First let it "burn in" for 12 to 24 hours, then put it into clean air for 30 to 60 minutes
-- and write down the average RZero value, the PPM shown is probably wrong right now which is why you're calibrating in the first place

local max = 0
local min = 0
local avg = 0

tmr.create():alarm(1000, tmr.ALARM_AUTO, function()
    local rzero = s.getRZero();
    local ppm = s.getPPM(); 

   if min == 0 or rzero < min then
        min = rzero
    end

    if max == 0 or rzero > max then
        max = rzero
    end

    avg = (min + max) / 2
    s.setRZero(avg)

    print(
        "RZero:", rzero, 
        "ppm:", ppm, 
        "Min:", string.format("%.04f", min), 
        "Max:", string.format("%.04f", max), 
        "Avg:", avg
    )
end)
