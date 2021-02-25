//
//  MenuViewController.swift
//  Puzzle Numbers
//
//  Created by Владислав on 20.01.2021.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var esasyButton: ButtonStyle!
    @IBOutlet weak var mediumButton: ButtonStyle!
    @IBOutlet weak var hardButton: ButtonStyle!
    @IBOutlet weak var infoButton: ButtonStyle!
    
    let makeSoundButton = SimpleSound(named: "chik")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animateMenuButtons()
    }
    
    func animateMenuButtons() {
        //анимация проявления из белого
        let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
        fadeInAnimation.fromValue = 0
        fadeInAnimation.toValue = 1
        fadeInAnimation.duration = 3
        self.esasyButton.layer.add(fadeInAnimation, forKey: nil)
        self.mediumButton.layer.add(fadeInAnimation, forKey: nil)
        self.hardButton.layer.add(fadeInAnimation, forKey: nil)
        self.infoButton.layer.add(fadeInAnimation, forKey: nil)
    }
    
    @IBAction func esyPress(_ sender: Any) {
        makeSoundButton.play()
    }
    @IBAction func mediumPress(_ sender: Any) {
        makeSoundButton.play()
    }
    @IBAction func hardPress(_ sender: Any) {
        makeSoundButton.play()
    }
    @IBAction func infoPress(_ sender: Any) {
        makeSoundButton.play()
    }
}
