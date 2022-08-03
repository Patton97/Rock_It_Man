import("vector2")

-- although lua 5.4 introduces <const>, you can't seem to do this for globals
-- so we use the old method of creating a read-only table
-- http://andrejs-cainikovs.blogspot.com/2009/05/lua-constants.html
local function setReadOnly(tbl)
  return setmetatable({}, {
      __index = tbl,
      __newindex = function(t, key, value)
          error("attempting to change constant " ..
                 tostring(key) .. " to " .. tostring(value), 2)
      end
  })
end

CONSTANTS = {}

CONSTANTS.ASSET_DIR = "assets"
CONSTANTS.IMG_DIR = CONSTANTS.ASSET_DIR .. "/images"
CONSTANTS.SCREEN_WIDTH = 400
CONSTANTS.SCREEN_HEIGHT = 240
CONSTANTS.SCREEN_MID_X = CONSTANTS.SCREEN_WIDTH / 2
CONSTANTS.SCREEN_MID_Y = CONSTANTS.SCREEN_WIDTH / 2
CONSTANTS.SCREEN_TOP_LEFT = setReadOnly(Vector2(0,0))
CONSTANTS.SCREEN_BOTTOM_RIGHT = setReadOnly(Vector2(CONSTANTS.SCREEN_WIDTH, CONSTANTS.SCREEN_HEIGHT))
CONSTANTS.GRAVITY = 1

CONSTANTS = setReadOnly(CONSTANTS)