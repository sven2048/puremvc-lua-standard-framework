local MacroCommand = class("MacroCommand", PureMVC.BaseCommand)

function MacroCommand.__create()
    
    ---@class PureMVC.MacroCommand : PureMVC.BaseCommand
    local Instance = {}
    ---@type PureMVC.BaseCommand[]
    local _subCommands
    
    function Instance:ctor()
        
        self.super:ctor()
        _subCommands = {}
        self:InitializeMacroCommand()
    end
    
    function Instance:InitializeMacroCommand()
    end
    
    ---@param commandFunc fun():PureMVC.BaseCommand
    function Instance:AddSubCommand(commandFunc)
        
        table.insert(_subCommands, commandFunc)
    end
    
    ---@param notification PureMVC.Notification
    function Instance:Execute(notification)
        
        if #_subCommands == 0 then
            return
        end
        
        for _, commandFunc in ipairs(_subCommands) do
            local commandInstance = commandFunc()
            commandInstance:Execute(notification)
        end
        
        _subCommands = {}
    end
    
    return Instance
end

return MacroCommand