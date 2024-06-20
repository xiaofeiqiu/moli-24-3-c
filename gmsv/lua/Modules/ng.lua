---ģ����
local ngModule = ModuleBase:createModule('ng')

-- ��ͨ�������
local commandsNormal = {}

local function addFrame(charIndex)
  --Char.DischargeParty(charIndex);
  Char.SetData(charIndex, CONST.CHAR_����, 200000);
end

local function identity(player)
  local Count = 0
  for itemSlot = 8, 27 do
    local ItemIndex = Char.GetItemIndex(player, itemSlot)
    if ItemIndex > 0 then
      local money = Char.GetData(player, CONST.CHAR_���);
      local itemLv = Item.GetData(ItemIndex, CONST.����_�ȼ�);
      local price = itemLv * 200;
      if Item.GetData(ItemIndex, CONST.����_�Ѽ���) == 0 and money >= (itemLv * 200) then
        Count = Count + 1
        Char.SetData(player, CONST.CHAR_���, money - price);
        Item.SetData(ItemIndex, CONST.����_�Ѽ���, 1)
        NLG.SystemMessage(player, "[ϵͳ] �������ĵ��ߵȼ�Ϊ" .. itemLv .. "�����۳�ħ��" .. price .. "G");
        NLG.SystemMessage(player, "[ϵͳ] �����ϵ� " .. Item.GetData(ItemIndex, CONST.����_��ǰ��) .. "�Ѽ���Ϊ " .. Item.GetData(ItemIndex, CONST.����_����))
        Item.UpItem(player, itemSlot);
        NLG.UpChar(player);
        return ;
      end
    end
  end
  if Count == 0 then
    NLG.SystemMessage(player, "[ϵͳ] ������û����Ҫ��������Ʒ�������Ǯ�����Լ����˵��ߡ�");
    return ;
  end
  return
end

local function repairEquipment(player)
  local Count = 0
  for ItemSlot = 8, 8 do
    local ItemIndex = Char.GetItemIndex(player, ItemSlot)
    local money = Char.GetData(player, CONST.CHAR_���);
    local itemLv = Item.GetData(ItemIndex, CONST.����_�ȼ�);
    local itemName = Item.GetData(ItemIndex, CONST.����_����);
    local itemDur = Item.GetData(ItemIndex, CONST.����_�;�);
    local itemMaxDur = Item.GetData(ItemIndex, CONST.����_����;�);
    local repairedDur = itemMaxDur - itemDur
    --local decMaxDur = repairedDur * 1
    local price = repairedDur * 10
    local itemType = Item.GetData(ItemIndex, CONST.����_����);
    if money > price and itemMaxDur > itemDur and itemType >= 0 and itemType <= 14 then
      Count = Count + 1
      Char.SetData(player, CONST.CHAR_���, money - price);
      --Item.SetData(ItemIndex, CONST.����_�;�, itemDur + xhnj);
      --Item.UpItem(player, ItemSlot);
      -- local djnj1 = Item.GetData(ItemIndex,CONST.����_�;�);
      -- local djzdnj1 = Item.GetData(ItemIndex,CONST.����_����;�);
      Item.SetData(ItemIndex, CONST.����_�;�, itemMaxDur);
      Item.SetData(ItemIndex, CONST.����_����;�, itemMaxDur);
      NLG.SystemMessage(player, "[ϵͳ] �������װ����" .. itemName .. "���ָ��ˡ�" .. repairedDur .. "���;á��۳�ħ�ҡ�" .. price .. "G��");
      Item.UpItem(player, ItemSlot);
      NLG.UpChar(player);
      return
    end
  end
  if Count == 0 then
    NLG.SystemMessage(player, "[ϵͳ] ���������һ��û��Ҫ�ָ��;õ�װ��������������ħ�Ҳ��㡣");
    return
  end
  return
end

