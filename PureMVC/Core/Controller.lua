local Controller = class("Controller")
local _instance

---@param controllerFunc fun():PureMVC.Controller
---@return PureMVC.Controller
function Controller.GetInstance(controllerFunc)
    
    if not _instance and type(controllerFunc) == "function" then
        _instance = controllerFunc()
    end
    
    return _instance
end

function Controller.__create()
    
    ---@class PureMVC.Controller
    local Instance = {}
    ---@type table<string, fun():PureMVC.BaseCommand>
    local _commandMap
    ---@type PureMVC.View
    local _view
    
    function Instance:ctor()
        
        assert(_instance == nil, "Controller Singleton already constructed!")
        _instance   = self
        _commandMap = {}
        self:InitializeController()
    end
    
    function Instance:InitializeController()
        
        _view = PureMVC.View.GetInstance(function()
            return PureMVC.View.new()
        end)
    end
    
    ---@param notificationName string
    ---@return boolean
    function Instance:HasCommand(notificationName)
        
        return _commandMap[notificationName] ~= nil
    end
    
    ---@param notification PureMVC.Notification
    function Instance:ExecuteCommand(notification)
        
        local commandFunc     = _commandMap[notification:GetName()]
        local commandInstance = commandFunc()
        commandInstance:Execute(notification)
    end
    
    ---@param notificationName string
    ---@param commandFunc fun():PureMVC.BaseCommand
    function Instance:RegisterCommand(notificationName, commandFunc)
        
        if not self:HasCommand(notificationName) then
            _view:RegisterObserver(notificationName, PureMVC.Observer.new(self.ExecuteCommand, self))
        end
        _commandMap[notificationName] = commandFunc
    end
    
    ---@param notificationName string
    function Instance:RemoveCommand(notificationName)
        
        if not self:HasCommand(notificationName) then
            return
        end
        
        _view:RemoveObserver(notificationName, self)
        _commandMap[notificationName] = nil
    end
    
    return Instance
end

return Controller