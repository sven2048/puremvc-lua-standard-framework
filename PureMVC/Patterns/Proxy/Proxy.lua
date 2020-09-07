local Proxy = class("Proxy", PureMVC.Notifier)

function Proxy.__create()
    
    ---@class PureMVC.Proxy : PureMVC.Notifier
    local Instance = {}
    ---@type string
    local _proxyName
    ---@type any
    local _data
    
    ---@param proxyName string
    ---@param data any
    function Instance:ctor(proxyName, data)
        
        if not proxyName then
            proxyName = "Proxy"
        end
        _proxyName = proxyName
        _data      = data
    end
    
    function Instance:OnRegister()
    
    end
    
    function Instance:OnRemove()
    
    end
    
    ---@return string
    function Instance:GetProxyName()
        
        return _proxyName
    end
    
    ---@return any
    function Instance:GetData()
        
        return _data
    end
    
    return Instance
end

return Proxy