local function spriteRepair(player)
  local ZH = Char.GetData(player, CONST.CHAR_����);
  local money = Char.GetData(player, CONST.CHAR_���);
  local LV = Char.GetData(player, CONST.CHAR_�ȼ�);
  local ZHMB = ZH * 200;
  local ZHMBKC = ZHMB * LV
  if ZH <= 0 then
    NLG.SystemMessage(player, "��û�е��ꡣ");
  end
  if money >= ZHMBKC and ZH > 0 then
    Char.SetData(player, CONST.CHAR_���, money - ZHMBKC);
    Char.SetData(player, CONST.CHAR_����, 0);
    Char.FeverStop(player);
    NLG.UpChar(player);
    NLG.SystemMessage(player, "�л���ɡ��л�����Ϊ��" .. ZH .. "������Ϊ��" .. ZHMBKC .. "��ħ�ҡ�");
  end
  if money < ZHMBKC then
    NLG.SystemMessage(player, "��Ǯ��û���㻹�л꣬һ�����������ȥ�ɡ����л�۸���� ����*1000*�ȼ���");
  end
end

local function healthRepair(player)
  local i = Char.GetData(player, CONST.CHAR_����);
  local money = Char.GetData(player, CONST.CHAR_���);
  if (Char.GetData(player, CONST.CHAR_����) < 1) then
    NLG.SystemMessage(player, "��δ���ˡ�");
    return ;
  end
  if (money >= 200) and (Char.GetData(player, CONST.CHAR_����) > 0 and Char.GetData(player, CONST.CHAR_����) < 26) then
    Char.SetData(player, CONST.CHAR_����, 0);
    Char.SetData(player, CONST.CHAR_���, money - 200);
    NLG.UpdateParty(player);
    NLG.UpChar(player);
    NLG.SystemMessage(player, "��ϲ��������ϡ�");
    NLG.SystemMessage(player, "�۳�200ħ�ҡ�");
    return ;
  end
  if (money >= 400) and (Char.GetData(player, CONST.CHAR_����) > 24 and Char.GetData(player, CONST.CHAR_����) < 51) then
    Char.SetData(player, CONST.CHAR_����, 0);
    Char.SetData(player, CONST.CHAR_���, money - 400);
    NLG.UpdateParty(player);
    NLG.UpChar(player);
    NLG.SystemMessage(player, "��ϲ��������ϡ�");
    NLG.SystemMessage(player, "�۳�400ħ�ҡ�");
    return ;
  end
  if (money >= 800) and (Char.GetData(player, CONST.CHAR_����) > 49 and Char.GetData(player, CONST.CHAR_����) < 76) then
    Char.SetData(player, CONST.CHAR_����, 0);
    Char.SetData(player, CONST.CHAR_���, money - 800);
    NLG.UpdateParty(player);
    NLG.UpChar(player);
    NLG.SystemMessage(player, "��ϲ��������ϡ�");
    NLG.SystemMessage(player, "�۳�800ħ�ҡ�");
    return ;
  end
  if (money >= 1000) and (Char.GetData(player, CONST.CHAR_����) > 74 and Char.GetData(player, CONST.CHAR_����) < 101) then
    Char.SetData(player, CONST.CHAR_����, 0);
    Char.SetData(player, CONST.CHAR_���, money - 1000);
    NLG.UpdateParty(player);
    NLG.UpChar(player);
    NLG.SystemMessage(player, "��ϲ��������ϡ�");
    NLG.SystemMessage(player, "�۳�1000ħ�ҡ�");
    return ;
  else
    NLG.SystemMessage(player, "�Բ�������ħ�Ҳ��㣬���Ƽ۸�Ϊ������200��������400��������800��������1000����");
    return ;
  end
  return 0
end

function commandsNormal.where(charIndex, args)
  local target = charIndex;
  if #args == 1 then
    target = tonumber(args[1])
  end
  NLG.TalkToCli(charIndex, -1, target ..
    ' ��ͼ:' .. tostring(Char.GetData(target, CONST.CHAR_��ͼ)) .. '/' .. tostring(Char.GetData(target, CONST.CHAR_��ͼ����)) ..
    ', X:' .. tostring(Char.GetData(target, CONST.CHAR_X)) ..
    ', Y:' .. tostring(Char.GetData(target, CONST.CHAR_Y)) ..
    ', ����:' .. tostring(Char.GetData(target, CONST.CHAR_����))
  )
