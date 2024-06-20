# cgmsv lua

## ģ��ϵͳ

֧�ֶ�̬���ء�ж���Լ��汾����������Ǩ�ơ�����ͨ��Moduleע��Ļص�ж��ʱ�Զ�����

### ModuleBase��

#### ����

1. `name` ��ǰģ������, string����
2. `migrations` ����Ǩ���б� �������ͣ� ÿ��Ԫ����Ҫ��`version`��`name`��`value` ��������
    - `version` �汾�� number����
    - `name` ���� string����
    - `value` sql���߾��巽�� string��function����

#### ����

1. `ModuleBase:regCallback(eventNameOrCallbackKeyOrFn, fn)`  ע��ص�
    - ���� `eventNameOrCallbackKeyOrFn`
      - ���Դ���NL.Reg*��Ӧ���¼����ƣ���NL.RegLoginEvent ���� `LoginEvent`
      - �Զ�����������ڷ�ȫ�ֻص�����NPC�����ص���
      - �����ص�����NPC�����ص���

    - ���� `fn`
      - �ص����������eventNameOrCallbackKeyOrFn�������ص���fn���Դ�nil

    - ����ֵ `eventNameOrCallbackKeyOrFn`, `lastIx`, `fnIndex`
      - `eventNameOrCallbackKeyOrFn` ������ȫ��Key�����ڴ���NL.Reg*
      - `lastIx` ��ǰģ���µ�ע������
      - `fnIndex` ȫ��ע������

2. `ModuleBase:unRegCallback(eventNameOrCallbackKey, fnOrFnIndex)`  ��ע��ص�
    - ���� `eventNameOrCallbackKey`
      - ���Դ���NL.Reg*��Ӧ���¼����ƣ���NL.RegLoginEvent ���� `LoginEvent`
      - �Զ�����������ڷ�ȫ�ֻص�����NPC�����ص���

    - ���� `fnOrFnIndex`
      - ���봫��ע���õĻص�����
      - Ҳ����fnIndex ȫ��ע������
3. `ModuleBase:onLoad()`  ģ��ע�ṳ�ӣ��ɾ���ʵ��ģ��ʵ��
4. `ModuleBase:onUnload()`  ģ��ж�ع��ӣ��ɾ���ʵ��ģ��ʵ��
5. `ModuleBase:logInfo(msg, ...)`  ��ӡ��־
6. `ModuleBase:logDebug(msg, ...)`  ��ӡ��־
7. `ModuleBase:logWarn(msg, ...)`  ��ӡ��־
8. `ModuleBase:logError(msg, ...)`  ��ӡ��־
9. `ModuleBase:log(level, msg, ...)`  ��ӡ��־
10. `ModuleBase:addMigration(version, name, sqlOrFunction)` ����һ����Ǩ��

## ģ�����
����ģ�������ModuleConfig.lua
### loadModule 
����`Modules`�µ�Module��Module���������໥�����������ֶ�ָ��ȫ�ֱ��������򲻻�Ӱ������Module�������������Module��ͨ��getModule��ȡ
```
loadModule('admin') --����adminģ��
```
### useModule 
����`Module`Ŀ¼�µ���ͨlua, ��ͨlua������һ����������������ִ�С������ֶ�ָ��Ϊȫ�ֱ���������ֻ��Ӱ����ͨlua��module���ܷ�����ر���/����
```
useModule('Welcome') --����Welcome
```
### getModule
��ȡ��Ӧ��Module

### unloadModule
ж��Module

### reloadModule
���¼���Module

### Ŀǰ���õ�ģ��
1. admin ģ�鶯̬�����
2. ng �ڹ����
3. shop �����̵�NPC����
4. warp ���䴫��
5. warp2 �����㴫��
6. welcome ʾ��ģ��
7. itemPowerUp.lua װ��ǿ��
8. manaPool Ѫħ��
9. bag �����л�
10. autoRegister �Զ�ע��
11. ~~petExt/charExt/itemExt ������չģ��(�ѷ���)~~
12. petLottery ����齱
13. petRebirth ����ת��
14. autoUnlock �Զ��������˵��µĿ���
   
### �����е�ģ��
- AI��չ

## GMSV ��չģ��
1. BattleEx.lua ս�������չ
2. Char.lua  ���������չ
3. DamageHook.lua �˺��޸Ĳ���
4. Data.lua Data���
5. Item.lua ��Ʒ���
6. LowCpuUsage.lua ����cpuʹ�ò���
7. Protocol.lua ����������
8. Recipe.lua �䷽���
9. DummyChar.lua �������
10. NL.lua ��չ�¼����
11. NLG_ShowWindowTalked_Patch.lua NLG.ShowWindowTalked ���Ȳ���
12. Addresses.lua ������ַ
13. Field.lua Field���

