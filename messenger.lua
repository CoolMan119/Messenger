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
  
  
end
 

function Load()
  term.clear()
  print("Loaded")
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
  if result == "nosetup" then
    Setup()
  elseif result == "complete" then
    Load()
  end
end
