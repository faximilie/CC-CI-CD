-- Pull stage-2.lua and required libraries
-- Run them

-- Files start with / to make absolute file paths cleaner to implement
files = {
  '/bootstrap/stage-2.lua',
  '/libs/base64.lua',
  '/libs/json.lua'
}

gitUrl = 'https://raw.githubusercontent.com/faximilie/CC-CI-CD/main/devops%20IN%20MINECRAFT'

for file in files do
  url = gitUrl .. file
  downloadFile(url, file)
end

-- We need to move our current program to it's proper place but we may not know it's name
fs.move(shell.getRunningProgram(), "/bootstrap/stage-1.lua")

-- We can't really fork but we can open a new tab and kill the current one
shell.openTab("/bootstrap/stage-2.lua", ...) -- This will pass args to the next stage
shell.exit() -- Close this shell to make sure the new tab is the only tab


local function downloadFile(url, fileName)
  local request, err = http.get(url)

  if not request then error(err) end

  local file = fs.open(fileName, "w")
  file.write(request.readAll())
  file.close()
  request.close()
end




