-- Pull git.lua, websocket.lua and tests.lua
-- Run them
json = require "json"


local function http_to_json(url)
  local request, err = http.get(url)
  if not request then error(err) end
  -- Print the contents
  output = json.decode(request.readAll())
  request.close() -- Don't forget to close!
end


local function download_file(url)
  local request, err = http.get(url)

  if not request then error(err) end

  local split = string.split(url, '/')

  local file_name = split[#split]

  local file = fs.open(file_name, "w")
  file.write(request.readAll())
  file.close()
  request.close()
end


function split(haystack, needle)
  local start_pos = 0
  local end_pos = 0
  local parts = {}

  while end_pos ~= nil do
    start_pos = end_pos

    -- Move end position forward to next instance
    end_pos = string.find(haystack, needle, start_pos+1)

    -- If not nil we should grab between last find +1 and our new find -1
    if end_pos ~= nil then
      sub_string = string.sub(haystack, start_pos+1, end_pos-1)
    else
      -- If it's nil we can just have the last of the string
      sub_string = string.sub(haystack, start_pos+1)
    end

    -- Ensure we're only adding valid strings
    if sub_string ~= '' then
      parts[#parts + 1] = sub_string
    end
  end
end

print(http_to_json('https://api.github.com/repos/faximilie/CC-CI-CD/contents/'))


