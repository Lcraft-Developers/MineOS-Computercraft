function printCentered( y,s )
  local w,h = term.getSize()
  term.setCursorPos(w/2 - #s/2, y)
  term.write(s)
end

term.setTextColor(colors.white)
shell.run("clear")

-- [[ Menu

local termWidth, termHeight = term.getSize()
local selectedItem = 1
local running = true

function Choice1()
  running = false
  shell.run("disk/lwindow/starter")
end

function Exit()
  running = false
  print("\n\n\nSystem will shutdown in 3 secounds")
  os.sleep(3)
  os.shutdown()
end

mainMenu = {
 [1] = { text = "LWindow", handler = Choice1 },
 [2] = { text = "Exit", handler = Exit }
}

function printMenu( menu)
  z = 7
  term.setTextColor(colors.yellow)
  printCentered(5, "MineOS")
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
  while running do
    shell.run("clear")
    printMenu(mainMenu)
    
    event, key = os.pullEvent("key")
    onKeyPressed(key, mainMenu)
  end
end


main()
