os.pullEvent = os.pullEventRaw

local files = {
    [1] = {
        "messenger",
        "https://raw.githubusercontent.com/CoolMan119/Messenger/master/messenger.lua"
    },
    [2] = {
        "AES",
        "https://raw.githubusercontent.com/CoolMan119/Messenger/master/AES.lua"
    }
}

local suffix = "Install" 

local suffix2 = "Installing"

local suffix3 = "install"

if fs.exists("messenger") then
    suffix = "Upgrade"

    suffix2 = "Upgrading"

    suffix3 = "upgrade"
end

local x, y = term.getSize()

local function cPrint(text, y)
    local nx = math.floor(((x / 2) - #text)) + math.floor(#text / 2) + 1

    if x % 2 ~= 0 then
        nx = nx + 1
    end

    term.setCursorPos(nx, y)

    print(text)

    return nx
end

term.setBackgroundColor(colors.gray)

term.clear()

paintutils.drawLine(1, 1, x, 1, colors.lightGray)

term.setTextColor(colors.white)

term.setCursorPos(1, 1)

print("Messenger upgrader/installer")

term.setBackgroundColor(colors.gray)

term.setCursorPos(1, 3)

print("Pressing continue will "..suffix3.." Messenger and all of its assets:")

term.setCursorPos(1, 6)

term.setTextColor(colors.blue)

local installmessage = suffix.." Now"

print(installmessage)

local clicked = false

local data = {}

while not clicked do
    data = {os.pullEvent("mouse_click")}
    if data[4] == 6 and data[3] >= 1 and data[3] <= #suffix + 4 then
        clicked = true
    end
end

term.setBackgroundColor(colors.gray)

term.clear()

paintutils.drawLine(1, 1, x, 1, colors.lightGray)

term.setTextColor(colors.white)

term.setCursorPos(1, 1)

print(suffix2..":")

term.setBackgroundColor(colors.gray)

term.setCursorPos(1, 3)

print("Progress:")

paintutils.drawLine(1, 5, x, 5, colors.lightGray)

local req

local code

local file

local each = math.floor(x / #files)

local lastX = 1

local closeMessage = "Done!"

for k, v in pairs(files) do
    req = http.get(v[2])

    if req ~= nil then
        code = req.readAll()

        req.close()
    else
        paintutils.drawLine(1, 5, x, 5, colors.red)

        closeMessage = "Failed!"

        break
    end

    if #files == k then
        paintutils.drawLine(1, 5, x, 5, colors.lime)
    else
        paintutils.drawLine(lastX, 5, lastX + each, 5, colors.blue)
    end

    file = fs.open(v[1], "w")

    file.write(code)
 
    file.close()

    lastX = lastX + each
end

term.setBackgroundColor(colors.gray)

cPrint(closeMessage, y - 3)

sleep(3)

term.setBackgroundColor(colors.black)

term.clear()

term.setCursorPos(1, 1)
