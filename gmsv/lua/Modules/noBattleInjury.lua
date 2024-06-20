---ģ����
local NoBattleInjury = ModuleBase:createModule('noBattleInjury.lua')

--- ����ģ�鹳��
function NoBattleInjury:onLoad()
  self:logInfo('load')
  self:regCallback("BattleInjuryEvent", function(charIndex, battleIndex, injectOrigin, inject)
    if Char.GetData(charIndex, CONST.CHAR_Ѫ) > 0 then
      -- ���ر�����������
      return 0;
    end
    return inject;
  end)
end

--- ж��ģ�鹳��
function NoBattleInjury:onUnload()
  self:logInfo('unload')
end

return NoBattleInjury;
