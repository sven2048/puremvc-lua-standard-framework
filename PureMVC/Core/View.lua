local View = class("View")
local _instance

---@param viewFunc fun():PureMVC.View
---@return PureMVC.View
function View.GetInstance(viewFunc)
    
    if not _instance and type(viewFunc) == "function" then
        _instance = viewFunc()
    end
    return _instance
end

function View.__create()
    
    ---@class PureMVC.View
    local Instance = {}
    ---@type table<string, PureMVC.Mediator>
    local _mediatorMap
    ---@type table<string, PureMVC.Observer[]>
    local _observerMap
    
    function Instance:ctor()
        
        assert(_instance == nil, "View Singleton already constructed!")
        _instance    = self
        _mediatorMap = {}
        _observerMap = {}
        self:InitializeView()
    end
    
    function Instance:InitializeView()
    
    end
    
    ---@param notificationName string
    ---@param observer PureMVC.Observer
    function Instance:RegisterObserver(notificationName, observer)
        
        local observers = _observerMap[notificationName]
        if not observers then
            observers                      = {}
            _observerMap[notificationName] = observers
        end
        table.insert(observers, observer)
    end
    
    ---@param notification PureMVC.Notification
    function Instance:NotifyObservers(notification)
        
        local notificationName = notification:GetName()
        local observers        = _observerMap[notificationName]
        if observers then
            for _, v in ipairs(observers) do
                v:NotifyObserver(notification)
            end
        end
    end
    
    ---@param notificationName string
    ---@param notifyContext any
    function Instance:RemoveObserver(notificationName, notifyContext)
        
        local observers = _observerMap[notificationName]
        if not observers then
            return
        end
        
        for k, v in ipairs(observers) do
            if v:CompareNotifyContext(notifyContext) then
                table.remove(observers, k)
                break
            end
        end
        
        if #observers == 0 then
            _observerMap[notificationName] = nil
        end
    end
    
    ---@param mediator PureMVC.Mediator
    function Instance:RegisterMediator(mediator)
        
        local mediatorName = mediator:GetMediatorName()
        if not self:HasMediator(mediatorName) then
            _mediatorMap[mediatorName] = mediator
            local interests            = mediator:ListNotificationInterests()
            if #interests > 0 then
                local observer = PureMVC.Observer.new(mediator.HandleNotification, mediator)
                for _, v in ipairs(interests) do
                    self:RegisterObserver(v, observer)
                end
            end
            mediator:OnRegister()
        end
    end
    
    ---@param mediatorName string
    function Instance:RetrieveMediator(mediatorName)
        
        return _mediatorMap[mediatorName]
    end
    
    ---@param mediatorName string
    ---@return PureMVC.Mediator
    function Instance:RemoveMediator(mediatorName)
        
        local mediator = self:RetrieveMediator(mediatorName)
        
        if mediator then
            local interests = mediator:ListNotificationInterests()
            if #interests > 0 then
                for _, v in ipairs(interests) do
                    self:RemoveObserver(v, mediator)
                end
            end
            _mediatorMap[mediatorName] = nil
            mediator:OnRemove()
        end
        
        return mediator
    end
    
    ---@param mediatorName string
    ---@return boolean
    function Instance:HasMediator(mediatorName)
        
        return self:RetrieveMediator(mediatorName) ~= nil
    end
    
    return Instance
end

return View