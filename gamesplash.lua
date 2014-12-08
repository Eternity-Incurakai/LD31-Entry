local self={
  ["btns"]={
    ["play"]={
      ["x"]=50,
      ["y"]=400,
      ["width"]=150,
      ["height"]=75
    },
    ["credits"]={
      ["x"]=500,
      ["y"]=400,
      ["width"]=260,
      ["height"]=75
    },
    ["instructions"]={
      ["x"]=175,
      ["y"]=500,
      ["width"]=435,
      ["height"]=75
    }
  },
  ["img"]={
    ["x"]=200,
    ["y"]=0,
    ["sx"]=0.7,
    ["sy"]=0.7
  }
}
self.__index=self
function self.go()
  assets.splashmusic:play()
  function love.load(t)
  end
  function love.update(dt)
  end
  function love.draw()
    love.graphics.setBackgroundColor(255,255,255)
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(font(72))
    love.graphics.rectangle("line",self.btns.credits.x,self.btns.credits.y,self.btns.credits.width,self.btns.credits.height)
    love.graphics.print("Credits",self.btns.credits.x,self.btns.credits.y-8)
    love.graphics.rectangle("line",self.btns.play.x,self.btns.play.y,self.btns.play.width,self.btns.play.height)
    love.graphics.print("Play",self.btns.play.x,self.btns.play.y-8)
    love.graphics.rectangle("line",self.btns.instructions.x,self.btns.instructions.y,self.btns.instructions.width,self.btns.instructions.height)
    love.graphics.print("Instructions",self.btns.instructions.x,self.btns.instructions.y-8)
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(assets.title,self.img.x,self.img.y,0,self.img.sx,self.img.sy)
  end
  function love.mousepressed(x, y, button)
    if x>self.btns.credits.x and x<self.btns.credits.x+self.btns.credits.width and y>self.btns.credits.y and y<self.btns.credits.y+self.btns.credits.height then
      credits.go()
    elseif x>self.btns.play.x and x<self.btns.play.x+self.btns.play.width and y>self.btns.play.y and y<self.btns.play.y+self.btns.play.height then
      assets.splashmusic:stop()
      interlude.go()
    elseif x>self.btns.instructions.x and x<self.btns.instructions.x+self.btns.instructions.width and y>self.btns.instructions.y and y<self.btns.instructions.y+self.btns.instructions.height then
      instructions.go()
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
