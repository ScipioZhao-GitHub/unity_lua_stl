--------------------------------------------------------------------------------
--      All rights reserved.
--      Use, modification and distribution are subject to the "MIT License"
--------------------------------------------------------------------------------

-- 双节点 实现链表
local ZSTL_Dictionary = {}

ZSTL_Dictionary.__index = ZSTL_Dictionary;

-- 创建字典  用table 实现 
function ZSTL_Dictionary:New(tKey, tValue)
    local t = {}
    setmetatable(t, self)
    t.m_KeyList = {};
    t.Tkey = tKey;
    t.TValue = tValue;
    return t;
end

-- 添加
function ZSTL_Dictionary:Add( key, value )
    
    if nil == self[key] then
        self[key] = value;
        table.insert(self.m_KeyList, key)
    else
        self[key] = value;
    end
end

-- 清空
function ZSTL_Dictionary:Clear()
    local count = self:Count();
    for i = count, 1, -1 do
        self[self.m_KeyList[i]] = nil;
        table.remove( self.m_KeyList, i );
    end
end

-- 存在 key
function ZSTL_Dictionary:ContainsKey( key )
    local results = false;
    
    local count = self:Count();
    for i=1, count do
        if self.m_KeyList[i] == key then
            results = true;
            break;
        end
    end

    return results;
end

-- 存在 value
function ZSTL_Dictionary:ContainsValue( value )
    local results = false;
    
    local count = self:Count();
    for i=1, count do
        if self[self.m_KeyList[i]] == value then
            results = true;
            break;
        end
    end

    return results;
end

-- 长度
function ZSTL_Dictionary:Count()
    return #self.m_KeyList;
end


-- 获取key
function ZSTL_Dictionary:GetTKey()
    return self.Tkey;
end

-- 获取value
function ZSTL_Dictionary:GetTValue()
    return self.TValue;
end

-- 删除
function ZSTL_Dictionary:Remove( key )
    local results = false;

    local count = self:Count();
    for i=1, count do
        if self.m_KeyList[i] == key then
            results = true;
            self[key] = nil;
            table.remove( self.m_KeyList, i );
            break;
        end
    end

    return results;
end

-- 尝试获取
function ZSTL_Dictionary:TryGetValue(key)
    local status, value = false, nil;

    if nil ~= self[key] then
        status = true;
        value = self[key];
    end

    return status, value;
end

-- 迭代
function ZSTL_Dictionary:Iter()
    local i = 0;
    local count = self:Count();
    local datas = self;
    return function()
        i = i +1;
        if i <= count then
            return datas.m_KeyList[i], datas[datas.m_KeyList[i]];
        end
        return nil;
    end
end


return ZSTL_Dictionary; 