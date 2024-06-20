---httpģ��
local Module = ModuleBase:createModule('http')

---@alias ParamType {string:string}
---@alias HttpApiFn {string:fun(params:ParamType, body:string):string}
---@alias HttpMethods 'get'|'post'|'put'|'delete'|'patch'

--- ����ģ�鹳��
function Module:onLoad()
    self:logInfo('load')
    local status = Http.GetStatus();
    self:logInfo('Http.GetStatus', status);

    if status == 0 then
        Http.Init();
        self:logInfo('Http.Init');
        Http.AddMountPoint("/", "./lua/www/")
        self:logInfo('Http.AddMountPoint');
        status = 1;
    end
    if status == 1 then
        Http.Start("0.0.0.0", 10086);
        self:logInfo('Http.Start');
    end
    self._Apis = {} --[[@type {string: HttpApiFn}]];
    self:regCallback('HttpRequestEvent', Func.bind(self.onHttpRequest, self));
    self:regApi('post', "register", Func.bind(self.ApiRegister, self));
    self:regApi('post', "doLua", Func.bind(self.doLua, self));
    self:regApi('post', "reloadModule", Func.bind(self.reloadModule, self));
end

---http://127.0.0.1:10086/api/doLua
---@param params ParamType
---@param body string
---@return string
function Module:doLua(params, body)
    self:logInfo("doLua", params['lua']);
    local r, ret = pcall(dofile, params['lua']);
    self:logDebug('result', r, ret);
    return "true"
end

---http://127.0.0.1:10086/api/reloadModule
---@param params ParamType
---@param body string
---@return string
function Module:reloadModule(params, body)
    self:logInfo("reloadModule", params['module']);
    reloadModule(params['module']);
    return "true"
end

---ע�����û� http://127.0.0.1:10086/api/register
---@param params ParamType
---@param body string
---@return string
function Module:ApiRegister(params, body)
    local b, ret = pcall(JSON.decode, body);
    if b ~= true or ret == nil then
        return "false";
    end
    local account = ret.account;
    local password = ret.password;
    if (account or '') == '' or (password or '') == '' then
        return "false";
    end
    self:logInfo("Register", account, password);
    local user = SQL.QueryEx('select CdKey from tbl_user where CdKey = ?', account);
    if #user.rows == 0 then
        local seq = SQL.QueryEx('select max(SequenceNumber) + 1 as Max from tbl_user');
        local sql = 'insert into tbl_user (CdKey, SequenceNumber, AccountID, AccountPassWord, '
            .. ' EnableFlg, UseFlg, BadMsg, TrialFlg, DownFlg, ExpFlg) values ('
            .. SQL.sqlValue(account) .. ', ' .. SQL.sqlValue(seq.rows[1].Max) .. ', '
            .. SQL.sqlValue(account) .. ', '
            .. SQL.sqlValue(password) .. ',1,1,0,8,0,0);'
        local r = SQL.QueryEx(sql);
        if r.effectRows == 1 then
            return "true"
        end
        --print(r, sql);
    end

    return "false";
end

---http����ص�
---@param method string
---@param api string API����
---@param params ParamType ����
---@param body string body����
---@return string body ��������
function Module:onHttpRequest(method, api, params, body)
    if self._Apis[string.lower(method .. api)] then
        self:logInfo(string.lower(method .. api), self._Apis[string.lower(method .. api)]);
        return self._Apis[string.lower(method .. api)](params, body);
    end
    return "";
end

---@param method HttpMethods
---@param api string ��Ӧhttp://127.0.0.1:10086/api/******
---@param fn HttpApiFn
function Module:regApi(method, api, fn)
    self._Apis[string.lower(method .. api)] = fn;
end

--- ж��ģ�鹳��
function Module:onUnload()
    self:logInfo('unload')
    if Http.GetStatus() == 2 then
        Http.Stop();
    end
end

return Module;
