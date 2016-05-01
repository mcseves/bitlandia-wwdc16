//
//  GameScene.swift
//  Bit-landia
//
//  Created by Leonardo Brasil on 17/12/15.
//  Copyright (c) 2015 Tamyres Freitas. All rights reserved.
//

import SpriteKit
import AVFoundation


class InitialScene: SKScene {
    
    
    var buttonSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("botão(ida)", ofType: "wav")!)
    var audioPlayer = AVAudioPlayer()
   
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        
        let back = SKSpriteNode(imageNamed: "bitstartImage")
        
        back.position = CGPointMake(frame.size.width / 2, frame.size.height / 2)
        back.zPosition = -1
        back.size = self.frame.size
        

        self.addChild(back)
        
        
        let playButton = SKSpriteNode (imageNamed: "startnew")
        playButton.name = "playButton"
        playButton.position = CGPoint(x: CGRectGetMidX(self.frame)-3.5, y: CGRectGetMidY(self.frame) - 150)
        
        let liftUp = SKAction.scaleTo(1.2, duration: 1)
        let liftDown = SKAction.scaleTo(0.9, duration: 1)
        let sequence = SKAction.sequence([liftUp, liftDown])
        let repeating = SKAction.repeatActionForever(sequence)
        playButton.runAction(repeating)


        
        self.addChild(playButton)
        
        do {
            
            audioPlayer = try AVAudioPlayer(contentsOfURL: buttonSound, fileTypeHint: nil) }
            
        catch {
            
            print("file not found")
            return
        }
        audioPlayer.prepareToPlay()
        
       
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       
        
        if let startButton = childNodeWithName("playButton") {
            
            /* Called when a touch begins */
            for touch in touches {
                let location = touch.locationInNode(self)
                
                if startButton.containsPoint(location) {
                    print("Ir para outra cena")
                    audioPlayer.play()
                    
                    let secondScene = MenuScene(size: self.size)
                    let transition = SKTransition.fadeWithDuration(0.8)
                    secondScene.scaleMode = SKSceneScaleMode.AspectFill
                    self.scene!.view?.presentScene(secondScene, transition: transition)
                }
            }
        }
    }
    
    func playButtonSound(){
        
        do {
            
            audioPlayer = try AVAudioPlayer(contentsOfURL: buttonSound, fileTypeHint: nil) }
            
        catch {
            
            print("file not found")
            return
        }
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        audioPlayer.volume = 0.5

    
    }
    
    

   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
