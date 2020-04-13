function isEmpty(x, y)
    return tilemap[y][x] == 0
end
function love.load()
---   requires-----------------
    require("coins")
    require("animations")
    animator=require("animator")
    require("tilemap")
-------------------------------
    --Load the image
    im= love.graphics.newImage("tile.png")
    --We need the full image width and height for creating the quads
     width = im:getWidth()
     height = im:getHeight()
    im_rotation=0
    tilemap=tilemaps.tilemap
r=spawn_random_coins(tilemap,250)
-----------create a new player---------------------------
player = {
        image = love.graphics.newImage("player.png"),
        animation=animationz.anim_right,
        tile_x = 2,
        tile_y = 2
    }
assert(player.animation~=nil, "no animation")
--------------------------------------------------------
len=#r
end
function love.draw()
    for i,row in ipairs(tilemap) do
        for j,tile in ipairs(row) do
               if tile ~= 0 then
            
                   --Draw the image with the correct quad
                   love.graphics.draw(im, j * width, i * height)
               end    
             for len=1,#r do  
                for l=1,len do
               if i==r[len][l] and j==r[len][l+1] then
                            love.graphics.rectangle('fill', j*width+10, i*height+10, 10,10)
                         end end end
           end
       end
        --Draw the player and multiple its tile position with the tile width and height
        player.animation:draw(player.tile_x * width, player.tile_y * height,im_rotation,0.15,0.15)
end
function love.update(dt)
  --animate the player at 0 fps
    player.animation:update( dt*20 )
    for i=1,len do
                if r[i]~=nil and player.tile_y==r[i][1] and player.tile_x==r[i][2] then 
                table.remove(r, i)
                i=1
                print("collision") 
               end  
        end
 end
function love.keypressed(key)
    local x = player.tile_x
    local y = player.tile_y

    if key == "d" then
        x = x - 1
        player.animation=animationz.anim_left
    elseif key == "g" then
        x = x + 1
        player.animation=animationz.anim_right
    elseif key == "r" then
        y = y - 1
        player.animation=animationz.anim_above
    elseif key == "f" then
        y = y + 1
        player.animation=animationz.anim_bottom
    end

   if isEmpty(x, y) then
        player.tile_x = x
        player.tile_y = y
    end
if key == "space" then
        sfx:play()
    end
end