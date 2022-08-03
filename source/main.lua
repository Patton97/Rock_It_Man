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
    player:update()
    gfx.sprite.update()
    playdate.timer.updateTimers()
end