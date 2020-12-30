-- Clone entire git repo
-- Allow branches/versions
-- Provide mechanisms to update against repo (os.timers?)
json = require "json"

local arg = { ... }

url = arg[1]



local function http_get_json_decode(url)
  local request, err = http.get(url)
  if not request then error(err) end
  output = json.decode(request.readAll())
  request.close()
  return output
end

print(http_to_json('https://api.github.com/repos/faximilie/CC-CI-CD/contents/'))
