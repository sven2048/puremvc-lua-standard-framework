local Mediator = class("Mediator", PureMVC.Notifier)

function Mediator.__create()
    
    ---@class PureMVC.Mediator : PureMVC.Notifier
    local Instance = {}
    ---@type string
    local _mediatorName
    ---@type table
    local _viewComponent
    
    ---@param mediatorName string
    ---@param viewComponent table
    function Instance:ctor(mediatorName, viewComponent)
        
        if not mediatorName then
            mediatorName = "Mediator"
        end
        
        _mediatorName  = mediatorName
        _viewComponent = viewComponent
    end

    ---@return string
    function Instance:GetMediatorName()
        
        return _mediatorName
    end

    ---@return table
    function Instance:GetViewComponent()
        
        return _viewComponent
    end

    ---@return string[]
    function Instance:ListNotificationInterests()
        
        return {}
    end

    ---@param notification PureMVC.Notification
    function Instance:HandleNotification(notification)
    
    end

    function Instance:OnRegister()
    
    end

    function Instance:OnRemove()
    
    end

    return Instance
end

return Mediator