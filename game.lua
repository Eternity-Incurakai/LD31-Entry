local self={
  ["people"]={

  },
  ["algore"]={
    ["x"]=0,
    ["y"]=0,
    ["width"]=20,
    ["height"]=70,
    ["speed"]=100
  },
  ["time"]=0,
  ["nextspawntime"]=0
}
self.__index=self
function self.algore.isHitting(i)
  if not self.people[i].active then return nil end
  if self.people[i].x>self.algore.x+self.algore.width then return nil end
  if self.people[i].x+self.people[i].width<self.algore.x then return nil end
  if self.people[i].y>self.algore.y+self.algore.height then return nil end
  if self.people[i].y+self.people[i].height<self.algore.y then return nil end
  return true
end
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
    print(self.algore.hitting)
    self.time=self.time+dt
    local oldx=self.algore.x
    local oldy=self.algore.y
    if love.keyboard.isDown("s") or love.keyboard.isDown("down") then
      self.algore.hitting=nil
      self.algore.y=self.algore.y+self.algore.speed*dt
    elseif love.keyboard.isDown("w") or love.keyboard.isDown("up") then
      self.algore.hitting=nil
      self.algore.y=self.algore.y-self.algore.speed*dt
    end
    if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
      self.algore.hitting=nil
      self.algore.x=self.algore.x-self.algore.speed*dt
    elseif love.keyboard.isDown("d") or love.keyboard.isDown("right") then
      self.algore.hitting=nil
      self.algore.x=self.algore.x+self.algore.speed*dt
    end
    for i=1,#self.people do
      if self.people[i].active then
        local hit=self.algore.isHitting(i)
        if hit then -- Get Al Gore of the way
          self.algore.x=oldx
          self.algore.y=oldy
          self.algore.hitting=i
        end
        if self.people[i].choosetime<self.time then
          print(self.choose(i))
          self.people[i].active=false
        end
      end
    end
    if self.time<self.nextspawntime then return end
    self.people[#self.people+1]={["cg"]=math.random(),["active"]=false,["x"]=math.random(800),["y"]=math.random(600),["height"]=70,["width"]=20,["active"]=true,["choosetime"]=self.time+1000000}
    while self.algore.isHitting(#self.people) do
      self.people[#self.people].x=math.random(800)
      self.people[#self.people].y=math.random(600)
    end
    self.nextspawntime=1000000+self.time
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
    love.graphics.setColor(0,0,0)
    love.graphics.circle("line",self.algore.x,self.algore.y,10)
    love.graphics.line(self.algore.x,self.algore.y+10,self.algore.x,self.algore.y+40)
    love.graphics.line(self.algore.x,self.algore.y+40,self.algore.x-10,self.algore.y+60)
    love.graphics.line(self.algore.x,self.algore.y+40,self.algore.x+10,self.algore.y+60)
    love.graphics.line(self.algore.x,self.algore.y+25,self.algore.x+10,self.algore.y+15)
    love.graphics.line(self.algore.x,self.algore.y+25,self.algore.x-10,self.algore.y+15)
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