## ��չ�¼�/�ӿ�
- `NL.RegEnemyCommandEvent` �����ж��¼�
- `NL.RegCharaDeletedEvent` ��ɫɾ���¼�
- `NL.RegResetCharaBattleStateEvent` ��ɫս�������¼�
- `NL.RegBattleDamageEvent` ԭ����RegDamageCalculateEvent
- `NL.RegDamageCalculateEvent` �������ս���˺��¼�
- `NL.RegBattleHealCalculateEvent` ս�������¼�
- `NL.RegDeleteDummyEvent` ����ɾ���¼�
- `NL.RegItemExpansionEvent` ������Ʒ˵������
- `NLG.FindUser` ���������û�
- `Map.GetDungeonExpireTime` ��ȡ�Թ�ʣ��ʱ��
- `Map.GetDungeonExpireAt` ��ȡ�Թ�����ʱ��
- `Char.GetCharPointer` ��ȡ��ɫPtr
- `Char.GetWeapon` ��ȡ����
- `Char.GiveItem` �����Ʒ��֧�־�Ĭģʽ
- `Char.DelItem` ɾ����Ʒ��֧�־�Ĭģʽ
- `Char.DelItemBySlot` ɾ��ָ��λ�õ���Ʒ
- `Char.UnsetWalkPostEvent` �Ƴ��¼�
- `Char.UnsetWalkPreEvent` �Ƴ��¼�
- `Char.UnsetPostOverEvent` �Ƴ��¼�
- `Char.UnsetLoopEvent` �Ƴ��¼�
- `Char.UnsetTalkedEvent` �Ƴ��¼�
- `Char.UnsetWindowTalkedEvent` �Ƴ��¼�
- `Char.UnsetItemPutEvent` �Ƴ��¼�
- `Char.UnsetWatchEvent` �Ƴ��¼�
- `Char.MoveArray` ��ɫ�����ƶ�
- `Char.JoinParty` �������
- `Char.LeaveParty` �뿪����
- `Char.MoveItem` �ƶ���Ʒ
- `Char.IsValidCharPtr` 
- `Char.IsValidCharIndex` 
- `Char.GetDataByPtr` ����Ptr��ȡ����
- `Char.IsDummy` �Ƿ��Ǽ���
- `Char.CreateDummy` ��������
- `Char.DelDummy` ɾ������
- `Char.CalcConsumeFp` ���ڻ�ȡ��������Ҫ��fp
- `Char.SetPetDepartureState` ���ó���ս��״̬
- `Char.SetPetDepartureStateAll` ���ó���ս��״̬
- `Char.TradeItem` ֱ�ӽ�����Ʒ
- `Char.TradePet` ֱ�ӽ��׳���
- `Char.GetEmptyItemSlot` ��ȡ����Ʒ��
- `Char.GetEmptyPetSlot` ��ȡ�ճ�����
- `Battle.UnsetWinEvent` �Ƴ��¼�
- `Battle.UnsetPVPWinEvent` �Ƴ��¼�
- `Battle.GetNextBattle` ��ȡ��һ����սId
- `Battle.SetNextBattle` ������һ����սId
- `Battle.GetTurn` ��ȡ��ǰ�غ�
- `Battle.ActionSelect` ѡ��ս��ָ��
- `Battle.IsWaitingCommand` �ж��Ƿ�ȴ�ָ��
- `Data.ItemsetGetIndex` ��ȡItemsetIndex
- `Data.ItemsetGetData` ��ȡItemset����
- `Data.GetEncountData` ��ȡEncount����
- `Data.SetMessage` ��ȡMsg
- `Data.GetMessage` �޸�/����Msg����̬������Ʒʱ��Ż�����
- `Data.EnemyGetDataIndex` ��ȡEnemyDataIndex
- `Data.EnemyGetData` ��ȡEnemy����
- `Data.EnemyBaseGetDataIndex` ��ȡEnemyBaseDataIndex
- `Data.EnemyBaseGetData` ��ȡEnemyBase����
- `Item.GetSlot` ��ȡItemIndex��Ӧλ��
- `Protocol.makeEscapeString` �����ַ���
- `Protocol.makeStringFromEscaped` �����ַ���
- `Protocol.nrprotoEscapeString` ��������ַ���
- `Protocol.nrprotoUnescapeString` ��������ַ���
- `Protocol.Send` �����Զ�����
- `Protocol.GetCharIndexFromFd` ͨ��fd��ȡcharIndex
- `Protocol.OnRecv` ���ط��
- `Recipe.GiveRecipe` ����䷽
- `Recipe.RemoveRecipe` ɾ���䷽
- `regGlobalEvent` ע��ȫ���¼�������Delegate��DelegateҲ�ǰ�װ�������
- `removeGlobalEvent` �Ƴ�ע���¼�
- ����ӿڲο� [docs.lua](docs/docs.lua)

