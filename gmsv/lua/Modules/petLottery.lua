--ģ������
local moduleName = 'petLottery'
--ģ����
local PetLottery = ModuleBase:createModule(moduleName)

local pets = {
  { 3004, 500, },
  { 41382, 500, },
  { 1009, 500, },
  { 16003, 500, },
  { 16005, 500, },
  { 206, 500, },
  { 245, 500, },
  { 246, 500, },
  { 14027, 220, '�ö�������' },
  { 10088, 220, '����������' },
  { 103106, 220, '��˿����' },
  { 103277, 220, '˿ŵ����' },
  { 103278, 220, 'ʥ������' },
  { 103279, 220, 'ѩ������' },
  { 10006, 120, 'Ӱ����' },
  { 10007, 120, 'Ӱ����' },
  { 10008, 120, 'Ӱ����' },
  { 10009, 120, 'Ӱ����' },
  { 511, 150, 'x��' },
  { 512, 150, 'x��' },
  { 513, 150, 'x��' },
  { 514, 150, 'x��' },
  { 41220, 100, '����' },
  { 41241, 100, '�����в�è' },
  { 41249, 90, '�����в�è' },
  { 41242, 80, 'Ǫ���в�è' },
  { 41251, 70, '�����в�è' },
  { 41244, 60, 'ʮ�����в�è' },
  { 41256, 50, '�������в�è' },
  { 103132, 50, '�󹫼�' },
  { 103342, 30, '��˹����' },
  { 103316, 20, '��ͷ��ʿ' },
  { 103317, 20, '��ս����' },
  { 103318, 20, 'Ѫ����ʿ' },
  { 103319, 20, '������ʿ' },
  { 103320, 20, '��������' },
  { 103321, 15, '÷��' },
  { 103136, 15, '������' },
  { 103327, 8, 'ѩ�ٽ�' },
  { 103326, 8, '¶��' },
}

local MAX_N = table.reduce(pets, function(t, e)
  return t + e[2]
end, 0);

--- ����ģ�鹳��
function PetLottery:onLoad()
  self:logInfo('load')
  self:regCallback('ItemUseEvent', Func.bind(self.onItemUsed, self));
  --59999	137	123
  self.npc = self:NPC_createNormal('PetLottery', 10000, { x = 137, y = 123, mapType = 0, map = 59999, direction = 0, })
  self:NPC_regWindowTalkedEvent(self.npc, Func.bind(self.onWindowTalked, self));
end

function PetLottery:onWindowTalked(npc, player, seqNo, select, data)
  if select == CONST.BUTTON_�� then
    Char.GivePet(player, tonumber(seqNo));
  end
  NLG.UpChar(player);
end

function PetLottery:onItemUsed(charIndex, targetCharIndex, itemSlot)
  local itemIndex = Char.GetItemIndex(charIndex, itemSlot);
  if tonumber(Item.GetData(itemIndex, CONST.����_ID)) == 47763 then
    --NLG.ShowWindowTalked(charIndex, charIndex, CONST.����_��Ϣ��, CONST.BUTTON_�Ƿ�, 0, "\\n\\n    �Ƿ�")
    Char.DelItemBySlot(charIndex, itemSlot);
    local n = math.random(0, MAX_N)
    local k = n;
    for i, v in ipairs(pets) do
      if n <= v[2] then
       local name = Data.EnemyBaseGetData(Data.EnemyBaseGetDataIndex(Data.EnemyGetData(Data.EnemyGetDataIndex(tonumber(v[1])), CONST.DATA_ENEMY_TEMPNO)), CONST.DATA_ENEMYBASE_NAME) or 'nil';
        NLG.ShowWindowTalked(charIndex, self.npc, CONST.����_��Ϣ��, CONST.BUTTON_�Ƿ�, v[1],
          "\\n\\n    (" .. k .. ")��ƷΪ�� " .. name .. " һֻ���Ƿ���ȡ��")
        return -1;
      end
      n = n - v[2]
    end
    NLG.SystemMessage(charIndex, "���˸���į")
    return -1;
  end
  return 1;
end

--- ж��ģ�鹳��
function PetLottery:onUnload()
  self:logInfo('unload')
end

return PetLottery;
