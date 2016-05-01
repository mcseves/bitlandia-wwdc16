//
//  CodeScene.swift
//  Bit-landia
//
//  Created by Leonardo Brasil on 17/12/15.
//  Copyright © 2015 Tamyres Freitas. All rights reserved.
//


import UIKit
import SpriteKit
import AVFoundation


class LevelScene: SKScene, SKPhysicsContactDelegate {
    
    var passed: Int!
    let defaults = NSUserDefaults.standardUserDefaults()

    
    var primeiraRodada = 0
    var marcandoGambiarra = 0
    
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
    
    // respostas
    var boxAnswer = [Int]()
    var findAction = [Int]()
    
    // botões
    var checkButtonNode = SKSpriteNode(imageNamed:"startBtImage")
    let pauseButton = SKSpriteNode(imageNamed: "pauseBtimage")
    
    // tempo que diminui
    var time = NSTimer()
    var countDownText = SKLabelNode(text: "60")
    var countDown = 61
    
    // para UIView
    let blurView = UIView()
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark))
    
    var points = 0
    var totalTicket = 0
    let highScoreLabel = SKLabelNode()
    
    var caixasPreenchidas = 0
    
    
    // musica botoes 
    var buttonSoundIda = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("botão(ida)", ofType: "wav")!)
    var buttonSoundVolta = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("botão(volta)", ofType: "wav")!)
    var audioPlayer = AVAudioPlayer()
    
    var carousel : SKSpriteNode!
    var carouselWalkingFrames : [SKTexture]!
    
    var robot: SKSpriteNode!
    var robotWalkingFrames: [SKTexture]!
    
    var robot1 = SKSpriteNode(imageNamed: "robot1")
    let carousel1 = SKSpriteNode(imageNamed: "carrossel")
    
    //array de sequencia de acoes
    var seqActions: [SKAction]!
    
    //Tutorial
    var tutorialImages = SKSpriteNode(imageNamed: "tutorial1")
    var rightAnswer = SKSpriteNode(imageNamed: "tips")
    let pointingHand = SKSpriteNode(imageNamed: "handPointing")
    let movingHand = SKSpriteNode(imageNamed: "hand2Icon")
    
    private var selectedNode : SKNode!
    
    
    override func didMoveToView(view: SKView) {
        
        checkButtonNode.position = CGPoint(x: (self.view?.frame.width)!/1.25, y:(self.view?.frame.height)!/8)
        checkButtonNode.size = CGSize(width: checkButtonNode.size.width/2, height: checkButtonNode.size.height/2)
        checkButtonNode.name = "play"
        checkButtonNode.zPosition = 10
        addChild(checkButtonNode)
        
        countDownText.position = CGPointMake((self.view?.frame.width)!/15, (self.view?.frame.height)!/1.1)
        countDownText.fontSize = 30
        countDownText.name = "countDownText"
        countDownText.fontColor = UIColor.blackColor()
//        addChild(countDownText)
        
        highScoreLabel.fontName = "DIN Condensed"
        highScoreLabel.fontSize = 28
        highScoreLabel.fontColor = SKColor.blackColor()
        highScoreLabel.position = CGPointMake((self.view?.frame.width)!/1.3, (self.view?.frame.height)!/1.1)
//      highScoreLabel.text = "\(totalTicket)"
//        self.addChild(highScoreLabel)
        
        countTickets()
        createBackground()
        createActions()
        createBoxes()
        createArrows()
        createImages()
        carouselInitial()
        robotInitial()
    
        
        // tempo
        time = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(LevelScene.updateTimer), userInfo: nil, repeats: true)
        
        updateTimer()
            
            
        let totalTicketDefault = NSUserDefaults.standardUserDefaults()
            
        if (totalTicketDefault.valueForKey("totalTicket") != nil)  {
                
            totalTicket = totalTicketDefault.valueForKey("totalTicket") as! NSInteger!
        
        }
        
        SetTutorial()
    }
    
    
    
    // soma ponto de acordo com tempo
    func countTickets(){
        points += 1
        if (countDown >= 45) {
            self.updateTickets(3)
            
        }
        if (countDown > 15 && countDown <= 30) {
            self.updateTickets(2)
            
        }
            
        else {
           self.updateTickets(1)
        }
    }
    
    
    
    // Dá update nos pontos e na label
    func updateTickets(points: Int) {
        
        totalTicket += points
        highScoreLabel.text = "\(totalTicket)"

        let totalTicketDefault = NSUserDefaults.standardUserDefaults()
        totalTicketDefault.setValue(totalTicket, forKey: "totalTicket")
        totalTicketDefault.synchronize()
    
    }

    
    
    // Faz countdown de 60' e depois pause o timer e esconde ele
    func updateTimer() {
        
        if countDown > 0 {
            countDown -= 1
            countDownText.text = String(countDown)
            countDownText.hidden = false
        }
        else {
            countDownText.text = String(countDown)
            countDownText.hidden = true
            time.invalidate()
        }
    }
    
    
    
    func createBackground() {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPointMake(frame.size.width/2, frame.size.height/2)
        background.zPosition = -10
        background.size = self.frame.size
        background.userInteractionEnabled = false
        background.name = "not movable"
        addChild(background)
    }
