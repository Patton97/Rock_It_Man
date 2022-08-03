import "CoreLibs/graphics"

local gfx <const> = playdate.graphics

--- Loads an image from the images directory
--- @type fun(relativePath:string)
function LoadImage(relativePath)
    return gfx.image.new(CONSTANTS.IMG_DIR .. "/" .. relativePath)
end

--- Makes a sprite for an image from the images directory
--- @type fun(relativePath:string)
function MakeSprite(relativePath)
    local img = LoadImage(relativePath)
    assert(img)
    return gfx.sprite.new(img)
end

