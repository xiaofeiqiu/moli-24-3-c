---����ת����ȫbp+3��������+1
local moduleName = 'petRebirth'
local PetRebirth = ModuleBase:createModule(moduleName)

function PetRebirth:onTalked(npc, player)
  if NLG.CanTalk(npc, player) then
    NLG.ShowWindowTalked(player, npc, CONST.����_��Ϣ��, CONST.BUTTON_��ȡ��, 1, '\\n\\n   ����150���ĳ������ת��\\n   ת����bp+5,������+1,ȫ����+1,����+5,����/����/����/����+5\\n   ����: 10��ħ��')
  end
end

function PetRebirth:firstPage(npc, player, seqNo, select, data)
  if select == CONST.BUTTON_��һҳ then
    if Char.GetData(player, CONST.CHAR_���) < 100000 then
      NLG.ShowWindowTalked(player, npc, CONST.����_��Ϣ��, CONST.BUTTON_�ر�, 3, '\\n\\n   ��Ҳ���')
      return
    end
    local list = { }
    for i = 0, 4 do
      local pIndex = Char.GetPet(player, i);
      if pIndex >= 0 then
        local rebirthTime = Char.GetExtData(pIndex, 'rebirthTime') or 0;
        local lv = Char.GetData(pIndex, CONST.CHAR_�ȼ�)
        if lv > 150 then
          table.insert(list, Char.GetData(pIndex, CONST.CHAR_����) .. ' lv.' .. lv .. ' ' .. rebirthTime .. 'ת');
        else
          table.insert(list, Char.GetData(pIndex, CONST.CHAR_����) .. ' lv.' .. lv .. ' ' .. rebirthTime .. 'ת' .. '���ȼ����㣩');
        end
      else
        table.insert(list, '[��]');
      end
    end
    if table.isEmpty(list) then
      NLG.ShowWindowTalked(player, npc, CONST.����_��Ϣ��, CONST.BUTTON_�ر�, 3, '\\n\\n   û�к��ʵĳ���')
      return
    end
    NLG.ShowWindowTalked(player, npc, CONST.����_ѡ���, CONST.BUTTON_�ر�, 2, self:NPC_buildSelectionText('ѡ��ת���ĳ���', list));
  else
    return
  end
end

function PetRebirth:selectPage(npc, player, seqNo, select, data)
  if select == CONST.BUTTON_�ر� then
    return
  end
  local pIndex = Char.GetPet(player, tonumber(data) - 1);
  if pIndex < 0 then
    NLG.ShowWindowTalked(player, npc, CONST.����_��Ϣ��, CONST.BUTTON_ȷ��, 3, '\\n\\n   ��λ��û�г���')
    return
  end
  if Char.GetData(pIndex, CONST.CHAR_�ȼ�) < 150 then
    NLG.ShowWindowTalked(player, npc, CONST.����_��Ϣ��, CONST.BUTTON_ȷ��, 3,
      '\\n\\n   ' .. Char.GetData(pIndex, CONST.CHAR_����) .. ' lv.' .. Char.GetData(pIndex, CONST.CHAR_�ȼ�) .. ' �ȼ�����150')
    return
  end
  Char.SetData(player, CONST.CHAR_WindowBuffer2, pIndex + 1);
  NLG.ShowWindowTalked(player, npc, CONST.����_��Ϣ��, CONST.BUTTON_�Ƿ�, 4,
    '\\n\\n   ' .. Char.GetData(pIndex, CONST.CHAR_����) .. ' lv.' .. Char.GetData(pIndex, CONST.CHAR_�ȼ�) .. '\\n\\n   ȷ��ת����')
end

function PetRebirth:confirmPage(npc, player, seqNo, select, data)
  if select == CONST.BUTTON_�� then
    return
  end
  local pIndex = Char.GetData(player, CONST.CHAR_WindowBuffer2) - 1;
  Char.SetData(player, CONST.CHAR_WindowBuffer2, 0);
  if not Char.IsValidCharIndex(pIndex) then
    return
  end
  if Char.GetData(player, CONST.CHAR_���) < 100000 then
    NLG.ShowWindowTalked(player, npc, CONST.����_��Ϣ��, CONST.BUTTON_ȷ��, 3, '\\n\\n   ��Ҳ���')
    return
  end
  for i = 0, 4 do
    local pIndex2 = Char.GetPet(player, i);
    if pIndex2 == pIndex then
      if Char.GetData(pIndex, CONST.CHAR_�ȼ�) < 150 then
        NLG.ShowWindowTalked(player, npc, CONST.����_��Ϣ��, CONST.BUTTON_ȷ��, 3,
          '\\n\\n   ' .. Char.GetData(pIndex, CONST.CHAR_����) .. ' lv.' .. Char.GetData(pIndex, CONST.CHAR_�ȼ�) .. ' �ȼ�����150')
        return
      end
      --Char.AddGold(player, -100000);
      local arts = { CONST.PET_���, CONST.PET_����, CONST.PET_ǿ��, CONST.PET_����, CONST.PET_ħ�� };
      arts = table.map(arts, function(v)
        return { v, math.min(62, Pet.GetArtRank(pIndex, v) + 5) };
      end)
      table.forEach(arts, function(v)
        Pet.SetArtRank(pIndex, v[1], v[2]);
      end);
      Pet.ReBirth(player, pIndex);
      table.forEach(arts, function(v)
        Pet.SetArtRank(pIndex, v[1], v[2]);
      end);
      Char.SetData(pIndex, CONST.CHAR_������, math.min(100, Char.GetData(pIndex, CONST.CHAR_������) + 10));
      Char.SetData(pIndex, CONST.CHAR_ˮ����, math.min(100, Char.GetData(pIndex, CONST.CHAR_ˮ����) + 10));
      Char.SetData(pIndex, CONST.CHAR_������, math.min(100, Char.GetData(pIndex, CONST.CHAR_������) + 10));
      Char.SetData(pIndex, CONST.CHAR_������, math.min(100, Char.GetData(pIndex, CONST.CHAR_������) + 10));
      Char.SetData(pIndex, CONST.PET_������, math.min(10, Char.GetData(pIndex, CONST.PET_������) + 1));
      arts = { CONST.CHAR_����, CONST.CHAR_��˯, CONST.CHAR_��ʯ, CONST.CHAR_����,
               CONST.CHAR_����, CONST.CHAR_����, CONST.CHAR_��ɱ, CONST.CHAR_����,
               CONST.CHAR_����, CONST.CHAR_����, }
      table.forEach(arts, function(e)
        Char.SetData(pIndex, e, math.min(100, Char.GetData(pIndex, e) + 5));
      end)
      local rebirthTime = Char.GetExtData(pIndex, 'rebirthTime')
      rebirthTime = (rebirthTime or 0) + 1;
      Char.SetExtData(pIndex, 'rebirthTime', rebirthTime);
      --self:logDebug('rebirthTime=', petExtData.rebirthTime);
      if (rebirthTime or 0) > 5 then
        Char.SetData(pIndex, CONST.CHAR_����, CONST.����_аħ);
      end
      Pet.UpPet(player, pIndex);
      NLG.UpChar(pIndex);
      NLG.UpChar(player);
      NLG.ShowWindowTalked(player, npc, CONST.����_��Ϣ��, CONST.BUTTON_ȷ��, 3, '\\n\\n   �ѳɹ�ת��');
      return
    end
  end
  NLG.ShowWindowTalked(player, npc, CONST.����_��Ϣ��, CONST.BUTTON_ȷ��, 3, '\\n\\n   ��λ��û�г���')
  return
end

function PetRebirth:onSelected(npc, player, seqNo, select, data)
  if seqNo == 1 then
    self:firstPage(npc, player, seqNo, select, data)
  elseif seqNo == 2 then
    self:selectPage(npc, player, seqNo, select, data)
  elseif seqNo == 4 then
    self:confirmPage(npc, player, seqNo, select, data)
  end
end

--function PetRebirth:getPetData(charIndex)
--  ---@type PetExt
--  local charExt = getModule('petExt')
--  return charExt:getData(charIndex)
--end

--function PetRebirth:setPetData(charIndex, value)
--  ---@type PetExt
--  local charExt = getModule('petExt')
--  return charExt:setData(charIndex, value)
--end

--- ����ģ�鹳��
function PetRebirth:onLoad()
  self:logInfo('load')
  local npc = self:NPC_createNormal('����ת��', 101024, { map = 1000, x = 225, y = 83, direction = 4, mapType = 0 });
  self:NPC_regTalkedEvent(npc, Func.bind(self.onTalked, self));
  self:NPC_regWindowTalkedEvent(npc, Func.bind(self.onSelected, self));
end

--- ж��ģ�鹳��
function PetRebirth:onUnload()
  self:logInfo('unload')
end

return PetRebirth;
