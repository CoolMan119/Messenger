foundModem = false
-- Gets functions ready for use
function Setup()
	term.clear()
	term.setBackgroundColor(colors.black)
	term.clear()
	term.setCursorPos(1,1)
	term.setTextColor(colors.white)
	textutils.slowPrint("Welcome to Messaging!")
	textutils.slowPrint("Before we can continue, we have to setup the app for you")
	os.sleep(2)
	term.clear()
	term.setBackgroundColor(colors.gray)
	term.clear()
	term.setCursorPos(1,1)
	print("Please type in a color theme")
	colortheme = read()
	print("Applying...")
	shell.run("mkdir","config")
	shell.run("cd","config")
	file = fs.open("/config/color", "w")
	file.write(colortheme)
	file.close()
	term.clear()
	term.setCursorPos(1,1)
	textutils.slowPrint("Checking for rednet...")
	while not foundModem do
		if rednetCheckup() then else 
			print("Please attached a wireless modem")
		end
	end
	print("Rednet Found")
	textutils.slowPrint("Welp, this is the end of Setup! I really hope you enjoy this app! Please report all bugs on the Issues fourms! Thank You and have a Nice Day!")
	os.sleep(3)
	fs.delete("/status")
	file = fs.open("/status", "w")
	file.write("complete")
	file.exit()
	Load()
end
 
function rednetCheckSetup()
  for k,v in pars(rs.getSides()) do
    if peripheral.getType(v) == "modem" then
       if peripheral.call(v, "isWireless") == true then
         modemSide = v
         foundModem = true
       end
    end
	end
	if not foundModem then
		return false
  end
		return true
	end
end
  

function Load()
  term.clear()
	term.setCursorPos(1,1)
  print("Loaded")
  print("This app is under development and doesn't work yet, Sorry!")
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
  if result == "nosetup" then
    Setup()
  elseif result == "complete" then
    Load()
  end
end
Contact GitHub API Training Shop Blog About
© 2016 GitHub, Inc. Terms Privacy Security Status Help
