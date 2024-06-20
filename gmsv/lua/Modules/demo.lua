---ģ����
local Module = ModuleBase:createModule('demo')

--- ����ģ�鹳��
function Module:onLoad()
  self:logInfo('load')
  self:regCallback('PreItemPickUpEvent', function(charIndex, itemIndex)
    local n = NLG.Rand(1, 100);
    self:logDebugF('PreItemPickUpEvent %d %s => %d %s %d%%', charIndex, Char.GetData(charIndex, CONST.CHAR_����), itemIndex, Item.GetData(itemIndex, CONST.����_����), n);
    if n < 50 then
      return -1;
    end
    return 0;
  end)
end

--- ж��ģ�鹳��
function Module:onUnload()
  self:logInfo('unload')
end

return Module;
