local Observer = class("Observer")

function Observer.__create()
    
    ---@class PureMVC.Observer
    local Instance = {}
    ---@type fun(notification:PureMVC.Notification):void
    local _notifyMethod
    ---@type any
    local _notifyContext
    
    ---@param notifyMethod fun(notification:PureMVC.Notification):void
    ---@param notifyContext any
    function Instance:ctor(notifyMethod, notifyContext)
        
        _notifyMethod = notifyMethod
        _notifyContext = notifyContext
    end

    ---@return any
    function Instance:GetNotifyContext()
        
        return _notifyContext
    end

    ---@param notification PureMVC.Notification
    function Instance:NotifyObserver(notification)
        
        if _notifyMethod and type(_notifyMethod) == "function" then
            _notifyMethod(_notifyContext, notification)
        end
    end

    ---@param notifyContext any
    function Instance:CompareNotifyContext(notifyContext)
        
        return _notifyContext == notifyContext
    end

    return Instance
end

return Observer