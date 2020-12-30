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
  url = git_url . file
  download_file(url)
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




