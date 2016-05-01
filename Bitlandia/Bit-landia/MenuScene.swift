//
//  SecondScene.swift
//  Bit-landia
//
//  Created by Leonardo Brasil on 17/12/15.
//  Copyright © 2015 Tamyres Freitas. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation



class MenuScene: SKScene {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    var locked = SKSpriteNode(imageNamed: "lockerIcon")
    
    // para UIView
    let blurView = UIView()
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark))
    
    var score = 170
    var highscore = 0
    
    var actionLevel = LevelProperties.getLevels()
    
    var buttonSoundIda = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("botão(ida)", ofType: "wav")!)
    var audioPlayer = AVAudioPlayer()
    
    override func didMoveToView(view: SKView) {
        
        createBg()
        
        let highScoreDafault = NSUserDefaults.standardUserDefaults()
        
        if (highScoreDafault.valueForKey("highscore") != nil) {
            
            highscore = highScoreDafault.valueForKey("highscore") as! NSInteger!
        }
        
        countHighScore()

        
        self.backgroundColor = SKColor(red:0.43, green:0.76, blue:0.82, alpha:1)

        let playButton = SKSpriteNode(imageNamed:"startBtImage")
        playButton.name = "playButton"
        playButton.position = CGPoint(x: (self.view?.frame.width)!/10, y: (self.view?.frame.height)!/8)
        playButton.xScale = 0.2
        playButton.yScale = 0.2
//        self.addChild(playButton)
        
        let ticketImage = SKSpriteNode(imageNamed: "ticket")
        ticketImage.name = "ticket"
        ticketImage.xScale = 0.6
        ticketImage.yScale = 0.6
        ticketImage.position = CGPoint(x: (self.view?.frame.width)!/19, y: (self.view?.frame.height)!/1.055)
//        self.addChild(ticketImage)
        
        let highScoreLabel = SKLabelNode()
        highScoreLabel.fontName = "DIN Condensed"
        highScoreLabel.fontSize = 28
        highScoreLabel.fontColor = SKColor.blackColor()
        highScoreLabel.position = CGPoint(x: (self.view?.frame.width)!/8, y: (self.view?.frame.height)!/1.09)
        highScoreLabel.text = "\(highscore)"
//        self.addChild(highScoreLabel)
        
        createLevels()
    }
    
    func createBg(){
        let background = SKSpriteNode(imageNamed: "Map")
        background.position = CGPoint(x: (self.view?.frame.width)!/2, y: (self.view?.frame.height)!/2)
        background.zPosition = -5
        background.size = self.frame.size
        background.userInteractionEnabled = false
        background.name = "not movable"
        addChild(background)
    }
   
    func countHighScore(){
        
        //         score++
        
        if (score > highscore) {
            
            highscore = score
            let highScoreDefault = NSUserDefaults.standardUserDefaults()
            
            highScoreDefault.setValue(highscore, forKey: "highscore")
            highScoreDefault.synchronize()
            
        }
    }
    
    func createUIView () {
        
        blurView.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
        visualEffectView.frame = blurView.frame
        self.view!.addSubview(visualEffectView)
        self.view!.addSubview(blurView)
        
        
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        var pass: Int = Int()
        for touch in touches {
            
            let location = touch.locationInNode(self)
            let touchedNode = nodeAtPoint(location)
            
            // percorrendo todas as ações
            if touchedNode.name == "carrossel"{
                pass = 0
                print("eu")
            }
            else if touchedNode.name == "montanhaRussa" {
                pass = 1
                print("montanha")
            }
            else if touchedNode.name == actionLevel[2].name { pass = 2 }
            else if touchedNode.name == actionLevel[3].name { pass = 3 }
            else if touchedNode.name == actionLevel[4].name { pass = 4 }
            else if touchedNode.name == actionLevel[5].name { pass = 5 }
            else if touchedNode.name == actionLevel[6].name { pass = 6 }
            else if touchedNode.name == actionLevel[7].name { pass = 7 }
            
            if (pass == 0 && touchedNode.name == "carrossel") {
                
                createUIView()
                
                let bitorImage = "helloWorld.png"
                let image = UIImage(named: bitorImage)
                let olar = UIImageView(image: image)
                olar.frame = CGRect(x: frame.width/7.2, y: frame.height/6.2, width: (image?.size.width)!, height: (image?.size.height)!)
                blurView.addSubview(olar)
                
                let restart   = UIButton(type: UIButtonType.System) as UIButton
                let imageRestart = UIImage(named: "nextImage")
                restart.setBackgroundImage(imageRestart, forState: .Normal)
                restart.frame = CGRect(x: (self.view?.frame.width)!/1.4, y: (self.view?.frame.height)!/1.4, width: (imageRestart?.size.width)!/1.5, height: (imageRestart?.size.height)!/1.5)
                restart.addTarget(self, action: #selector(MenuScene.restartAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                blurView.addSubview(restart)
                
            }
            else if pass == 1 && defaults.boolForKey("haveRanOnce") {
                createUIView()
                createIntroView()
            }
            else {
                
                for i in 2 ... actionLevel.count{
                    if pass == i {
                        createUIView()
                        createComingSoonView()
                    }
                }
            }
        }

    }
    
    func createComingSoonView(){
        
        let imageName = "comingSoon.png"
        let image = UIImage(named: imageName)
        let comingsoon = UIImageView(image: image)
        comingsoon.frame = CGRect(x: CGRectGetMidX(self.frame)-200, y: CGRectGetMidY(self.frame)-150, width: 380, height: 280)
        
        blurView.addSubview(comingsoon)
        
        let menu  = UIButton(type: UIButtonType.System) as UIButton
        let imageMenu = UIImage(named: "backImage")
        menu.setBackgroundImage(imageMenu, forState: .Normal)
        menu.frame = CGRect(x:220, y: 250, width: (imageMenu?.size.width)!/1.5,height: (imageMenu?.size.height)!/1.5)
        menu.addTarget(self, action: #selector(LevelScene.menuAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        blurView.addSubview(menu)
    }
    
    func createIntroView (){
        print("nice")
        let rc = "helloRC"
        let rcImage = UIImage(named: rc)
        let RColar = UIImageView(image: rcImage)
        RColar.frame = CGRect(x: frame.width/7.2, y: frame.height/6.2, width: (rcImage?.size.width)!, height: (rcImage?.size.height)!)
        blurView.addSubview(RColar)
        
        let nextRC  = UIButton(type: UIButtonType.System) as UIButton
        let RCimageRestart = UIImage(named: "nextImage")
        nextRC.setBackgroundImage(RCimageRestart, forState: .Normal)
        nextRC.frame = CGRect(x: (self.view?.frame.width)!/1.4, y: (self.view?.frame.height)!/1.4, width: (RCimageRestart?.size.width)!/1.5, height: (RCimageRestart?.size.height)!/1.5)
        nextRC.addTarget(self, action: #selector(MenuScene.gotoRC(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        blurView.addSubview(nextRC)
        
    }
    
    
    
    func menuAction(sender:UIButton!)
    {
        visualEffectView.removeFromSuperview()
        blurView.removeFromSuperview()
        
    }
    
    func restartAction(sender:UIButton!) {
        
        visualEffectView.removeFromSuperview()
        blurView.removeFromSuperview()
        
        let firstScene = LevelScene(size: self.size)
        //                firstScene.passed = pass
        let transition = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 1)
        firstScene.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(firstScene, transition: transition)
        
    }
    
    func gotoRC(sender:UIButton!) {
        
        visualEffectView.removeFromSuperview()
        blurView.removeFromSuperview()
        
        let secondScene = SecondLevel(size: self.size)
        let transition = SKTransition.pushWithDirection(SKTransitionDirection.Left, duration: 1)
        secondScene.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(secondScene, transition: transition)
        
    }
    
    func playButtonSoundIda(){
        
        do {
            
            audioPlayer = try AVAudioPlayer(contentsOfURL: buttonSoundIda, fileTypeHint: nil)
        }
            
        catch {
            
            print("file not found")
            return
        }
        audioPlayer.prepareToPlay()
        audioPlayer.volume = 0.5
        audioPlayer.play()
        
    }
    
    func createLevels(){
        
        for index in 0..<actionLevel.count{
            
            let newLevel = SKSpriteNode(imageNamed: actionLevel[index].imageLevel)
            
            newLevel.name = actionLevel[index].name
            newLevel.xScale = 1
            newLevel.yScale = 1
            
            newLevel.position = CGPointMake((self.view?.frame.width)!/actionLevel[index].mapX, (self.view?.frame.height)!/actionLevel[index].mapY)
            
//            newLevel.userInteractionEnabled = false
            
            if(index > 2 && index < 3){
                newLevel.alpha = 0.3
            }
            
            if index == 1{
                locked.position = CGPointMake((self.view?.frame.width)!/actionLevel[index].mapX, (self.view?.frame.height)!/actionLevel[index].mapY)
                locked.zPosition = 20
                if !defaults.boolForKey("haveRanOnce"){
                    self.addChild(locked)
                    newLevel.alpha = 0.3
                }
            }
            
            let newNumber = SKSpriteNode(imageNamed: "n\(index+1)")
            newNumber.name = actionLevel[index].name
            newNumber.xScale = 1.1
            newNumber.yScale = 1.1
            newNumber.position = CGPointMake((self.view?.frame.width)!/actionLevel[index].numX, (self.view?.frame.height)!/actionLevel[index].numY)
            
            self.addChild(newLevel)
            self.addChild(newNumber)

        }
        
    }
    
}
