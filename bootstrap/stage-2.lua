json = require "/libs/json"
base64 = require "/libs/base64"
common = require "/libs/common"

local args = {...}

local function walkDir(url)
  dirContents = common.httpGetJsonDecode(url)
  for _,v in pairs(dirContents) do
    if v['type'] == 'dir' then
      walkDir(v['url'])
    else
      common.downloadFile(v['download_url'], v['path'])
    end
  end
end


-- local url = args[1]
local url = 'https://api.github.com/repos/faximilie/CC-CI-CD/contents?ref='
local ref = args[2]

-- TODO Deal with ref being nil
walkDir(url .. ref)