end

function commandsNormal.char(charIndex, args)
  if args[1] == 'healthRepair' then
    return healthRepair(charIndex)
  elseif args[1] == 'spriteRepair' then
    return spriteRepair(charIndex)
  elseif args[1] == 'addFrame' then
    return addFrame(charIndex)
  end
end

-- function commandsNormal.rank4(charIndex)
--   if Char.GetData(charIndex, CONST.CHAR_ְ��) == 3 and Char.GetData(charIndex, CONST.CHAR_�ȼ�) >= 100 then
--     Char.SetData(charIndex, CONST.CHAR_ְ��, 4);
--     Char.SetData(charIndex, CONST.CHAR_ְҵ, Char.GetData(charIndex, CONST.CHAR_ְҵ) + 1);
--     NLG.UpChar(charIndex);
--   end
-- end

function commandsNormal.item(charIndex, args)
  if args[1] == 'sort' then
    NLG.SortItem(charIndex)
    NLG.UpChar(charIndex);
  elseif args[1] == 'identity' then
    return identity(charIndex)
  elseif args[1] == 'repair' then
    return repairEquipment(charIndex)
  end
end

--function commandsNormal.changeSex(charIndex, args)
--  print( Char.GetData(charIndex, CONST.CHAR_����), Char.GetData(charIndex, CONST.CHAR_ԭ��), Char.GetData(charIndex, CONST.CHAR_ԭʼͼ��))
--  --if args[1] then
--  --  Char.SetData(charIndex, CONST.CHAR_����, args[1]);
--  --else
--  --  Char.SetData(charIndex, CONST.CHAR_����, Char.GetData(charIndex, CONST.CHAR_ԭ��));
--  --end
--end

function commandsNormal.daka(charIndex)
  Char.SetData(charIndex, CONST.CHAR_��ʱ, 99 * 3600);
  if Char.IsFeverTime(charIndex) == 1 then
    Char.FeverStop(charIndex)
  else
    Char.FeverStart(charIndex)
  end
  NLG.UpChar(charIndex)
end

function commandsNormal.redoDp(charIndex)
  local total = (Char.GetData(charIndex, CONST.CHAR_�ȼ�) - 1) * 4 + 30;
  local s = { CONST.CHAR_����, CONST.CHAR_����, CONST.CHAR_ǿ��, CONST.CHAR_�ٶ�, CONST.CHAR_ħ�� }
  for i, v in pairs(s) do
    Char.SetData(charIndex, v, 0);
  end
  Char.SetData(charIndex, CONST.CHAR_������, total);
  NLG.UpChar(charIndex)
end

function commandsNormal.encount(charIndex)
  Battle.Encount(charIndex, charIndex);
end

function commandsNormal.noencount(charIndex)
  local kg = Char.GetData(charIndex,CONST.CHAR_�����п���);
  if(kg == 0)then
     Char.SetData(charIndex,CONST.CHAR_�����п���,1);
    NLG.SystemMessage(charIndex,"�������Ѿ�������");
  else
     Char.SetData(charIndex,CONST.CHAR_�����п���,0);
    NLG.SystemMessage(charIndex,"�������Ѿ��رգ�");
  end
end

function commandsNormal.goHome(charIndex)
  --Char.DischargeParty(charIndex);
  Char.Warp(charIndex, 0, 1000, 236, 88);
end

