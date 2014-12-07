local self={
  ["people"]={

  },
  ["algore"]={
    ["x"]=400,
    ["y"]=400,
    ["width"]=20,
    ["height"]=70,
    ["speed"]=250
  },
  ["time"]=0,
  ["nextspawntime"]=0,
  ["votes"]={
    ["gore"]=0,
    ["bush"]=0
  },
  ["slider1"]={
    ["x"]=50,
    ["pos"]=50,
    ["y"]=80,
    ["height"]=20,
    ["width"]=30,
    ["length"]=200,
    ["isDown"]=false,
    ["offset"]=0,
    ["rpos"]=0
  },
  ["slider2"]={
    ["x"]=550,
    ["pos"]=550,
    ["y"]=80,
    ["height"]=20,
    ["width"]=30,
    ["length"]=200,
    ["isDown"]=false,
    ["offset"]=0,
    ["rpos"]=0
  },
  ["state"]="",
  ["upper"]=0,
  ["lower"]=0
}
self.__index=self
function self.getCG() -- WARNING: attempting to understand this function has been known to result in severe headaches.  You have been warned :P
  local x=math.random()*(self.upper-self.lower)+self.lower
  local cm=self.slider2.rpos -- Coefficient of meanness
  local cf=self.slider1.rpos -- Coefficient of funds
  if x == 0.5 then return 0.5 end -- wow, lucky guess!
  if x>0.5 then
    return cf*(cm*(2*x*x-2*x+1)+(1-cm)*((1+math.sqrt(2*x-1))/2))+(1-cf)*x
  else
    return cf*(cm*(2*x-2*x*x)+(1-cm)*x)+(1-cf)*x
  end
end
function self.areHitting(a,b)
  if not self.people[a].active then return false end
  if not self.people[b].active then return false end
  if self.people[a].x>self.people[b].x+self.people[b].width then return false end
  if self.people[a].x+self.people[a].width<self.people[b].x then return false end
  if self.people[a].y>self.people[b].y+self.people[b].height then return false end
  if self.people[a].y+self.people[a].height<self.people[b].y then return false end
  return true
end
function self.algore.isHitting(i)
  if not self.people[i].active then return false end
  if self.people[i].x>self.algore.x+self.algore.width then return false end
  if self.people[i].x+self.people[i].width<self.algore.x then return false end
  if self.people[i].y>self.algore.y+self.algore.height then return false end
  if self.people[i].y+self.people[i].height<self.algore.y then return false end
  return true
end
function self.convince(i,v) -- i = person, v = how much
  if not self.people[i] then return end
  if self.people[i].cg==1 then return end
  if self.people[i].cg>1-v then self.people[i].cg=1 return end
  self.people[i].cg=self.people[i].cg+v
end
function self.choose(i)
  return math.random()<self.people[i].cg