# �������
skill:Ǭ��һ��Ϊ��
Ǭ��һ�� 3 130003 1 6 1 100 100 159 2 1 1000 0
1:��������
2:���ܴ���
3:���ܽ���
4:��������(0��ʾ��������,1��ʾ������,2��ʾ��������,3��ʾħ������,6��ʾ�����༼��)
5:��ʾ�Ǳ�ְְҵĬ������ѧ���Ĵ˼��ܵȼ�(Ҳ����˵skilllv��û�й涨�˼��ܿ�ѧϰ�ȼ���������ְҵ��������6)
6:���Ӧ��Ҳ�Ǽ�������(���Ǻ�ȷ��)
7:�ü���ѧϰ����
8:�����֪��
9:��ʾ��������(255��ʾ������,143��ʾ��������,159Ӧ���ǽ����������߹�����,64Ӧ���ǻ���,128����)10:��skillexp��ľ��������
11:�������輼����
12:��������,ò�ƶ���1000
13:���Ҳ�����
ע:0������������,��һ����ְҵ�ܺ�,10�ǽ�ʿ,20��ս��,��֮�����ְҵ��ϰ����-1����,���һ����������ǰ���Ǹ�д��ְҵ�ô˼��ܵľ�������~~~~һ������200,
����,0����д10 200,��˼���ǵ���ʿʹ���⼼��,��һ�εľ������200/10,����20����һ��,������������ĵ��⼼.���������д�Ļ�,��������ְҵ��һ�ζ���10����

TECH:Ǭ��һ��Ϊ��
Ǭ��һ�� LV1 TECH_Parameter AS:0,HR:-2,DD:10, 300 130003 3 1 1 1141 10 1
1:��������
2:��������
3:����Ч��
4:���ܴ����Լ�����ͼ��(������ڲ����ظ�,������Щ����Ҫ�õ���ͬ��ͼ��,һ���һ�����ϸ����)
5:���ܵ�ע��(�������Ϸ�еļ��ܿ���)
6:��ʾ�ü�����������skill.txt�ļ��ܴ���
7:���ܵȼ�(�����30,��ʾ�ǳ���ʹ��,�����50,��ʾBOSSʹ��)
8:��������1��ʾս������,2��ʾ��������,3��ʾ���Ƽ��ȱ�װʲô��)
9:���ܷ�Χ
10:�����ħ��
11:����ʹ����(0��ʾ�˿�ʹ��,���BOSS��1)

��:֪�������ϵĶ���,��ôд�����Ѿ�����������
��ʵ��������ʲôSF������5��8�ŵļ���,�������һ�޵�
��������TECH��..������֪ʶ�ҾͲ���˵��.�ҾͰ��Լ������������ó���˵��.
������� LV1 TECH_ContinuationAttack AS:0,AN:2,AM:2,DD:20, 310 1329995 1999 1 1 1141 20 1
������� LV2 TECH_ContinuationAttack AS:0,AN:2,AM:2,DD:25, 311 1329995 1999 2 1 1141 40 1
������� LV3 TECH_ContinuationAttack AS:0,AN:2,AM:2,DD:30, 312 1329995 1999 3 1 1141 80 1
������� LV4 TECH_ContinuationAttack AS:0,AN:2,AM:2,DD:35, 313 1329995 1999 4 1 1141 100 1
������� LV5 TECH_ContinuationAttack AS:0,AN:2,AM:2,DD:40, 314 1329995 1999 5 1 1141 120 1
������� LV6 TECH_ContinuationAttack AS:0,AN:2,AM:2,DD:45, 315 1329995 1999 6 1 1141 140 1
������� LV7 TECH_ContinuationAttack AS:0,AN:2,AM:2,DD:50, 316 1329995 1999 7 1 1141 160 1
������� LV8 TECH_ContinuationAttack AS:0,AN:2,AM:2,DD:60, 317 1329995 1999 8 1 1141 180 1
������� LV9 TECH_ContinuationAttack AS:0,AN:2,AM:2,DD:70, 318 1329995 1999 9 1 1141 200 1
������� LV10 TECH_ContinuationAttack AS:0,AN:2,AM:2,DD:80, 319 1329995 1999 10 1 1141 220 1

