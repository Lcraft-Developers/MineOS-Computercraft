local getFile = function(file)
  local filedata = {}
  for line in io.lines(file) do
    filedata[#filedata+1] = line
  end
  return filedata
end


-- [[ Menu

local termWidth, termHeight = term.getSize()
local selectedItem = 1
local running = true

function Choice1()
  shell.run("disk/lwindow/login")
end

function Choice2()
  shell.run("disk/lwindow/register")
end

function Exit()
  running = false
  print("System will shutdown in 3 secounds")
  os.sleep(3)
  shell.run("disk/startup")
end

function Console()
  shell.run("clear")
  running = false
end

function Logout()
  fs.delete("disk/lwindow/currentaccount.lua")
  running = false
  run()
end

local reload()
  mainMenu = {
    [1] = { text = "Login", handler = Choice1 },
    [2] = { text = "Register", handler = Choice2 },
    [3] = { text = "Exit", handler = Exit }
  }

  if file_check("disk/lwindow/currentaccount.lua") then
    name = getFile(tostring("disk/lwindow/currentaccount.lua"))
    isAdmin = getFile(tostring("disk/lwindow/users/".. name[1] .."/infos.lua"))[5]
    if tostring(isAdmin) == "true" then
     mainMenu = {
     [1] = { text = "Logout", handler = Logout },
     [2] = { text = "Console", handler = Console },
     [3] = { text = "Exit", handler = Exit }
    }
    else
     mainMenu = {
     [1] = { text = "Logout", handler = Logout },
     [2] = { text = "Exit", handler = Exit }
    }
    end
  end
end

function printMenu( menu)
  reload()
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

function onKeyPressed( key, menu)
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

function onItemSelected( menu )
  menu[selectedItem].handler()
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