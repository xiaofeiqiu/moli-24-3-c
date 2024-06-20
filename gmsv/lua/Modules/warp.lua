local Warp = ModuleBase:createModule('warp')

--��������������������
local warpPoints = {
  { "ʥ��³����", 0, 100, 134, 218 },
  { "������", 0, 100, 681, 343 },
  { "�����ش�", 0, 100, 587, 51 },
  { "άŵ�Ǵ�", 0, 100, 330, 480 },
  { "������", 0, 300, 273, 294 },
  { "���ɴ�", 0, 300, 702, 147 },
  { "��ŵ����", 0, 400, 217, 455 },
  { "���ȴ�", 0, 400, 570, 274 },
  { "������˹��", 0, 400, 248, 247 },
  { "����³����", 0, 33200, 99, 165 },
  { "���Ǳ�����", 0, 33500, 17, 76 },
  { "��������", 0, 43100, 120, 107 },
  { "³����˹��", 0, 43000, 322, 883 },
  { "��ŵ���Ǵ�", 0, 43000, 431, 823 },
  { "�׿�������", 0, 43000, 556, 313 },
  { "���׶ٴ�", 0, 32205, 127, 138 },
  { "�Ǽͳ�", 0, 322277, 33, 56 },
  { "ʥʮ�����ߵ���", 0, 32699, 50, 50 },
  { "���＼����", 0, 32104, 48, 16 },
  { "�ɼ�������", 0, 32130, 11, 8 },
}

local function calcWarp()
  local page = math.modf(#warpPoints / 8) + 1
  local remainder = math.fmod(#warpPoints, 8)
  return page, remainder
end

function Warp:onLoad()
  self:logInfo('load');
  local warpNPC = self:NPC_createNormal('������', 103010, { x = 242, y = 88, mapType = 0, map = 1000, direction = 6 });
  self:NPC_regWindowTalkedEvent(warpNPC, function(npc, player, _seqno, _select, _data)
    local column = tonumber(_data)
    local page = tonumber(_seqno)
    local warpPage = page;
    local winMsg = "1\\n��������ȥ����\\n"
    local winButton = CONST.BUTTON_�ر�;
    local totalPage, remainder = calcWarp()
    --��ҳ16 ��ҳ32 �ر�/ȡ��2
    if _select > 0 then
      if _select == CONST.BUTTON_��һҳ then
        warpPage = warpPage + 1
        if (warpPage == totalPage) or ((warpPage == (totalPage - 1) and remainder == 0)) then
          winButton = CONST.BUTTON_��ȡ��
        else
          winButton = CONST.BUTTON_����ȡ��
        end
      elseif _select == CONST.BUTTON_��һҳ then
        warpPage = warpPage - 1
        if warpPage == 1 then
          winButton = CONST.BUTTON_��ȡ��
        else
          winButton = CONST.BUTTON_��ȡ��
        end
      elseif _select == 2 then
        warpPage = 1
        return
      end
      local count = 8 * (warpPage - 1)
      if warpPage == totalPage then
        for i = 1 + count, remainder + count do
          winMsg = winMsg .. warpPoints[i][1] .. "\\n"
        end
      else
        for i = 1 + count, 8 + count do
          winMsg = winMsg .. warpPoints[i][1] .. "\\n"
        end
      end
      NLG.ShowWindowTalked(player, npc, CONST.����_ѡ���, winButton, warpPage, winMsg);
    else
      local count = 8 * (warpPage - 1) + column
      local short = warpPoints[count]
      Char.Warp(player, short[2], short[3], short[4], short[5])
    end
  end)
  self:NPC_regTalkedEvent(warpNPC, function(npc, player)
    if (NLG.CanTalk(npc, player) == true) then
      local msg = "1\\n��������ȥ����\\n";
      for i = 1, 8 do
        msg = msg .. warpPoints[i][1] .. "\\n"
      end
      NLG.ShowWindowTalked(player, npc, CONST.����_ѡ���, CONST.BUTTON_��ȡ��, 1, msg);
    end
    return
  end)
end

function Warp:onUnload()
  self:logInfo('unload')
end

return Warp;
