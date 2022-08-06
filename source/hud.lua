local isInitialised = false

local isHUDVisible = false
local function toggleHUD()
  if isHUDVisible then isHUDVisible = false
  else isHUDVisible = true end
end

function InitialiseHUD()
  if isInitialised then return end
  --playdate.setMenuImage(LoadImage("test2"))
  playdate.getSystemMenu():addMenuItem("Toggle HUD", toggleHUD)
  isInitialised = true
end