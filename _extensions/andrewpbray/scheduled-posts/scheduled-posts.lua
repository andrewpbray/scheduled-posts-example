-- Toggle draft to true if the date of the doc is in the future
function Meta(m)
  if m.date ~= nil then
    if tonumber(m.date[1].text) > os.time() then 
      m["draft"] = true
      return m
    end
  end
end