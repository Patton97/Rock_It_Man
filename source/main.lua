import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "hud"
InitialiseHUD()

import "player"

local gfx <const> = playdate.graphics

local player = Player()
local function gameStart()
    player:onStart()
end
gameStart()

function playdate.update()
    local deltaTime = playdate.getElapsedTime()

    TODO: MOVE HUD DRAWING INTO HUD.LUA
    if isHUDVisible then print("HUD") end

    player:update(deltaTime)
    gfx.sprite.update()
    playdate.timer.updateTimers()
    playdate.resetElapsedTime()
end