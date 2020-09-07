local Notification = class("Notification")

function Notification.__create()
    
    ---@class PureMVC.Notification
    local Instance = {}
    ---@type string
    local _name
    ---@type any
    local _body
    ---@type string
    local _type
    
    ---@param name string
    ---@param body any
    ---@param type string
    function Instance:ctor(name, body, type)
        
        _name = name
        _body = body
        _type = type
    end
    
    ---@return string
    function Instance:GetName()
        
        return _name
    end
    
    ---@return any
    function Instance:GetBody()
        
        return _body
    end
    
    ---@return string
    function Instance:GetType()
        
        return _type
    end
    
    ---@return string
    function Instance:ToString()
        
        return string.format("Notification Name: %s\nBody: %s\nType: %s", tostring(_name), tostring(_body), tostring(_type))
    end
    
    return Instance
end

return Notification