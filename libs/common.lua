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

return common
