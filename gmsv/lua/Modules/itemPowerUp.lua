local ItemPowerUP = ModuleBase:createModule('itemPowerUp')

local MAX_LEVEL = 20;
local SAVE_LEVEL2 = 10;
local SAVE_LEVEL = 7;
local LevelRate = { 0, 0, 0, 10, 20, 30, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 93, 93, 96, 96, 97, 97, 98, 98, 99, 99, 99, 99, 99, 99, 99, 99 }

function ItemPowerUP:setItemData(itemIndex, value)
  ---@type ItemExt
  local itemExt = getModule('itemExt')
  return itemExt:setItemData(itemIndex, value)
end

function ItemPowerUP:getItemData(itemIndex)
  ---@type ItemExt
  local itemExt = getModule('itemExt')
  return itemExt:getItemData(itemIndex)
end

--CharIndex: ��ֵ�� ��Ӧ�¼��Ķ���index�������ߣ�����ֵ��Lua���洫�ݸ���������
--DefCharIndex: ��ֵ�� ��Ӧ�¼��Ķ���index�������ߣ�����ֵ��Lua���洫�ݸ���������
--OriDamage: ��ֵ�� δ�����˺�����ֵ��Lua���洫�ݸ���������
--Damage: ��ֵ�� �����˺�����ʵ�˺�������ֵ��Lua���洫�ݸ���������
--BattleIndex: ��ֵ�� ��ǰս��index����ֵ��Lua���洫�ݸ���������
--Com1: ��ֵ�� ������ʹ�õĄ�����̖����ֵ��Lua���洫�ݸ���������
--Com2: ��ֵ�� �����߹���������Ŀ�ˌ����λ�ã���ֵ��Lua���洫�ݸ���������
--Com3: ��ֵ�� ������ʹ�õ���������tech��ID����ֵ��Lua���洫�ݸ���������
--DefCom1: ��ֵ�� ������ʹ�õĄ�����̖����ֵ��Lua���洫�ݸ���������
--DefCom2: ��ֵ�� �����߹���������Ŀ�ˌ����λ�ã���ֵ��Lua���洫�ݸ���������
--DefCom3: ��ֵ�� ������ʹ�õ���������tech��ID����ֵ��Lua���洫�ݸ���������
--Flg: ��ֵ�� �˺�ģʽ������鿴�����ֵ˵������ֵ��Lua���洫�ݸ���������
--Flg ֵ˵��
local DmgType = CONST.DamageFlags

function ItemPowerUP:onDamageCalculateEvent(
  charIndex, defCharIndex, oriDamage, damage,
  battleIndex, com1, com2, com3, defCom1, defCom2, defCom3, flg)
  if damage <= 0 or flg == DmgType.Miss or flg == NoDmg then
    return damage;
  end
  --self:logDebug('battle', battleIndex, 'turn', Battle.GetTurn(battleIndex));
  --self:logDebug(
  --  'charIndex:', charIndex,
  --  'defCharIndex:', defCharIndex,
  --  'oriDamage:', oriDamage,
  --  'damage:', damage,
  --  'battleIndex:', battleIndex,
  --  'com1:', com1,
  --  'com2:', com2,
  --  'com3:', com3,
  --  'defCom1:', defCom1,
  --  'defCom2:', defCom2,
  --  'defCom3:', defCom3,
  --  'flg:', flg
  --)
  if Char.GetData(charIndex, CONST.CHAR_����) == CONST.��������_�� then
    for i = 0, 7 do
      local itemIndex = Char.GetItemIndex(charIndex, i);
      if itemIndex >= 0 then
        local data = self:getItemData(itemIndex)
        if (data.level or 0) > 0 then
          local itemType = Item.GetData(itemIndex, CONST.����_����);
          if Item.Types.isWeapon(itemType) then
            local weaponDmg = Item.GetData(itemIndex, CONST.����_����);
            if Item.GetData(itemIndex, CONST.����_ħ��) > 0 and flg == DmgType.Magic then
              weaponDmg = weaponDmg + tonumber(Item.GetData(itemIndex, CONST.����_ħ��));
            end
            local dmg = math.ceil((data.level * data.level / 100 + data.level / 100) * weaponDmg);
            --self:logDebug('add damage' .. dmg)
            damage = damage + dmg;
          end
        end
      end
    end
  end
  if Char.GetData(defCharIndex, CONST.CHAR_����) == CONST.��������_�� then
    for i = 0, 7 do
      local itemIndex = Char.GetItemIndex(defCharIndex, i);
      if itemIndex >= 0 then
        local data = self:getItemData(itemIndex)
        if (data.level or 0) > 0 then
          local itemType = Item.GetData(itemIndex, CONST.����_����);
          if Item.Types.isArmour(itemType) then
            --self:logDebug('dec damage' .. (data.level * 2))
            damage = damage - data.level * 3;
          end
        end
      end
    end
  end
  if damage < 1 then
    return 1;
  end
  return damage;
