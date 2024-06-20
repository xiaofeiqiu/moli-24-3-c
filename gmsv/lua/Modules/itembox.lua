---����ģ��
local Module = ModuleBase:createModule('itembox')

--- ����ģ�鹳��
function Module:onLoad()
  self:logInfo('load')
  self:regCallback('ItemBoxGenerateEvent', function(mapType, floor, boxId, adm)
    local n = NLG.Rand(1, 100);
    -- 30% �ڱ��䣬30%�ױ��䣬 40%��ͨ����
    if n > 70 then
      --self:logDebug('ItemBoxGenerateEvent', mapType, floor, boxId, 18003, adm);
      return { 18003, adm }
    end
    if n > 40 then
      --self:logDebug('ItemBoxGenerateEvent', mapType, floor, boxId, 18004, adm);
      return { 18004, adm }
    end
    --self:logDebug('ItemBoxGenerateEvent', mapType, floor, boxId, 18002, adm);
    return { 18002, adm };
  end)
end

--- ж��ģ�鹳��
function Module:onUnload()
  self:logInfo('unload')
end

return Module;
