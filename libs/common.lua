-- Bunch of common functions I really don't want to litter the top of my files with
local common = {}
function common.httpGetJsonDecode(url)
  local request, err = http.get(url)
  if not request then error(err) end
  output = json.decode(request.readAll())
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

function common.downloadGitB64(gitUrl, fileName)
  local git = common.httpGetJsonDecode(gitUrl)
  local content = base64.decode(git['content'])
  local file = fs.open(fileName, "w")
  file.write(content)
  file.close()
end

function common.walkDir(url)
  local dirContents = common.httpGetJsonDecode(url)
  for _,v in pairs(dirContents) do
    if v['type'] == 'dir' then
      walkDir(v['url'])
    else
      common.downloadGitB64(v['git_url'], v['path'])
    end
  end
end

function common.walkDir(url)
  local dirContents = common.httpGetJsonDecode(url)
  for _,v in pairs(dirContents) do
    if v['type'] == 'dir' then
      common.walkDir(v['url'])
    else
      common.downloadGitB64(v['git_url'], v['path'])
    end
  end
end
return common
