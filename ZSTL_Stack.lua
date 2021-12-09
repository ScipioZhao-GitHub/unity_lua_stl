--------------------------------------------------------------------------------
--      All rights reserved.
--      Use, modification and distribution are subject to the "MIT License"
--------------------------------------------------------------------------------

-- 实现栈 依赖 ZSTL_List 实现
local ZSTL_List = require "ZSTL_List"

local ZSTL_Stack = {}

ZSTL_Stack.__index = ZSTL_Stack;

-- 创建栈
function ZSTL_Stack:New()
    local t = {}
    setmetatable(t, self)
    t.m_List = ZSTL_List:New();
    return t;
end

-- 顶部元素
function ZSTL_Stack:Top()
    return self.m_List:Front();
end

-- 入栈
function ZSTL_Stack:Push( value )
    self.m_List:Push_Front( value );
end

-- 出栈
function ZSTL_Stack:Pop()
    return self.m_List:Pop_Front();
end

-- 盘空
function ZSTL_Stack:Empty()
    return self.m_List:Count() <= 0;
end

-- 长度
function ZSTL_Stack:Count()
    return self.m_List:Count();
end

-- 清空
function ZSTL_Stack:Clear()
    self.m_List:Clear();
end


return ZSTL_Stack; 