local module = ModuleBase:createModule('heroWashPoint')

local itemId=778020

local function startswith ( str, substr)  
  if str == nil or substr == nil then  
      return nil, "the string or the sub-stirng parameter is nil"  
  end  
  if string.find(str, substr) ~= 1 then  
      return false  
  else  
      return true  
  end  
end


function module:onScriptCall(npcIndex, charIndex, text, msg)

  if not startswith(text,"Ӷ��ϴ��")then
    return
  end

  local windowStr = getModule('heroesFn'):buildCampHeroesList(charIndex)
  NLG.ShowWindowTalked(charIndex, self.npc, CONST.����_ѡ���, CONST.BUTTON_�ر�, 1,windowStr);

end

function module:onTalkedEvent(npc, charIndex, seqno, select, data)


  data=tonumber(data)
  if select == CONST.BUTTON_�ر� then
    return ;
  end
  local campHeroes = getModule('heroesFn'):getCampHeroesData(charIndex)
  local heroData = campHeroes[data]
  local heroIndex = heroData.index;

  local vital = Char.GetData(heroIndex,CONST.CHAR_����)/100
  local str = Char.GetData(heroIndex,CONST.CHAR_����)/100
  local tgh = Char.GetData(heroIndex,CONST.CHAR_ǿ��)/100
  local quick = Char.GetData(heroIndex,CONST.CHAR_�ٶ�)/100
  local magic = Char.GetData(heroIndex,CONST.CHAR_ħ��)/100

  local addedPoint =vital+str+tgh+quick+magic

  local totalPoint = addedPoint + Char.GetData(heroIndex,CONST.CHAR_������)
  if(Char.DelItem(charIndex,itemId,1) < 0) then
    NLG.SystemMessage(charIndex,"[ϵͳ]δ֪ԭ������Ʒɾ��ʧ��!");
    return;
  end
  -- ϴ��
  Char.SetData(heroIndex,CONST.CHAR_������ ,totalPoint)
  Char.SetData(heroIndex,CONST.CHAR_����,0)
  Char.SetData(heroIndex,CONST.CHAR_����,0)
  Char.SetData(heroIndex,CONST.CHAR_ǿ��,0)
  Char.SetData(heroIndex,CONST.CHAR_�ٶ�,0)
  Char.SetData(heroIndex,CONST.CHAR_ħ��,0)

  NLG.UpChar(heroIndex)
  NLG.SystemMessage(charIndex,"Ӷ��ϴ��ɹ�");
end

function module:onLoad()
  self:logInfo('load')
  self:regCallback('ScriptCallEvent', Func.bind(self.onScriptCall, self))
  self.npc = self:NPC_createNormal('Ӷ��ϴ��', 105502, { x = 235, y = 84, mapType = 0, map = 1000, direction = 6 });
  -- self:NPC_regTalkedEvent(self.npc, Func.bind(self.showAINpcHome, self));
  self:NPC_regWindowTalkedEvent(self.npc, Func.bind(self.onTalkedEvent, self));
end

function module:onUnload()
  self:logInfo('unload')
end

return module;
