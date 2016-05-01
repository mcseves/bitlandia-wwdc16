//
//  ScoreVC.swift
//  Bit-landia
//
//  Created by Tamyres Freitas on 12/20/15.
//  Copyright © 2015 Tamyres Freitas. All rights reserved.
//

import UIKit
import SpriteKit


class ScoreVC: UIViewController {
    
    var ticket = 0
    var totalTicket = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       let totalTicketDefault = NSUserDefaults.standardUserDefaults()
        
        if (totalTicketDefault.valueForKey("totalTicket") != nil) {
            
           totalTicket = totalTicketDefault.valueForKey("totalTicket") as! NSInteger!
        }
       
    }
    
    func countTickets(){
        
        ticket += 1
        
        let timer : LevelScene = LevelScene()
        
        if (timer.countDown <= 15) {
            totalTicket = ticket + 1
            let totalTicketDefault = NSUserDefaults.standardUserDefaults()
            
            totalTicketDefault.setValue(totalTicket, forKey: "totalTicket")
            totalTicketDefault.synchronize()
        
        }
        
            if (timer.countDown <= 30) {
            

            totalTicket = ticket + 2
            let totalTicketDefault = NSUserDefaults.standardUserDefaults()
            
            totalTicketDefault.setValue(totalTicket, forKey: "totalTicket")
            totalTicketDefault.synchronize()

        
        }
        
        else {
            
         
            totalTicket = ticket + 3 
            let totalTicketDefault = NSUserDefaults.standardUserDefaults()
            
            totalTicketDefault.setValue(totalTicket, forKey: "totalTicket")
            totalTicketDefault.synchronize()
        

         }
    }
}
