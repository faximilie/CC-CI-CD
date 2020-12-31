json = require "/libs/json"
base64 = require "/libs/base64"
common = require "/libs/common"

local args = {...}

local url = 'https://api.github.com/repos/faximilie/CC-CI-CD/contents?ref='
local ref = args[2]

-- TODO Deal with ref being nil
common.walkDir(url .. ref)

