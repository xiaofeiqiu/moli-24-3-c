---@meta _

---@since HOOK:v0.2.30
---@return string
function getHookVer() end

---����Moduleģ��
function loadModule(string) end

---������ͨLUA
function useModule(string) end

---��ȡģ��
---@param name string ģ��ID
---@return ModuleBase|any
function getModule(name) end

---����ģ��
---@param name string ģ��ID
function reloadModule(name) end

---ж��ģ��
---@param name string ģ��ID
function unloadModule(name) end

--- ע��ȫ���¼�
---@param eventName string
---@param fn function|OrderedCallback
---@param moduleName string
---@param extraSign string
---@return number ȫ��ע��Index
function regGlobalEvent(eventName, fn, moduleName, extraSign) end

--- ע��ȫ���¼�
---@param eventName string
---@param fn function|OrderedCallback
---@return number ȫ��ע��Index
function regGlobalEvent(eventName, fn) end

--- �Ƴ�ȫ���¼�
---@param eventName string
---@param fnIndex number ȫ��ע��Index
---@param moduleName string|nil
---@param extraSign string|nil
function removeGlobalEvent(eventName, fnIndex, moduleName, extraSign) end

--- �Ƴ�ȫ���¼�
---@param eventName string
---@param fnIndex number ȫ��ע��Index
function removeGlobalEvent(eventName, fnIndex) end

---������ת����string��ʽ����ʶ��ת�������
---@param s string|number
---@return string|nil @string��ʽ���� ʧ�ܷ���'null'
function SQL.sqlValue(s) end

---ִ��ָ����Mysql��ѯ��
---@param sql  string Ҫִ�е�Mysql��ѯ��䡣
---@return string[][] @table[a][b]aΪ������bΪ����
function SQL.querySQL(sql, returnNil) end

---��ȡװ�������� ItemIndex��λ��
---@param charIndex number
---@return number @װ��λ��
---@return number @װ������
---@return number @itemIndex
function Char.GetWeapon(charIndex) end

---���index�Ƿ���ȷ
---@param charIndex number
function Char.IsValidCharIndex(charIndex) end

---��ȡ�յĵ�����
---@param charIndex number
---@return number @slot
function Char.GetEmptyItemSlot(charIndex) end

---��ȡ����������λ
---@param charIndex number
---@param itemIndex number
---@return number @slot
function Char.GetItemSlot(charIndex, itemIndex) end

---��ȡ�յĳ�����
---@param charIndex number
---@return number @slot
function Char.GetEmptyPetSlot(charIndex) end

---�Ƿ�Ϊ����
---@param charIndex number
---@return boolean
function Char.IsPet(charIndex) end

---�Ƿ�Ϊ���
---@param charIndex number
---@return boolean
function Char.IsPlayer(charIndex) end

---�Ƿ�Ϊ����
---@param charIndex number
---@return boolean
function Char.IsEnemy(charIndex) end

---�Ƿ�ΪNPC
---@param charIndex number
---@return boolean
function Char.IsNpc(charIndex) end
