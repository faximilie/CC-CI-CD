-- Clone entire git repo
-- Allow branches/versions
-- Provide mechanisms to update against repo (os.timers?)
json = require "/libs/json"
base64 = require "/libs/base64"
common = require "/libs/common"

local arg = { ... }

function addRefToGitUrl(url, ref)
end

url = arg[1]
ref = arg[2]

if ref == nil then
  ref = 'main'
end

config = json.decode(common.readFile('config.json'))

if not config['auth_token'] then
  print('Auth token not defined, Githubs API limit is 60 for un-authenticated users')
end

gitUrl = 'https://api.github.com/repos/%s/contents?ref=%s'

common.walkDir(gitUrl:format(url, ref), config['auth_token'])