end
function self.go(state,lower,upper)
  self.state=state
  self.lower=lower
  self.upper=upper
  self.people={}
  self.algore={
    ["x"]=400,
    ["y"]=400,
    ["width"]=20,
    ["height"]=70,
    ["speed"]=250
  }
  self.time=0
  self.nextspawntime=0
  self.votes={
    ["gore"]=0,
    ["bush"]=0
  }
  self.slider1={
    ["x"]=50,
    ["pos"]=50,
    ["y"]=80,
    ["height"]=20,
    ["width"]=30,
    ["length"]=200,
    ["isDown"]=false,
    ["offset"]=0,
    ["rpos"]=0
  }
  self.slider2={
    ["x"]=550,
    ["pos"]=550,
    ["y"]=80,
    ["height"]=20,
    ["width"]=30,
    ["length"]=200,
    ["isDown"]=false,
    ["offset"]=0,
    ["rpos"]=0
  }
  function love.load(t)

  end
  function love.update(dt)
    self.time=self.time+dt
    if self.time>60 then interlude.go(self.votes.gore,self.vote) end
    if self.algore.hitting then self.convince(self.algore.hitting,0.125*dt) end
    if self.slider1.isDown then
      self.slider1.pos=love.mouse.getX()-self.slider1.offset
      if self.slider1.pos<self.slider1.x then self.slider1.pos=self.slider1.x end
      if self.slider1.pos>self.slider1.x+self.slider1.length-self.slider1.width then self.slider1.pos=self.slider1.x+self.slider1.length-self.slider1.width end
      self.slider1.rpos=((self.slider1.pos-self.slider1.x)/(self.slider1.length-self.slider1.width))
    end
    if self.slider2.isDown then
      self.slider2.pos=love.mouse.getX()-self.slider2.offset
      if self.slider2.pos<self.slider2.x then self.slider2.pos=self.slider2.x end
      if self.slider2.pos>self.slider2.x+self.slider2.length-self.slider2.width then self.slider2.pos=self.slider2.x+self.slider2.length-self.slider2.width end
      self.slider2.rpos=((self.slider2.pos-self.slider2.x)/(self.slider2.length-self.slider2.width))
    end
    local oldx=self.algore.x
    local oldy=self.algore.y
    if love.keyboard.isDown("s") or love.keyboard.isDown("down") then
      self.algore.hitting=nil
      if self.algore.y-10+self.algore.height+self.algore.speed*dt>600 then
        self.algore.y=540
      else
        self.algore.y=self.algore.y+self.algore.speed*dt
      end
    elseif love.keyboard.isDown("w") or love.keyboard.isDown("up") then
      self.algore.hitting=nil
      if self.algore.y-10-self.algore.speed*dt<130 then
        self.algore.y=140
      else
        self.algore.y=self.algore.y-self.algore.speed*dt
      end
    end
    if love.keyboard.isDown("a") or love.keyboard.isDown("left") then
      self.algore.hitting=nil
      if self.algore.x-(self.algore.width/2)-self.algore.speed*dt<0 then
        self.algore.x=10
      else
        self.algore.x=self.algore.x-self.algore.speed*dt
      end
    elseif love.keyboard.isDown("d") or love.keyboard.isDown("right") then
      self.algore.hitting=nil
      if self.algore.x+(self.algore.width/2)+self.algore.speed*dt>800 then
        self.algore.x=790
      else
        self.algore.x=self.algore.x+self.algore.speed*dt
      end
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
          if self.choose(i) then
            self.votes.gore=self.votes.gore+1
          else
            self.votes.bush=self.votes.bush+1
          end
          self.people[i].active=false
        end
      end
    end
    if self.time<self.nextspawntime then return end
    self.people[#self.people+1]={["cg"]=self.getCG(),["active"]=false,["x"]=math.random(780),["y"]=math.random(140,530),["height"]=70,["width"]=20,["active"]=true,["choosetime"]=self.time+5}
    local okay=false
    while not okay do
      self.people[#self.people].x=math.random(780)
      self.people[#self.people].y=math.random(140,530)
      okay=true
      if self.algore.isHitting(#self.people) then okay=false end
      for i=1,#self.people-1 do if self.areHitting(i,#self.people) then okay=false end end
    end
    self.nextspawntime=2/((self.slider1.rpos*5)+1)+self.time
  end
  function love.draw()
    love.graphics.setFont(font(72))
    love.graphics.print(self.state.." - 00:"..(60-math.floor(self.time)),(400-font(72):getWidth(self.state.." - 00:"..(60-math.floor(self.time)))/2),0)
    love.graphics.setFont(font(12))
    love.graphics.setColor(0,0,0)
    --love.graphics.print(self.votes.gore.." GORE, "..self.votes.bush.." BUSH",0,0)
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
    if self.slider1.isDown then
      love.graphics.setColor(100,100,100)
    else
      love.graphics.setColor(200,200,200)
    end
    love.graphics.arc("fill",self.slider1.pos+10,self.slider1.y+10,10,-math.pi,-math.pi/2)
    love.graphics.arc("fill",self.slider1.pos+self.slider1.width-10,self.slider1.y+10,10,-math.pi/2,0)
    love.graphics.arc("fill",self.slider1.pos+self.slider1.width-10,self.slider1.y+self.slider1.height-10,10,0,math.pi/2)
    love.graphics.arc("fill",self.slider1.pos+10,self.slider1.y+self.slider1.height-10,10,math.pi/2,math.pi)
    love.graphics.rectangle("fill",self.slider1.pos,self.slider1.y+10,self.slider1.width,self.slider1.height-20)
    love.graphics.rectangle("fill",self.slider1.pos+10,self.slider1.y,self.slider1.width-20,self.slider1.height)
    love.graphics.setColor(0,0,0)
    love.graphics.line(self.slider1.pos+10,self.slider1.y+8,self.slider1.pos+10,self.slider1.y+12)
    love.graphics.line(self.slider1.pos+15,self.slider1.y+5,self.slider1.pos+15,self.slider1.y+15)
    love.graphics.line(self.slider1.pos+20,self.slider1.y+8,self.slider1.pos+20,self.slider1.y+12)
    love.graphics.rectangle("line",self.slider1.x,self.slider1.y,self.slider1.length,self.slider1.height)
    love.graphics.print(" No\nAds",self.slider1.x+3,self.slider1.y+self.slider1.height)
    love.graphics.print(" All\nOut",self.slider1.x+self.slider1.length-22,self.slider1.y+self.slider1.height)
    if self.slider2.isDown then
      love.graphics.setColor(100,100,100)
    else
      love.graphics.setColor(200,200,200)
    end
    love.graphics.arc("fill",self.slider2.pos+10,self.slider2.y+10,10,-math.pi,-math.pi/2)
    love.graphics.arc("fill",self.slider2.pos+self.slider2.width-10,self.slider2.y+10,10,-math.pi/2,0)
    love.graphics.arc("fill",self.slider2.pos+self.slider2.width-10,self.slider2.y+self.slider2.height-10,10,0,math.pi/2)
    love.graphics.arc("fill",self.slider2.pos+10,self.slider2.y+self.slider2.height-10,10,math.pi/2,math.pi)
    love.graphics.rectangle("fill",self.slider2.pos,self.slider2.y+10,self.slider2.width,self.slider2.height-20)
    love.graphics.rectangle("fill",self.slider2.pos+10,self.slider2.y,self.slider2.width-20,self.slider2.height)
    love.graphics.setColor(0,0,0)
    love.graphics.line(self.slider2.pos+10,self.slider2.y+8,self.slider2.pos+10,self.slider2.y+12)
    love.graphics.line(self.slider2.pos+15,self.slider2.y+5,self.slider2.pos+15,self.slider2.y+15)
    love.graphics.line(self.slider2.pos+20,self.slider2.y+8,self.slider2.pos+20,self.slider2.y+12)
    love.graphics.rectangle("line",self.slider2.x,self.slider2.y,self.slider2.length,self.slider2.height)
    love.graphics.print("Nice",self.slider2.x+2,self.slider2.y+self.slider2.height)
    love.graphics.print("Mean",self.slider2.x+self.slider2.length-30,self.slider2.y+self.slider2.height)
  end
  function love.mousepressed(x, y, button)
    if x>self.slider1.pos  and x<self.slider1.pos+self.slider1.width and y>self.slider1.y and y<self.slider1.y+self.slider1.height then
      self.slider1.isDown=true
      self.slider1.offset=x-self.slider1.pos
    end
    if x>self.slider2.pos  and x<self.slider2.pos+self.slider2.width and y>self.slider2.y and y<self.slider2.y+self.slider2.height then
      self.slider2.isDown=true
      self.slider2.offset=x-self.slider2.pos
    end
  end
  function love.mousereleased(x, y, button)
    self.slider1.isDown=false
    self.slider2.isDown=false
  end
  function love.focus(f)

  end
  function love.quit()

  end
end
return self
