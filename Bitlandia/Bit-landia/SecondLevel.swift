//
//  SecondLevel.swift
//  Bit-landia
//
//  Created by Maria Carolina Santos on 29/04/16.
//  Copyright © 2016 Tamyres Freitas. All rights reserved.
//


import UIKit
import SpriteKit
import AVFoundation


class SecondLevel: SKScene, SKPhysicsContactDelegate {
    
    var passed: Int!
    
    // recuperando lista de ações existentes e levels existentes
    var list = ActionProperties.getActions()
    var actionLevel = LevelProperties.getLevels()
    
    // criando array com infos das ações
    var actionArray = [SKNode]()
    var actionIdArray = [Int]()
    
    // arrays de posicoes dos espaçoes e ações
    var boxPositionX = [CGFloat]()
    var boxPositionY = [CGFloat]()
    var actionsPositionX = [CGFloat]()
    var actionsPositionY = [CGFloat]()
    var nextArrow = [SKSpriteNode]()
    let changeArrow = SKAction.setTexture(SKTexture(imageNamed: "yesNext"))
    let changeBackArrow = SKAction.setTexture(SKTexture(imageNamed: "noNext"))
    
    //personagem e brinquedo
    
    var bitor = SKSpriteNode(imageNamed: "robot1")
    var rollerCoaster = SKSpriteNode(imageNamed: "rollerCoaster")
    var carRC = SKSpriteNode(imageNamed: "carRC")
    var bitorSequence: [SKAction]!
    var carSequence: [SKAction]!
    
    let instructions = SKSpriteNode(imageNamed: "instr")
    
    // respostas
    var boxAnswer = [Int]()
    var findAction = [Int]()
    
    // botões
    var checkButtonNode = SKSpriteNode(imageNamed:"startBtImage")
   
