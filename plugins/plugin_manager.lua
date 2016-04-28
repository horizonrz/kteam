local function saveplug(extra, success, result)
  local msg = extra.msg
  local name = extra.name
  local receiver = get_receiver(msg)
  if success then
    local file = 'plugins/'..name..'.lua'
    print('File saving to:', result)
    os.rename(result, file)
    print('File moved to:', file)
  else
    print('Error downloading: '..msg.id)
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false)
  end
end
local function run(msg, matches)
local receiver = get_receiver(msg)
local group = msg.to.id
    if msg.reply_id then
   local name = matches[2]
      if matches[1] == "save" and matches[2] and is_sudo(msg) then
load_document(msg.reply_id, saveplug, {msg=msg,name=name})
        return 'Plugin '..name..' has been saved.'
    end
end
if matches[1]:lower() == 'addplug' and is_sudo(msg) then
  local text = matches[2]
  local b = 1
  local name = matches[3]
  local file = io.open("plugins/"..name..matches[4], "w")
  file:write(text)
  file:flush()
  file:close()
  return "Done!"
  end
if matches[1]:lower() == 'send' and is_sudo(msg) then
send_document(get_receiver(msg), "plugins/"..matches[2]..".lua", ok_cb, false)
end
  if matches[1]:lower() == 'send>' and is_sudo(msg) then
 local plg = io.popen("cat plugins/"..matches[2]..".lua" ):read('*all')
  return plg
end
  return {
  patterns = {
    "^[!/#]([Aa]ddplug) (.+) (.*) (.*)$",
	"^[!/#]([Ss]end) (.*)$",
	"^[!/#]([Ss]end>) (.*)$",
	"^[!/#]([Ss]ave) (.*)$",
  },
  run = run
}

