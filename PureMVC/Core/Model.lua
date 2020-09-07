local Model = class("Model")
local _instance

---@param modelFunc fun()
---@return PureMVC.Model
function Model.GetInstance(modelFunc)
    
    if not _instance and type(modelFunc) == "function" then
        _instance = modelFunc()
    end
    
    return _instance
end

function Model.__create()
    
    ---@class PureMVC.Model
    local Instance = {}
    ---@type table<string, PureMVC.Proxy>
    local _proxyMap
    
    function Instance:ctor()
        
        assert(_instance == nil, "Model Singleton already constructed!")
        _instance = self
        _proxyMap = {}
        self:InitializeModel()
    end
    
    function Instance:InitializeModel()
    end
    
    ---@param proxy PureMVC.Proxy
    function Instance:RegisterProxy(proxy)
        
        _proxyMap[proxy:GetProxyName()] = proxy
        proxy:OnRegister()
    end
    
    ---@param proxyName string
    ---@return PureMVC.Proxy
    function Instance:RetrieveProxy(proxyName)
        
        return _proxyMap[proxyName]
    end
    
    ---@param proxyName string
    ---@return PureMVC.Proxy
    function Instance:RemoveProxy(proxyName)
        
        local proxy = self:RetrieveProxy(proxyName)
        if proxy then
            _proxyMap[proxyName] = nil
            proxy:OnRemove()
        end
        return proxy
    end
    
    ---@param proxyName string
    ---@return boolean
    function Instance:HasProxy(proxyName)
        
        return self:RetrieveProxy(proxyName) ~= nil
    end
    
    return Instance
end

return Model