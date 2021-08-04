local function getFile(file)
  local filedata = {}
  for line in io.lines(file) do
    filedata[#filedata+1] = line
  end
  return filedata
end

local function file_check(file_name)
  if fs.exists(tostring(file_name)) then
    return true
  else
     return false
  end
end

local function printCentered(y, s)
  local w,h = term.getSize()
  term.setCursorPos(w/2 - #s/2, y)
  term.write(s)
end

-- [[ Menu

local termWidth, termHeight = term.getSize()
local selectedItem = 1
local running = true

local function Choice1()
  shell.run("disk/lwindow/login")
end

local function Choice2()
  shell.run("disk/lwindow/register")
end

local function Exit()
  running = false
  print("System will shutdown in 3 secounds")
  os.sleep(3)
  shell.run("disk/startup")
end

local function Console()
  shell.run("clear")
  shell.run("shell")
  running = false
end

local function Logout()
  fs.delete("disk/lwindow/currentaccount.lua")
  running = false
  run()
end

local function Email()
  shell.run("disk/lwindow/email")
end

local function reload()
  mainMenu = {
    [1] = { text = "Login", handler = Choice1 },
    [2] = { text = "Register", handler = Choice2 },
    [3] = { text = "Exit", handler = Exit }
  }

  if file_check("disk/lwindow/currentaccount.lua") then
    name = getFile("disk/lwindow/currentaccount.lua")[1]
    isAdmin = getFile(tostring("disk/lwindow/users/".. tostring(name).. "/infos.lua"))[4]
    if tostring(isAdmin) == "true" then
     mainMenu = {
     [1] = { text = "Console", handler = Console },
     [2] = { text = "Mail", handler = Email },
     [3] = { text = "Logout", handler = Logout },
     [4] = { text = "Exit", handler = Exit }
    }
   else
     mainMenu = {
     [1] = { text = "Mail", handler = Email },
     [2] = { text = "Logout", handler = Logout },
     [3] = { text = "Exit", handler = Exit }
    }
    end
  end
end

reload()

local function printMenu( menu)
  z = 7
  term.setTextColor(colors.yellow)
  printCentered(5, "LWindow")
  term.setTextColor(colors.white)
  for i=1,#menu do
  z = z + 1
  term.setCursorPos(20, z)
    if i == selectedItem then
      print(">> "..menu[i].text)
    else
      print("   "..menu[i].text)
    end
  end
end

local function onItemSelected( menu )
  menu[selectedItem].handler()
end

local function onKeyPressed( key, menu)
  shell.run("clear")
  printMenu(mainMenu)
  if key == keys.enter then
    onItemSelected(menu)
  elseif key == keys.up then
    if selectedItem > 1 then
      selectedItem = selectedItem - 1
    end
  elseif key == keys.down then
    if selectedItem < #menu then
      selectedItem = selectedItem + 1
    end
  end
end

function main()
  term.setTextColor(colors.white)
  while running do
    shell.run("clear")
    printMenu(mainMenu)
    
    event, key = os.pullEvent("key")
    onKeyPressed(key, mainMenu)
  end
end

main()