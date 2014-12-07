local self={
  ["btns"]={
    ["go"]={
      ["x"]=100,
      ["y"]=150,
      ["width"]=150,
      ["height"]=75
    }
  },
  ["lswmessage"]="",
  ["electors"]={ -- Electors from states won by >5% (e.g. we will not play them)
    ["bush"]=195,
    ["gore"]=204
  },
  ["states"]={
    {
      ["name"]="Florida",
      ["votes"]=25
    },
    {
      ["name"]="New Mexico",
      ["votes"]=5
    },
    {
      ["name"]="Wisconson",
      ["votes"]=11
    },
    {
      ["name"]="Iowa",
      ["votes"]=7
    },
    {
      ["name"]="Oregon",
      ["votes"]=7
    },
    {
      ["name"]="New Hampshire",
      ["votes"]=4
    },
    {
      ["name"]="Minnesota",
      ["votes"]=10
    },
    {
      ["name"]="Missouri",
      ["votes"]=11
    },
    {
      ["name"]="Ohio",
      ["votes"]=21
    },
    {
      ["name"]="Nevada",
      ["votes"]=4
    },
    {
      ["name"]="Tennessee",
      ["votes"]=11
    },
    {
      ["name"]="Pennsylvania",
      ["votes"]=23
    }
  }
}
self.__index=self
function self.reset()
  self.states={
    {
      ["name"]="Florida",
      ["votes"]=25
    },
    {
      ["name"]="New Mexico",
      ["votes"]=5
    },
    {
      ["name"]="Wisconson",
      ["votes"]=11
    },
    {
      ["name"]="Iowa",
      ["votes"]=7
    },
    {
      ["name"]="Oregon",
      ["votes"]=7
      },
    {
      ["name"]="New Hampshire",
      ["votes"]=4
    },
    {
      ["name"]="Minnesota",
      ["votes"]=10
    },
    {
      ["name"]="Missouri",
      ["votes"]=11
    },
    {
      ["name"]="Ohio",
      ["votes"]=21
    },
    {
      ["name"]="Nevada",
      ["votes"]=4
    },
    {
      ["name"]="Tennessee",
      ["votes"]=11
    },
    {
      ["name"]="Pennsylvania",
      ["votes"]=23
    }
  }
  self.electors={
    ["bush"]=195,
    ["gore"]=204
  }
  self.lswmessage=""
function self.go(result)
  if result then
    local state=table.remove(self.states)
    if result.bush>result.gore then
      self.electors.bush=self.electors.bush+state.votes
      self.lswmessage="Bush won "..state.name.." and its "..state.votes.." votes by a count of "..result.bush.." to "..result.gore
    else -- We COULD have a tie - but give it to Gore.  Too much of an edge case and unlikely.  Not worth it to program :P
      self.electors.gore=self.electors.gore+state.votes
      self.lswmessage="Gore won "..state.name.." and its "..state.votes.." votes by a count of "..result.gore.." to "..result.bush
    end
  end
  if self.electors.bush>269 then
    self.reset()
    finale.go(false)
  elseif self.electors.gore>269 then
    self.reset()
    finale.go(true)
  end
  if self.electors.bush < self.electors.gore then
    self.lswmessage=self.lswmessage.."\nCurrent electoral votes: Gore leads "..self.electors.gore.." electors to "..self.electors.bush.." electors"
  elseif self.electors.gore < self.electors.bush then
    self.lswmessage=self.lswmessage.."\nCurrent electoral votes: Bush leads "..self.electors.bush.." electors to "..self.electors.gore.." electors"
  else
    self.lswmessage=self.lswmessage.."\nCurrent electoral votes: Tied at "..self.electors.gore
  end
  function love.load(t)
  end
  function love.update(dt)
  end
  function love.draw()
    love.graphics.setBackgroundColor(255,255,255)
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(font(36))
    love.graphics.printf("Next up: "..self.states[#self.states].name.." with "..self.states[#self.states].votes.." electoral votes",0,0,800)
    love.graphics.printf(self.lswmessage,0,self.btns.go.y+self.btns.go.height+25,800)
    love.graphics.rectangle("line",self.btns.go.x,self.btns.go.y,self.btns.go.width,self.btns.go.height)
    love.graphics.setFont(font(72))
    love.graphics.print("Go",self.btns.go.x,self.btns.go.y-8)
  end
  function love.mousepressed(x, y, button)
    if x>self.btns.go.x and x<self.btns.go.x+self.btns.go.width and y>self.btns.go.y and y<self.btns.go.y+self.btns.go.height then
      game.go(self.states[#self.states].name)
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
