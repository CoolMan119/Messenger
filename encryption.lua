--Usable Characters 32-126
--encryption.encrypt(key,message) (Used for encrypting)
--encryption.decrypt(key,message) (Used for decrypting)
--encryption.generateKey(length) (Returns a key of the given length)
encrypt = function(key,message)
  local counter = 1
  local out = ""
  if type(key) ~= "string" or string.len(key) < 1 then
    error("Invalid Key")
  end
  for i = 1,string.len(message) do
    local c = string.byte(string.sub(key,counter,counter))-32+string.byte(string.sub(message,i,i))
    if c > 126 then
      c = c - 94
    end
    counter = counter + 1
    if counter > string.len(key) then
      counter = 1
    end
    out = out..string.char(c)
  end
  return out
end
decrypt = function(key,message)
  if (not key) or type(key) ~= "string" or string.len(key) < 1 then
    error("Invalid Key")
  end
  local counter = 1
  local out = ""
  for i = 1,string.len(message) do
    local c = string.byte(string.sub(message,i,i))-(string.byte(string.sub(key,counter,counter))-32)
    if c < 32 then
      c = c + 94
    end
    counter = counter + 1
    if counter > string.len(key) then
      counter = 1
    end
    out = out..string.char(c)
  end
  return out
end
generateKey = function(length)
  if (not length) or type(length) ~= "number" or length < 1 then
    error("Invalid Length")
  end
  local out = ""
  for i = 1,length do
    out = out..string.char(math.random(32,126))
  end
  return out
end
