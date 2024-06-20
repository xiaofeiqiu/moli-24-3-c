# cgmsv lua

## 模块系统

支持动态加载、卸载以及版本升级的数据迁移。其中通过Module注册的回调卸载时自动清理

### ModuleBase类

#### 属性

1. `name` 当前模块名字, string类型
2. `migrations` 升级迁移列表， 数组类型， 每项元素需要有`version`，`name`，`value` 三个属性
    - `version` 版本号 number类型
    - `name` 名称 string类型
    - `value` sql或者具体方法 string或function类型

#### 方法

1. `ModuleBase:regCallback(eventNameOrCallbackKeyOrFn, fn)`  注册回调
    - 参数 `eventNameOrCallbackKeyOrFn`
      - 可以传入NL.Reg*对应的事件名称，如NL.RegLoginEvent 传入 `LoginEvent`
      - 自定义的名称用于非全局回调（如NPC创建回调）
      - 匿名回调（如NPC创建回调）

    - 参数 `fn`
      - 回调函数，如果eventNameOrCallbackKeyOrFn是匿名回调，fn可以传nil

    - 返回值 `eventNameOrCallbackKeyOrFn`, `lastIx`, `fnIndex`
      - `eventNameOrCallbackKeyOrFn` 函数的全局Key，用于传入NL.Reg*
      - `lastIx` 当前模块下的注册序列
      - `fnIndex` 全局注册序列

2. `ModuleBase:unRegCallback(eventNameOrCallbackKey, fnOrFnIndex)`  反注册回调
    - 参数 `eventNameOrCallbackKey`
      - 可以传入NL.Reg*对应的事件名称，如NL.RegLoginEvent 传入 `LoginEvent`
      - 自定义的名称用于非全局回调（如NPC创建回调）

    - 参数 `fnOrFnIndex`
      - 可入传入注册用的回调函数
      - 也可以fnIndex 全局注册序列
3. `ModuleBase:onLoad()`  模块注册钩子，由具体实现模块实现
4. `ModuleBase:onUnload()`  模块卸载钩子，由具体实现模块实现
5. `ModuleBase:logInfo(msg, ...)`  打印日志
6. `ModuleBase:logDebug(msg, ...)`  打印日志
7. `ModuleBase:logWarn(msg, ...)`  打印日志
8. `ModuleBase:logError(msg, ...)`  打印日志
9. `ModuleBase:log(level, msg, ...)`  打印日志
10. `ModuleBase:addMigration(version, name, sqlOrFunction)` 创建一个新迁移

## 模块加载
具体模块加载在ModuleConfig.lua
### loadModule 
加载`Modules`下的Module，Module的作用域相互独立，除非手动指定全局变量，否则不会影响其他Module，如需访问其他Module可通过getModule获取
```
loadModule('admin') --加载admin模块
```
### useModule 
加载`Module`目录下的普通lua, 普通lua都会在一个公共的作用域下执行。除非手动指定为全局变量，否则只会影响普通lua，module不能访问相关变量/方法
```
useModule('Welcome') --加载Welcome
```
### getModule
获取对应的Module

### unloadModule
卸载Module

### reloadModule
重新加载Module

### 目前能用的模块
1. admin 模块动态管理等
2. ng 内挂相关
3. shop 东门商店NPC配置
4. warp 村落传送
5. warp2 练级点传送
6. welcome 示例模块
7. itemPowerUp.lua 装备强化
8. manaPool 血魔池
9. bag 背包切换
10. autoRegister 自动注册
11. ~~petExt/charExt/itemExt 公共扩展模块(已废弃)~~
12. petLottery 宠物抽奖
13. petRebirth 宠物转生
14. autoUnlock 自动解锁崩端导致的卡号
   
### 开发中的模块
- AI扩展

