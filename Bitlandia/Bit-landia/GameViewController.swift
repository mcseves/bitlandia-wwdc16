//
//  GameViewController.swift
//  Bit-landia
//
//  Created by Leonardo Brasil on 17/12/15.
//  Copyright (c) 2015 Tamyres Freitas. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation



class GameViewController: UIViewController {
    
    // Background sound
    
    var backgroundSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bitland", ofType: "wav")!)
    var audioPlayer = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            
            audioPlayer = try AVAudioPlayer(contentsOfURL: backgroundSound, fileTypeHint: nil) }
            
        catch {
            
            print("file not found")
            return
        }
        
        audioPlayer.numberOfLoops = -1
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        
        // First Scene
        
            let scene = InitialScene(size: view.bounds.size)
            let skView = self.view as! SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        
        
        }
    

    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
