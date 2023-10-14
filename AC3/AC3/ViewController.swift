//
//  ViewController.swift
//  AC3
//
//  Created by Pol Valero on 6/10/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var resultValue: Float64 = 0
    var actualValue1: Float64 = 0
    var actualValue2: Float64 = 0
    var operation: Int = 0
    var hasOperation: Bool = false
    var hasComma: Bool = false
    var commaCounter: Int = 0


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func clearCalculation(_ sender: UIButton) {
        resultValue = 0
        actualValue1 = 0
        actualValue2 = 0
        operation = 0
        hasOperation = false
        hasComma = false
        commaCounter = 0
        resultLabel.text = "0"
    }
    
    
    @IBAction func numberClicked(_ sender: UIButton) {
        // TAG = Number value
        if hasOperation {
            if hasComma {
                commaCounter += 1
                actualValue2 = actualValue2 + Float64(sender.tag) / pow(10, Float64(commaCounter))
                resultLabel.text = String(actualValue2)
            } else {
                actualValue2 = actualValue2 * 10 + Float64(sender.tag)
                resultLabel.text = String(actualValue2.clean)
            }

        } else {
            if hasComma {
                commaCounter += 1
                actualValue1 = actualValue1 + Float64(sender.tag) / pow(10, Float64(commaCounter))
                resultLabel.text = String(actualValue1)
            } else {
                actualValue1 = actualValue1 * 10 + Float64(sender.tag)
                resultLabel.text = String(actualValue1.clean)
            }
        }
    }
    
    
    @IBAction func operatorClicked(_ sender: UIButton) {
        // TAG 1 = + ; 2 = - ; 3 = x ; 4 = /
        if hasOperation {
            performOperation()
            resultLabel.text = String(resultValue.clean)
        } else {
            operation = sender.tag
            hasOperation = true
        }
        hasComma = false
        commaCounter = 0
    }
    
    
    @IBAction func calculateResult(_ sender: UIButton) {
        if hasOperation {
            performOperation()
            resultLabel.text = String(resultValue.clean)
        } else {
            resultLabel.text = String(resultValue.clean)
        }
        hasComma = false
        commaCounter = 0
        hasOperation = false
    }
    
    
    
    @IBAction func percentatgeCalculation(_ sender: UIButton) {
        if hasOperation {
            actualValue2 = actualValue2 / 100
            resultLabel.text = String(actualValue2.clean)
        } else {
            actualValue1 = actualValue1 / 100
            resultLabel.text = String(actualValue1.clean)
        }
        hasComma = false
        commaCounter = 0
    }
    
    
    @IBAction func PlusMinusClicked(_ sender: UIButton) {
        if hasOperation {
            actualValue2 = actualValue2 * -1
            resultLabel.text = String(actualValue2.clean)
        } else {
            actualValue1 = actualValue1 * -1
            resultLabel.text = String(actualValue1.clean)
        }
        hasComma = false
        commaCounter = 0
    }
    
    
    @IBAction func flotantClicked(_ sender: UIButton) {
        hasComma = true
    }

    func performOperation() {
        switch operation {
        case 1:
            resultValue = actualValue1 + actualValue2
        case 2:
            resultValue = actualValue1 - actualValue2
        case 3:
            resultValue = actualValue1 * actualValue2
        case 4:
            resultValue = actualValue1 / actualValue2
        default:
            resultValue = 0
        }
        actualValue1 = resultValue
        actualValue2 = 0
    }
    
}

extension Float64 {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

