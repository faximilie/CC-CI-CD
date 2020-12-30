-- Bunch of common functions I really don't want to litter the top of my files with
function common.http_get_json_decode(url)
  local request, err = http.get(url)
  if not request then error(err) end
  output = json.decode(request.readAll())
  request.close()
  return output
end
