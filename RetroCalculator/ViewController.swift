//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Jaroslav Bažant on 16.08.17.
//  Copyright © 2017 DewDrops. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var outputLbl: UILabel!
    var buttonSound: AVAudioPlayer!
    
    var runningNumber = ""
    enum Operations: String {
        case Divide = "/"
        case Multiply = "*"
        case Substract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    var currentOperation = Operations.Empty
    var leftValString = ""
    var rightValString = ""
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let path  = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do{
            try buttonSound = AVAudioPlayer(contentsOf: soundURL)
            buttonSound.prepareToPlay()
        } catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    @IBAction func buttonPressed(sender: UIButton){
        playSound()
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: UIButton){
        processOperation(operation: .Divide)
    }
    @IBAction func onMultiplyPressed(sender: UIButton){
        processOperation(operation: .Multiply)
    }
    @IBAction func onSubtractPressed(sender: UIButton){
        processOperation(operation: .Substract)
    }
    @IBAction func onAddPressed(sender: UIButton){
        processOperation(operation: .Add)
    }
    @IBAction func onEqualPressed(sender: UIButton){
        processOperation(operation: currentOperation)
    }
    
    @IBAction func clearPressed(_ sender: UIButton) {
        clear()
    }
    
    func clear(){
        playSound()
        runningNumber = ""
        leftValString = ""
        rightValString = ""
        result = ""
        currentOperation = Operations.Empty
        outputLbl.text = "0"
    }
    
    func playSound() {
        if buttonSound.isPlaying {
            buttonSound.stop()
        }
        buttonSound.play()
    }
    
    func processOperation(operation: Operations){
        playSound()
        if currentOperation != Operations.Empty {
            if runningNumber != "" {
                rightValString = runningNumber
                runningNumber = ""
                if currentOperation == Operations.Multiply{
                    result = "\(Double(leftValString)! * Double(rightValString)!)"
                } else if currentOperation == Operations.Divide{
                    result = "\(Double(leftValString)! / Double(rightValString)!)"
                } else if currentOperation == Operations.Substract{
                    result = "\(Double(leftValString)! - Double(rightValString)!)"
                } else if currentOperation == Operations.Add{
                    result = "\(Double(leftValString)! + Double(rightValString)!)"
                }
                leftValString = result
                outputLbl.text = result
            }
            currentOperation = operation
        } else {
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
}

