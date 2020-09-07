local BaseCommand = class("BaseCommand", PureMVC.Notifier)

function BaseCommand.__create()
    
    ---@class PureMVC.BaseCommand : PureMVC.Notifier
    local Instance = {}
    
    function Instance:ctor()
        self.super:ctor()
    end
    
    ---@param notification PureMVC.Notification
    function Instance:Execute(notification)
    end
    
    return Instance
end

return BaseCommand