//    
//    
//    
//    func createButton (){
//        pauseButton.position = CGPoint(x: 200, y: 300)
//        pauseButton.size = CGSizeMake(30, 30)
//        pauseButton.name = "teste"
//        pauseButton.zPosition = 3
//        addChild(pauseButton)
//    
//    }
    
    func carouselInitial(){
        carousel1.position = CGPoint(x: 380, y: 250)
        carousel1.size = CGSizeMake(carousel1.size.width/3.3, carousel1.size.height/3.3)
        carousel1.name = "carousel"
        carousel1.zPosition = 3
        addChild(carousel1)
        
    }
    
    
    
    func robotInitial(){
        robot1.position = CGPoint(x: 150, y: 150)
        robot1.zPosition = 50
        robot1.size = CGSizeMake(robot1.size.width/4, robot1.size.height/4)
        addChild(robot1)
        
    }
    
    func createWinSituation(){
        
        let one = SKAction.setTexture(SKTexture(imageNamed: "carrossel1"))
        let two = SKAction.setTexture(SKTexture(imageNamed: "carrossel2"))
        let three = SKAction.setTexture(SKTexture(imageNamed: "carrossel3"))
        let four = SKAction.setTexture(SKTexture(imageNamed: "carrossel4"))
        let wait = SKAction.waitForDuration(0.27)

        let sequence = SKAction.sequence([one, wait, two, wait, three, wait, four, wait])
        
        robot1.removeFromParent()
        carousel1.runAction(SKAction.repeatActionForever(sequence))
        
    }
    
    
    func createActions() {
        
        for index in 0..<5{
            
            let newAc = list[index]
            
            newAc.name = "movable"
//            newAc.xScale = 0.8
//            newAc.yScale = 0.8
            
            let offsetFraction = (CGFloat(index)+1.0) / (CGFloat(5) + 0.8)
            newAc.position = CGPoint(x: size.width/1.08, y: size.height * offsetFraction)
            newAc.zPosition = 0
            
            newAc.userInteractionEnabled = false
            
            actionArray.append(newAc)
            actionIdArray.append(newAc.actionId)
            
            print("action id \(actionIdArray[index])")
            
            actionsPositionX.append(newAc.position.x)
            actionsPositionY.append(newAc.position.y)
            
            findAction.append(-1)
            
            self.addChild(newAc)
                    
        }
        
        print("result \(actionIdArray.count)")
        
    }
    
    
    
    func createImages(){
        
        for index in 0..<5{
            
            let newImage = SKSpriteNode(texture: SKTexture(imageNamed: list[index].pictureName))
            
//            newImage.xScale = 0.8
//            newImage.yScale = 0.8
            newImage.position = CGPointMake(actionsPositionX[index], actionsPositionY[index])
            newImage.zPosition = -3
            
            newImage.userInteractionEnabled = true
            
            newImage.name = "not movable"
            newImage.alpha = 0.4
            
            self.addChild(newImage)
        }
        
    }
    
    func createBoxes() {
        for index in 0..<actionLevel[0].solve.count {
            let box = SKSpriteNode(imageNamed: "emptyBoxIcon")
            box.name = "\(actionLevel[0].solve[index])"
//            box.xScale = 0.8
//            box.yScale = 0.8
            print("box \(box.name)")
            
            // aumentar espaco = aumentar denominador
            let offsetFraction = (CGFloat(index)+1.0) / (CGFloat(actionLevel[0].solve.count) + 2)
            
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
        for index in 0..<(actionLevel[0].solve.count-1){
            let next = SKSpriteNode(imageNamed: "noNext")
            next.xScale = 0.9
            next.yScale = 0.9
            next.position.x = CGFloat(boxPositionX[index])+50
            next.position.y = CGFloat(boxPositionY[index])
//            next.color = UIColor(red:0.22, green:0.31, blue:0.51, alpha:1.00)
            self.addChild(next)
            
            nextArrow.append(next)
        }
        
    }

    func SetTutorial(){
        
        tutorialImages.position = CGPointMake(size.width/2.6, size.height/1.15)
        tutorialImages.userInteractionEnabled = false
        tutorialImages.name = "NOT TOUCJ"
        tutorialImages.zPosition = 20
        
        let liftUp = SKAction.scaleTo(1.1, duration: 0.4)
        let liftDown = SKAction.scaleTo(0.9, duration: 0.4)
        let sequence = SKAction.sequence([liftUp, liftDown])
        
        pointingHand.position = CGPointMake(actionsPositionX[0]-110, actionsPositionY[0]+60)
        pointingHand.zPosition = 12
        pointingHand.size = CGSize(width: pointingHand.size.width*2.7, height: pointingHand.size.height*2.7)
        pointingHand.name = "moving hand"
        pointingHand.userInteractionEnabled = false
        
        pointingHand.runAction(SKAction.repeatActionForever(sequence))
        
        self.addChild(tutorialImages)
        self.addChild(pointingHand)
    }
    
    func createMovementHand(){
        
        pointingHand.removeFromParent()

        movingHand.position = CGPointMake(actionsPositionX[0], actionsPositionY[0]-50)
        movingHand.xScale = 1.3
        movingHand.yScale = 1.3
        movingHand.zPosition = 20
        
        let waiting = SKAction.waitForDuration(2)
        
        let moveHand = SKAction.moveTo(CGPoint(x: boxPositionX[0]+5, y: boxPositionY[0]-50), duration: 2.5)
        let originalPos = SKAction.moveTo(CGPointMake(actionsPositionX[0], actionsPositionY[0]-50), duration: 0.0001)
        let newSeq = SKAction.sequence([moveHand, waiting, originalPos])
        
        movingHand.runAction(SKAction.repeatActionForever(newSeq))
        self.addChild(movingHand)
        
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
                    
                    for j in 0..<actionLevel[0].solve.count{
                        
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
                    
                    if (boxAnswer[0] == actionLevel[0].solve[0] && marcandoGambiarra == 0){
                        tutorialImages.texture = SKTexture(imageNamed: "tutorial2")
                        movingHand.removeFromParent()
                        marcandoGambiarra = 1
                    }
                    if (boxAnswer[1] == actionLevel[0].solve[1] && marcandoGambiarra == 1){
                        tutorialImages.texture = SKTexture(imageNamed: "tutorial3")
                        marcandoGambiarra = 2
                    }
                    if (boxAnswer[2] != -1 && marcandoGambiarra == 2){
                        tutorialImages.removeFromParent()
                        
                    }

                }
            }
        }
        selectedNode = nil
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        var sitOK = 0
        var beltOK = 0

        seqActions = [SKAction]()
        
        let wait = SKAction.waitForDuration(0.7)
        let moveUp = SKAction.moveToY(240, duration: 0.4)
        let shrink = SKAction.scaleTo(0.6, duration: 0.3)
        let moveDown = SKAction.moveToY(190, duration: 0.2)
        let moveSit = SKAction.moveToY(230, duration: 0.2)
        let moveLeft = SKAction.moveToX(380, duration: 0.01)
        let moveRight = SKAction.moveToX(390, duration: 0.01)
        let resize = SKAction.resizeToWidth(robot1.size.width*1.6, duration: 0.01)
        let normal = SKAction.resizeToWidth(robot1.size.width, duration: 0.01)
        let wrong = SKAction.scaleTo(1.2, duration: 0.1)
        let newWidth = SKAction.resizeToWidth(robot1.size.width*0.9, duration: 0.00001)
        
        if primeiraRodada == 0 {
                createMovementHand()
                primeiraRodada += 1
        }

        
        for touch in touches {
            
            let location = touch.locationInNode(self)
            let touchedNode = nodeAtPoint(location)
            var resultado = 0
                
            playButtonSoundIda()
            
            //botão de play
            if (touchedNode.name == "play") {
               
                for i in 0..<boxAnswer.count {
                    
                    if (boxAnswer[i] < 0){
                        print("nao preenchi")
                        
                    }
                    
                    if (boxAnswer[i] != actionLevel[0].solve[i]) {
                        resultado += 1
                        print("resultado: \(resultado)")
                    }
                    
                    
                    if resultado == 0 {
                        
                        if boxAnswer[i] == 0 {
                            print("andar")
                            let walkAnimation = SKAction.moveTo(CGPoint(x: 390, y: 170), duration: 3.0)
                            seqActions.append(walkAnimation)
                            seqActions.append(wait)
                            
                        }
                        else if boxAnswer[i] == 1{
                            print("coloquei o cinto")
                            beltOK = 1
                            if sitOK == 1{
                                let openBeltAnimation = SKAction.setTexture(SKTexture(imageNamed: "beltOpen"))
                                let closeBeltAnimation = SKAction.setTexture(SKTexture(imageNamed: "beltClose"))
                                seqActions.append(openBeltAnimation)
                                seqActions.append(wait)
                                seqActions.append(closeBeltAnimation)
                                seqActions.append(wait)
                                
                            }
                            else{
                                let openBeltAnimation = SKAction.setTexture(SKTexture(imageNamed: "beltUpOpen"))
                                let closeBeltAnimation = SKAction.setTexture(SKTexture(imageNamed: "beltUpClose"))
                                seqActions.append(openBeltAnimation)
                                seqActions.append(wait)
                                seqActions.append(closeBeltAnimation)
                                seqActions.append(wait)
                                
                            }
                        }
                        else if boxAnswer[i] == 2{
                            print("sentar")
                            let sitAnimation = SKAction.setTexture(SKTexture(imageNamed: "bitorSit"))
                            seqActions.append(moveSit)
                            seqActions.append(sitAnimation)
                            seqActions.append(wait)
                            
                            sitOK = 1;
                        }
                        else if boxAnswer[i] == 3{
                            print("entrar")
                            seqActions.append(moveUp)
                            seqActions.append(shrink)
                            seqActions.append(moveDown)
                            seqActions.append(wait)
                            
                        }
                        else if boxAnswer[i] == 4{
                            print("ligar")
                            if sitOK == 1 {
                                var turnOnAnimation = SKAction.setTexture(SKTexture(imageNamed: "bitorPressSit1"))
                                var turnOffAnimation = SKAction.setTexture(SKTexture(imageNamed: "bitorPressSit2"))
                                
                                if beltOK == 1 {
                                    turnOnAnimation = SKAction.setTexture(SKTexture(imageNamed: "onBelt"))
                                    turnOffAnimation = SKAction.setTexture(SKTexture(imageNamed: "offBelt"))
                                    
                                }
                                seqActions.append(moveLeft)
                                seqActions.append(resize)
                                seqActions.append(turnOnAnimation)
                                seqActions.append(wait)
                                seqActions.append(turnOffAnimation)
                                seqActions.append(wait)
                                seqActions.append(moveRight)
                                seqActions.append(normal)
                                seqActions.append(SKAction.setTexture(SKTexture(imageNamed: "beltClose")))
                            }
                            else{
                                let turnOnAnimation = SKAction.setTexture(SKTexture(imageNamed: "bitorPress1"))
                                let turnOffAnimation = SKAction.setTexture(SKTexture(imageNamed: "bitorPress2"))
                                seqActions.append(resize)
                                seqActions.append(turnOnAnimation)
                                seqActions.append(wait)
                                seqActions.append(turnOffAnimation)
                                seqActions.append(wait)
                                seqActions.append(normal)
                                seqActions.append(SKAction.setTexture(SKTexture(imageNamed: "robot1")))
                            }
                        }
                    }
                    if resultado == 1{
                        print("resultado 1")
                        let confused = SKAction.setTexture(SKTexture(imageNamed: "notRight"))
                        let jump = SKAction.moveToY(220, duration: 0.5)
                        let fall = SKAction.moveToY(190, duration: 0.5)
                        seqActions.append(confused)
                        seqActions.append(newWidth)
                        seqActions.append(wrong)
                        seqActions.append(jump)
                        seqActions.append(fall)
                        seqActions.append(jump)
                        seqActions.append(fall)
                        seqActions.append(jump)
                        seqActions.append(fall)
                        seqActions.append(jump)
                        seqActions.append(fall)
                        seqActions.append(jump)
                        seqActions.append(fall)
                        seqActions.append(jump)
                        seqActions.append(fall)
                        
                    }
                }
                
                if (resultado == 0) {
                    
                    print("acertou tudo!!!")
                    
                    checkButtonNode.name = "acertou"

                    let sequence = SKAction.sequence(seqActions)
                    robot1.runAction(sequence)
                    
                    let nodeWin = SKNode()
                    scene?.addChild(nodeWin)
                    let waitingAction = SKAction.waitForDuration(10);
                    let actions = SKAction.runBlock({ () -> Void in
                        self.createWinSituation()
                        nodeWin.removeFromParent()
                    })
                    nodeWin.runAction(SKAction.sequence([waitingAction,actions]));
          
                    let node = SKNode()
                    scene?.addChild(node)
                    let waitAction = SKAction.waitForDuration(15);
                    let action = SKAction.runBlock({ () -> Void in
                        self.createUIView()
                        self.nextScreen()
                        node.removeFromParent()
                    })
                    
                    defaults.setBool(true, forKey: "haveRanOnce")
                    NSUserDefaults.standardUserDefaults().synchronize()

                    node.runAction(SKAction.sequence([waitAction,action]));
                 }
                    
                else {
                    print("errou")
                    
                    let sequence = SKAction.sequence(seqActions)
                    robot1.runAction(sequence)
                    
                    let node = SKNode()
                    scene?.addChild(node)
                    let waitAction = SKAction.waitForDuration(8);
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
                selectedNode.zPosition = 100
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
        time.invalidate()
    
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
        text.text = ("Great job! You got Bitor to the Carousel, using a sequence of actions.\n Instructions are really important for computers and algorithms!")
    
        text.textAlignment = .Center
        text.font = UIFont(name: "SF Atarian System", size: 19)
        text.textColor = UIColor.whiteColor()
        blurView.addSubview(text)
        
        let restart   = UIButton(type: UIButtonType.System) as UIButton
        let imageRestart = UIImage(named: "retryImage")
        restart.setBackgroundImage(imageRestart, forState: .Normal)
        restart.frame = CGRect(x: 340, y: 260, width: (imageRestart?.size.width)!/1.5, height: (imageRestart?.size.height)!/1.5)
        restart.addTarget(self, action: #selector(LevelScene.restartAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        blurView.addSubview(restart)
        
        let menu  = UIButton(type: UIButtonType.System) as UIButton
        let imageMenu = UIImage(named: "backImage")
        menu.setBackgroundImage(imageMenu, forState: .Normal)
        menu.frame = CGRect(x:200, y: 260, width: (imageMenu?.size.width)!/1.5,height: (imageMenu?.size.height)!/1.5)
        menu.addTarget(self, action: #selector(LevelScene.menuAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        blurView.addSubview(menu)
        
        let next  = UIButton(type: UIButtonType.System) as UIButton
        let nextImage = UIImage(named: "nextImage")
        next.setBackgroundImage(nextImage, forState: .Normal)
        next.frame = CGRect(x:480, y: 260, width: (imageMenu?.size.width)!/1.5,height: (imageMenu?.size.height)!/1.5)
        next.addTarget(self, action: #selector(LevelScene.goToNextLevel(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        blurView.addSubview(next)
        
        let close   = UIButton(type: UIButtonType.System) as UIButton
        let imageClose = UIImage(named: "close")
        close.setBackgroundImage(imageClose, forState: .Normal)
        close.frame = CGRect(x:100, y: 60, width: 25,height: 25)
        close.addTarget(self, action: #selector(LevelScene.closeAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
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
        restartLose.addTarget(self, action: #selector(LevelScene.restartAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        blurView.addSubview(restartLose)
        
        
        let menuLose   = UIButton(type: UIButtonType.System) as UIButton
        let imageMenu = UIImage(named: "backImage")
        menuLose.setBackgroundImage(imageMenu, forState: .Normal)
        menuLose.frame = CGRect(x:240, y: 260, width: (imageMenu?.size.width)!/1.5,height: (imageMenu?.size.height)!/1.5)
        menuLose.addTarget(self, action: #selector(LevelScene.menuAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        blurView.addSubview(menuLose)
    
    }
    
    // Funcao que reseta a LevelScene quando o botao "restart" é presionado
    func restartAction(sender:UIButton!)
    {
        
        self.scene?.view?.paused = false

        visualEffectView.removeFromSuperview()
        blurView.removeFromSuperview()
        
        self.removeAllChildren()
        self.removeAllActions()
        self.scene?.removeFromParent()
//        actionArray.removeAll()
//        actionIdArray.removeAll()
//        boxPositionX.removeAll()
//        boxPositionY.removeAll()
        self.scene?.removeChildrenInArray(actionArray)
        
        let restartScene = LevelScene(size: self.size)
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
        time = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(LevelScene.updateTimer), userInfo: nil, repeats: true)
        updateTimer()
        self.scene?.view?.paused = false

        
    }
    
    func goToNextLevel(sender:UIButton!){
        
        visualEffectView.removeFromSuperview()
        blurView.removeFromSuperview()
        
        self.removeAllChildren()
        self.removeAllActions()
        self.scene?.removeFromParent()
        self.removeFromParent()
        
        let secondScene = SecondLevel(size: self.size)
        let transition = SKTransition.fadeWithDuration(1)
        secondScene.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(secondScene, transition: transition)

        
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

