//
//  ActionProperties.swift
//  Bit-landia
//
//  Created by Maria Carolina Santos on 07/01/16.
//  Copyright © 2016 Tamyres Freitas. All rights reserved.
//

import Foundation

class ActionProperties {
    
    static var actionsList:[Action] = Array()

    class func getActions() -> [Action]{
        
        let walk = Action(actionType: .Walk)
        let fasten = Action(actionType: .Fasten)
        let sit = Action(actionType: .Sit)
        let pick = Action(actionType: .Pick)
        let plug = Action(actionType: .Plug)
        let onRollerCoaster = Action(actionType: .OnRollerCoaster)
        let upRollerCoaster = Action(actionType: .UpRollerCoaster)
        let sitCar = Action(actionType: .SitCar)
        let loopRollerCoaster = Action(actionType: .LoopRollerCoaster)
        let downRollerCoaster = Action(actionType: .DownRollerCoaster)
       
        
        
        actionsList = [walk, fasten, sit, pick, plug, onRollerCoaster, upRollerCoaster, sitCar, loopRollerCoaster, downRollerCoaster]
        
        return actionsList
        
        
    }
    
    
}
   