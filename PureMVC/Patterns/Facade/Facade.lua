local Facade = class("Facade")
local _instance

---@param facadeFunc fun():PureMVC.Facade
---@return PureMVC.Facade
function Facade.GetInstance(facadeFunc)
    if not _instance and type(facadeFunc) == "function" then
        _instance = facadeFunc()
    end
    return _instance
end

function Facade.__create()
    
    ---@class PureMVC.Facade
    local Instance = {}
    ---@type PureMVC.Model
    local _model
    ---@type PureMVC.View
    local _view
    ---@type PureMVC.Controller
    local _controller
    
    function Instance:ctor()
        
        assert(_instance == nil, "Facade Singleton already constructed!")
        _instance = self
        self:InitializeFacade()
    end
    
    function Instance:InitializeFacade()
        
        self:InitializeModel()
        self:InitializeController()
        self:InitializeView()
    end
    
    function Instance:InitializeModel()
        
        _model = PureMVC.Model.GetInstance(function()
            return PureMVC.Model.new()
        end)
    end
    
    function Instance:InitializeController()
        
        _controller = PureMVC.Controller.GetInstance(function()
            return PureMVC.Controller.new()
        end)
    end
    
    function Instance:InitializeView()
        
        _view = PureMVC.View.GetInstance(function()
            return PureMVC.View.new()
        end)
    end
    
    ---@param notificationName string
    ---@param commandFunc fun():PureMVC.BaseCommand
    function Instance:RegisterCommand(notificationName, commandFunc)
        
        _controller:RegisterCommand(notificationName, commandFunc)
    end
    
    ---@param notificationName string
    function Instance:RemoveCommand(notificationName)
        
        _controller:RemoveCommand(notificationName)
    end
    
    ---@param notificationName string
    function Instance:HasCommand(notificationName)
        
        return _controller:HasCommand(notificationName)
    end
    
    ---@param proxy PureMVC.Proxy
    function Instance:RegisterProxy(proxy)
        
        _model:RegisterProxy(proxy)
    end
    
    ---@param proxyName string
    ---@return PureMVC.Proxy
    function Instance:RetrieveProxy(proxyName)
        
        return _model:RetrieveProxy(proxyName)
    end
    
    ---@param proxyName string
    ---@return PureMVC.Proxy
    function Instance:RemoveProxy(proxyName)
        
        return _model:RemoveProxy(proxyName)
    end
    
    ---@param proxyName string
    ---@return boolean
    function Instance:HasProxy(proxyName)
        
        return _model:HasProxy(proxyName)
    end
    
    ---@param mediator PureMVC.Mediator
    function Instance:RegisterMediator(mediator)
        
        _view:RegisterMediator(mediator)
    end
    
    ---@param mediatorName string
    ---@return PureMVC.Mediator
    function Instance:RetrieveMediator(mediatorName)
        
        return _view:RetrieveMediator(mediatorName)
    end
    
    ---@param mediatorName string
    ---@return PureMVC.Mediator
    function Instance:RemoveMediator(mediatorName)
        
        return _view:RemoveMediator(mediatorName)
    end
    
    ---@param mediatorName string
    ---@return boolean
    function Instance:HasMediator(mediatorName)
        
        return _view:HasMediator(mediatorName)
    end
    
    ---@param notificationName string
    ---@param body any
    ---@param type string
    function Instance:SendNotification(notificationName, body, type)
        
        self:NotifyObservers(PureMVC.Notification.new(notificationName, body, type))
    end
    
    ---@param notification PureMVC.Notification
    function Instance:NotifyObservers(notification)
        
        _view:NotifyObservers(notification)
    end
    
    return Instance
end

return Facade