-- Settings
local time_work = 25*60 -- 25 min
local time_break = 5*60 -- 5 min
local time_longbreak = 15*60 -- 15 min
local longbreak_every = 4 -- longbreak evert 2 pomodors

local msg_work = ''
local msg_break = ''
local msg_longbreak = ''

local color_work = '#fff'
local color_break = '#81a2be'
local color_longbreak = '#b5bd68'

local icon = ' '

-- Required
local gears = require('gears')
local wibox = require('wibox')
local naughty = require('naughty')
local awful = require('awful')

-- Variables
local widget = wibox.widget.textbox()
local timer = gears.timer()
local counter = 0
local p_count = 1
local mode = 0 -- 0 - work, 1 - break, 2 -longbreak

local menu = nil

-- Some functions
function round(x)
  return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end

function getVars() -- Give color and time for current mode
  local time, color, msg = nil

  if mode == 0 then
    time = time_work
    color = color_work
    msg = msg_work
  end
  if mode == 1 then
    time = time_break
    color = color_break
    msg = msg_break
  end
  if mode == 2 then
    time = time_longbreak
    color = color_longbreak
    msg = msg_longbreak
  end
  return time, color, msg
end

function update()
  local time, color, msg = getVars()
  local ti = time - counter

  local mins = string.format("%02.f", math.floor(ti/60) )
  local sec = string.format("%02.f", ti - mins*60 )
  local str = mins..':'..sec

  local co = ''
  if mode == 0 then co = ' ('..p_count..'/'..longbreak_every..')' end
  -- Set
  widget:set_markup('<span color="'..color..'">'..msg..' '..str..co..'</span>')
end

function setMode(m)
  mode = m
  counter = 0
end
function contextmenu()
  if not menu then menu = awful.menu{ items = {
                                        {"Switch to...", {
                                           {"Work time", function() setMode(0) end},
                                           {"Break time", function() setMode(1) end},
                                           {"Longbreak time", function() setMode(2) end},
                                        }},
                                        {"Reset counters", function()
                                           mode = 0
                                           counter = 0
                                           p_count = 1
                                        end}
  }} end

  menu:toggle()
end

function swmode()
  if mode > 0 then
    -- If now is break, go to work
    mode = 0
    p_count = p_count+1
  else
    -- If now is work
    if p_count == longbreak_every then
      -- Do long break
      mode = 2
      p_count = 0
    else
      -- Do short break
      mode = 1
    end
  end

  local str = 'Go to work!'
  if mode == 1 then str = 'Go break!' end
  if mode == 2 then str = 'Go long break!' end

  naughty.notify({
      title = "Pomodoro timer!",
      text = str,
      font = 'Monospace 18',
      icon = icon
  })
  -- Zero counter
  counter = 0
end
-- Create timner
function time()
  timer.start_new(1, function()
                    counter = counter + 1
                    -- Switch mode
                    local timer, color, msg = getVars()
                    if counter >= timer then swmode() end
                    -- Restart
                    update()
                    time()
  end)
end

time()

-- Configure widget contextmenu
widget:buttons(awful.util.table.join(
                 awful.button({}, 1, function() contextmenu() end),
                 awful.button({}, 2, function() contextmenu() end),
                 awful.button({}, 3, function() contextmenu() end)
))


return widget
