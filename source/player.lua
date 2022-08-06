import("CoreLibs/math")
import("constants")
import("utils")
import("vector2")

local MAX_THRUST <const> = 0.25

class('Player', {
    sprite = nil,
    isEngineOn = false,
    thrust = 0,
    velocity = Vector2(0,0),
    rotationalVelocity = 0
}).extends(Object)

function Player:init()
    Player.super.init()
    self.sprite = MakeSprite("landers/hull_window_lander/main")
    self:enableInputHandlers()
end

function Player:onStart()
    self.sprite:moveTo(CONSTANTS.SCREEN_MID_X, CONSTANTS.SCREEN_MID_Y)
    self.sprite:add()
end

local function updateVelocity(self, deltaTime)
    local rotationInRad = math.rad(self.sprite:getRotation())

    if (self.isEngineOn) then
        self.thrust = Clamp(self.thrust + deltaTime, 0, MAX_THRUST)
        self.velocity.x = self.velocity.x + self.thrust * math.sin(rotationInRad)
        self.velocity.y = self.velocity.y - self.thrust * math.cos(rotationInRad)
    else
        self.thrust = 0
    end

    self.velocity.y = self.velocity.y + CONSTANTS.GRAVITY * deltaTime
    
    if (self.velocity.x > 0) then
        self.velocity.x = self.velocity.x - deltaTime
        self.velocity.x = Clamp(self.velocity.x, 0, self.velocity.x)
    elseif (self.velocity.x < 0) then
        self.velocity.x = self.velocity.x + deltaTime
        self.velocity.x = Clamp(self.velocity.x, self.velocity.x, 0)
    end

    local currentX, currentY = self.sprite:getPosition()
    if (currentY >= CONSTANTS.SCREEN_BOTTOM_RIGHT.y) then
        self.velocity.y = 0
    end
end

--- Updates the position of the provided player object
--- @diagnostic disable-next-line: undefined-doc-name
--- @type fun(self:Player)
local function updatePosition(self)
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

    self.sprite:moveTo(newPos.x, newPos.y)
end

--- Updates the rotation of the provided player object
--- @diagnostic disable-next-line: undefined-doc-name
--- @type fun(self:Player)
local function updateRotation(self)
    local crankPos = math.floor(playdate.getCrankPosition())
    if crankPos >= 360 then crankPos = 0 end
    print ("crankPos: " .. crankPos)
    self.sprite:setRotation(crankPos)
end

--- Updates the player object
--- @type fun(deltaTime:number)
function Player:update(deltaTime)
    updateVelocity(self, deltaTime)
    updateRotation(self)
    updatePosition(self)
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
        leftButtonDown = function()
            
        end,
    }
    playdate.inputHandlers.push(self.inputHandlers)
end

function Player:disableInputHandlers()
    playdate.inputHandlers.pop(self.inputHandlers)
    self.inputHandlers = {}
end