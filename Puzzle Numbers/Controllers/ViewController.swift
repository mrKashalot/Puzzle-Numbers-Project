//
//  ViewController.swift
//  Puzzle Numbers
//
//  Created by Владислав on 19.01.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var gameView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    
    var gameViewWidth: CGFloat! //задаем перменную шириниы нашего игрового поля!
    var blockWidth: CGFloat! //задаем перменную ширину нашего лейбл (квадрат)
    
    //перменные отвечающие за центрирование нашего лейбл!
    //пишеи вместо Int значение CGFloat чтобы не было отсупа последнего лейбл блока справа от границы игровойзоный! расчет будет точнее
    var xCen: CGFloat!
    var yCen: CGFloat!
    
    //задаем 2 пустых массива блоков и их центров!
    var blocksArray: NSMutableArray = []
    var centerArray: NSMutableArray = []
    
    //настройки счетчика времени- заводим перменные
    var timeCount: Int = 0
    var gameTimer: Timer = Timer()
    
    //пустое место нашего отсутствующего блока!
    var emptyBlock: CGPoint!
    
    let makeSoundButton = SimpleSound(named: "chik")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //вызов функции производящей блоки!
        makeBlocks()
        //вызов функции рандомайз
        //  randomizeAction()
        self.resetButtonPress(Any.self) // используем вместо рандомайзера что бы - запусился таймер и мы получили новую расстановку лейбл блоков
    }
    
    func makeBlocks() {
        
        //нажимая на кнопку - сбрасываем блоки лейбл и их центры очищаем массивы
        blocksArray = []
        centerArray = []
        
        gameViewWidth = gameView.frame.size.width //при загрузке нашего игрового поля - мы обозначаемпараметры
        blockWidth = gameViewWidth / 4 //делаем ширину блока лейб на ширину игрового поля чтоб ровно влезало
        
        xCen = blockWidth / 2
        yCen = blockWidth / 2
        
        var labelNumber: Int = 1 //значение которое должен показывать блок
        
        //данный цикл повторяет отрисовку цикла из 4 лейбл по вертикали для отрисовки по горизонтали
        for v in 0 ..< 4
        {
            //задаем цикл при котором горизонтально блок будет дублироваться вправо пока не дойдет до края или не получит значение в притык к 4
            for h in 0 ..< 4
            {
                //параметры рамки блока лейбл
                let blockFrame: CGRect = CGRect(x: 0, y: 0, width: blockWidth - 4, height: blockWidth - 4) //ставим минус 4 потому что хотим отступы и зазоры между блокам лейбл
                //добавляем лейбл кодом!
                let block: MyLabel = MyLabel(frame: blockFrame)
                
                block.isUserInteractionEnabled = true //для восприятия жестов
                
                let thisCen: CGPoint = CGPoint(x: xCen, y: yCen)
                
                block.center = thisCen
                //block.center = CGPoint(x: xCen, y: yCen) //задаем центр нашего блока лейбл
                block.OriginalCenter = thisCen
                
                centerArray.add(thisCen) //добавляем местоположение наших блоков их центра координаты см выше в массив центров
                block.text = String(labelNumber) //присваиваем значение тексту!
                
                labelNumber += 1 //добавляем значение + 1 к начальному что бы получился порядой! от 1 до 20
                
                block.textAlignment = NSTextAlignment.center //задаем положение текста!
                block.font = UIFont(name: "DIN Condensend Bold", size: 45) //задаем шрифт и размер цифр в лейбл блоках
                block.textColor = UIColor.white
                
                block.backgroundColor = UIColor.blue //задаем цвет нашего лейбл
                gameView.addSubview(block) //помещаем наше вью на игровое саб вью
                
                blocksArray.add(block) //добавляем блоки в массив!
                
                xCen = xCen + blockWidth //задаем центр для нашего х и говорим что хотим еще один такой жецентрироваться до края игровоой вью
            }
            xCen = blockWidth / 2
            yCen = yCen + blockWidth
        }
        //удаляем последний блок из массива - блоков всего хоти от 0 до 15 без 16
        let lastMoveBlock: MyLabel = blocksArray[15] as! MyLabel
        lastMoveBlock.removeFromSuperview() //удаляем блок с супервью
        blocksArray.removeObject(at: 15)
    }
    
    //делаем рандом положения лейбл блоков (берем значения центрирования лейблов и адаем рандом)
    func randomizeAction() {
        
        let tempCenterArray: NSMutableArray = centerArray.mutableCopy() as! NSMutableArray //добавляем чтобы обновить центры иначе будет краш!
        
        for anyBlockArray in blocksArray {
            
            let randomIndex: Int = Int(arc4random()) % tempCenterArray.count
            let randomCenter: CGPoint = tempCenterArray[randomIndex] as! CGPoint
            
            (anyBlockArray as! MyLabel).center = randomCenter
            tempCenterArray.removeObject(at: randomIndex) //задаем что бы не пропадали блоки!
        }
        
        emptyBlock = tempCenterArray[0] as! CGPoint //позволяе сохрнаять блок и не удалять его - присваиваем ему статус индекса 0 в массиве
    }
    
    @IBAction func resetButtonPress(_ sender: Any) {
        
        makeSoundButton.play()
        
        //запускаем рандомайзер еще раз рандомайзер!
        randomizeAction()
        
        //запуск таймера по нажатию на кнопку
        timeCount = 0
        gameTimer.invalidate()
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    //функция таймера прибавление значения!
    @objc func timerAction() {
        timeCount += 1
        timerLabel.text = String.init(format: "%02d\"", timeCount)
    }
    
    //логика жестов!
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let playerTouch: UITouch = touches.first!
        //условие - если пользователь жмет на блоки в котейнере нашего массива лейбл вью
        if (blocksArray.contains(playerTouch.view as Any)) {
            
            
            let touchView: MyLabel = (playerTouch.view) as! MyLabel
            //логика сдвига лейбл блока в пустой центр лейбл блока
            let xDiffrnt: CGFloat = touchView.center.x - emptyBlock.x
            let yDiffrent: CGFloat = touchView.center.y - emptyBlock.y
            //дистанция сдвига
            let distance: CGFloat = sqrt(pow(xDiffrnt, 2) + pow(yDiffrent, 2))
            
            if (distance == blockWidth) {
                let tempCenter: CGPoint = touchView.center
                
                UIView.beginAnimations(nil, context: nil)
                UIView.setAnimationDuration(0.2)
                touchView.center = emptyBlock
                UIView.commitAnimations()
                
                //условие сменыцвета при занимаемом положении и возвращает серый если не находится в своем положении
                if (touchView.OriginalCenter == emptyBlock) {
                    touchView.backgroundColor = UIColor.green
                } else {
                    touchView.backgroundColor = UIColor.blue
                }
                
                touchView.center = emptyBlock
                
                emptyBlock = tempCenter
            }
        }
    }
}
//отвечает за ориганильное местоположение лейбл блока! необходима для смены цвета в исходное положение
class MyLabel: UILabel {
    var OriginalCenter: CGPoint!
}

