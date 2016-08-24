local request

local ret

local function http(url)
    url = textutils.formatUrl(url)

    request = http.get(url)

    if request == nil then
        return false
    else
        ret = request.readAll()

        request.close()

        return ret
    end
end

