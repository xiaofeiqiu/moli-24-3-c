---@class ModuleBase
local ModuleBase = { name = '', callbacks = {}, lastIx = 0, migrations = nil };

_G.ModuleBase = ModuleBase;

local function loadPart(self, path)
  path = 'lua/Modules/' .. path;
  self:logInfo('load part ', path)
  local result, module = pcall(function()
    return loadfile(path, 'bt', self.___ctx)()
  end)
  if not result then
    self:logError('load part failed.', path, '\n', module)
    return nil;
  end
  return module;
end

ModuleBase.__index = ModuleBase;
function ModuleBase:new(name)
  local o = {};
  setmetatable(o, self)
  o.name = name;
  o.callbacks = {};
  o.lastIx = 0;
  return o;
end

---@alias ModuleType ModuleBase|NPCPart|AssetsPart|CharPart

---@param name string
---@param depParts? string[]
---@return ModuleType
function ModuleBase:createModule(name, depParts)
  local SubModule = ModuleBase:new(name)
  SubModule.parts = table.slice(ModuleBase.parts);
  if depParts then
    for i, v in ipairs(depParts) do
      local part = loadPart(v);
      if part then
        table.insert(SubModule.parts, part);
      end
    end
  end
  for i, part in ipairs(SubModule.parts) do
    for k, p in pairs(part) do
      if k ~= 'load' and k ~= 'onLoad' and k ~= 'unload' and k ~= 'onUnload' and k ~= 'name' then
        SubModule[k] = p;
      end
    end
  end
  SubModule.__index = SubModule;
  function SubModule:new()
    local o = ModuleBase:new(name);
    setmetatable(o, SubModule)
    return o;
  end

  return SubModule;
end

---@class ModulePart: ModuleBase
---@field name string
---@field onLoad function
---@field onUnload function
---@field ___isPart boolean

---@param name string
---@return ModulePart
function ModuleBase:createPart(name)
  ---@type ModulePart
  local SubModule = {
    name = name,
    onLoad = function()
    end,
    onUnload = function()
    end,
    ___isPart = true,
  }
  return SubModule;
end

---@param version number �汾��
---@param name string ����
---@param value function|string ����Ǩ�Ʒ�����sql
function ModuleBase:addMigration(version, name, value)
  local migrations = rawget(self, 'migrations')
  --self:logDebug('addMigration', migrations);
  if migrations == nil then
    migrations = {}
    rawset(self, 'migrations', migrations);
  end
  table.insert(migrations, { version = version, name = name, value = value });
end

---@param eventName string
---@param fn function
---@param extSign string
---@return string fnKey, number cbIndex, number fnIndex
function ModuleBase:regCallback(eventName, fn, extSign)
  self.lastIx = self.lastIx + 1;
  if type(eventName) == 'function' then
    fn = eventName;
    eventName = '_' .. self.name .. '_cb_' .. self.lastIx;
  end
  local fnIndex = regGlobalEvent(eventName, fn, self.name, extSign);
  logInfo(self.name, 'regCallback', eventName, self.lastIx, fnIndex, fn);
  self.callbacks[self.lastIx] = { key = eventName, fnIndex = fnIndex, fn = fn, extSign = extSign };
  return eventName, self.lastIx, fnIndex;
end

---@param eventNameOrCallbackKey string
---@param fnOrCbIndex function|number
function ModuleBase:unRegCallback(eventNameOrCallbackKey, fnOrCbIndex)
  local cbIndex = fnOrCbIndex--[[@as number]];
  if type(fnOrCbIndex) == 'function' then
    cbIndex = table.findIndex(self.callbacks, function(e)
      return fnOrCbIndex == e.fn
    end) --[[@as number]]
  end
  local fnCb = self.callbacks[cbIndex];
  if not fnCb then
    logWarn(self.name, 'cannot find callback of ' .. eventNameOrCallbackKey, fnOrCbIndex)
    return
  end
  logInfo(self.name, 'removeGlobalEvent', fnCb.key, fnCb.fnIndex, fnCb.fn);
  removeGlobalEvent(fnCb.key, fnCb.fnIndex, self.name, fnCb.extSign);
  self.callbacks[cbIndex] = nil;
end

function ModuleBase:migrate()
  if self.migrations then
    local ret = SQL.querySQL('select ifnull(max(id), 0) version from lua_migration where module = \'' .. self.name .. '\';');
    local version = tonumber(ret[1][1]);
    table.sort(self.migrations, function(a, b)
      return b.version - a.version > 0
    end)
    for i, migration in ipairs(self.migrations) do
      if migration.version > version then
        self:logInfo('run migration: ' .. migration.version)
        version = migration.version;
        if type(migration.value) == 'function' then
          migration.value();
        elseif type(migration.value) == 'string' then
          SQL.querySQL(migration.value);
        end
        SQL.querySQL('insert into lua_migration (id, name, module) values ('
          .. SQL.sqlValue(migration.version) .. ', '
          .. SQL.sqlValue(migration.name) .. ', '
          .. SQL.sqlValue(self.name) .. ');');
      end
    end
  end
end

function ModuleBase:log(level, msg, ...)
  log(self.name, level, msg, ...)
end

function ModuleBase:logInfo(msg, ...)
  logInfo(self.name, msg, ...)
end

function ModuleBase:logDebug(msg, ...)
  logDebug(self.name, msg, ...)
end

function ModuleBase:logWarn(msg, ...)
  logWarn(self.name, msg, ...)
end

function ModuleBase:logError(msg, ...)
  logError(self.name, msg, ...)
end

function ModuleBase:logF(level, msg, ...)
  log(self.name, level, string.format(msg, ...))
end

function ModuleBase:logInfoF(msg, ...)
  logInfo(self.name, string.format(msg, ...))
end

function ModuleBase:logDebugF(msg, ...)
  logDebug(self.name, string.format(msg, ...))
end

function ModuleBase:logWarnF(msg, ...)
  logWarn(self.name, string.format(msg, ...))
end

function ModuleBase:logErrorF(msg, ...)
  logError(self.name, string.format(msg, ...))
end

function ModuleBase:load()
  for i, part in pairs(self.parts) do
    part.onLoad(self);
  end
  self:migrate();
  self:onLoad()
end

function ModuleBase:unload()
  for i, part in pairs(self.parts) do
    part.onUnload(self);
  end
  self:onUnload()
  for i, fnCb in pairs(self.callbacks) do
    removeGlobalEvent(fnCb.key, fnCb.fnIndex, self.name, fnCb.extSign);
  end
  self.callbacks = {};
end

function ModuleBase:onLoad()

end

function ModuleBase:onUnload()

end

ModuleBase.parts = {
  dofile('lua/libs/Module/Parts/Npc.lua'),
  dofile('lua/libs/Module/Parts/Assets.lua'),
  dofile('lua/libs/Module/Parts/Char.lua'),
}
