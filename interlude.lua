local self={
  ["btns"]={
    ["go"]={
      ["x"]=100,
      ["y"]=150,
      ["width"]=150,
      ["height"]=75
    }
  },
  ["states"]={

  }
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
    love.graphics.setFont(font(72))
    love.graphics.print("A GORE-Y ELECTION",30,0)
    love.graphics.rectangle("line",self.btns.go.x,self.btns.go.y,self.btns.go.width,self.btns.go.height)
    love.graphics.print("Go",self.btns.go.x,self.btns.go.y-8)
  end
  function love.mousepressed(x, y, button)
    if x>self.btns.go.x and x<self.btns.go.x+self.btns.go.width and y>self.btns.go.y and y<self.btns.go.y+self.btns.go.height then
      game.go()
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
