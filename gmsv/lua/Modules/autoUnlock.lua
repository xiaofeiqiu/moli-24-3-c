---ģ����
local Module = ModuleBase:createModule('autoUnlock')

function Module:onLogin(fd, head, data)
  local user = SQL.querySQL('select RegistNumber from tbl_lock where CdKey = ' .. SQL.sqlValue(data[3]), true);
  if user then
    local charIndex = NLG.FindUser(data[3], tonumber(user[1][1]));
    if charIndex >= 0 then
      return 0;
    end
    self:logInfo('����', data[3])
    SQL.querySQL('delete from tbl_lock where CdKey = ' .. SQL.sqlValue(data[3]));
    SQL.querySQL('delete from tbl_lock2 where CdKey = ' .. SQL.sqlValue(data[3]));
  end
end

function Module:onTalked(charIndex, msg, color, range, size)
  local command = msg:match('^/([%w]+)')
  if command and string.lower(command) == 'selfkickout' then
    local arg = msg:match('^/[%w]+ +(.+)$')
    arg = arg and string.split(arg, ' ') or {}
    if #arg >= 2 then
      local ret = SQL.querySQL("select 1 from tbl_user where CdKey = " .. SQL.sqlValue(arg[1]) .. ' and AccountPassWord = ' .. SQL.sqlValue(arg[2]), true)
      if ret ~= nil then
        local targetChar = NLG.FindUser(arg[1]);
        if targetChar >= 0 then
          self:logInfoF("%s(%s) �߳� %s(%s)",
            Char.GetData(charIndex, CONST.CHAR_����),
            Char.GetData(charIndex, CONST.CHAR_CDK),
            Char.GetData(targetChar, CONST.CHAR_����),
            Char.GetData(targetChar, CONST.CHAR_CDK)
          )
          NLG.DropPlayer(targetChar);
          NLG.SystemMessage(charIndex, string.format('�����ɹ�'));
        else
          NLG.SystemMessage(charIndex, string.format('���˻�������'));
        end
      else
        --todo ��ȫ����
        NLG.SystemMessage(charIndex, string.format('�˺Ż����벻��ȷ'));
      end
    else
      NLG.SystemMessage(charIndex, string.format('ָ�����: /selfKickOut �˺� ����'));
    end
    return 0
  end
  return 1
end

--- ����ģ�鹳��
function Module:onLoad()
  self:logInfo('load')
  self:regCallback('ProtocolOnRecv', Func.bind(self.onLogin, self), 'JFVf');
  self:regCallback('TalkEvent', Func.bind(self.onTalked, self));
end

--- ж��ģ�鹳��
function Module:onUnload()
  self:logInfo('unload')
end

return Module;
