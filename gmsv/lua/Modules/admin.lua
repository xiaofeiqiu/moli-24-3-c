---@class Admin:ModuleBase|ModuleType
local Admin = ModuleBase:createModule('admin')
-- gm����
local commands = {}
--GM�˺��б�
local gmList = { 'u01', 'u02', 'u03', 'u04', 'u05', 'aaa','gongjianshou','fashi'};
local gmDict = {};
table.forEach(gmList, function(e)
  gmDict[e] = true
end)

function commands.module(charIndex, args)
  if args[1] == 'reload' then
    reloadModule(args[2]);
  elseif args[1] == 'unload' then
    unloadModule(args[2]);
  elseif args[1] == 'load' then
    loadModule(args[2]);
  end
end

function commands.dofile(charIndex, args)
  local r, msg = pcall(dofile, args[1]);
  if not r then
    NLG.TalkToCli(charIndex, -1, tostring(msg));
  end
end

---�Ƿ����Ա
---@param charIndex CharIndex
---@return boolean
function Admin:isAdmin(charIndex)
  local cdKey = Char.GetData(charIndex, CONST.CHAR_CDK)
  if not gmDict[cdKey] then
    return false
  end
  return true;
end

function Admin:handleChat(charIndex, msg, color, range, size)
  if not self:isAdmin(charIndex) then
    return 1
  end
  local command = msg:match('^/([%w]+)')
  if commands[command] then
    local arg = msg:match('^/[%w]+ +(.+)$')
    arg = arg and string.split(arg, ' ') or {}
    commands[command](charIndex, arg);
    return 0
  end
  return 1
end

function Admin:onLoad()
  self:logInfo('load')
  self:regCallback('TalkEvent', Func.bind(Admin.handleChat, self))
end

function Admin:onUnload()
  self:logInfo('unload')
end

return Admin;
