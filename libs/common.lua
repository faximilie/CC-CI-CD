-- Bunch of common functions I really don't want to litter the top of my files with
local common = {}
function common.httpGetJsonDecode(url, auth)
  local headers = {}
  local auth = auth or nil
  if auth then
    headers['Authorization'] = auth
  end
  local request, err = http.get(url, headers)
  if not request then error(err) end
  local output = json.decode(request.readAll())
  request.close()
  return output
end

function common.downloadFile(url, fileName)
  local request, err = http.get(url)

  if not request then error(err) end

  local file = fs.open(fileName, "w")
  file.write(request.readAll())
  file.close()
  request.close()
end

function common.downloadGitB64(gitUrl, fileName, auth)
  local auth = auth or nil
  local git = common.httpGetJsonDecode(gitUrl, auth)
  local content = base64.decode(git['content'])
  local file = fs.open(fileName, "w")
  file.write(content)
  file.close()
end

function common.walkDir(url, prefix, auth)
  local auth = auth or nil
  local dirContents = common.httpGetJsonDecode(url)
  for _,v in pairs(dirContents) do
    if v['type'] == 'dir' then
      common.walkDir(v['url'], prefix, auth)
    else
      common.downloadGitB64(v['git_url'], prefix .. v['path'], auth)
    end
  end
end
return common