## GMSV 扩展模块
1. BattleEx.lua 战斗相关扩展
2. Char.lua  人物相关扩展
3. DamageHook.lua 伤害修改补丁
4. Data.lua Data相关
5. Item.lua 物品相关
6. LowCpuUsage.lua 减低cpu使用补丁
7. Protocol.lua 封包拦截相关
8. Recipe.lua 配方相关
9. DummyChar.lua 假人相关
10. NL.lua 扩展事件相关
11. NLG_ShowWindowTalked_Patch.lua NLG.ShowWindowTalked 长度补丁
12. Addresses.lua 基础地址
13. Field.lua Field相关

## 扩展事件/接口
- `NL.RegEnemyCommandEvent` 怪物行动事件
- `NL.RegCharaDeletedEvent` 角色删除事件
- `NL.RegResetCharaBattleStateEvent` 角色战斗结束事件
- `NL.RegBattleDamageEvent` 原来的RegDamageCalculateEvent
- `NL.RegDamageCalculateEvent` 补丁后的战斗伤害事件
- `NL.RegBattleHealCalculateEvent` 战斗治疗事件
- `NL.RegDeleteDummyEvent` 假人删除事件
- `NL.RegItemExpansionEvent` 用于物品说明处理
- `NLG.FindUser` 查找在线用户
- `Map.GetDungeonExpireTime` 获取迷宫剩余时间
- `Map.GetDungeonExpireAt` 获取迷宫过期时间
- `Char.GetCharPointer` 获取角色Ptr
- `Char.GetWeapon` 获取武器
- `Char.GiveItem` 添加物品，支持静默模式
- `Char.DelItem` 删除物品，支持静默模式
- `Char.DelItemBySlot` 删除指定位置的物品
- `Char.UnsetWalkPostEvent` 移除事件
- `Char.UnsetWalkPreEvent` 移除事件
- `Char.UnsetPostOverEvent` 移除事件
- `Char.UnsetLoopEvent` 移除事件
- `Char.UnsetTalkedEvent` 移除事件
- `Char.UnsetWindowTalkedEvent` 移除事件
- `Char.UnsetItemPutEvent` 移除事件
- `Char.UnsetWatchEvent` 移除事件
- `Char.MoveArray` 角色连续移动
- `Char.JoinParty` 加入队伍
- `Char.LeaveParty` 离开队伍
- `Char.MoveItem` 移动物品
- `Char.IsValidCharPtr` 
- `Char.IsValidCharIndex` 
- `Char.GetDataByPtr` 根据Ptr获取数据
- `Char.IsDummy` 是否是假人
- `Char.CreateDummy` 创建假人
- `Char.DelDummy` 删除假人
- `Char.CalcConsumeFp` 用于获取技能所需要的fp
- `Char.SetPetDepartureState` 设置宠物战斗状态
- `Char.SetPetDepartureStateAll` 设置宠物战斗状态
- `Char.TradeItem` 直接交易物品
- `Char.TradePet` 直接交易宠物
- `Char.GetEmptyItemSlot` 获取空物品栏
- `Char.GetEmptyPetSlot` 获取空宠物栏
- `Battle.UnsetWinEvent` 移除事件
- `Battle.UnsetPVPWinEvent` 移除事件
- `Battle.GetNextBattle` 获取下一场连战Id
- `Battle.SetNextBattle` 设置下一场连战Id
- `Battle.GetTurn` 获取当前回合
- `Battle.ActionSelect` 选择战斗指令
- `Battle.IsWaitingCommand` 判断是否等待指令
- `Data.ItemsetGetIndex` 获取ItemsetIndex
- `Data.ItemsetGetData` 获取Itemset数据
- `Data.GetEncountData` 获取Encount数据
- `Data.SetMessage` 获取Msg
- `Data.GetMessage` 修改/新增Msg，动态创建物品时大概会有用
- `Data.EnemyGetDataIndex` 获取EnemyDataIndex
- `Data.EnemyGetData` 获取Enemy数据
- `Data.EnemyBaseGetDataIndex` 获取EnemyBaseDataIndex
- `Data.EnemyBaseGetData` 获取EnemyBase数据
- `Item.GetSlot` 获取ItemIndex对应位置
- `Protocol.makeEscapeString` 编码字符串
- `Protocol.makeStringFromEscaped` 解码字符串
- `Protocol.nrprotoEscapeString` 封包编码字符串
- `Protocol.nrprotoUnescapeString` 封包解码字符串
- `Protocol.Send` 发送自定义封包
- `Protocol.GetCharIndexFromFd` 通过fd获取charIndex
- `Protocol.OnRecv` 拦截封包
- `Recipe.GiveRecipe` 添加配方
- `Recipe.RemoveRecipe` 删除配方
- `regGlobalEvent` 注册全局事件，代替Delegate，Delegate也是包装这个方法
- `removeGlobalEvent` 移除注册事件
- 更多接口参考 [docs.lua](docs/docs.lua)

