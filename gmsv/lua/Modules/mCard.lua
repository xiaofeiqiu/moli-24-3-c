---װ���忨ģ��
local ModuleCard = ModuleBase:createModule('mCard')

local NormalRate = 2;
local BossRate = 1;

function ModuleCard:onBattleStartEvent(battleIndex)
  local type = Battle.GetType(battleIndex)
  self:logDebug('battle start', battleIndex, type, CONST.ս��_��ͨ)
  if type == CONST.ս��_��ͨ then
    --local enemyDataList = {};
    --self.cache[tostring(battleIndex)] = enemyDataList;
    for i = 10, 19 do
      local charIndex = Battle.GetPlayer(battleIndex, i);
      if charIndex >= 0 then
        local enemyId = Char.GetData(charIndex, CONST.CHAR_EnemyBaseId);
        --self:logDebug('enemy', battleIndex, i, charIndex, enemyId,
        --  Char.GetData(charIndex, CONST.CHAR_EnemyBaseId),
        --  Char.GetData(charIndex, CONST.CHAR_����)
        --);

        local rate = NormalRate;
        if Char.GetData(charIndex, CONST.CHAR_EnemyBossFlg) == 1 then
          rate = BossRate;
        end
        --rate = 1000;
        if math.random(0, 100) >= rate then
          goto continue;
        end
        local itemIndex = Char.GiveItem(charIndex, 606627, 1, false);
        if itemIndex >= 0 then
          Item.SetData(itemIndex, CONST.����_�Ѽ���, 1);
          local name = Data.EnemyBaseGetData(Data.EnemyBaseGetDataIndex(enemyId), CONST.DATA_ENEMYBASE_NAME) or 'nil';
          Item.SetData(itemIndex, CONST.����_����, string.format("װ����Ƭ(%s)", name));
          Item.SetData(itemIndex, CONST.����_Func_UseFunc, 'LUA_useMCard');
          Item.SetData(itemIndex, CONST.����_Func_AttachFunc, '');
          Item.SetData(itemIndex, CONST.����_���ò���, tostring(enemyId));
          Item.SetData(itemIndex, CONST.����_Explanation1, -1);
          Item.SetData(itemIndex, CONST.����_Explanation2, -1);
          Item.UpItem(charIndex, itemIndex);
        end
        --if enemyId and enemyId > 0 then
        --  enemyDataList[tostring(i)] = {
        --    EnemyBaseId = Char.GetData(charIndex, CONST.CHAR_EnemyBaseId),
        --    EnemyId = enemyId,
        --    Level = Char.GetData(charIndex, CONST.CHAR_�ȼ�),
        --    Name = Char.GetData(charIndex, CONST.CHAR_����),
        --    Ethnicity = Char.GetData(charIndex, CONST.CHAR_����),
        --  };
        --end
      end
      :: continue ::
    end
  end
end

