import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/sprites"
import "CoreLibs/timer"

import "player"

local gfx <const> = playdate.graphics

local player = Player()
local function gameStart()
    player:onStart()
end
gameStart()

function playdate.update()
    local deltaTime = playdate.getElapsedTime()
    player:update(deltaTime)
    gfx.sprite.update()
    playdate.timer.updateTimers()
    playdate.resetElapsedTime()
end