---@class PureMVC
---@field PACKAGE_NAME string
---@field Observer PureMVC.Observer
---@field View PureMVC.View
---@field Model PureMVC.Model
---@field Controller PureMVC.Controller
---@field Facade PureMVC.Facade
---@field Notifier PureMVC.Notifier
---@field Proxy PureMVC.Proxy
---@field Mediator PureMVC.Mediator
---@field BaseCommand PureMVC.BaseCommand
---@field MacroCommand PureMVC.MacroCommand
---@field SimpleCommand PureMVC.SimpleCommand
---@field Notification PureMVC.Notification
PureMVC              = PureMVC or {}
PureMVC.PACKAGE_NAME = PureMVC.PACKAGE_NAME or "PureMVC"

require(PureMVC.PACKAGE_NAME .. ".Class")

PureMVC.Observer      = require(PureMVC.PACKAGE_NAME .. ".Patterns.Observer.Observer")
PureMVC.View          = require(PureMVC.PACKAGE_NAME .. ".Core.View")
PureMVC.Model         = require(PureMVC.PACKAGE_NAME .. ".Core.Model")
PureMVC.Controller    = require(PureMVC.PACKAGE_NAME .. ".Core.Controller")
PureMVC.Facade        = require(PureMVC.PACKAGE_NAME .. ".Patterns.Facade.Facade")
PureMVC.Notifier      = require(PureMVC.PACKAGE_NAME .. ".Patterns.Observer.Notifier")

PureMVC.Proxy         = require(PureMVC.PACKAGE_NAME .. ".Patterns.Proxy.Proxy")
PureMVC.Mediator      = require(PureMVC.PACKAGE_NAME .. ".Patterns.Mediator.Mediator")
PureMVC.BaseCommand   = require(PureMVC.PACKAGE_NAME .. '.Patterns.Command.BaseCommand')
PureMVC.MacroCommand  = require(PureMVC.PACKAGE_NAME .. '.Patterns.Command.MacroCommand')
PureMVC.SimpleCommand = require(PureMVC.PACKAGE_NAME .. '.Patterns.Command.SimpleCommand')
PureMVC.Notification  = require(PureMVC.PACKAGE_NAME .. ".Patterns.Observer.Notification")