�������Ч���ǹ���2����ͬ�ж���,����ͬʱ���1.8�����˺�,ͼ�����õ���Ǭ����ͼ��.10����ħ200.
��������������˵����һ������Ч��������.�����Ч������ȫ�����Լ���Ƶ�
����:AS:0,AN:2,AM:2,DD:80
���Ҹĳ�:AS:0,AN:2,AM:2,HR:50,DD:80,�Ǿ�����ԭ�еĻ��������50%������(HR��ʾ����)
���Ҹĳ�:AS:0,AN:2,AM:2,HR:50,TR:80,�Ǿͱ�ʾԭ����1.8���˺��ĳ������80%�Ĺ�����
���Ҹĳ�:AS:0,AN:2,AM:2,HR:50,AV:50,TR:80�Ǳ�ʾ����ԭ���Ļ����������50%������
���Ҹĳ�:AS:0,AN:2,AM:2,CR:50,HR:50,AV:50,TR:80�Ǿͱ�ʾ����ԭ���Ļ�����������50%�ı�ɱ��
�Դ�����!�Լ����ڼ����ϼ�ʲôЧ��(ʲôʯ����.������),ֻҪ�Ǽ��������Ч��,�������ܼ���ȥ

����ڿ�������һ������,�����ظ�
��ħ���� LV10 TECH_Revive AR:6000, 6819 1329998 1699 1 1 87 200 1
AR:6000.�����ʾ�˱��������Ժ�ָ���Ѫ��
�����ĳɶ���.�ͱ�ʾ���������ָ���������

Ȼ��˵һ�µ��Ǽ��ܵĴ��������:
������� LV10 TECH_ContinuationAttack AS:0,AN:2,AM:2,DD:80, 319 1329995 1999 10 1 1141 200 1
���������Ϊ����.��ҿ�����,�ҵ�������ܵĴ�����319,��ǰ��Ҳ������.319���������Ǽ��ܴ���,ͬ���Ǻ�ͼ���ĵ����й�
��Ϊ�����ǲ�����д��,����Ҳ�����ظ�
��ǰ��˵��.��������ܵ�ͼ����Ǭ����ͼ��.��ô��ҿ��ԶԱ�Ǭ����һ��
Ǭ���Ĵ�����300~309�������������310~319.
ͼ������300��Ӧ����310
ͼ������301��Ӧ����311
�ڿ��ҵĶ�ħ����.���������ظ���ͼ��
ԭ�����Ĵ�����6809��Ӧ�����Ķ�ħ������6819

��������Ӧ���ܿ�������..
����������������.����Ǭ����ͼ��
Ǭ����ͼ����301�Ļ�.�������ļ���ֻҪ��311�Ϳ�����.
�����Ҫ��2����Ǭ��ͼ��һ���ļ���,��ô��������Ǭ����ͼ��
����311�Ѿ��ظ���Ե��.��ô�ĳ�321�Ϳ�����

�Դ�����.���������Ѹ�ٹ���ͼ���ļ���.��ô�Ͱ�ԭ�е�26200~26209�ĳ�26210~26219�Ϳ���.
ֻҪ��֤���ظ��Ϳ���..
���Ͼ��Ǽ��ܴ����ȡ��(������ȡ��Ŷ)
TECH�������Ӧ�þ���Щ������.

****��:����ȥ��Ҫ����Ƴ����ļ���ȥskill��������
�������ķ������Ϊ��
skill: ������� 1999 1329995 1 0 1 100 100 143 2 1 1000 0
tech: ������� LV10 TECH_ContinuationAttack AS:0,AN:2,AM:2,DD:80, 319 1329995 1999 10 1 1141 220 1

�����г���.Ӧ�ú������
���ݵڶ�����skill��tech�Ľ���:�Ѹù��������ݹ�������.
tech���������ļ��ܱ����1999.��ôskill����1999

## 
[nr setpettech 0 3 8659] ���õ�0������ĵ���������Ϊ8659 ����ǿ������
[nr setpettech 0 3 451] ���õ�0������ĵ���������Ϊ������ EX
[nr makepet 905] ���Լ���һ������,����id Ϊ905. ����id ������ gmsv\data\enemy_cn.txt ����鵽
[nr checkoinum] �鿴��ǰ����id
[nr metamo {����ID}] �ı�����id 
/module reload {module_name}
/daka ������
