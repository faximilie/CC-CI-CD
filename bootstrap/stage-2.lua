json = require "/libs/json"
base64 = require "/libs/base64"
common = require "/libs/common"

local args = {...}

local url = 'https://api.github.com/repos/faximilie/CC-CI-CD/contents?ref=main'

common.walkDir(url)

