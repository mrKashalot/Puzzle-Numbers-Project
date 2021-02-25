//
//  ViewStyle.swift
//  Puzzle Numbers
//
//  Created by Владислав on 19.01.2021.
//

import UIKit

@IBDesignable
class ViewStyle: UIView {

    @IBInspectable var startColor: UIColor = .white {
        didSet {
            self.updateColors()
        }
    }
    @IBInspectable var endColor: UIColor = .black {
        didSet {
            self.updateColors()
        }
    }
    
    @IBInspectable var startLocation: CGFloat = 0 {
        didSet {
            self.updateLocations()
        }
    }
    @IBInspectable var endLocation: CGFloat = 1 {
        didSet {
            self.updateLocations()
        }
    }
    
    @IBInspectable var startPoint: CGPoint = .zero {
        didSet {
            self.updateStartPoint()
        }
    }
    @IBInspectable var endPoint: CGPoint = CGPoint(x: 0, y: 1) {
        didSet {
            self.updateEndPoint()
        }
    }
    
    override static var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    //создаем вычисляемую перменную для работы со слоем
    var gradientLayer: CAGradientLayer {
        return self.layer as! CAGradientLayer
    }
    
    //методы обновления параметров слоя с градиентом - каждый метод отвечает за начало и конец и точку градинета начало конец (описаны выше)
    func updateLocations() {
        self.gradientLayer.locations = [self.startLocation as NSNumber, self.endLocation as NSNumber]
    }
    
    func updateColors() {
        self.gradientLayer.colors = [self.startColor.cgColor, self.endColor.cgColor]
    }
    
    func updateStartPoint() {
        self.gradientLayer.startPoint = startPoint
    }
    
    func updateEndPoint() {
        self.gradientLayer.endPoint = endPoint
    }
}
