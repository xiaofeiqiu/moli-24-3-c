---@class NPCPart: ModulePart
local NPCPart = ModuleBase:createPart('NpcPart');

---@alias NpcPosition {x:number,y:number,map:number,mapType:number,direction:number}
---@alias ShopBaseInfo {buyRate:number,sellRate:number,shopType:number,msgBuySell:number,msgBuy:number,msgMoneyNotEnough:number,msgBagFull:number,msgSell:number,msgAfterSell:number,sellTypes:table|'all'}

local function fillShopSellType(tb)
  local all = tb == 'all';
  local ret = {}
  for i = 1, 48 do
    if all or tb[i - 1] then
      table.insert(ret, '1');
    else
      table.insert(ret, '0');
    end
  end
  return ret;
end

---@param name string
---@param image number
---@param positionInfo NpcPosition
---@param shopBaseInfo ShopBaseInfo
---@return CharIndex
function NPCPart:NPC_createShop(name, image, positionInfo, shopBaseInfo, items)
  local shopNpcPrefix = table.join({
    shopBaseInfo.buyRate or 100,
    shopBaseInfo.sellRate or 100,
    shopBaseInfo.shopType or CONST.SHOP_TYPE_BOTH,
    shopBaseInfo.msgBuySell or '10146',
    shopBaseInfo.msgBuy or '10147',
    shopBaseInfo.msgMoneyNotEnough or '10148',
    shopBaseInfo.msgBagFull or '10149',
    shopBaseInfo.msgSell or '10150',
    shopBaseInfo.msgAfterSell or '10151',
    table.unpack(fillShopSellType(shopBaseInfo.sellTypes or {})),
  }, '|');
  local ret = NL.CreateArgNpc("Itemshop2", shopNpcPrefix .. '|' .. table.join(items or {}, '|'), name, image, positionInfo.mapType, positionInfo.map, positionInfo.x, positionInfo.y, positionInfo.direction);
  if ret >= 0 then
    table.insert(self.npcList, ret);
  end
  return ret;
end


---@param name string
---@param image number
---@param positionInfo NpcPosition
---@param initCallback fun(charIndex:number):boolean
---@return CharIndex
function NPCPart:NPC_createNormal(name, image, positionInfo, initCallback)
  local initFn, cbIndex, fnIndex = self:regCallback(initCallback or function()
    return true
  end)
  local npc = NL.CreateNpc(nil, initFn);
  self:unRegCallback(initFn, cbIndex);
  if npc < 0 then
    return -1;
  end
  table.insert(self.npcList, npc);
  Char.SetData(npc, CONST.CHAR_����, image);
  Char.SetData(npc, CONST.CHAR_ԭ��, image);
  Char.SetData(npc, CONST.CHAR_X, positionInfo.x);
  Char.SetData(npc, CONST.CHAR_Y, positionInfo.y);
  Char.SetData(npc, CONST.CHAR_��ͼ, positionInfo.map);
  Char.SetData(npc, CONST.CHAR_����, positionInfo.direction);
  Char.SetData(npc, CONST.CHAR_����, name);
  Char.SetData(npc, CONST.CHAR_��ͼ����, positionInfo.mapType);
  NLG.UpChar(npc);
  return npc
end

---@param list {name:string,image:number,price:number,desc:string,count:number, maxCount:number}[]
---@param image number
---@param msg1 string
---@param msg2 string
---@param msg3 string
---@param name string
---@return string
function NPCPart:NPC_buildBuyWindowData(image, name, msg1, msg2, msg3, list)
  return table.join({ image, name, msg1, msg2, msg3, table.unpack(table.map(list, function(e)
    return table.join({ e.name or '?', e.image or 0, e.price or 0, e.desc or '', e.count or 1, e.maxCount or 1 }, '|')
  end)) }, '|')
end

---ע��npc Talked�¼�
---@param npc number
---@param fn fun(npc: number, player: number):void
---@return string fnKey
---@return number lastIndex
---@return number fnIndex
function NPCPart:NPC_regTalkedEvent(npc, fn)
  local talkedFn, lastIndex, fnIndex = self:regCallback(self.name .. '_npc_' .. npc .. '_TalkedEvent', fn)
  Char.SetTalkedEvent(nil, talkedFn, npc);
  return talkedFn, lastIndex, fnIndex
end

---@alias WindowTalkedCallback fun(npc: number, player: number, seqno: number, select: number, data: string):void

---ע��npc WindowTalked�¼�
---@param npc number
---@param fn  WindowTalkedCallback
---@return string fnKey
---@return number lastIndex
---@return number fnIndex
function NPCPart:NPC_regWindowTalkedEvent(npc, fn)
  local talkedFn, lastIndex, fnIndex = self:regCallback(self.name .. '_npc_' .. npc .. '_WindowTalkedEvent', fn)
  Char.SetWindowTalkedEvent(nil, talkedFn, npc);
  return talkedFn, lastIndex, fnIndex
end

---@param title string
---@param options string[]
---@return string
function NPCPart:NPC_buildSelectionText(title, options)
  local line = #(string.split(title, '\\n') or {}) or 1;
  local msg = line .. '\\n' .. title .. '\\n'
  for i = 1, 8 do
    if options[i] == nil then
      return msg;
    end
    msg = msg .. options[i] .. '\\n'
  end
  return msg;
end

function NPCPart:onLoad()
  self.npcList = {};
end

function NPCPart:onUnload()
  for i, v in pairs(self.npcList) do
    NL.DelNpc(v);
  end
end

return NPCPart;
