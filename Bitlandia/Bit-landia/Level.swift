//
//  Fase.swift
//  Bit-landia
//
//  Created by Maria Carolina Santos on 07/01/16.
//  Copyright © 2016 Tamyres Freitas. All rights reserved.
//

import Foundation
import UIKit
//import Action

class Level: NSObject{
    
    var name:String
    var id:Int
    var solve:[Int]
    var levelBg:String
    var time:Int                // esqueci ):
    var amount:Int
    var imageLevel:String       // imagem da atração no mapa
    var attraction:String       // imagem da atração no level
    var mapX:CGFloat
    var mapY:CGFloat
    var numX:CGFloat
    var numY:CGFloat
    
    init(pName:String, pId:Int, pSolve:[Int], pLevelBg:String, pTime:Int, pAmount:Int, pImageLevel:String, pAttraction:String, pMapX: CGFloat, pMapY:CGFloat, pNumX: CGFloat, pNumY: CGFloat) {
        self.name = pName
        self.id = pId
        self.solve = pSolve
        self.levelBg = pLevelBg
        self.time = pTime
        self.amount = pAmount
        self.imageLevel = pImageLevel
        self.attraction = pAttraction
        self.mapX = pMapX
        self.mapY = pMapY
        self.numX = pNumX
        self.numY = pNumY
    }
}