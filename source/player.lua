import("constants")
import("utils")
import("vector2")

class('Player', {sprite = nil, isEngineOn = false, enginePower = 2, velocity = Vector2(0,0)}).extends(Object)
function Player:init()
    Player.super.init()
    self.sprite = MakeSprite("lander")
    self:enableInputHandlers()
end

function Player:onStart()
    self.sprite:moveTo(CONSTANTS.SCREEN_MID_X, CONSTANTS.SCREEN_MID_X)
    self.sprite:add()
end

--- Updates the player object
--- @type fun(deltaTime:number)
function Player:update(deltaTime)
    if (self.isEngineOn) then
        self.velocity.y = self.velocity.y - self.enginePower * deltaTime
    end

    local rotationInRad = math.rad(self.sprite:getRotation())
    self.velocity = Vector2(
        self.velocity.x * math.cos(rotationInRad) - self.velocity.y * math.sin(rotationInRad),
        self.velocity.y * math.cos(rotationInRad) - self.velocity.x * math.sin(rotationInRad)
    )

    self.velocity.y = self.velocity.y + CONSTANTS.GRAVITY * deltaTime

    if (self.velocity.y > CONSTANTS.GRAVITY) then
        self.velocity.y = CONSTANTS.GRAVITY
    end

    local currentX, currentY = self.sprite:getPosition()
    local newPos = Vector2(currentX + self.velocity.x, currentY + self.velocity.y)
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

    -- if (newPos.y == bottomRight.y) then
    --     self.velocity.x = 0
    -- end

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