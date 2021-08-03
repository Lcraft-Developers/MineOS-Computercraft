function printCentered( y,s )
  local w,h = term.getSize()
  term.setCursorPos(w/2 - #s/2, y)
  term.write(s)
end

shell.run("clear")
term.setTextColor(colors.white)
print("-------------------------------------")
print("OS starting...")
print("OS Type: LWindow")
print("Computer ID: ".. tostring(os.getComputerID()))
print("OS Build Version: ".. tostring(os.version()))
print("OS Version: 1.2.5b")
print("Time: ".. tostring(os.time()))
print("Day: ".. tostring(os.day()))
print("-------------------------------------")
os.sleep(math.random(3,10))
shell.run("clear")

term.setBackgroundColor(colors.black)
term.setTextColor(colors.yellow)
printCentered(5, "LWindow")
term.setTextColor(colors.gray)
printCentered(18, "by Lcraft Studios")
term.setTextColor(colors.white)

fs.delete("disk/lwindow/currentaccount.lua")

os.sleep(2)
shell.run("disk/lwindow/menu")

