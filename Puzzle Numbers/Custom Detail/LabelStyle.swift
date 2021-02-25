//
//  LabelStyle.swift
//  Puzzle Numbers
//
//  Created by Владислав on 19.01.2021.
//

import UIKit

@IBDesignable
class LabelStyle: UILabel {
    
    //метод начального прикосновения - анимация кнопки
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //АНИМАЦИЯ КНОПКИ ВХОДА!скейл размера чуть больше чем есть!
        self.transform = CGAffineTransform( scaleX: 1.1, y: 1.1)//стави 1 и 1 чуть больше
        
        //задаем параметры анимации! задержка скорость конечный результат
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {self.transform = CGAffineTransform.identity}, completion: nil)
        //возвращаем функционал!
        super.touchesBegan(touches, with: event)
        //возврат дефолтного начения - пишем его выше
        //self.transform = CGAffineTransform.identity
    }
    
    //ширина контура кнопки
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    //цвет конутра кнопки
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    //радиус кнопки  - для круга
    @IBInspectable var borderRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = borderRadius
        }
    }
    
    //позиция тени
    @IBInspectable var shadowOpacity: Float = 0.0 {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
        }
    }
    //размытие тени
    @IBInspectable var shadowRadius: CGFloat = 0.0 {
        didSet {
            self.layer.shadowRadius = shadowRadius
        }
    }
}
