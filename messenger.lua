os.pullEvent = os.pullEventRaw

if not fs.exists(".CHATCONFIG")
  local toAppend = {}

  term.setBackgroundColor(colors.gray)

  term.clear()

  paintutils.drawLine(1, 1, x, 1, colors.lightGray)

  term.setTextColor(colors.white)

  term.setCursorPos(1, 1)

  print("Messenger Configuration")

  term.setBackgroundColor(colors.gray)

  term.setCursorPos(1, 3)

  print("Enter your username:")

  term.setCursorPos(1, 4)

  toAppend["username"] = read()
end