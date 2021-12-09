--------------------------------------------------------------------------------
--      All rights reserved.
--      Use, modification and distribution are subject to the "MIT License"
--------------------------------------------------------------------------------

-- 双节点 实现链表
local ZSTL_List = {}

ZSTL_List.__index = ZSTL_List;

-- 创建节点
local function CreateNode( value )
    return { value = value, prev = nil, next = nil };
end

-- 创建链表
function ZSTL_List:New()
    local t = {}
    setmetatable(t, self)
    t.length = 0;
    t.prev = nil;
    t.next = nil;
    return t;
end

-- 第一个元素
function ZSTL_List:Front()
    local value = nil;
    local firstNode = self.next;
    if nil ~= firstNode then
        value = firstNode.value;
    end
    return value;
end

-- 最后一个元素
function ZSTL_List:Back()
    local value = nil;
    local tailNode = self.prev;
    if nil ~= tailNode then
        value = tailNode.value;
    end
    
    return value;
end

-- 头插
function ZSTL_List:Push_Front(value)
    local node = CreateNode( value );
    
    local fristNode = self.next;
    if nil ~= fristNode then
        fristNode.prev = node;
    end

    node.next = fristNode;
    self.next = node;

    -- 只有一个元素
    if nil == self.prev then
        self.prev = node;
    end

    self.length = self.length + 1;
end

-- 头删
function ZSTL_List:Pop_Front()
    local fristNode = self.next;
    local value = nil
    if nil ~= fristNode then
        self.next = fristNode.next;
        value = fristNode.value;
    end
    
    if self.prev == fristNode then
        self.prev = nil;
    end

    self.length = math.max( 0, self.length -1)
    return value;
end

-- 尾插 nextNode
function ZSTL_List:Push_Back_Node( node )
    node.prev, node.next = nil, nil
    local tailNode  = self.prev;
    if nil ~= tailNode then
        tailNode.next = node;
    end

    node.prev = tailNode;
    self.prev = node;

    -- 只有一个元素
    if nil == self.next then
        self.next = node;
    end

    self.length = self.length+1;
end

-- 尾插
function ZSTL_List:Push_Back( value )
    self:Push_Back_Node( CreateNode( value ) );
end 

-- 尾删
function ZSTL_List:Pop_Back()
    local tailNode  = self.prev;
    local value = nil
    if nil ~= tailNode then
        self.prev = tailNode.prev;
        tailNode.prev.next = nil;
        value = tailNode.value;
    end
    
    if self.next == tailNode then
        self.next = nil;
    end

    self.length = math.max( 0, self.length -1)
    return value;
end

-- 删除 第一个找到的元素
function ZSTL_List:Remove( value )
    local status, index, reNode = self:Find(value);
    if status then
        if nil ~= reNode.prev then
            reNode.prev.next = reNode.next;
        end

        if nil ~= reNode.next then
            reNode.next.prev = reNode.prev;
        end

        if self.next == reNode then
            self.next = reNode.next;
        end

        if self.prev == reNode then
            self.prev = reNode.prev;
        end

        self.length = math.max( 0, self.length -1)
    end
    return status;
end

-- 插入
function ZSTL_List:Insert( value, index )
    local node = CreateNode(value);    

    index = index < 1 and 1 or 1;
    index = index > self.length + 1  and self.length + 1 or  self.length + 1;
    local insertIndex, insertNode = self:Index( index );
    if nil ~= insertNode then
        node.prev = insertNode.prev;
        node.next = insertNode;
        insertNode.prev = node;

        if nil ~= node.prev then
            node.prev.next = node;
        end

        if self.next == insertNode then
            self.next = node;
        end
        self.length = self.length + 1;
    else
        --尾插
        self:Push_Back(value)
    end
end

-- 索引 遵从lua 下标从1 开始
function ZSTL_List:Index( index )
    local value, _node = nil,nil;
    
    for i, node in self:IterNode() do
        if i == index then
            value = node.value;
            _node = node;
            break;
        end
    end
    return value;
end

-- 查询
function ZSTL_List:Find(value)
    local status, index, reNode = false, -1, nil;
    
    for i, node in self:IterNode() do
        if node.value == value then
            status = true;
            index = i;
            reNode = node;
            break;
        end 
    end

    return status, index, reNode;
end

-- 长度
function ZSTL_List:Count()
    return self.length;
end

-- 清空
function ZSTL_List:Clear()
    self.length = 0;
    self.prev = nil;
    self.next = nil;
end

-- 排序 不是很好 数据量大的情况下建议不要用  有性能开销 
-- 本来不想实现 考虑到在实际应用过程中经常用到(数量量级比较低的情况下  问题不大)
function ZSTL_List:Sort(comp)
    local datas = {};
    for i, value in self:Iter() do
        datas[#datas+1] = value;
    end
    self:Clear();
    table.sort( datas, comp );

    for i=1, #datas do
        self:Push_Back( datas[i] );
    end
end

-- 洗牌 乱序
function ZSTL_List:Shuffle()
    local dataNodes = {};
    for i, node in self:IterNode() do
        dataNodes[#dataNodes+1] = node;
    end
    self:Clear();
    
    local count = #dataNodes;
    math.randomseed(tostring(os.time()):reverse():sub( 1,6 ))
    for i = 1, #dataNodes-1 do
        local randIndex = math.random( i+1, count );
        
        local temp = dataNodes[i];
        dataNodes[i] = dataNodes[randIndex];
        dataNodes[randIndex] = temp;
    end

    for i = 1,#dataNodes  do
        -- body
        self:Push_Back_Node( dataNodes[i] );
    end
end

-- 遍历 值 外部一般使用这个
function ZSTL_List:Iter()
    local i = 0;
    local nextNode = self; 
    return function()
        i = i + 1;
        nextNode = nextNode.next;
        if nil ~= nextNode then
            return i, nextNode.value;
        end
        return nil;
    end
end

-- 遍历 节点
function ZSTL_List:IterNode()
    local i = 0;
    local nextNode = self; 
    return function()
        i = i + 1;
        nextNode = nextNode.next;
        if nil ~= nextNode then
            return i, nextNode;
        end
        return nil;
    end
end

return ZSTL_List; 