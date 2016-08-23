-- File Dialog API by CrazedProgrammer
-- You can find info and documentation on these pages:
--
-- You may use this in your ComputerCraft programs and modify it without asking.
-- However, you may not publish this API under your name without asking me.
-- If you have any suggestions, bug reports or questions then please send an email to:
-- crazedprogrammer@gmail.com
 
local function list(dir)
    local fullList = fs.list(dir)
    table.sort(fullList, function (a, b) return string.lower(a) < string.lower(b) end)
    local displayList = { }
    for i = 1, #fullList do if fs.isDir(dir.."/"..fullList[i]) then displayList[#displayList + 1] = fullList[i] end end
    for i = 1, #fullList do if not fs.isDir(dir.."/"..fullList[i]) then displayList[#displayList + 1] = fullList[i] end end
    return displayList
end
 
local function draw(dir, offset)
    local width, height = term.getSize()
    term.setBackgroundColor(colors.white)
    term.clear()
    term.setCursorPos(1, 2 - offset)
    term.setBackgroundColor(colors.yellow)
    term.setTextColor(colors.black)
    term.write(".."..string.rep(" ", width - 2))
    for k,v in pairs(list(dir)) do
        term.setCursorPos(1, k + 2 - offset)
        if fs.isDir(dir.."/"..v) then
            term.setBackgroundColor(colors.yellow)
            term.write(v..string.rep(" ", width - #v))
        else
            term.setBackgroundColor(colors.white)
            term.write(v)
        end
    end
    term.setCursorPos(1, 1)
    term.setBackgroundColor(colors.gray)
    term.setTextColor(colors.white)
    if dir ~= "" then
        term.write("/"..dir..string.rep(" ", width - #dir - 2))
    else
        term.write("/"..string.rep(" ", width - 2))
    end
    term.setBackgroundColor(colors.red)
    term.write("X")
    term.setBackgroundColor(colors.gray)
    term.setCursorPos(width, 2)
    term.write("^")
    term.setCursorPos(width, height - 1)
    term.write("v")
    term.setCursorPos(1, height)
    term.setBackgroundColor(colors.lightGray)
    term.setTextColor(colors.black)
    term.write(string.rep(" ", width))
end
 
local function reset()
    term.setCursorPos(1, 1)
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
    term.clear()
end
 
function open(dir)
    dir = dir or ""
    local offset, width, height = 0, term.getSize()
    draw(dir, offset)
    while true do
        local e = {os.pullEvent()}
        if e[1] == "mouse_click" then
            local x, y = e[3], e[4]
            if x == width and y == 1 then
                reset()
                return
            elseif x == width and y == 2 then
                offset = offset - math.floor(height / 3) + 1
                if offset < 0 then
                    offset = 0
                end
            elseif x == width and y == height - 1 then
                offset = offset + math.floor(height / 3) - 1
            elseif y > 1 and y < height then
                if y + offset == 2 and dir ~= "" then
                    dir = fs.getDir(dir)
                else
                    for k,v in pairs(list(dir)) do
                        if k == y + offset - 2 then
                            if fs.isDir(dir.."/"..v) then
                                dir = fs.getDir(dir.."/"..v.."/_")
                            else
                                reset()
                                return fs.getDir(dir.."/"..v.."/_")
                            end
                        end
                    end
                end
            elseif y == height then
                term.setCursorPos(1, height)
                local file = read()
                if file == "" then
                elseif file == ".." and dir ~= "" then
                    dir = fs.getDir(dir)
                elseif file:sub(1, 1) == "/" then
                    if fs.isDir(file) then
                        dir = file:sub(2, #file)
                    else
                        reset()
                        return file:sub(2, #file)
                    end
                elseif fs.isDir(dir.."/"..file) then
                    dir = fs.getDir(dir.."/"..file.."/_")
                else
                    reset()
                    return fs.getDir(dir.."/"..file.."/_")
                end
            end
        elseif e[1] == "mouse_scroll" then
            offset = offset + e[2] * (math.floor(height / 3) - 1)
            if offset < 0 then
                offset = 0
            end
        elseif e[1] == "term_resize" then
            width, height = term.getSize()
        end
        draw(dir, offset)
    end
end
