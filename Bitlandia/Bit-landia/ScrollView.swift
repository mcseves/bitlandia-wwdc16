//
//  ScrollView.swift
//  Bit-landia
//
//  Created by Maria Carolina on 08/01/16.
//  Copyright © 2016 Tamyres Freitas. All rights reserved.
//

import Foundation
import SpriteKit

class ScrollView: SKScene {
    
    var startY: CGFloat = 0.0
    var lastY: CGFloat = 0.0
    var moveableArea = SKNode()
    
    override func didMoveToView(view: SKView) {
        // set position & add scrolling/moveable node to screen
        moveableArea.position = CGPointMake(0, 0)
        self.addChild(moveableArea)
        
        // Create Label node and add it to the scrolling node to see it
        let top = SKLabelNode(fontNamed: "Avenir-Black")
        top.text = "Top"
        top.fontSize = CGRectGetMaxY(self.frame)/15
        top.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMaxY(self.frame)*0.9)
        moveableArea.addChild(top)
        
        let bottom = SKLabelNode(fontNamed: "Avenir-Black")
        bottom.text = "Bottom"
        bottom.fontSize = CGRectGetMaxY(self.frame)/20
        bottom.position = CGPoint(x:CGRectGetMidX(self.frame), y:0-CGRectGetMaxY(self.frame)*0.5)
        moveableArea.addChild(bottom)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)  {
        // store the starting position of the touch
        for touch in touches {
        let location = touch.locationInNode(self)
        startY = location.y
        lastY = location.y
        }
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
        let location = touch.locationInNode(self)
        // set the new location of touch
        let currentY = location.y
        
        // Set Top and Bottom scroll distances, measured in screenlengths
        let topLimit:CGFloat = 0.0
        let bottomLimit:CGFloat = 0.6
        
        // Set scrolling speed - Higher number is faster speed
        let scrollSpeed:CGFloat = 1.0
        
        // calculate distance moved since last touch registered and add it to current position
        let newY = moveableArea.position.y + ((currentY - lastY)*scrollSpeed)
        
        // perform checks to see if new position will be over the limits, otherwise set as new position
        if newY < self.size.height*(-topLimit) {
            moveableArea.position = CGPointMake(moveableArea.position.x, self.size.height*(-topLimit))
        }
        else if newY > self.size.height*bottomLimit {
            moveableArea.position = CGPointMake(moveableArea.position.x, self.size.height*bottomLimit)
        }
        else {
            moveableArea.position = CGPointMake(moveableArea.position.x, newY)
        }
        
        // Set new last location for next time
        lastY = currentY
     }
    }

}
