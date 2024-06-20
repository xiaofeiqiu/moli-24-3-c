---@class GmsvData: ModuleBase
local GmsvData = ModuleBase:createModule('gmsvData')

GmsvData.CONST = {};
--[["��͵ȼ�"	"��ߵȼ�"	"��ͳ�������"	"��߳�������"	"enemyai����"	"ս������"	"ս������"	"����ģʽ"	"1��׽0����׽"	"������Ʒitem����1"
--	"������Ʒitem����2"	"������Ʒitem����3"	"������Ʒitem����4"	"������Ʒitem����5"	"������Ʒitem����6"	"������Ʒitem����7"	"������Ʒitem����8"
--	"������Ʒitem����9"	"������Ʒitem����10"	"��Ʒ����1"	"��Ʒ����2"	"��Ʒ����3"	"��Ʒ����4"	"��Ʒ����5"	"��Ʒ����6"	"��Ʒ����7"	
--	"��Ʒ����8"	"��Ʒ����9"	"��Ʒ����10"	͵����Ʒitem����1	͵����Ʒitem����2	͵����Ʒitem����3	͵����Ʒitem����4	͵����Ʒitem����5	
--	"͵������1"	"͵������2"	"͵������3"	"͵������4"	"͵������5"	"0�ǹ�1��BOSS"	"0Ϊ1��1Ϊ2��"	"�ٻ�ħ���ٻ��Ĵ��루enemy��"	
--	"�ٻ�ħ���ٻ��Ĵ��루enemy��"	"enemytalk����"
--]]
GmsvData.CONST.Enemy = {};
GmsvData.CONST.Enemy.Name = 1;
GmsvData.CONST.Enemy.Param = 2;
GmsvData.CONST.Enemy.EnemyId = 3;
GmsvData.CONST.Enemy.BaseId = 4;
GmsvData.CONST.Enemy.MinLevel = 5;
GmsvData.CONST.Enemy.MaxLevel = 6;
GmsvData.CONST.Enemy.MinCount = 7;
GmsvData.CONST.Enemy.MaxCount = 8;
GmsvData.CONST.Enemy.EnemyAI = 9;
GmsvData.CONST.Enemy.Exp = 10;
GmsvData.CONST.Enemy.Dp = 11;
GmsvData.CONST.Enemy.AttackMode = 12;
GmsvData.CONST.Enemy.CanSeal = 13;
GmsvData.CONST.Enemy.DropItemId1 = 14;
GmsvData.CONST.Enemy.DropItemId2 = 15;
GmsvData.CONST.Enemy.DropItemId3 = 16;
GmsvData.CONST.Enemy.DropItemId4 = 17;
GmsvData.CONST.Enemy.DropItemId5 = 18;
GmsvData.CONST.Enemy.DropItemId6 = 19;
GmsvData.CONST.Enemy.DropItemId7 = 20;
GmsvData.CONST.Enemy.DropItemId8 = 21;
GmsvData.CONST.Enemy.DropItemId9 = 22;
GmsvData.CONST.Enemy.DropItemId10 = 23;
GmsvData.CONST.Enemy.DropItemPercent1 = 24;
GmsvData.CONST.Enemy.DropItemPercent2 = 25;
GmsvData.CONST.Enemy.DropItemPercent3 = 26;
GmsvData.CONST.Enemy.DropItemPercent4 = 27;
GmsvData.CONST.Enemy.DropItemPercent5 = 28;
GmsvData.CONST.Enemy.DropItemPercent6 = 29;
GmsvData.CONST.Enemy.DropItemPercent7 = 30;
GmsvData.CONST.Enemy.DropItemPercent8 = 31;
GmsvData.CONST.Enemy.DropItemPercent9 = 32;
GmsvData.CONST.Enemy.DropItemPercent10 = 33;
GmsvData.CONST.Enemy.StealItemId1 = 34;
GmsvData.CONST.Enemy.StealItemId2 = 35;
GmsvData.CONST.Enemy.StealItemId3 = 36;
GmsvData.CONST.Enemy.StealItemId4 = 37;
GmsvData.CONST.Enemy.StealItemId5 = 38;
GmsvData.CONST.Enemy.StealItemPercent1 = 39;
GmsvData.CONST.Enemy.StealItemPercent2 = 40;
GmsvData.CONST.Enemy.StealItemPercent3 = 41;
GmsvData.CONST.Enemy.StealItemPercent4 = 42;
GmsvData.CONST.Enemy.StealItemPercent5 = 43;
GmsvData.CONST.Enemy.IsBoss = 44;
GmsvData.CONST.Enemy.IsDoubleAction = 45;
GmsvData.CONST.Enemy.SummonEnemyId1 = 46;
GmsvData.CONST.Enemy.SummonEnemyId2 = 47;
GmsvData.CONST.Enemy.EnemyTalkId = 48;
--����	���	����BP	"������Χ"	����	"����BP"	"����BP"	"����BP"	"�ٶ�BP"	"ħ��BP"	"��׽�Ѷ�"	"ͼ���ȼ�"	"����Ҫ��"	
--����	����	������	ˮ����	������	������	����	�ƿ�	ʯ��	�쿹	˯��	����	"ͼ������"	? ��ɱ	����	"������λ"	ͼ�����	"���鱶��"	?	
--"ͼ�����"	?	"0��׽1����׽"	"1������λtech���"	"2������λtech���"	"3������λtech���"	"4������λtech���"	
--"5������λtech���"	"6������λtech���"	"7������λtech���"	"8������λtech���"	"9������λtech���"
--"10������λtech���"
GmsvData.CONST.EnemyBase = {};
GmsvData.CONST.EnemyBase.Name = 1;
GmsvData.CONST.EnemyBase.EnemyBaseId = 2;
GmsvData.CONST.EnemyBase.BaseBP = 3;
GmsvData.CONST.EnemyBase.BP������Χ = 4;
GmsvData.CONST.EnemyBase.���� = 5;
GmsvData.CONST.EnemyBase.����BP = 6;
GmsvData.CONST.EnemyBase.����BP = 7;
GmsvData.CONST.EnemyBase.����BP = 8;
GmsvData.CONST.EnemyBase.�ٶ�BP = 9;
GmsvData.CONST.EnemyBase.ħ��BP = 10;
GmsvData.CONST.EnemyBase.��׽�Ѷ� = 11;
GmsvData.CONST.EnemyBase.ͼ���ȼ� = 12;
GmsvData.CONST.EnemyBase.����Ҫ�� = 13;
GmsvData.CONST.EnemyBase.���� = 14;
GmsvData.CONST.EnemyBase.���� = 15;
GmsvData.CONST.EnemyBase.������ = 16;
GmsvData.CONST.EnemyBase.ˮ���� = 17;
GmsvData.CONST.EnemyBase.������ = 18;
GmsvData.CONST.EnemyBase.������ = 19;
GmsvData.CONST.EnemyBase.���� = 20;
GmsvData.CONST.EnemyBase.�ƿ� = 21;
GmsvData.CONST.EnemyBase.ʯ�� = 22;
GmsvData.CONST.EnemyBase.�쿹 = 23;
GmsvData.CONST.EnemyBase.˯�� = 24;
GmsvData.CONST.EnemyBase.���� = 25;
GmsvData.CONST.EnemyBase.ͼ������ = 26;
GmsvData.CONST.EnemyBase.��ɱ = 28;
GmsvData.CONST.EnemyBase.���� = 29;
GmsvData.CONST.EnemyBase.������λ = 30;
GmsvData.CONST.EnemyBase.ͼ����� = 31;
GmsvData.CONST.EnemyBase.���鱶�� = 32;
GmsvData.CONST.EnemyBase.ͼ����� = 34;
GmsvData.CONST.EnemyBase.����׽ = 36;
GmsvData.CONST.EnemyBase.TechId1 = 37;
GmsvData.CONST.EnemyBase.TechId2 = 38;
GmsvData.CONST.EnemyBase.TechId3 = 39;
GmsvData.CONST.EnemyBase.TechId4 = 40;
GmsvData.CONST.EnemyBase.TechId5 = 41;
GmsvData.CONST.EnemyBase.TechId6 = 42;
GmsvData.CONST.EnemyBase.TechId7 = 43;
GmsvData.CONST.EnemyBase.TechId8 = 44;
GmsvData.CONST.EnemyBase.TechId9 = 45;
GmsvData.CONST.EnemyBase.TechId10 = 46;
GmsvData.CONST.ItemSet = {};
GmsvData.CONST.ItemSet.δ���� = 1;
GmsvData.CONST.ItemSet.���������� = 2;
GmsvData.CONST.ItemSet.˫��Ч�� = 3;
GmsvData.CONST.ItemSet.INIT_FUNCTION = 4;
GmsvData.CONST.ItemSet.WATCH_FUNC = 5;
GmsvData.CONST.ItemSet.USE_FUNC = 6;
GmsvData.CONST.ItemSet.ATTACH_FUNC = 7;
GmsvData.CONST.ItemSet.DETACH_FUNC = 8;
GmsvData.CONST.ItemSet.DROP_FUNC = 9;
GmsvData.CONST.ItemSet.PRE_PICK_UP_FUNC = 10;
GmsvData.CONST.ItemSet.PICK_UP_FUNC = 11;
GmsvData.CONST.ItemSet.Id = 12;
GmsvData.CONST.ItemSet.ͼ�� = 13;
GmsvData.CONST.ItemSet.�۸� = 14;
GmsvData.CONST.ItemSet.��Ʒ���� = 15;
GmsvData.CONST.ItemSet.OTHERFLG������� = 16;
GmsvData.CONST.ItemSet.˫��ʹ�� = 17;
GmsvData.CONST.ItemSet.�ܷ�˫�� = 18;
GmsvData.CONST.ItemSet.ս��ʹ������0����1��Ʒ2װ�� = 19;
GmsvData.CONST.ItemSet.TARGETĿ�� = 20;
GmsvData.CONST.ItemSet.�õ��������� = 21;
GmsvData.CONST.ItemSet.�õ��������� = 22;
GmsvData.CONST.ItemSet.�ص��� = 23;
GmsvData.CONST.ItemSet.��Ʒ�ȼ� = 24;
GmsvData.CONST.ItemSet.BASE_FAILED_PROBʧ������ = 25;
GmsvData.CONST.ItemSet.�;����� = 26;
GmsvData.CONST.ItemSet.�;����� = 27;
GmsvData.CONST.ItemSet.�չ��������� = 28;
GmsvData.CONST.ItemSet.�չ��������� = 29;
GmsvData.CONST.ItemSet.ABLEEFFECTBETWEENHAVE֮�����ܹ�Ӱ�� = 30;
GmsvData.CONST.ItemSet.�ٷֱȼӳ� = 31;
GmsvData.CONST.ItemSet.�������� = 32;
GmsvData.CONST.ItemSet.�������� = 33;
GmsvData.CONST.ItemSet.�������� = 34;
GmsvData.CONST.ItemSet.�������� = 35;
GmsvData.CONST.ItemSet.�������� = 36;
GmsvData.CONST.ItemSet.�������� = 37;
GmsvData.CONST.ItemSet.�������� = 38;
GmsvData.CONST.ItemSet.�������� = 39;
GmsvData.CONST.ItemSet.�ظ����� = 40;
GmsvData.CONST.ItemSet.�ظ����� = 41;
GmsvData.CONST.ItemSet.��ɱ���� = 42;
GmsvData.CONST.ItemSet.��ɱ���� = 43;
GmsvData.CONST.ItemSet.�������� = 44;
GmsvData.CONST.ItemSet.�������� = 45;
GmsvData.CONST.ItemSet.�������� = 46;
GmsvData.CONST.ItemSet.�������� = 47;
GmsvData.CONST.ItemSet.�������� = 48;
GmsvData.CONST.ItemSet.�������� = 49;
GmsvData.CONST.ItemSet.�������� = 50;
GmsvData.CONST.ItemSet.�������� = 51;
GmsvData.CONST.ItemSet.ħ������ = 52;
GmsvData.CONST.ItemSet.ħ������ = 53;
GmsvData.CONST.ItemSet.������������ = 54;
GmsvData.CONST.ItemSet.������������ = 55;
GmsvData.CONST.ItemSet.�������� = 56;
GmsvData.CONST.ItemSet.�������� = 57;
GmsvData.CONST.ItemSet.�������� = 58;
GmsvData.CONST.ItemSet.�������� = 59;
GmsvData.CONST.ItemSet.����1 = 60;
GmsvData.CONST.ItemSet.����2 = 61;
GmsvData.CONST.ItemSet.����1ֵ = 62;
GmsvData.CONST.ItemSet.����2ֵ = 63;
GmsvData.CONST.ItemSet.������������ = 64;
GmsvData.CONST.ItemSet.������������ = 65;
GmsvData.CONST.ItemSet.������������ = 66;
GmsvData.CONST.ItemSet.������������ = 67;
GmsvData.CONST.ItemSet.������������ = 68;
GmsvData.CONST.ItemSet.������������ = 69;
GmsvData.CONST.ItemSet.�������� = 70;
GmsvData.CONST.ItemSet.�������� = 71;
GmsvData.CONST.ItemSet.��˯���� = 72;
GmsvData.CONST.ItemSet.��˯���� = 73;
GmsvData.CONST.ItemSet.��ʯ���� = 74;
GmsvData.CONST.ItemSet.��ʯ���� = 75;
GmsvData.CONST.ItemSet.�������� = 76;
GmsvData.CONST.ItemSet.�������� = 77;
GmsvData.CONST.ItemSet.�������� = 78;
GmsvData.CONST.ItemSet.�������� = 79;
GmsvData.CONST.ItemSet.�������� = 80;
GmsvData.CONST.ItemSet.�������� = 81;
GmsvData.CONST.ItemSet.���⹦�� = 82;
GmsvData.CONST.ItemSet.�Ӳ���1 = 83;
GmsvData.CONST.ItemSet.�Ӳ���2 = 84;
GmsvData.CONST.ItemSet.��ʯ���_���� = 85;
GmsvData.CONST.ItemSet.��ʯ���_���� = 86;
GmsvData.CONST.ItemSet.��ʯ���_���� = 87;
GmsvData.CONST.ItemSet.USEACTIONʹ�ù��� = 88;
GmsvData.CONST.ItemSet.�ǳ���ʧ = 89;
GmsvData.CONST.ItemSet.������ʧ = 90;
GmsvData.CONST.ItemSet.���� = 91;
GmsvData.CONST.ItemSet.��ħ���� = 92;
GmsvData.CONST.ItemSet.��ħ���� = 93;
GmsvData.CONST.ItemSet.�ܷ���� = 94;
GmsvData.CONST.ItemSet.��Ʒ˵��msg = 95;
GmsvData.CONST.ItemSet.�Ҽ�˵��msg = 96;
GmsvData.CONST.ItemSet.�������� = 97;
GmsvData.CONST.ItemSet.�׺ڱ����ܿ��� = 98;
GmsvData.CONST.ItemSet.�����г��� = 99;
GmsvData.CONST.ItemSet.ħ������ = 100;
GmsvData.CONST.ItemSet.ħ������ = 101;
GmsvData.CONST.ItemSet.������NPC1������� = 102;

