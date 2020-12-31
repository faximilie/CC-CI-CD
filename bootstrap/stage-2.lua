json = require "/libs/json"
base64 = require "/libs/base64"
common = require "/libs/common"

local args = {...}

local function downloadGitB64(gitUrl, fileName)
  local git = common.httpGetJsonDecode(gitUrl)
  content = base64.decode(git['content'])
  local file = fs.open(fileName, "w")
  file.write(content)
  file.close()
end

local function walkDir(url)
  local dirContents = common.httpGetJsonDecode(url)
  for _,v in pairs(dirContents) do
    if v['type'] == 'dir' then
      walkDir(v['url'])
    else
      -- common.downloadFile(v['git_url'], v['path'])
      downloadGitB64(v['git_url'], v['path'])
    end
  end
end


-- local url = args[1]
local url = 'https://api.github.com/repos/faximilie/CC-CI-CD/contents?ref='
local ref = args[2]

-- TODO Deal with ref being nil
walkDir(url .. ref)

