os.execute("clear")
local event = require("event")
local component = require("component")
local modem = component.modem
assert(modem, "You are fucking stupid")
if not modem.isOpen(420) then
  print("Do you want to open port 420? [y/n]")
  local option = io.read():lower()
  if option == "y" then
    print("Opening port 420")
    modem.open(420)
  else
    return
  end
end
if not modem.isOpen(420) then
  return
end

print("Port 420 is open!")
os.sleep(1)
os.execute("clear")
print("Is this the downloading server? [y/n]")
local option = io.read()
if option == "y" then
  while true do
    local _, _, ip, _, _, message = event.pull("modem_message")
    local args = string.split(message, " ")
    local command = args[1]
    table.remove(args, 1)
    if command == "get" then
      local raw_file = args[1]
      local internet = require("internet")
      local handle = internet.request(raw_file)
      local result = ""
      for chunk in handle do result = result..chunk end
      if modem.send(ip, [, result]) then
        print("Sent the file")
        else
        print("Failed to send the file")
        os.sleep(2)
        os.execute("clear")
     end
  end
end
        
      