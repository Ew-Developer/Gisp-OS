local component = require("component")

function getComponent(name)
    return component[name] or error(string.format("%s component is required for Gisp-OS.", name))
end

local eeprom, gpu = getComponent("eeprom"), getComponent("gpu")
local internet = require("internet") or error("Internet component is required for Gisp-OS.")

local w, h = gpu.getResolution()
gpu.fill(1, 1, w, h, " ") -- clears the screen
gpu.setForeground(0xFFFFFF)
gpu.setBackground(0x000000)
gpu.fill(1, 1, w/2, h/2, "X") -- fill top left quarter of screen
gpu.copy(1, 1, w/2, h/2, w/2, h/2)