---ģ����
local BattleEx = ModuleBase:createModule('battleEx')

--- ����ģ�鹳��
function BattleEx:onLoad()
  self:logInfo('load')
  --self:regCallback('BattleStartEvent', function(battleIndex)
  --  local encountId = Data.GetEncountData(Battle.GetNextBattle(battleIndex), CONST.Encount_ID)
  --  local nextencountid = Data.GetEncountData(Battle.GetNextBattle(battleIndex), CONST.Encount_NextEncountID)
  --  self:logDebug(Battle.GetNextBattle(battleIndex), encountId, nextencountid);
  --  self:logDebug(Data.GetEncountIndex(1041));
  --  if encountId ~= 1041 then
  --    Battle.SetNextBattle(battleIndex, Data.GetEncountIndex(1041));
  --  end
  --end)
end

--- ж��ģ�鹳��
function BattleEx:onUnload()
  self:logInfo('unload')
end

return BattleEx;
