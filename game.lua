local self={
  ["people"]={

  },
  ["time"]=0,
  ["nextspawntime"]=0
}
self.__index=self
function self.convince(i)
  if not self.people[i] then return end
  if self.people[i].cg==1 then return end
  if self.people[i].cg>0.99 then self.people[i].cg=1 return end
  self.people[i].cg=self.people[i].cg+0.01
end
function self.choose(i)
  return math.random()<self.people[i].cg
end
function self.go()
  function love.load(t)

  end
  function love.update(dt)
    --self.convince(#self.people)
    self.time=self.time+dt
    for i=1,#self.people do
      if self.people[i].active then
        if self.people[i].choosetime<self.time then
          print(self.choose(i))
          self.people[i].active=false
        end
      end
    end
    if self.time<self.nextspawntime then return end
    local psn={}
    psn.cg=math.random()
    psn.x=math.random(800)
    psn.y=math.random(600)
    psn.active=true
    psn.choosetime=self.time+5
    self.people[#self.people+1]=psn
    self.nextspawntime=1+self.time
  end
  function love.draw()
    for i=1,#self.people do
      if self.people[i].active then
        love.graphics.setColor(255*(1-self.people[i].cg),0,255*self.people[i].cg)
        love.graphics.circle("line",self.people[i].x,self.people[i].y,10)
        love.graphics.line(self.people[i].x,self.people[i].y+10,self.people[i].x,self.people[i].y+40)
        love.graphics.line(self.people[i].x,self.people[i].y+40,self.people[i].x-10,self.people[i].y+60)
        love.graphics.line(self.people[i].x,self.people[i].y+40,self.people[i].x+10,self.people[i].y+60)
        love.graphics.line(self.people[i].x,self.people[i].y+25,self.people[i].x+10,self.people[i].y+15)
        love.graphics.line(self.people[i].x,self.people[i].y+25,self.people[i].x-10,self.people[i].y+15)
      end
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
