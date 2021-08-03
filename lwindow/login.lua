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
  local realpass = table[3]
  local realskey = table[4]

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