    // para UIView
    let blurView = UIView()
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark))
    
    // musica botoes
    var buttonSoundIda = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("botão(ida)", ofType: "wav")!)
    var buttonSoundVolta = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("botão(volta)", ofType: "wav")!)
    var audioPlayer = AVAudioPlayer()
    
    private var selectedNode : SKNode!
    
    
    override func didMoveToView(view: SKView) {
        
        checkButtonNode.position = CGPoint(x: (self.view?.frame.width)!/1.25, y:(self.view?.frame.height)!/8)
        checkButtonNode.size = CGSize(width: checkButtonNode.size.width/2, height: checkButtonNode.size.height/2)
        checkButtonNode.name = "play"
        checkButtonNode.zPosition = 10
        addChild(checkButtonNode)
        
        createBackground()
        createActions()
        createBoxes()
        createArrows()
        createImages()
    }
    
    
    func createBackground() {
        let background = SKSpriteNode(imageNamed: "rcScene")
        background.position = CGPointMake(frame.size.width/2, frame.size.height/2)
        background.zPosition = -10
        background.size = self.frame.size
        background.userInteractionEnabled = false
        background.name = "not movable"
        addChild(background)
        
        bitor.position = CGPoint(x: 20, y: 185)
        bitor.zPosition = 50
        bitor.size = CGSizeMake(bitor.size.width/8, bitor.size.height/8)
        bitor.userInteractionEnabled = false
        addChild(bitor)
        
        carRC.position = CGPointMake(80, 175)
        carRC.zPosition = 51
        carRC.userInteractionEnabled = false
        addChild(carRC)
        
        rollerCoaster.position = CGPointMake(CGRectGetMidX(self.frame)-52,CGRectGetMidY(self.frame)+40)
        rollerCoaster.userInteractionEnabled = false
        addChild(rollerCoaster)
        
        instructions.position = CGPointMake(size.width/2.6, size.height/1.15)
        instructions.userInteractionEnabled = false
        instructions.name = "NOT TOUCJ"
        instructions.zPosition = 20
        addChild(instructions)
    }
    
    
    func createActions() {
        
        var count = 0
        
        for index in 5..<list.count{
            
            let newAc = list[index]
            
            newAc.name = "movable"
            
            let offsetFraction = (CGFloat(count)+1.0) / (CGFloat(5) + 0.8)
            newAc.position = CGPoint(x: size.width/1.08, y: size.height * offsetFraction)
            newAc.zPosition = 0
            
            newAc.userInteractionEnabled = false
            
            actionArray.append(newAc)
            actionIdArray.append(newAc.actionId)
            
            actionsPositionX.append(newAc.position.x)
            actionsPositionY.append(newAc.position.y)
            
            findAction.append(-1)
            
            self.addChild(newAc)
            count += 1
            
        }
        
        print("result \(actionIdArray.count)")
        
    }
    
    
    func createImages(){
        var count = 0
        for index in 5..<list.count{
            
            let newImage = SKSpriteNode(texture: SKTexture(imageNamed: list[index].pictureName))
            
            newImage.position = CGPointMake(actionsPositionX[count], actionsPositionY[count])
            newImage.zPosition = -3
            
            newImage.userInteractionEnabled = true
            
            newImage.name = "not movable"
            newImage.alpha = 0.4
            
            self.addChild(newImage)
            count += 1
        }
        
    }
    
    func createBoxes() {
        for index in 0..<actionLevel[1].solve.count {
            let box = SKSpriteNode(imageNamed: "emptyBoxIcon")
            box.name = "\(actionLevel[1].solve[index])"
            print("box \(box.name)")
            
            // aumentar espaco = aumentar denominador
            let offsetFraction = (CGFloat(index)+1.0) / (CGFloat(actionLevel[1].solve.count) + 2)
            
            box.position = CGPoint(x: size.width * offsetFraction - (self.view?.frame.width)!/20, y: size.height/8)
            box.zPosition = -4
            
            boxPositionX.append(box.position.x)
            boxPositionY.append(box.position.y)
            boxAnswer.append(-1)
            
            box.userInteractionEnabled = true
            self.addChild(box)
            
        }
    }
    
    func createArrows() {
        for index in 0..<(actionLevel[1].solve.count-1){
            let next = SKSpriteNode(imageNamed: "noNext")
            next.xScale = 0.9
            next.yScale = 0.9
            next.position.x = CGFloat(boxPositionX[index])+50
            next.position.y = CGFloat(boxPositionY[index])
            self.addChild(next)
            
            nextArrow.append(next)
        }
        
    }
    
    
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            let location = touch.locationInNode(self)
            //            let touchedNode = nodeAtPoint(location)
            if selectedNode != nil{
                selectedNode.position = location
                
            }
        }
    }
    
    
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        var gambi = 0
        
        for touch in touches {
            
            let location = touch.locationInNode(self)
            let touchedNode = nodeAtPoint(location)
            
            // percorrendo todas as ações
            for index in 0..<actionArray.count{
                
                if (actionArray[index].containsPoint(location)){
                    
                    for j in 0..<actionLevel[1].solve.count{
                        
                        let pos = CGPointMake(boxPositionX[j], boxPositionY[j])
                        
                        //ação está na caixa?
                        if (actionArray[index].containsPoint(pos)) {
                            touchedNode.position = pos
                            gambi += 1
                            boxAnswer[j] = actionIdArray[index]
                            
                            if(j < nextArrow.count){
                                nextArrow[j].runAction(changeArrow)
                            }
                            
                            //estamos mudando a ação de caixa?
                            if (findAction[index] >= 0) {
                                boxAnswer[findAction[index]] = -1
                                print("retirei!!!")
                                print("box: \(boxAnswer[findAction[index]])")
                                if(j < nextArrow.count){
                                    nextArrow[j].runAction(changeBackArrow)
                                }
                                
                            }
                            
                            //salvando local da ação!
                            findAction[index] = j
                            print("local da acao: \(findAction[index]) com array \(actionArray[index])")
                            
                        }
                        
                    }
                    
                    // n acertou caixa, volta pro lugar original
                    if (gambi == 0){
                        touchedNode.position  = CGPointMake(actionsPositionX[index], actionsPositionY[index])
                        playButtonSoundVolta()
                        //ação está saindo de uma caixa?
                        if(findAction[index] >= 0){
                            boxAnswer[findAction[index]] = -1
                            print("retirei!!!")
                            print("box: \(boxAnswer[findAction[index]])")
                            if(findAction[index] < nextArrow.count){
                                nextArrow[findAction[index]].runAction(changeBackArrow)
                            }
                            findAction[index] = -1
                        }
                        
                    }
                    
                    //animação de diminuir ação selecionada
                    let dropDown = SKAction.scaleTo(1, duration: 0.2)
                    touchedNode.runAction(dropDown, withKey: "drop")
                    print("parou")
                    
                }
            }
        }
        selectedNode = nil
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        bitorSequence = [SKAction]()
        carSequence = [SKAction]()
        
        let normalAngleCar = SKAction.rotateToAngle(0, duration: 0.1)
        let disappearBitor = SKAction.fadeAlphaTo(0, duration: 0.00001)
        
        for touch in touches {
            
            let location = touch.locationInNode(self)
            print("local \(location)")
            let touchedNode = nodeAtPoint(location)
            var resultado = 0
            
            playButtonSoundIda()
            
            //botão de play
            if (touchedNode.name == "play") {
                
                instructions.removeFromParent()
                
                for i in 0..<boxAnswer.count {
                    
                    print("resposta \(i) = \(boxAnswer[i])")
                    
                    if (boxAnswer[i] < 0){
                        print("nao preenchi")
                        
                    }
                    
                    if (boxAnswer[i] != actionLevel[1].solve[i]) {
                        resultado += 1
                        print("resultado: \(resultado)")
                    }
                    
                    
                    if resultado == 0 {
                        if boxAnswer[i] == 7 {
                            let walk = SKAction.moveTo(CGPoint(x: 40, y: 185), duration: 0.5)
                            let moveSit = SKAction.moveTo(CGPoint(x: 60, y: 230), duration: 0.3)
                            let moveDown = SKAction.moveTo(CGPoint(x: 72, y: 190), duration: 0.3)
                            let shrink = SKAction.scaleTo(0.8, duration: 0.001)
                            let sit = SKAction.setTexture(SKTexture(imageNamed: "sitLeft"))
                            bitorSequence.append(walk)
                            bitorSequence.append(moveSit)
                            bitorSequence.append(moveDown)
                            bitorSequence.append(shrink)
                            bitorSequence.append(sit)
                        }
                        else if boxAnswer[i] == 5 {
                            
                            let newCar = SKAction.setTexture(SKTexture(imageNamed: "goCar"))
                            let scale = SKAction.scaleTo(1.2, duration: 0.00001)
                            let positionCar = SKAction.moveToY(182, duration: 0.00001)
                            let resize = SKAction.resizeToHeight(carRC.size.height*1.6, duration: 0.001)
                            let forward = SKAction.moveToX(150, duration: 1)
                            carSequence.append(newCar)
                            carSequence.append(scale)
                            carSequence.append(resize)
                            carSequence.append(positionCar)
                            carSequence.append(forward)

                            
                        }
                        else if boxAnswer[i] == 6 {
                            let upCar = SKAction.rotateToAngle(1.3, duration: 0.1)
                            let move1 = SKAction.moveTo(CGPointMake(180, 260), duration: 0.5)
                            let upcar2 = SKAction.rotateToAngle(1.29, duration: 0.001)
                            let upMov = SKAction.moveTo(CGPointMake(250, 360), duration: 0.5)
                            carSequence.append(upCar)
                            carSequence.append(move1)
                            carSequence.append(upcar2)
                            carSequence.append(upMov)
                            carSequence.append(normalAngleCar)
                            
                        }
                        else if boxAnswer[i] == 9 {
                            let downcar = SKAction.rotateToAngle(-1.3, duration: 0.001)
                            let movedown = SKAction.moveTo(CGPointMake(330, 240), duration: 0.3)
                            let downcar2 = SKAction.rotateToAngle(0, duration: 0.001)
                            let moveright = SKAction.moveTo(CGPointMake(373, 255), duration: 0.2)
                            let downcar3 = SKAction.rotateToAngle(-1.2, duration: 0.001)
                            let movedown2 = SKAction.moveTo(CGPointMake(432, 203), duration: 0.2)
                            let upagain = SKAction.rotateToAngle(0.3, duration: 0.001)
                            let moveloop = SKAction.moveTo(CGPointMake(530, 250), duration: 0.2)
                            let upagain2 = SKAction.rotateToAngle(0.6, duration: 0.001)
                            
                            carSequence.append(downcar)
                            carSequence.append(movedown)
                            carSequence.append(downcar2)
                            carSequence.append(moveright)
                            carSequence.append(downcar3)
                            carSequence.append(movedown2)
                            carSequence.append(upagain)
                            carSequence.append(moveloop)
                            carSequence.append(upagain2)
                            
                        }
                        else if boxAnswer[i] == 8 {
                            let little = SKAction.moveTo(CGPointMake(560, 290), duration: 0.2)
                            let right = SKAction.rotateToAngle(1.57, duration: 0.001)
                            let little1 = SKAction.moveTo(CGPointMake(550, 330), duration: 0.1)
                            let left = SKAction.rotateByAngle(0.789, duration: 0.001)
                            let little2 = SKAction.moveTo(CGPointMake(526, 339), duration: 0.1)
                            //roda mais
                            let little3 = SKAction.moveTo(CGPointMake(433, 323), duration: 0.1)
                            //roda mais
                            let little4 = SKAction.moveTo(CGPointMake(470, 228), duration: 0.1)
                            //saiu do loop uhul
                            let little5 = SKAction.moveTo(CGPointMake(520, 182), duration: 0.1)
                            let rotateNormal = SKAction.rotateToAngle(0.26, duration: 0.001)
                            let out = SKAction.moveTo(CGPointMake(800, 188), duration: 0.2)
                            
                            carSequence.append(little)
                            carSequence.append(right)
                            carSequence.append(little1)
                            carSequence.append(left)
                            carSequence.append(little2)
                            carSequence.append(left)
                            carSequence.append(little3)
                            carSequence.append(left)
                            carSequence.append(little4)
                            carSequence.append(left)
                            carSequence.append(left)
                            carSequence.append(little5)
                            carSequence.append(rotateNormal)
                            carSequence.append(out)

                        }
                     
                    }
                    if resultado == 1{
                        let lostRC = SKAction.setTexture(SKTexture(imageNamed: "wrongRC"))
                        let moveUpwrong = SKAction.moveToY(380, duration: 0.2)
                        let scaleup = SKAction.scaleTo(1.5, duration: 0.001)
                        let resizeAgain = SKAction.resizeToHeight(carRC.size.height*2.5, duration: 0.001)
                        let movedownwrong = SKAction.moveToY(350, duration: 0.3)
                        let rotate1 = SKAction.rotateByAngle(0.4, duration: 0.001)
                        let rotate2 = SKAction.rotateByAngle(-0.4, duration: 0.001)
                        let movedown2 = SKAction.moveToY(300, duration: 0.3)
                        let movedown3 = SKAction.moveToY(250, duration: 0.3)
                        let movedown4 = SKAction.moveToY(200, duration: 0.3)
                        let movedown5 = SKAction.moveToY(150, duration: 0.3)
                        let movedown6 = SKAction.moveToY(100, duration: 0.3)
                        let movedown7 = SKAction.moveToY(50, duration: 0.3)
                        let movedown8 = SKAction.moveToY(0, duration: 0.3)
                        let movedown9 = SKAction.moveToY(-100, duration: 0.3)

                        carSequence.append(lostRC)
                        carSequence.append(resizeAgain)
                        carSequence.append(moveUpwrong)
                        carSequence.append(scaleup)
                        carSequence.append(normalAngleCar)
                        carSequence.append(movedownwrong)
                        carSequence.append(rotate1)
                        carSequence.append(movedown2)
                        carSequence.append(normalAngleCar)
                        carSequence.append(rotate2)
                        carSequence.append(movedown3)
                        carSequence.append(normalAngleCar)
                        carSequence.append(rotate1)
                        carSequence.append(movedown4)
                        carSequence.append(normalAngleCar)
                        carSequence.append(rotate2)
                        carSequence.append(movedown5)
                        carSequence.append(normalAngleCar)
                        carSequence.append(rotate1)
                        carSequence.append(movedown6)
                        carSequence.append(normalAngleCar)
                        carSequence.append(rotate2)
                        carSequence.append(movedown7)
                        carSequence.append(normalAngleCar)
                        carSequence.append(rotate1)
                        carSequence.append(movedown8)
                        carSequence.append(normalAngleCar)
                        carSequence.append(rotate2)
                        carSequence.append(movedown9)
                        carSequence.append(normalAngleCar)
                        
                    }
                }
                
                if (resultado == 0) {
                    
                    self.bitor.runAction(SKAction.sequence(self.bitorSequence))
                    
                    let animationWin = SKNode()
                    let waiting = SKAction.waitForDuration(1.1)
                    scene?.addChild(animationWin)
                    let actionWin = SKAction.runBlock({ () -> Void in
                        self.bitor.runAction(disappearBitor)
                        self.carRC.runAction(SKAction.sequence(self.carSequence))
                    })
                    animationWin.runAction(SKAction.sequence([waiting,actionWin]))

                    
                    let node = SKNode()
                    scene?.addChild(node)
                    let waitAction = SKAction.waitForDuration(7.5);
                    let action = SKAction.runBlock({ () -> Void in
                        self.createUIView()
                        self.nextScreen()
                        node.removeFromParent()
                    })
                    node.runAction(SKAction.sequence([waitAction,action]));
                }
                    
                else {
                    print("errou")
                    
                    self.bitor.runAction(SKAction.sequence(self.bitorSequence))
                    
                    let animationWin = SKNode()
                    let waiting = SKAction.waitForDuration(1.1)
                    scene?.addChild(animationWin)
                    let actionWin = SKAction.runBlock({ () -> Void in
                        self.bitor.runAction(disappearBitor)
                        self.carRC.runAction(SKAction.sequence(self.carSequence))
                    })
                    animationWin.runAction(SKAction.sequence([waiting,actionWin]))

                    
                    let node = SKNode()
                    scene?.addChild(node)
                    let waitAction = SKAction.waitForDuration(20);
                    let action = SKAction.runBlock({ () -> Void in
                        self.createUIView()
                        self.loseScreen()
                        node.removeFromParent()
                    })
                    node.runAction(SKAction.sequence([waitAction,action]));
                    
                }
            }
            else if (touchedNode.name == "movable") {
                selectedNode = touchedNode
                selectedNode.zPosition = 200
                let liftUp = SKAction.scaleTo(1.4, duration: 0.001)
                touchedNode.runAction(liftUp, withKey: "pickup")
                
            }
        }
    }
    
    
    
    // Cria a uiview transparente, só chamar a funçao no lugar que desejar que ela funcione
    
    func createUIView () {
        
        blurView.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
        visualEffectView.frame = blurView.frame
        self.view!.addSubview(visualEffectView)
        self.view!.addSubview(blurView)
        
    }
    
    // Funcao que cria uiview do botao "pause" na tela, chamo a funcao quando o node é tocado
    func nextScreen () {
        
        let imageName = "winView.png"
        let image = UIImage(named: imageName)
        let parabens = UIImageView(image: image)
        parabens.frame = CGRect(x: CGRectGetMidX(self.frame)-200, y: CGRectGetMidY(self.frame)-150, width: 380, height: 280)
        
        blurView.addSubview(parabens)
        
        let text = UILabel()
        text.frame = CGRect(x: 200, y: 40, width:280, height: 300)
        text.numberOfLines = 0
        text.text = ("Great job! The instructions you gave helped Bitor ride the roller coaster. \n")
        
        text.textAlignment = .Center
        text.font = UIFont(name: "SF Atarian System", size: 19)
        text.textColor = UIColor.whiteColor()
        blurView.addSubview(text)
        
        let restart   = UIButton(type: UIButtonType.System) as UIButton
        let imageRestart = UIImage(named: "retryImage")
        restart.setBackgroundImage(imageRestart, forState: .Normal)
        restart.frame = CGRect(x: 380, y: 260, width: (imageRestart?.size.width)!/1.5, height: (imageRestart?.size.height)!/1.5)
        restart.addTarget(self, action: #selector(SecondLevel.restartAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        blurView.addSubview(restart)
        
        let menu  = UIButton(type: UIButtonType.System) as UIButton
        let imageMenu = UIImage(named: "backImage")
        menu.setBackgroundImage(imageMenu, forState: .Normal)
        menu.frame = CGRect(x:240, y: 260, width: (imageMenu?.size.width)!/1.5,height: (imageMenu?.size.height)!/1.5)
        menu.addTarget(self, action: #selector(SecondLevel.menuAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        blurView.addSubview(menu)
        
        let close   = UIButton(type: UIButtonType.System) as UIButton
        let imageClose = UIImage(named: "close")
        close.setBackgroundImage(imageClose, forState: .Normal)
        close.frame = CGRect(x:100, y: 60, width: 25,height: 25)
        close.addTarget(self, action: #selector(SecondLevel.closeAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        //        blurView.addSubview(close)
        
    }
    
    func loseScreen(){
        
        let imageName = "loseView.png"
        let image = UIImage(named: imageName)
        let opa = UIImageView(image: image)
        opa.frame = CGRect(x: CGRectGetMidX(self.frame)-200, y: CGRectGetMidY(self.frame)-150, width: 380, height: 280)
        
        blurView.addSubview(opa)
        
        
        let text = UILabel()
        text.frame = CGRect(x: 200, y: 30, width:300, height: 300)
        text.numberOfLines = 0
        text.text = ("Oh, it seems like Bitor got lost in action!\nLet's try again?")
        text.textAlignment = .Center
        text.font = UIFont(name: "SF Atarian System", size: 20)
        blurView.addSubview(text)
        
        
        let restartLose   = UIButton(type: UIButtonType.System) as UIButton
        let imageRestart = UIImage(named: "retryImage")
        restartLose.setBackgroundImage(imageRestart, forState: .Normal)
        restartLose.frame = CGRect(x: 380, y: 260, width: (imageRestart?.size.width)!/1.5, height: (imageRestart?.size.height)!/1.5)
        restartLose.addTarget(self, action: #selector(SecondLevel.restartAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        blurView.addSubview(restartLose)
        
        
        let menuLose   = UIButton(type: UIButtonType.System) as UIButton
        let imageMenu = UIImage(named: "backImage")
        menuLose.setBackgroundImage(imageMenu, forState: .Normal)
        menuLose.frame = CGRect(x:240, y: 260, width: (imageMenu?.size.width)!/1.5,height: (imageMenu?.size.height)!/1.5)
        menuLose.addTarget(self, action: #selector(SecondLevel.menuAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        blurView.addSubview(menuLose)
        
    }
    
    // Funcao que reseta a Second Level quando o botao "restart" é presionado
    func restartAction(sender:UIButton!)
    {
        
        self.scene?.view?.paused = false
        
        visualEffectView.removeFromSuperview()
        blurView.removeFromSuperview()
        
        self.removeAllChildren()
        self.removeAllActions()
        self.scene?.removeFromParent()
        self.scene?.removeChildrenInArray(actionArray)
        
        let restartScene = SecondLevel(size: self.size)
        let transition = SKTransition.crossFadeWithDuration(0.3)
        restartScene.scaleMode = SKSceneScaleMode.AspectFill
        self.view?.presentScene(restartScene, transition: transition)
        
        
    }
    
    // Funcao que reseta e leva para o MenuScene quando o botao "menu" é presionado
    
    func menuAction(sender:UIButton!)
    {
        
        self.scene?.view?.paused = false
        
        visualEffectView.removeFromSuperview()
        blurView.removeFromSuperview()
        
        self.removeAllChildren()
        self.removeAllActions()
        self.scene?.removeFromParent()
        self.removeFromParent()
        
        let secondScene = MenuScene(size: self.size)
        let transition = SKTransition.fadeWithDuration(0.3)
        secondScene.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(secondScene, transition: transition)
        
    }
    
    func closeAction(sender:UIButton!)
    {
        playButtonSoundVolta()
        visualEffectView.removeFromSuperview()
        blurView.removeFromSuperview()
        self.scene?.view?.paused = false
        
        
    }
    
    func playButtonSoundIda(){
        
        do {
            
            audioPlayer = try AVAudioPlayer(contentsOfURL: buttonSoundIda, fileTypeHint: nil) }
            
        catch {
            
            print("file not found")
            return
        }
        audioPlayer.prepareToPlay()
        audioPlayer.volume = 0.5
        audioPlayer.play()
        
    }
    
    func playButtonSoundVolta(){
        
        do {
            
            audioPlayer = try AVAudioPlayer(contentsOfURL: buttonSoundVolta, fileTypeHint: nil) }
            
        catch {
            
            print("file not found")
            return
        }
        audioPlayer.prepareToPlay()
        audioPlayer.play()
        
    }
    
    
}

