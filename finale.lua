local self={
  ["btns"]={
    ["back"]={
      ["x"]=50,
      ["y"]=500,
      ["width"]=180,
      ["height"]=75
    }
  },
  ["wintext"]="Congratulations!  You have recieved the needed 270 electoral votes!  You have changed history!"
  ["losetext"]="George Bush has defeated you... but you can always try again!"
}
self.__index=self
function self.go(wewon)
  local text
  if wewon then
    text=self.wintext
  else
    text=self.losetext
  end
  function love.load(t)
  end
  function love.update(dt)
  end
  function love.draw()
    love.graphics.setBackgroundColor(255,255,255)
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(font(32))
    love.graphics.printf(text,0,0,800)
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
