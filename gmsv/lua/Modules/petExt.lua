---@class PetExt:ModuleBase
local PetExt = ModuleBase:createModule('petExt')
local MAX_CACHE_SIZE = 5000;

---Ǩ�ƶ���
PetExt:addMigration(1, 'init lua_petData', function()
  SQL.querySQL([[create table if not exists lua_petData
(
	id int not null,
	data text null,
	create_time int default 0 not null,
	constraint lua_petData_pk
		primary key (id)
) engine innodb;
]])
end);
PetExt:addMigration(2, 'extend data', function()
  SQL.querySQL([[
  alter table lua_petdata modify data longtext null;
]])
end);

function PetExt:setData(charIndex, value)
  error("ʹ��Char.SetExtData����")
  return ;
  --local type = Char.GetData(charIndex, CONST.CHAR_����);
  --if type ~= CONST.��������_�� then
  --  return nil
  --end
  --local args = tonumber(Char.GetData(charIndex, CONST.CHAR_ThankFlower));
  --if not (args > 0) then
  --  args = self.n + 1;
  --  self.n = args;
  --  Char.SetData(charIndex, CONST.CHAR_ThankFlower, args);
  --end
  --local sql = 'replace into lua_petData (id, data, create_time) VALUES ('
  --  .. SQL.sqlValue(args) .. ','
  --  .. SQL.sqlValue(JSON.encode(value)) .. ','
  --  .. SQL.sqlValue(os.time()) .. ')';
  --local r = SQL.querySQL(sql)
  ----print(r, sql);
  --self.cache:set(args, value);
end

---@return table
function PetExt:getData(charIndex)
  error("ʹ��Char.GetExtData����")
  return ;
  --local args = tonumber(Char.GetData(charIndex, CONST.CHAR_ThankFlower));
  --local data;
  --if args > 0 then
  --  data = self.cache:get(args)
  --  if not data then
  --    data = SQL.querySQL('select data from lua_petData where id = ' .. SQL.sqlValue(args))
  --    if type(data) == 'table' and data[1] then
  --      data = data[1][1]
  --      data = JSON.decode(data)
  --    else
  --      data = nil;
  --    end
  --  end
  --end
  --data = data or {};
  --if args ~= nil and args > 0 then
  --  self.cache:set(args, data);
  --end
  --return data;
end

--- ����ģ�鹳��
function PetExt:onLoad()
  self:logInfo('load')
  --self.cache = LRU.new(MAX_CACHE_SIZE);
  --self.n = SQL.querySQL('select ifnull(max(id), 0) from lua_petData')[1][1]
end

--- ж��ģ�鹳��
function PetExt:onUnload()
  self:logInfo('unload')
end

return PetExt;