function GmsvData:loadData()
  self.enemy = {}
  self.enmeyBase2enemy={}
  local count = 0;
  local file = io.open('data/enemy.txt')
  for line in file:lines() do
    if line then
      if string.match(line, '^(%s*(#|$))') then
        goto continue;
      end
      local enemy = string.split(line, '\t');
      if enemy and #enemy == 48 then
        self.enemy[enemy[self.CONST.Enemy.EnemyId]] = enemy;
        if self.enmeyBase2enemy[enemy[self.CONST.Enemy.BaseId]] == nil then
          self.enmeyBase2enemy[enemy[self.CONST.Enemy.BaseId]]=enemy[self.CONST.Enemy.EnemyId]
        end
        
        count = count + 1;
      end
    end
    :: continue ::
  end
  self:logInfo('loaded enemy', count);
  self.enemyBase = {}
  count = 0;
  file:close();
  file = io.open('data/enemybase.txt')
  for line in file:lines() do
    if line then
      if string.match(line, '^(%s*(#|$))') then
        goto continue;
      end
      local enemyBase = string.split(line, '\t');
      if enemyBase and #enemyBase == 46 then
        self.enemyBase[enemyBase[self.CONST.EnemyBase.EnemyBaseId]] = enemyBase;
        count = count + 1;
      end
    end
    :: continue ::
  end
  self:logInfo('loaded enemyBase', count);
  file:close();
  count = 0;
  self.itemSet = {}
  file = io.open('data/itemset.txt')
  for line in file:lines() do
    if line then
      if string.match(line, '^(%s*(#|$))') then
        goto continue;
      end
      local itemSet = string.split(line, '\t');
      if itemSet and #itemSet == 102 then
        self.itemSet[itemSet[self.CONST.ItemSet.Id]] = itemSet;
        count = count + 1;
      end
    end
    :: continue ::
  end
  self:logInfo('loaded itemSet', count);
  file:close();
  -- jobs.txt
  count = 0;
  self.jobs = {}
  file = io.open('data/jobs.txt')
  for line in file:lines() do
    if line then
      if string.match(line, '^(%s*(#|$))') then
        goto continue;
      end
      local jobs = string.split(line, '\t');
    
      if jobs and #jobs==39  then
        self.jobs[jobs[3]] = jobs;
        count = count + 1;
      end
    end
    :: continue ::
  end
  self:logInfo('loaded jobs', count);
  file:close();
  --for i, v in pairs(data) do
  --  print(i, v)
  --end
  --print(MAX_N);
end

---@param enemyId string|number
---@return string
function GmsvData:getEnemyName(enemyId)
  local enemy = self.enemy[tostring(enemyId)];
  self:logInfo('enemy', enemyId, enemy, self.enemy);
  if enemy then
    self:logInfo('enemy', enemy[GmsvData.CONST.Enemy.BaseId]);
    local base = self.enemyBase[enemy[GmsvData.CONST.Enemy.BaseId]];
    self:logInfo('base', base);
    if base then
      return base[GmsvData.CONST.EnemyBase.Name];
    end
  end
  return nil
end

--- ����ģ�鹳��
function GmsvData:onLoad()
  self:logInfo('load')
  self:loadData();
end

--- ж��ģ�鹳��
function GmsvData:onUnload()
  self:logInfo('unload')
end

return GmsvData;
