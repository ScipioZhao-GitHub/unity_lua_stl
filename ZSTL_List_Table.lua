--------------------------------------------------------------------------------
--      All rights reserved.
--
--      Use, modification and distribution are subject to the "MIT License"
--------------------------------------------------------------------------------

--  table  实现链表
-- 要比节点实现简单很多 
--          增  删  改  查  索引
--table                好   1
--双节点    好  好  好      O(n)
--不知道table 里面的具体实现  双节点一切在自己掌控中 
-- 需要频繁索引  用table    频繁增改 用双节点
local ZSTL_List_Table = {}

ZSTL_List_Table.__index = ZSTL_List_Table;

-- 创建链表
function ZSTL_List_Table:New()
    local t = {}
    setmetatable(t, self)
    return t;
end

-- 第一个元素
function ZSTL_List_Table:Front()
    local value = self[1];
    return value;
end

-- 最后一个元素
function ZSTL_List_Table:Back()
    local value = self[#self];
    return value;
end

-- 头插
function ZSTL_List_Table:Push_Front(value)
    table.insert(self, 1, value)
end

-- 头删
function ZSTL_List_Table:Pop_Front()
    local value = self[1];
    table.remove(self, 1)
    return value;
end


-- 尾插
function ZSTL_List_Table:Push_Back( value )
    table.insert(self, #self+1, value)
end 

-- 尾删
function ZSTL_List_Table:Pop_Back()
    local value = self[#self];
    table.remove(self, #self)
    return value;
end

-- 删除 第一个找到的元素
function ZSTL_List_Table:Remove( value )
    local status, index = self:Find(value);
    if status then
        table.remove( self, index );
    end

    return status;
end

-- 删除 下标
function ZSTL_List_Table:RemoveAt( index )
    local status = index >= 1 and index <= self:Count()
    if status then
        table.remove( self, index );
    end
    return status
end

-- 插入
function ZSTL_List_Table:Insert( value, index )
    index = math.max( 1, index );
    index = math.min( self:Count()+1,index )
    table.insert( self, index, value );
end

-- 索引 遵从lua 下标从1 开始
function ZSTL_List_Table:Index( index )
    local value = table[index];
    return value;
end

-- 查询
function ZSTL_List_Table:Find(value)
    local status, index = false, -1;
    for i, _value in self:Iter() do
        if _value == value then
            status = true;
            index = i;
            break;
        end 
    end

    return status, index;
end

-- 长度
function ZSTL_List_Table:Count()
    return #self;
end

-- 清空
function ZSTL_List_Table:Clear()
    local count = self:Count()
    for i = count, 1, -1 do
        table.remove(self,i)
    end
end

function ZSTL_List_Table:Sort(comp)
    table.sort( self, comp );
end

-- 洗牌 乱序
function ZSTL_List_Table:Shuffle()    
    local count = #self;
    math.randomseed(tostring(os.time()):reverse():sub( 1,6 ))
    for i = 1, #self-1 do
        local randIndex = math.random( i+1, count );
        
        local temp = self[i];
        self[i] = self[randIndex];
        self[randIndex] = temp;
    end

end

-- 遍历 值 外部一般使用这个
function ZSTL_List_Table:Iter()
    local i = 0; 
    local list = self;
    return function()
        i = i+1;
        if #list >= i then
            return i, list[i];
        end
        return nil;
    end
end


return ZSTL_List_Table; 