Map = _G.Map or {};

---��ȡ�Թ���ʣ��ʱ��
function Map.GetDungeonExpireTimeByDungeonId(dungeonId)
  local t = Map.GetDungeonExpireAtByDungeonId(dungeonId);
  if t < 0 then
    return t;
  end
  t = t - os.time()
  if t <= 0 then
    return 0;
  end
  return t
end

---��ȡ�Թ���ͼ��ʣ��ʱ��
function Map.GetDungeonExpireTime(floor)
  local t = Map.GetDungeonExpireAt(floor);
  if t < 0 then
    return t;
  end
  t = t - os.time()
  if t <= 0 then
    return 0;
  end
  return t
end

if Map.GetDungeonExpireAtByDungeonId == nil then
  ---��ȡ�Թ��Ĺ���ʱ��
  function Map.GetDungeonExpireAtByDungeonId(dungeonId)
    for i = 0, Addresses.ActiveDungeon_TBL_SIZE - 1 do
      --if dSize >= Addresses.DungeonConf_SIZE then
      --  return -1;
      --end
      local ptr = Addresses.ActiveDungeon_TBL + 0x68 * i
      if ffi.readMemoryInt32(ptr) == 1 then
        --dSize = dSize + 1;
        if ffi.readMemoryInt32(ptr + 0x4) == dungeonId then
          local t = ffi.readMemoryInt32(ptr + 0xc)
          return t
        end
      end
    end
    return -1;
  end
end

---��ȡ�Թ���ͼ�Ĺ���ʱ��
function Map.GetDungeonExpireAt(floor)
  --local dSize = 0;
  local cfgId = Map.GetDungeonId(floor)
  if cfgId < 0 then
    return -1;
  end
  return Map.GetDungeonExpireAtByDungeonId(cfgId);
end

---����floor�����Թ�����ʱ��
function Map.SetDungeonExpireAt(floor, time)
  --local dSize = 0;
  local cfgId = Map.GetDungeonId(floor)
  if cfgId < 0 then
    return -1;
  end
  return Map.SetDungeonExpireAtByDungeonId(cfgId, time)
end

if Map.SetDungeonExpireAtByDungeonId == nil then
  ---�����Թ�Id�����Թ�����ʱ��
  function Map.SetDungeonExpireAtByDungeonId(dungeonId, time)
    for i = 0, Addresses.ActiveDungeon_TBL_SIZE - 1 do
      --if dSize >= Addresses.DungeonConf_SIZE then
      --  return -1;
      --end
      local ptr = Addresses.ActiveDungeon_TBL + 0x68 * i
      if ffi.readMemoryInt32(ptr) == 1 then
        --dSize = dSize + 1;
        if ffi.readMemoryInt32(ptr + 0x4) == dungeonId then
          if time - os.time() < 181 then
            ffi.setMemoryInt32(ptr + 0x24, 1)
          end
          ffi.setMemoryInt32(ptr + 0xc, time)
          return 0
        end
      end
    end
    return -1;
  end
end

if Map.GetDungeonId == nil then
  ---��ȡ�Թ�Id
  function Map.GetDungeonId(floor)
    if floor < 0 then
      return -1;
    end
    local mapIndex = ffi.readMemoryDWORD(Addresses.MapIndexMapping[1] + floor * 4)
    if mapIndex < 0 or mapIndex >= Addresses.MapTableSize[1] then
      return -1;
    end
    local cfgId = ffi.readMemoryDWORD(Addresses.MapTable[1] + 0x80 * mapIndex + 0x4)
    return cfgId;
  end
end

if Map.FindDungeonEntry == nil then
  ---��ȡ�Թ����
  ---@param dungeonId integer dungeonId
  ---@return number mapType, number floor, number x, number y
  function Map.FindDungeonEntry(dungeonId)
    for i = 0, Addresses.ActiveDungeon_TBL_SIZE - 1 do
      --if dSize >= Addresses.DungeonConf_SIZE then
      --  return -1;
      --end
      local ptr = Addresses.ActiveDungeon_TBL + 0x68 * i
      if ffi.readMemoryInt32(ptr) == 1 then
        --dSize = dSize + 1;
        if ffi.readMemoryInt32(ptr + 0x4) == dungeonId then
          return ffi.readMemoryInt32(ptr + 0x10), ffi.readMemoryInt32(ptr + 0x14), ffi.readMemoryInt32(ptr + 0x18),
              ffi.readMemoryInt32(ptr + 0x1C)
        end
      end
    end
    return -1;
  end
end
