class('Vector2', {x = 0, y = 0}).extends(Object)

function Vector2:init(x, y)
  Vector2.super.init(self)
  self.x = x
  self.y = y
end

--- Clamps the provided vectorToClamp,
--- where the min x & y are derived from the provided topLeft 
--- and the max x & y are derived from the provided bottomRight
--- @diagnostic disable-next-line: undefined-doc-name
--- @type fun(vectorToClamp:Vector2, topLeft:Vector2, bottomRight:Vector2)
function ClampVector2(vectorToClamp, topLeft, bottomRight)
    if (vectorToClamp.x < topLeft.x) then
        vectorToClamp.x = topLeft.x
    end

    if (vectorToClamp.x > bottomRight.x) then
        vectorToClamp.x = bottomRight.x
    end

    if (vectorToClamp.y < topLeft.y) then
        vectorToClamp.y = topLeft.y
    end

    if (vectorToClamp.y > bottomRight.y) then
        vectorToClamp.y = bottomRight.y
    end
end