# 技能详解
skill:乾坤一掷为例
乾坤一掷 3 130003 1 6 1 100 100 159 2 1 1000 0
1:技能名字
2:技能代号
3:技能解释
4:技能种类(0表示被动技能,1表示物理攻击,2表示生产技能,3表示魔法技能,6表示其他类技能)
5:表示非本职职业默认所能学到的此技能等级(也就是说skilllv里没有规定此技能可学习等级到几级的职业都可练到6)
6:这个应该也是技能种类(不是很确定)
7:该技能学习费用
8:这个不知道
9:表示武器限制(255表示无限制,143表示近身武器,159应该是近身武器或者弓可用,64应该是回力,128空手)10:与skillexp里的经验相关联
11:技能所需技能栏
12:这个不清楚,貌似都是1000
13:这个也不清楚
注:0后面有两个格,第一个填职业总号,10是剑士,20是战斧,总之是填各职业见习代号-1的数,最后一个格是填你前面那格写的职业用此技能的经验所得~~~~一般设置200,
比如,0后面写10 200,意思就是当剑士使用这技能,用一次的经验就是200/10,就是20经验一次,等于这就是他的得意技.最后两个格不写的话,就是所有职业用一次都是10经验

TECH:乾坤一掷为例
乾坤一掷 LV1 TECH_Parameter AS:0,HR:-2,DD:10, 300 130003 3 1 1 1141 10 1
1:技能名字
2:技能性质
3:技能效果
4:技能代号以及调用图挡(这个环节不能重复,关于有些技能要用到相同的图挡,一会我会做详细解释)
5:技能的注释(会出现游戏中的技能筐里)
6:表示该技能所关联的skill.txt的技能代号
7:技能等级(如果是30,表示是宠物使用,如果是50,表示BOSS使用)
8:技能种类1表示战斗技能,2表示生产技能,3表示治疗急救变装什么的)
9:技能范围
10:所需耗魔量
11:技能使用者(0表示人可使用,宠和BOSS是1)

三:知道了以上的东西,那么写技能已经不是难事了
其实不管你在什么SF看到的5花8门的技能,都是如出一辙的
首先设置TECH吧..理论性知识我就不多说了.我就把自己做几个技能拿出来说吧.
疯狂乱舞 LV1 TECH_ContinuationAttack AS:0,AN:2,AM:2,DD:20, 310 1329995 1999 1 1 1141 20 1
疯狂乱舞 LV2 TECH_ContinuationAttack AS:0,AN:2,AM:2,DD:25, 311 1329995 1999 2 1 1141 40 1
疯狂乱舞 LV3 TECH_ContinuationAttack AS:0,AN:2,AM:2,DD:30, 312 1329995 1999 3 1 1141 80 1
疯狂乱舞 LV4 TECH_ContinuationAttack AS:0,AN:2,AM:2,DD:35, 313 1329995 1999 4 1 1141 100 1
疯狂乱舞 LV5 TECH_ContinuationAttack AS:0,AN:2,AM:2,DD:40, 314 1329995 1999 5 1 1141 120 1
疯狂乱舞 LV6 TECH_ContinuationAttack AS:0,AN:2,AM:2,DD:45, 315 1329995 1999 6 1 1141 140 1
疯狂乱舞 LV7 TECH_ContinuationAttack AS:0,AN:2,AM:2,DD:50, 316 1329995 1999 7 1 1141 160 1
疯狂乱舞 LV8 TECH_ContinuationAttack AS:0,AN:2,AM:2,DD:60, 317 1329995 1999 8 1 1141 180 1
疯狂乱舞 LV9 TECH_ContinuationAttack AS:0,AN:2,AM:2,DD:70, 318 1329995 1999 9 1 1141 200 1
疯狂乱舞 LV10 TECH_ContinuationAttack AS:0,AN:2,AM:2,DD:80, 319 1329995 1999 10 1 1141 220 1