local function getPetBp(player, args)
  local hasPet = false;
  for i = args[2] or 0, args[2] or 4 do
    local pet = Char.GetPet(player, i);
    if (pet >= 0) then
      hasPet = true;
      local arr_rank1 = Pet.GetArtRank(pet, CONST.PET_���);
      local arr_rank11 = Pet.FullArtRank(pet, CONST.PET_���);
      local arr_rank2 = Pet.GetArtRank(pet, CONST.PET_����);
      local arr_rank21 = Pet.FullArtRank(pet, CONST.PET_����);
      local arr_rank3 = Pet.GetArtRank(pet, CONST.PET_ǿ��);
      local arr_rank31 = Pet.FullArtRank(pet, CONST.PET_ǿ��);
      local arr_rank4 = Pet.GetArtRank(pet, CONST.PET_����);
      local arr_rank41 = Pet.FullArtRank(pet, CONST.PET_����);
      local arr_rank5 = Pet.GetArtRank(pet, CONST.PET_ħ��);
      local arr_rank51 = Pet.FullArtRank(pet, CONST.PET_ħ��);
      local a1 = (arr_rank1 - arr_rank11);
      local a2 = (arr_rank2 - arr_rank21);
      local a3 = (arr_rank3 - arr_rank31);
      local a4 = (arr_rank4 - arr_rank41);
      local a5 = (arr_rank5 - arr_rank51);
      local a6 = a1 + a2 + a3 + a4 + a5;
      local a61 = arr_rank1 + arr_rank2 + arr_rank3 + arr_rank4 + arr_rank5;
      NLG.SystemMessage(player, Char.GetData(pet, CONST.CHAR_����) .. "��:" .. a61 .. "��" .. a6 .. ')')
      NLG.SystemMessage(player, "��:" .. arr_rank1 .. "(" .. a1 .. ") ��:" .. arr_rank2 .. "(" .. a2 .. ") ǿ:" .. arr_rank3 .. "(" .. a3 .. ") ��:" ..
        arr_rank4 .. "(" .. a4 .. ") ħ:" .. arr_rank5 .. "(" .. a5 .. ")");
    end
  end
  if not args[2] then
    if hasPet then
      NLG.SystemMessage(player, "-----------------------------------");
    else
      NLG.SystemMessage(player, "û�г���");
    end
  end
end

local function petRebirth(player, args)
  local pet = Char.GetPet(player, tonumber(args[2]));
  if pet >= 0 then
    local s = { CONST.PET_���, CONST.PET_����, CONST.PET_ǿ��, CONST.PET_����, CONST.PET_ħ�� };
    for i, v in pairs(s) do
      local r = Pet.FullArtRank(pet, v);
      Pet.SetArtRank(pet, v, r - math.random(0, 4))
    end
    Pet.ReBirth(player, pet);
    local arr_rank1 = Pet.GetArtRank(pet, CONST.PET_���);
    local arr_rank11 = Pet.FullArtRank(pet, CONST.PET_���);
    local arr_rank2 = Pet.GetArtRank(pet, CONST.PET_����);
    local arr_rank21 = Pet.FullArtRank(pet, CONST.PET_����);
    local arr_rank3 = Pet.GetArtRank(pet, CONST.PET_ǿ��);
    local arr_rank31 = Pet.FullArtRank(pet, CONST.PET_ǿ��);
    local arr_rank4 = Pet.GetArtRank(pet, CONST.PET_����);
    local arr_rank41 = Pet.FullArtRank(pet, CONST.PET_����);
    local arr_rank5 = Pet.GetArtRank(pet, CONST.PET_ħ��);
    local arr_rank51 = Pet.FullArtRank(pet, CONST.PET_ħ��);
    local a1 = (arr_rank1 - arr_rank11);
    local a2 = (arr_rank2 - arr_rank21);
    local a3 = (arr_rank3 - arr_rank31);
    local a4 = (arr_rank4 - arr_rank41);
    local a5 = (arr_rank5 - arr_rank51);
    local a6 = a1 + a2 + a3 + a4 + a5;
    local a61 = arr_rank1 + arr_rank2 + arr_rank3 + arr_rank4 + arr_rank5;
    NLG.SystemMessage(player, Char.GetData(pet, CONST.CHAR_����) .. "��:" .. a61 .. "��" .. a6 .. ')')
    NLG.SystemMessage(player, "��:" .. arr_rank1 .. "(" .. a1 .. ") ��:" .. arr_rank2 .. "(" .. a2 .. ") ǿ:" .. arr_rank3 .. "(" .. a3 .. ") ��:" ..
      arr_rank4 .. "(" .. a4 .. ") ħ:" .. arr_rank5 .. "(" .. a5 .. ")");
  end
end

function zl(charIndex)
  local currentGold = Char.GetData(charIndex,CONST.CHAR_���);
  for ItemSlot = 8,27 do
    local ItemIndex = Char.GetItemIndex(charIndex, ItemSlot)
    if ItemIndex > 0 then
      local name = Item.GetData(ItemIndex, CONST.����_����);
      if name == "ħʯ" then
        local itemID =  Item.GetData(ItemIndex, CONST.����_ID);
        local price = Item.GetData(ItemIndex, CONST.����_�۸�);
        Char.DelItem(charIndex,itemID,1)
        currentGold = currentGold+price*5
        Char.SetData(charIndex,CONST.CHAR_���,currentGold);
      end
      Item.UpItem(charIndex, ItemSlot);
      NLG.UpChar(charIndex);
    end
  end
  NLG.SortItem(charIndex);
  NLG.SystemMessage(charIndex,"����������ϡ�");
end

function md(charIndex)
  for i=0,4 do
    local _PetIndex = Char.GetPet(charIndex,i);                       
        if _PetIndex >= 0 then                       
                if(Char.GetData(_PetIndex,CONST.CHAR_�ȼ�) > 1) then               
                        NLG.SystemMessage(charIndex,"[ϵͳ]�޷��Է�1���������ϴ��!");       
                        goto continue       
                end               
                Pet.SetArtRank(_PetIndex,CONST.�赵_���,Pet.FullArtRank(_PetIndex,CONST.�赵_���));               
                Pet.SetArtRank(_PetIndex,CONST.�赵_����,Pet.FullArtRank(_PetIndex,CONST.�赵_����));               
                Pet.SetArtRank(_PetIndex,CONST.�赵_ǿ��,Pet.FullArtRank(_PetIndex,CONST.�赵_ǿ��));               
                Pet.SetArtRank(_PetIndex,CONST.�赵_����,Pet.FullArtRank(_PetIndex,CONST.�赵_����));               
                Pet.SetArtRank(_PetIndex,CONST.�赵_ħ��,Pet.FullArtRank(_PetIndex,CONST.�赵_ħ��));               
                Pet.ReBirth(charIndex, _PetIndex);               
                NLG.SystemMessage(charIndex,"[ϵͳ]���"..i.."�ĳ����Ѿ�������");               
        else                       
                NLG.SystemMessage(charIndex,"[ϵͳ]���"..i.."��û�г���");               
        end   
        ::continue::
  end
end

function commandsNormal.zl(charIndex)
  zl(charIndex)
end

function commandsNormal.md(charIndex)
  md(charIndex)
end

function commandsNormal.pet(player, args)
  if args[1] == 'bp' then
    return getPetBp(player, args);
  elseif string.lower(args[1] or '') == 'rebirth' then
    return petRebirth(player, args);
  end
end

function commandsNormal.bank(player, args)
  NLG.OpenBank(player, player);
end

function ngModule:handleTalkEvent(charIndex, msg)
  self:logDebug('ng', charIndex, msg);
  local command = msg:match('^/([%w]+)')
  if commandsNormal[command] then
    local arg = msg:match('^/[%w]+ +(.+)$')
    arg = arg and string.split(arg, ' ') or {}
    commandsNormal[command](charIndex, arg);
    return 0
  end
  return 1;
end

--- ����ģ�鹳��
function ngModule:onLoad()
  self:logInfo('load')
  self:regCallback('TalkEvent', Func.bind(self.handleTalkEvent, self))
end

--- ж��ģ�鹳��
function ngModule:onUnload()
  self:logInfo('unload')
end

return ngModule;
