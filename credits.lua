local self={
  ["btns"]={
    ["back"]={
      ["x"]=50,
      ["y"]=500,
      ["width"]=180,
      ["height"]=75
    }
  },
  ["creditstext"]="Splash Music - Courtesy of Robert del Naja\nCode licensed by Eternity Incurakai under the MIT license - some assets may not be compatible with this license so please check before redistributing.\nElections information from Wikipedia article \"United States presidential election, 2000\".\nFor this game, we are completely ignoring that Maine and Nebraska give partial electoral votes - it was too complex to program :D\nTitle image by Peter Richards, used with permission, all rights reserved."
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
    love.graphics.printf(self.creditstext,0,0,800)
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
