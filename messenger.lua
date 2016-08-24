foundModem = false
-- Gets functions ready for use
local actualColors = {
	 colors.white,
	 colors.orange,
	 colors.magenta,
	 colors.lightBlue,
	 colors.yellow,
	 colors.lime,
	 colors.pink,
	 colors.gray,
	 colors.lightGray,
	 colors.cyan,
	 colors.purple,
	 colors.blue,
	 colors.brown,
	 colors.green,
	 colors.red,
	 colors.black
}

local sx, sy = term.getSize()

function Setup()
	local colorSetup = false

	term.clear()
	term.setBackgroundColor(colors.black)
	term.clear()
	term.setCursorPos(1,1)
	term.setTextColor(colors.white)
	textutils.slowPrint("Welcome to Messaging!")
	textutils.slowPrint("Before we can continue, we have to setup the app for you")
	os.sleep(2)

	if not fs.exists("config/color") then
		while not colorSetup do --Fixes theme issue
			term.setTextColor(colors.white)

			term.clear()
			term.setBackgroundColor(colors.gray)

			paintutils.drawLine(1, 1, sx, 1, colors.lightGray)

			term.setCursorPos(1, 1)

			write("Setup")

			term.setBackgroundColor(colors.gray)

			term.setCursorPos(1, 3)

			write("Enter theme code:")

			local tc = read()

			tc = tonumber(tc)

			if tc ~= nil then
				for k, v in pairs(actualColors) do
					if v == tc then
						colorSetup = true
					end
				end
			end
		end

		local file = fs.open("config/color", "w")
		file.write(tostring(tc))
		file.close()

		term.setBackgroundColor(tc)
	else
		local file = fs.open("config/color", "r")

		term.setBackgroundColor(tonumber(file.readAll()))

		file.close()
	end

	while not foundModem do
		if rednetCheckSetup() then else 
			error("Please attach a wireless modem and run Setup again")
		end
	end
	print("Rednet Found")
	textutils.slowPrint("Welp, this is the end of Setup! I really hope you enjoy this app! Please report all bugs on the Issues fourms! Thank You and have a Nice Day!")
	
	fs.delete("/status")
	file = fs.open("/status", "w")
	file.write("complete")
	file.close()
	fs.delete("/config/config")
	os.sleep(3)
	Load()
end
 
function rednetCheckSetup()
  for k,v in pairs(rs.getSides()) do
    if peripheral.getType(v) == "modem" then
       if peripheral.call(v, "isWireless") == true then
         modemSide = v
         foundModem = true
       end
    end
	end
	if not foundModem then
		return false
  	else
		return true
	end
end
  

function Load()
  term.clear()
  term.setCursorPos(1,1)
  rednetCheckSetup()
  if rednetCheckSetup() then else
  	error("Please atatch a wireless modem and run Messenger again")
  end
  file = fs.open("/config/color", "r")
  local theme = file.readLine()
  term.clear()
  term.setTextColor(colors.white)
  print("This app does nothing yet, Sorry!")
  
end

  

 
-- Program Starts Here
term.clear()
if fs.exists("/status") == false then
  file = fs.open("/status", "w")
  file.write("nosetup")
  file.close()
  Setup()
elseif fs.exists("/status") == true then
  file = fs.open("/status", "r")
  result = file.readLine()
  file.close()
  if result == "nosetup" then
    Setup()
  elseif result == "complete" then
    Load()
  end
end
