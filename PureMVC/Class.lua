local function _create(proxy)
    
    local instance = proxy.__create()
    
    for k, v in pairs(proxy) do
        
        if k ~= "new" and k ~= "__create" and k ~= "super" then
            instance[k] = v
        end
    end
    
    if not proxy.super and not instance.ctor then
        instance.ctor = function()
        end
    end
    
    if proxy.super then
        
        local superInstance = _create(proxy.super)
        instance.super      = superInstance
        setmetatable(instance, { __index = superInstance })
    end
    
    instance.__index = instance
    return instance
end

function class(className, superProxy)
    
    local superType = type(superProxy)
    local proxy
    
    if superType ~= "table" then
        superType  = nil
        superProxy = nil
    end
    
    proxy         = {}
    proxy.super   = superProxy
    proxy.__cname = className
    
    function proxy.new(...)
        
        local instance = _create(proxy)
        instance:ctor(...)
        return instance
    end
    
    return proxy
end