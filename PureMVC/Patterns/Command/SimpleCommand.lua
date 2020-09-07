local SimpleCommand = class("SimpleCommand", PureMVC.BaseCommand)

function SimpleCommand.__create()
    
    ---@class PureMVC.SimpleCommand : PureMVC.BaseCommand
    local Instance = {}
    
    function Instance:ctor()
        Instance.super:ctor()
    end
    
    ---@param notification PureMVC.Notification
    function Instance:Execute(notification)
    end
    
    return Instance
end

return SimpleCommand