local self={
  ["cg"]=nil,
  ["x"]=nil,
  ["y"]=nil
}
function self.config(cg,x,y) -- Coefficient of Gore, x, y
  self.cg,self.x,self.y=cg,x,y
end
function self.convince()
  if self.cg==1 then return end -- If we're 100% gore then there's no sense convincing further
  self.cg=self.cg+0.01
end
function self.draw()
  love.graphics.setColor(255*(1-self.cg),0,255*self.cg)
  love.graphics.circle("line",self.x,self.y,10)
  love.graphics.line(self.x,30,self.x,60)
  love.graphics.line(self.x,60,self.x-10,80)
  love.graphics.line(self.x,60,self.x+10,80)
  love.graphics.line(self.x,45,self.x+10,35)
  love.graphics.line(self.x,45,self.x-10,35)
end
self.__index=self
return self
