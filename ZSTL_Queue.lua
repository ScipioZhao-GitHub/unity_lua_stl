--------------------------------------------------------------------------------
--      All rights reserved.
--      Use, modification and distribution are subject to the "MIT License"
--------------------------------------------------------------------------------

-- 实现栈 依赖 ZSTL_List 实现
local ZSTL_List = require "ZSTL_List"

local ZSTL_Queue = {}

ZSTL_Queue.__index = ZSTL_Queue;

-- 创建栈
function ZSTL_Queue:New()
    local t = {}
    setmetatable(t, self)
    t.m_List = ZSTL_List:New();
    return t;
end

-- 队头元素
function ZSTL_Queue:Front()
    return self.m_List:Front();
end

-- 队尾元素
function ZSTL_Queue:Back()
    return self.m_List:Back();
end

-- 入队
function ZSTL_Queue:Push( value )
    self.m_List:Push_Back( value );
end

-- 出队
function ZSTL_Queue:Pop()
    return self.m_List:Pop_Front();
end

-- 盘空
function ZSTL_Queue:Empty()
    return self.m_List:Count() <= 0;
end

-- 长度
function ZSTL_Queue:Count()
    return self.m_List:Count();
end

-- 清空
function ZSTL_Queue:Clear()
    self.m_List:Clear();
end

return ZSTL_Queue; 