local self={
  ["btns"]={
    ["back"]={
      ["x"]=50,
      ["y"]=500,
      ["width"]=180,
      ["height"]=75
    }
  },
  ["instructionstext"]="You're Al Gore (the guy with the black outline) and the voters pop up and random - they could come in with bias (more red = more likely to vote Bush, more blue = more likely to vote Gore) - you use the arrow keys to move.  If you go up to someone and talk to them (just try to go through them) then they'll be more likely to vote you."
}
self.__index=self
function self.go()
  function love.load(t)
  end
  function love.update(dt)
  end
  function love.draw()
    love.graphics.setBackgroundColor(255,255,255)
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(font(32))
    love.graphics.printf(self.instructionstext,0,0,800)
    love.graphics.rectangle("line",self.btns.back.x,self.btns.back.y,self.btns.back.width,self.btns.back.height)
    love.graphics.setFont(font(72))
    love.graphics.print("Back",self.btns.back.x,self.btns.back.y-8)
  end
  function love.mousepressed(x, y, button)
    if x>self.btns.back.x and x<self.btns.back.x+self.btns.back.width and y>self.btns.back.y and y<self.btns.back.y+self.btns.back.height then
      gamesplash.go()
    end
  end
  function love.mousereleased(x, y, button)

  end
  function love.focus(f)

  end
  function love.quit()

  end
end
return self