end

function ItemPowerUP:onItemOverLapEvent(charIndex, fromItemIndex, targetItemIndex, num)
  if Item.GetData(fromItemIndex, CONST.����_����) == 'ħʯ' then
    --self:logDebug('onItemOverLapEvent', charIndex, fromItemIndex, targetItemIndex, num);
    --if not Item.GetData(targetItemIndex, CONST.����_��װ��) then
    --  return 0
    --end
    --local fromSlot = getItemSlot(charIndex, fromItemIndex);
    local type = Item.GetData(targetItemIndex, CONST.����_����);
    if not (Item.Types.isArmour(type) or Item.Types.isWeapon(type)) then
      return 0
    end
    local data = self:getItemData(targetItemIndex);
    local rate = math.random(0, 100);
    local rawLv = data.level or 0;
    if rate < LevelRate[rawLv + 1] then
      if (data.level or 0) > 0 then
        if data.level >= SAVE_LEVEL2 then
          if math.random(0, 2) == 1 then
            data.level = 0;
          else
            data.level = data.level - math.random(1, data.level / 2)
          end
        elseif data.level > SAVE_LEVEL then
          data.level = data.level - 1;
        end
        self:setItemData(targetItemIndex, data);
      end
      NLG.SystemMessage(charIndex, "[ϵͳ] ǿ����" .. Item.GetData(targetItemIndex, CONST.����_����) .. "��ʧ�ܡ���" .. rate .. '/' .. LevelRate[rawLv + 1] .. "��");
      if data.level > 0 then
        Item.SetData(targetItemIndex, CONST.����_����, data.name .. ' +' .. data.level);
      else
        Item.SetData(targetItemIndex, CONST.����_����, data.name);
      end
      Char.DelItem(charIndex, Item.GetData(fromItemIndex, CONST.����_ID), 1);
      Item.UpItem(charIndex, -1);
      return 0;
    end
    data.level = rawLv + 1;
    if data.level > MAX_LEVEL then
      data.level = MAX_LEVEL;
    end
    data.name = data.name or Item.GetData(targetItemIndex, CONST.����_����);
    Item.SetData(targetItemIndex, CONST.����_����, data.name .. ' +' .. data.level);
    if Item.Types.isWeapon(type) then
    elseif Item.Types.isArmour(type) then
    end
    NLG.SystemMessage(charIndex, "[ϵͳ] ǿ����" .. Item.GetData(targetItemIndex, CONST.����_����) .. "���ɹ�����" .. rate .. '/' .. LevelRate[rawLv + 1] .. "��");
    self:setItemData(targetItemIndex, data);
    Char.DelItem(charIndex, Item.GetData(fromItemIndex, CONST.����_ID), 1);
    Item.UpItem(charIndex, -1);
    return 1;
  end
end

function ItemPowerUP:onLoad()
  self:logInfo('load')
  self:regCallback('ItemOverLapEvent', Func.bind(self.onItemOverLapEvent, self));
  self:regCallback('DamageCalculateEvent', Func.bind(self.onDamageCalculateEvent, self))
end

function ItemPowerUP:onUnload()
  self:logInfo('unload')
end

return ItemPowerUP;
