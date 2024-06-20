---��ȡװ�������� ItemIndex��λ��
---@return number װ��λ�� ,number װ������, number itemIndex
function Char.GetWeapon(charIndex)
  local ItemIndex = Char.GetItemIndex(charIndex, CONST.EQUIP_����);
  if ItemIndex >= 0 and Item.isWeapon(ItemIndex) then
    return ItemIndex, CONST.EQUIP_����, Item.GetData(ItemIndex, CONST.����_����);
  end
  ItemIndex = Char.GetItemIndex(charIndex, CONST.EQUIP_����)
  if ItemIndex >= 0 and Item.isWeapon(ItemIndex) then
    return ItemIndex, CONST.EQUIP_����, Item.GetData(ItemIndex, CONST.����_����);
  end
  return -1, -1, -1;
end

---���index�Ƿ���ȷ
function Char.IsValidCharIndex(charIndex)
  return Char.GetData(charIndex, 0) == 1;
end

function Char.GetEmptyItemSlot(charIndex)
  if not Char.IsValidCharIndex(charIndex) then
    return -1;
  end
  if Char.GetData(charIndex, CONST.CHAR_����) ~= CONST.��������_�� then
    return -1;
  end
  for i = 8, 27 do
    if Char.GetItemIndex(charIndex, i) == -2 then
      return i;
    end
  end
  return -2;
end

function Char.GetItemSlot(charIndex, itemIndex)
  for i = 0, 27 do
    if Char.GetItemIndex(charIndex, i) == itemIndex then
      return i;
    end
  end
  return -1;
end

function Char.GetEmptyPetSlot(charIndex)
  if not Char.IsValidCharIndex(charIndex) then
    return -1;
  end
  for i = 0, 4 do
    if Char.GetPet(charIndex, i) < 0 then
      return i;
    end
  end
  return -2;
end

function Char.IsPet(charIndex)
  if charIndex >= 0 then
    if Char.GetData(charIndex, CONST.CHAR_����) == CONST.��������_�� then
      return true
    end
  end
  return false;
end

function Char.IsPlayer(charIndex)
  if charIndex >= 0 then
    if Char.GetData(charIndex, CONST.CHAR_����) == CONST.��������_�� then
      return true
    end
  end
  return false;
end

function Char.IsEnemy(charIndex)
  if charIndex >= 0 then
    if Char.GetData(charIndex, CONST.CHAR_����) == CONST.��������_�� then
      return true
    end
  end
  return false;
end

function Char.IsNpc(charIndex)
  if charIndex >= 0 then
    if Char.GetData(charIndex, CONST.CHAR_����) == CONST.��������_NPC then
      return true
    end
  end
  return false;
end
