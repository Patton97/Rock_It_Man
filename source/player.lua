import("constants")
import("utils")
import("vector2")

class('Player', {sprite = nil, isEngineOn = false}).extends(Object)
function Player:init()
    Player.super.init()
    self.sprite = MakeSprite("lander")
    self:enableInputHandlers()
end

function Player:onStart()
    self.sprite:moveTo(CONSTANTS.SCREEN_MID_X, CONSTANTS.SCREEN_MID_X)
    self.sprite:add()
end

function Player:update()
    local delta = Vector2(0,0)
    if (self.isEngineOn) then
        delta.y = delta.y - 1
    else
        delta.y = delta.y + 1
    end

    local currentX, currentY = self.sprite:getPosition()
    local newPos = Vector2(currentX + delta.x, currentY + delta.y)
    local currentWidth, currentHeight = self.sprite:getSize()
    local topLeft = Vector2(
        CONSTANTS.SCREEN_TOP_LEFT.x + currentWidth / 2,
        CONSTANTS.SCREEN_TOP_LEFT.y + currentHeight / 2
    )
    local bottomRight = Vector2(
        CONSTANTS.SCREEN_BOTTOM_RIGHT.x - currentWidth / 2,
        CONSTANTS.SCREEN_BOTTOM_RIGHT.y - currentHeight / 2
    )
    ClampVector2(newPos, topLeft, bottomRight)

    self.sprite:moveTo(newPos.x, newPos.y)
end

function Player:turnEngineOn()
    self.isEngineOn = true
end
function Player:turnEngineOff()
    self.isEngineOn = false
end

function Player:enableInputHandlers()
    self.inputHandlers = {
        AButtonDown = function()
            self:turnEngineOn()
        end,
        AButtonUp = function()
            self:turnEngineOff()
        end,
        cranked = function(change, acceleratedChange)
            self.sprite:setRotation(self.sprite:getRotation() + change)
        end,
    }
    playdate.inputHandlers.push(self.inputHandlers)
end

function Player:disableInputHandlers()
    playdate.inputHandlers.pop(self.inputHandlers)
    self.inputHandlers = {}
end