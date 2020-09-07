local Notifier = class("Notifier")

function Notifier.__create()
    
    ---@class PureMVC.Notifier
    local Instance = {}

    function Instance:ctor()
    end

    ---@param notificationName string
    ---@param body any
    ---@param type string
    function Instance:SendNotification(notificationName, body, type)
        
        local facade = Instance.GetFacade()
        if facade then
            facade:SendNotification(notificationName, body, type)
        end
    end

    ---@return PureMVC.Facade
    function Instance.GetFacade()
        
        return PureMVC.Facade.GetInstance(function()
            return PureMVC.Facade.new()
        end)
    end

    return Instance
end

return Notifier