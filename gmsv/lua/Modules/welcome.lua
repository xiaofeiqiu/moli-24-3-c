---ģ����
local Welcome = ModuleBase:createModule('welcome')
---Ǩ�ƶ���
Welcome:addMigration(1, 'initial module', function()
  print('run migration version: 1');
end);

--- ����ģ�鹳��
function Welcome:onLoad()
  self:logInfo('load')
end

--- ж��ģ�鹳��
function Welcome:onUnload()
  self:logInfo('unload')
end

return Welcome;