这个技能效果是攻击2个不同敌对象,并且同时造成1.8倍的伤害,图挡调用的是乾坤的图挡.10级耗魔200.
这里想跟大家着重说的是一个技能效果的问题.这里的效果是完全可以自己设计的
比如:AS:0,AN:2,AM:2,DD:80
若我改成:AS:0,AN:2,AM:2,HR:50,DD:80,那就是在原有的基础提高了50%命中率(HR表示命中)
若我改成:AS:0,AN:2,AM:2,HR:50,TR:80,那就表示原来的1.8倍伤害改成了提高80%的攻击力
若我改成:AS:0,AN:2,AM:2,HR:50,AV:50,TR:80那表示又在原来的基础上提高了50%的闪躲
若我改成:AS:0,AN:2,AM:2,CR:50,HR:50,AV:50,TR:80那就表示又在原来的基础上增加了50%的必杀率
以此类推!自己想在技能上加什么效果(什么石化啦.混乱啦),只要是技能种类的效果,基本都能加上去

大家在看我做的一个技能,气绝回复
恶魔重生 LV10 TECH_Revive AR:6000, 6819 1329998 1699 1 1 87 200 1
AR:6000.这个表示人被拉起来以后恢复的血量
数量改成多少.就表示被拉起来恢复数量多少

然后说一下的是技能的代码的问题:
疯狂乱舞 LV10 TECH_ContinuationAttack AS:0,AN:2,AM:2,DD:80, 319 1329995 1999 10 1 1141 200 1
还是以这个为例子.大家看到了,我的这个技能的代号是319,我前面也解释了.319并不单单是技能代码,同样是和图挡的调用有关
因为代码是不能乱写的,并且也不能重复
我前面说了.我这个技能的图挡是乾坤的图挡.那么大家可以对比乾坤看一下
乾坤的代号是300~309而我这个技能是310~319.
图挡代码300对应的是310
图挡代码301对应的是311
在看我的恶魔重生.他是气绝回复的图挡
原气绝的代码是6809对应我做的恶魔重生是6819

到这里大家应该能看出来了..
比如你想做个技能.利用乾坤的图挡
乾坤的图挡是301的话.你新做的技能只要填311就可以了.
如果你要做2个和乾坤图挡一样的技能,那么还是利用乾坤的图挡
由于311已经重复的缘故.那么改成321就可以了

以此类推.如果你想做迅速果断图挡的技能.那么就把原有的26200~26209改成26210~26219就可以.
只要保证不重复就可以..
以上就是技能代码的取法(不是乱取的哦)
TECH里的设置应该就这些问题了.

****四:接下去就要把设计出来的技能去skill里设置了
拿我做的疯狂乱舞为例
skill: 疯狂乱舞 1999 1329995 1 0 1 100 100 143 2 1 1000 0
tech: 疯狂乱舞 LV10 TECH_ContinuationAttack AS:0,AN:2,AM:2,DD:80, 319 1329995 1999 10 1 1141 220 1

这样列出来.应该很清楚了
根据第二步对skill和tech的解释:把该关联的数据关联起来.
tech里所关联的技能编号是1999.那么skill里是1999

## 
[nr setpettech 0 3 8659] 设置第0个宠物的第三个技能为8659 （超强即死）
[nr setpettech 0 3 451] 设置第0个宠物的第三个技能为气功蛋 EX
[nr makepet 905] 给自己加一个宠物,宠物id 为905. 宠物id 可以在 gmsv\data\enemy_cn.txt 里面查到
[nr checkoinum] 查看当前形象id
[nr metamo {形象ID}] 改变形象id 
/module reload {module_name}
/daka 开启打卡