--[[
function ModuleCard:onBattleOverEvent(battleIndex)
  local type = Battle.GetType(battleIndex)
  self:logDebug('battle over', battleIndex, type, CONST.ս��_��ͨ)
  if type == CONST.ս��_��ͨ then
    local enemyDataList = self.cache[tostring(battleIndex)];
    self.cache[tostring(battleIndex)] = nil;
    local winSide = Battle.GetWinSide(battleIndex);
    --self:logDebug('enemyDataList', battleIndex, enemyDataList, winSide);
    if enemyDataList == nil then
      return
    end
    --for i, v in pairs(enemyDataList) do
    --  print(i, v);
    --end
    local chars = {}
    for i = 0, 9 do
      local charIndex = Battle.GetPlayer(battleIndex, i);
      if charIndex >= 0 and Char.GetData(charIndex, CONST.CHAR_����) == CONST.��������_�� and Char.ItemSlot(charIndex) < 20 then
        table.insert(chars, charIndex)
      end
    end
    --self:logDebug('chars', #chars);
    ---@type GmsvData
    local gmsvData = getModule('gmsvData');
    -- ---@type ItemExt
    --local itemExt = getModule('itemExt');
    if winSide == 0 then
      for i, enemy in pairs(enemyDataList) do
        local enemyData = gmsvData.enemy[tostring(enemy.EnemyId)];
        if enemyData == nil then
          self:logDebug('enemy data not found', enemy.EnemyId);
          goto continue;
        end
        local rate = NormalRate;
        if enemyData[gmsvData.CONST.Enemy.IsBoss] then
          rate = BossRate;
        end
        --if Char.GetData(charIndex, CONST.CHAR_CDK) == 'u01' then
        rate = 1000;
        --end
        if #chars > 0 and math.random(0, 100) < rate then
          local n = math.random(1, #chars);
          --print(n, chars[n])
          local charIndex = chars[n];
          local itemIndex = Char.GiveItem(charIndex, 606627, 1, false);
          if itemIndex >= 0 then
            Item.SetData(itemIndex, CONST.����_����, string.format("װ����Ƭ(%s)", gmsvData:getEnemyName(enemy.EnemyId)));
            Item.SetData(itemIndex, CONST.����_Func_UseFunc, 'LUA_useMCard');
            Item.SetData(itemIndex, CONST.����_Func_AttachFunc, '');
            Item.SetData(itemIndex, CONST.����_���ò���, tostring(enemy.EnemyId));
            Item.SetData(itemIndex, CONST.����_Explanation1, -1);
            Item.SetData(itemIndex, CONST.����_Explanation2, -1);
            Item.UpItem(charIndex, itemIndex);
          end
          if Char.ItemSlot(charIndex) >= 20 then
            table.remove(chars, n)
          end
        end
        :: continue ::
      end
    end
  end
end
]]

---@param CharIndex number
---@param TargetCharIndex number
---@param ItemSlot number
function ModuleCard:onUseCard(CharIndex, TargetCharIndex, ItemSlot)
  self:logDebug('LUA_useMCard', CharIndex, TargetCharIndex, ItemSlot);
  local items = {}
  for i = 0, 7 do
    local itemIndex = Char.GetItemIndex(CharIndex, i)
    if itemIndex >= 0 then
      items[i + 1] = Item.GetData(itemIndex, CONST.����_����);
    else
      items[i + 1] = '��'
    end
  end
  local data = self:NPC_buildSelectionText('ѡ��ħ��װ��', items);
  Char.SetData(CharIndex, CONST.CHAR_WindowBuffer1, ItemSlot);
  Char.SetData(CharIndex, CONST.CHAR_WindowBuffer2, Char.GetItemIndex(CharIndex, ItemSlot));
  NLG.ShowWindowTalked(CharIndex, self.dummyNPC, CONST.����_ѡ���, CONST.BUTTON_�ر�, 0, data);
  return 0;
end

function ModuleCard:onItemExpansionEvent(itemIndex, type, msg)
  --self:logDebug('onItemExpansionEvent', itemIndex, type, msg);
  if Item.GetData(itemIndex, CONST.����_Func_UseFunc) == 'LUA_useMCard' then
    local enemyId = tonumber(Item.GetData(itemIndex, CONST.����_���ò���));
    local name = Data.EnemyBaseGetData(Data.EnemyBaseGetDataIndex(Data.EnemyGetData(Data.EnemyGetDataIndex(enemyId), CONST.DATA_ENEMY_TEMPNO)), CONST.DATA_ENEMYBASE_NAME) or 'nil';
    if type == 1 then
      return '$0��ӡ��$5' .. name .. '$0�����Ŀ�Ƭ\n$7˫������Ϊװ����ħ';
    end
    if type == 2 then
      return '$0��ӡ��$5' .. name .. '$0�����Ŀ�Ƭ\nЧ��: ������ + 10';
    end
  else
    if type == 2 then
      ---@type ItemExt
      local itemExt = getModule('itemExt');
      local data = itemExt:getItemData(itemIndex, true);
      if data.mcard then
        local enemyId = tonumber(data.mcard);
        local name = Data.EnemyBaseGetData(Data.EnemyBaseGetDataIndex(Data.EnemyGetData(Data.EnemyGetDataIndex(enemyId), CONST.DATA_ENEMY_TEMPNO)), CONST.DATA_ENEMYBASE_NAME) or 'nil';
        return msg .. '\n' .. string.format('������$3%s$0�����', name);
      end
    end
  end
  return msg;
end

function ModuleCard:onWindowTalked(npc, player, seqno, select, data)
  if select == CONST.BUTTON_�ر� then
    return ;
  end
  data = tonumber(data) - 1;
  local itemIndex = Char.GetItemIndex(player, data);
  local cardIndex = Char.GetItemIndex(player, Char.GetData(player, CONST.CHAR_WindowBuffer1));
  if Char.GetData(player, CONST.CHAR_WindowBuffer2) ~= cardIndex then
    return ;
  end
  local enemyId = tonumber(Item.GetData(cardIndex, CONST.����_���ò���));
  ---@type ItemExt
  local itemExt = getModule('itemExt');
  local itemExtData = itemExt:getItemData(itemIndex);
  if itemExtData.mcard then
    NLG.SystemMessage(player, '����Ʒ�Ѿ���ħ')
    return ;
  end
  itemExtData.mcard = enemyId;
  Item.SetData(itemIndex, CONST.����_����, Item.GetData(itemIndex, CONST.����_����) + 10);
  itemExt:setItemData(itemIndex, itemExtData);
  NLG.SystemMessage(player, '��ħ�ɹ�');
  Char.DelItemBySlot(player, Char.GetData(player, CONST.CHAR_WindowBuffer1));
  Item.UpItem(player, Char.GetData(player, CONST.CHAR_WindowBuffer1));
  Item.UpItem(player, data);
end

--- ����ģ�鹳��
function ModuleCard:onLoad()
  self:logInfo('load')
  --self.cache = { }
  self:regCallback('BattleStartEvent', Func.bind(self.onBattleStartEvent, self))
  --self:regCallback('BattleOverEvent', Func.bind(self.onBattleOverEvent, self))
  self:regCallback('ItemString', Func.bind(self.onUseCard, self), 'LUA_useMCard')
  self:regCallback('ItemExpansionEvent', Func.bind(self.onItemExpansionEvent, self))
  self.dummyNPC = self:NPC_createNormal('DummyNPC', 10000, { x = 0, y = 0, map = 777, mapType = 0, direction = 0 });
  self:NPC_regWindowTalkedEvent(self.dummyNPC, Func.bind(self.onWindowTalked, self));
end

--- ж��ģ�鹳��
function ModuleCard:onUnload()
  self:logInfo('unload')
end

return ModuleCard;
