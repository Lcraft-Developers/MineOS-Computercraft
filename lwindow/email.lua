local function printCentered( y,s )
    local w,h = term.getSize()
    term.setCursorPos(w/2 - #s/2, y)
    term.write(s)
end

local isRunning = true

local function printMenu()
    term.setTextColor(colors.white)
    term.setCursorPos(10, 19)
    print("Press Y to go to the menu")
end

local function onKeyPressed(key)
    key = key - 1
    if key == keys.y then
        shell.run("disk/lwindow/menu")
    end
end

local function main()
    while isRunning do
        shell.run("clear")
        printMenu()

        event, key = os.pullEvent("key")
        onKeyPressed(key)
    end
end

main()