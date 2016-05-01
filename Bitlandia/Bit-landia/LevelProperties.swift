//
//  LevelProperties.swift
//  Bit-landia
//
//  Created by Maria Carolina Santos on 07/01/16.
//  Copyright © 2016 Tamyres Freitas. All rights reserved.
//

import Foundation

class LevelProperties {

    static var levelList:[Level] = Array()
    class func getLevels() -> [Level] {
    
        let carrossel = Level(pName: "carrossel", pId: 1, pSolve: [0,3,2,1,4], pLevelBg: "", pTime: 10, pAmount: 5, pImageLevel:"carrosselIcon", pAttraction:"carrossel1", pMapX: 6, pMapY:3.5, pNumX: 4.9, pNumY: 9.3)
        
        let montanhaRussa = Level(pName: "montanhaRussa", pId: 2, pSolve: [7,5,6,9,8], pLevelBg: "", pTime: 10, pAmount: 5, pImageLevel:"montanha", pAttraction:"montanha", pMapX: 1.94, pMapY: 2, pNumX: 1.6, pNumY: 3.2)
        
        let rodaGigante = Level(pName: "rodaGigante", pId: 6, pSolve: [], pLevelBg: "", pTime: 10, pAmount: 5, pImageLevel:"rodagigante",pAttraction:"rodagigante", pMapX: 6, pMapY: 1.3, pNumX: 6.5, pNumY: 1.8)
        
        let crazyMug = Level(pName: "crazyMug", pId: 7, pSolve: [], pLevelBg: "", pTime: 10, pAmount: 5, pImageLevel:"lockerIcon",pAttraction:"", pMapX: 2.5, pMapY: 1.17, pNumX: 2.75, pNumY: 1.36)
        
        let kabum = Level(pName: "kabum", pId: 3, pSolve: [], pLevelBg: "", pTime: 10, pAmount: 5, pImageLevel:"lockerIcon",pAttraction:"", pMapX: 1.8, pMapY: 1.1, pNumX: 1.6, pNumY: 1.1)
        
        let carrinhoBate = Level(pName: "carrinhoBate", pId: 4, pSolve: [], pLevelBg: "", pTime: 10, pAmount: 5, pImageLevel:"lockerIcon",pAttraction:"", pMapX: 1.15, pMapY: 1.2, pNumX: 1.07, pNumY: 1.15)
        
        let comida = Level(pName: "comida", pId: 5, pSolve: [], pLevelBg: "", pTime: 10, pAmount: 5, pImageLevel:"lockerIcon",pAttraction:"", pMapX: 1.12, pMapY: 3, pNumX: 1.04, pNumY: 3.3)
        
        let horrorHouse = Level(pName: "horrorHouse", pId: 8, pSolve: [], pLevelBg: "", pTime: 10, pAmount: 5, pImageLevel:"lockerIcon",pAttraction:"", pMapX: 1.3, pMapY: 4.8, pNumX: 1.36, pNumY: 12)
        
        
        levelList = [carrossel, montanhaRussa, rodaGigante, crazyMug, kabum, carrinhoBate, comida, horrorHouse]
        
        return levelList
    
    }


}
