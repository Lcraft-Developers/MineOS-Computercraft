local function function getFile(file)
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

local function tbl2file(file,tbl)
  local file = fs.open(file,"w")
  for k,v in pairs(tbl) do
    file.writeLine(v)
  end
  file.close()
end

local function printCentered(y,s)
  local w,h = term.getSize()
  term.setCursorPos(w/2 - #s/2, y)
  term.write(s)
end

shell.run("clear")
term.setTextColor(colors.white)
printCentered(3, "LWindow - Login")
printCentered(6, "Username: ")
local username = read()
printCentered(8, "Password: ")
local passwort = read("*")
printCentered(9, "S-Key: ")
local skey = read("*")

root = "disk/lwindow/users/"..username

if not file_check(tostring(root).. "/infos.lua") then
  print("\n\nThis account dont exist!")
  sleep(2)
else
  local table = getFile(tostring(root).."/infos.lua")
  local realpass = table[2]
  local realskey = table[3]

  if realpass == passwort then
    if realskey == skey then
      print("\n\nNow you are logged in")
      local usercur = {username}
      tbl2file("disk/lwindow/currentaccount.lua", usercur)
      sleep(2)
    else
      print("\n\nSkey is wrong")
      sleep(2)
    end
  else
    print("\n\nPassword is wrong")
    sleep(2)
  end
end
shell.run("disk/lwindow/menu")
