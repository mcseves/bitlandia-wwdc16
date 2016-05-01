//
//  Action.swift
//  Bit-landia
//
//  Created by Maria Carolina Santos on 07/01/16.
//  Copyright © 2016 Tamyres Freitas. All rights reserved.
//

import Foundation
import SpriteKit

class Action: SKSpriteNode {
    
    enum ActionType: Int {
        case Walk = 0,
        Fasten,
        Sit,
        Pick,
        Plug,
        OnRollerCoaster,
        UpRollerCoaster,
        SitCar,
        LoopRollerCoaster,
        DownRollerCoaster
        
        static let allActions = [Walk, Fasten, Sit, Pick, Plug, OnRollerCoaster, UpRollerCoaster, SitCar, LoopRollerCoaster, DownRollerCoaster]
        
    }
    
    let actionPicture: SKTexture
    let actionName: String
    let pictureName: String
    let actionId: Int
    
    init(actionType: ActionType) {

        switch actionType {
        case .Walk:
            actionPicture = SKTexture(imageNamed:"walkIcon")
            actionName = "0"
            pictureName = "walkIcon"
            actionId = 0
           
        case .Fasten:
            actionPicture = SKTexture(imageNamed: "fastenIcon")
            actionName = "1"
            pictureName = "fastenIcon"
            actionId = 1
            
        case .Sit:
            actionPicture = SKTexture(imageNamed: "sitIcon")
            actionName = "2"
            pictureName = "sitIcon"
            actionId = 2
            
        case .Pick:
            actionPicture = SKTexture(imageNamed: "pickIcon")
            actionName = "3"
            pictureName = "pickIcon"
            actionId = 3
            
        case .Plug:
            actionPicture = SKTexture(imageNamed: "plugIcon")
            actionName = "4"
            pictureName = "plugIcon"
            actionId = 4
            
        case .OnRollerCoaster:
            actionPicture = SKTexture(imageNamed: "onRollerCoasterIcon")
            actionName = "5"
            pictureName = "onRollerCoasterIcon"
            actionId = 5
            
        case .UpRollerCoaster:
            actionPicture = SKTexture(imageNamed: "upRollerCoasterIcon")
            actionName = "6"
            pictureName = "upRollerCoasterIcon"
            actionId = 6
            
        case .SitCar:
            actionPicture = SKTexture(imageNamed: "sitCarIcon")
            actionName = "7"
            pictureName = "sitCarIcon"
            actionId = 7
            
        case .LoopRollerCoaster:
            actionPicture = SKTexture(imageNamed: "loopRollerCoasterIcon")
            actionName = "8"
            pictureName = "loopRollerCoasterIcon"
            actionId = 8
            
        case .DownRollerCoaster:
            actionPicture = SKTexture(imageNamed: "downRollerCoasterIcon")
            actionName = "9"
            pictureName = "downRollerCoasterIcon"
            actionId = 9
            
//        default:
//            actionPicture = SKTexture(imageNamed: "")
//            actionName = "nopic"
//            actionId = -1
            
        }
        
        super.init(texture: actionPicture, color: UIColor.clearColor(), size: actionPicture.size())
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//
//    var idAction: Int
//    var name: String
//    var image: String
//    var x: Float
//    var y: Float
//
//    init(pIDAction:Int, pName:String, pImage:String, pX:Float, pY:Float){
//        self.idAction = pIDAction
//        self.name = pName
//        self.image = pImage
//        self.x = pX
//        self.y = pY
//    }


//}