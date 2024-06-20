local strExt = {}

local function getCharSize(char)
    if not char then
        return 0
    elseif char > 240 then
        return 4
    elseif char > 225 then
        return 3
    elseif char > 192 then
        return 2
    else
        return 1
    end
end

local function utf8len(str)
    local len = 0;
    local curIndex = 1;
    while curIndex <= #str do
        local char = string.byte(str, curIndex);
        curIndex = curIndex + getCharSize(char)
        len = len + 1;
    end

    return len;
end

local function utf8len_withChinese(str)
    local len = 0;
    local curIndex = 1;
    while curIndex <= #str do
        local char = string.byte(str, curIndex);
        local charLen = getCharSize(char);
        curIndex = curIndex + charLen;
        if charLen > 2 then
            len = len + 2
        else
            len = len +1;
        end
    end
    return len;
end

local function subString_utf8(str, startChar, numChars)
    local startIndex = 1;
    while startChar > 1 do
        local char = string.byte(str, startIndex);
        startIndex = startIndex + getCharSize(char);
        startChar = startChar - 1;
    end

    local currentIndex = startIndex;
    while numChars > 0 and currentIndex <= #str do
        local char = string.byte(str, currentIndex);
        currentIndex = currentIndex + getCharSize(char);
        numChars = numChars - 1;
    end

    return str:sub(startIndex, currentIndex - 1), numChars
end

local function strSub(str, len)
    local curLen = 0;
    local curIdx = 1;
    local tmpStr = '';
    while curIdx <= #str and curLen < len do
        local char = string.byte(str, curIdx);
        local charLen = getCharSize(char);
        curIdx = curIdx + charLen;
        if charLen > 2 then
            curLen = curLen + 2;
        else
            curLen = curLen + 1;
        end
    end

    return str:sub(1, curLen)
end

function strExt.strParse(strTable)
    local resStr = '';
    for idx = 1, #strTable do
        local _str = strTable[idx][1];
        local _len = strTable[idx][2];

        -- 如果_str长度>_len, 则截取字符串, 否则拼接空格
        local curStr = '';
        if #_str > _len then
            curStr = strSub(_str, _len);
        else
            local diff = _len - #_str;
            curStr = _str;
            for i = 1, diff do
                curStr = curStr .. ' ';
            end
        end
        resStr = resStr .. curStr;
    end

    return resStr;
end





return strExt;

