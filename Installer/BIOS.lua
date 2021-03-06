local internet = require("internet") or error("Internet component is required for GispOS.")

local fileMode = false
while true do
  print("Download the installer onto a file? [Y/N]")

  local option = io.read(1):lower()
  if option == "y" then
    fileMode = true
    break
  elseif option == "n" then
    fileMode = false
    break
  end
end

print("Downloading installer...")
local codeResult = ""
for chunk in internet.request("https://raw.githubusercontent.com/Ew-Developer/Gisp-OS/main/Installer/Installer.lua") do
  codeResult = codeResult..chunk
end
print("Downloaded installer!")

if fileMode then
  print("Installing installer...")

  local file = io.open("/installer.lua", "w")
  file:write(codeResult)
  file:close()

  print("Installed installer on '/installer.lua'!")
  return
end

print("Running installer...")
local result, errorMessage = load(codeResult, "=installer")
if not result then
  error(errorMessage)
end

local runSucceed, runErrorMessage = xpcall(result, debug.traceback)
if not runSucceed then
  error(runErrorMessage)
end