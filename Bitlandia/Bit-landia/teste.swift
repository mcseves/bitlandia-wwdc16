//
//  CodeScene.swift
//  Bit-landia
//
//  Created by Leonardo Brasil on 17/12/15.
//  Copyright © 2015 Tamyres Freitas. All rights reserved.
//

//import UIKit
//import SpriteKit
//
////class LevelScene: SKScene {
//    //
//    //    var tornado : SKSpriteNode!
//    //    var tornadoWalkingFrames : [SKTexture]!
//    
//    let rectNode = SKSpriteNode (imageNamed: "rectNode")
//    let andeNode = SKSpriteNode(imageNamed: "andeNode")
//    let copyNode = SKSpriteNode(imageNamed: "andeNode")
//    
//    var actionNode: SKSpriteNode = SKSpriteNode()
//    let list = ActionProperties.getActions()
//    
//    
//    override func didMoveToView(view: SKView) {
//        self.backgroundColor = SKColor.cyanColor()
//        
//        
//        andeNode.size = CGSize (width: 40, height: 40)
//        andeNode.position = CGPoint (x: 520 , y: 200)
//        andeNode.zPosition = 2
//        addChild(andeNode)
//        
//        rectNode.size = CGSize(width: 90, height: view.frame.size.height+120)
//        rectNode.position = CGPoint(x: 524, y: 100)
//        rectNode.zPosition = 0
//        addChild(rectNode)
//        
//        setActions()
//        //
//        //        let tornadoAnimatedAtlas = SKTextureAtlas(named: "tornado")
//        //        var tornadoFrames = [SKTexture]()
//        //
//        //        let numImages = tornadoAnimatedAtlas.textureNames.count
//        //        for var i=1; i<=numImages; i++ {
//        //            let tornadoTextureName = "\(i)"
//        //            tornadoFrames.append(tornadoAnimatedAtlas.textureNamed(tornadoTextureName))
//        //        }
//        //
//        //        tornadoWalkingFrames = tornadoFrames
//        //
//        //        let firstFrame = tornadoWalkingFrames[0]
//        //        tornado = SKSpriteNode(texture: firstFrame)
//        //        tornado.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
//        //        tornado.xScale = 0.2
//        //        tornado.yScale = 0.2
//        //        addChild(tornado)
//        
//        
//        //        movingTornado()
//    }
//    
//    //    func movingTornado() {
//    //        //This is our general runAction method to make our bear walk.
//    //        tornado.runAction(SKAction.repeatActionForever(
//    //            SKAction.animateWithTextures(tornadoWalkingFrames,
//    //                timePerFrame: 0.1,
//    //                resize: false,
//    //                restore: true)),
//    //            withKey:"movingTornado")
//    //    }
//    //
//    
//    func setActions (){
//        
//        let listImages = ["action", "play43", "ticket"]
//        
//        for i in 0..<listImages.count {
//            
//            let listOfImage = listImages[i]
//            
//            let sprite = SKSpriteNode(imageNamed: listOfImage)
//            sprite.xScale = 0.1
//            sprite.yScale = 0.1
//            
//            let offsetFraction = CGFloat(i)+1.0 / (CGFloat(listImages.count) + 1.0)
//            sprite.position = CGPoint(x: size.width * offsetFraction , y: size.height/2)
//            self.addChild(sprite)
//            
//            //            actionNode.name = list[index].name
//            //            actionNode = SKSpriteNode(imageNamed: list[index].image)
//            //            actionNode.size = CGSizeMake(100, 100)
//            //            addChild(actionNode)
//        }
//        
//    }
//    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        
//        //        var actionArray = [SKSpriteNode]()
//        
//        for touch in touches {
//            let location = touch.locationInNode(self)
//            print(location)
//            print(actionNode.name)
//            
//            if andeNode.containsPoint(location) {
//                
//                copyNode.position = CGPoint(x: 35, y: 35)
//                copyNode.size = CGSize(width: 40, height: 40)
//                copyNode.removeFromParent()
//                addChild(copyNode)
//                
//            }
//            
//            
//            
//            if copyNode.containsPoint(location) {
//                copyNode.removeFromParent()
//            }
//            
//        }
//        
//        
//        print("touched")
//        
//        //        tornado.removeActionForKey("movingTornado")
//        
//    }
//    
//    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        for touch in touches {
//            let location = touch.locationInNode(self)
//            
//            if andeNode.containsPoint(location) {
//                
//                andeNode.position = location
//                //                print(location)
//                
//            }
//        }
//    }
//    
//    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        andeNode.position = CGPoint (x: 520 , y: 200)
//        
//        
//    }
//    
//    
//}
//

