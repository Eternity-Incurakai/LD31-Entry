local self={
  ["people"]={

  },
  ["time"]=0,
  ["nextspawntime"]=0
}
self.__index=self
function self.go()
  function love.load(t)

  end
  function love.update(dt)
    self.time=self.time+dt
    if self.time<self.nextspawntime then return end
    local psn=require "person"
    psn.config(math.random(),math.random(600),math.random(800))
    table.insert(self.people,psn)
  end
  function love.draw()
    for i=1,#self.people do
      self.people[i].draw()
    end
  end
  function love.mousepressed(x, y, button)
  end
  function love.mousereleased(x, y, button)

  end
  function love.focus(f)

  end
  function love.quit()

  end
end
return self
