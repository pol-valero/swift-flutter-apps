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
    var numDigitsEntered: Int = 0; //Number of digits that have been entered one just after the other. A max of 9 digits is allowed


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
        updateResultLabel(value: 0)
        numDigitsEntered = 0;
    }
    
    func convertToScientificNotation(number: Double) -> String {
        let numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = .scientific
        numberFormatter.exponentSymbol = "e"
        numberFormatter.minimumIntegerDigits = 1
        numberFormatter.maximumFractionDigits = 2
        
        numberFormatter.locale = Locale(identifier: "es_ES")
        
        return numberFormatter.string(from: NSNumber(value: number)) ?? String(number)
    }
    
    func convertToDecimalNotation(number: Double) -> String {
        let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.maximumFractionDigits = 5
        
            numberFormatter.locale = Locale(identifier: "es_ES")

            return numberFormatter.string(from: NSNumber(value: number)) ?? String(number)
    }
    
    func updateResultLabel(value: Double) {
        
        if abs(value) >= 1e9 {
            resultLabel.text = convertToScientificNotation(number: value);
        } else {
            resultLabel.text = convertToDecimalNotation(number: value);
        }

    }
    
    
    @IBAction func numberClicked(_ sender: UIButton) {
        
        numDigitsEntered += 1;

        // TAG = Number value
        if hasOperation {
            if hasComma {
                commaCounter += 1
                actualValue2 = actualValue2 + Float64(sender.tag) / pow(10, Float64(commaCounter))
                updateResultLabel(value: actualValue2)
            } else {
                actualValue2 = actualValue2 * 10 + Float64(sender.tag)
                updateResultLabel(value: actualValue2)
            }

        } else {
            if numDigitsEntered <= 9 {
                if hasComma {
                    commaCounter += 1
                    actualValue1 = actualValue1 + Float64(sender.tag) / pow(10, Float64(commaCounter))
                    updateResultLabel(value: actualValue1)
                } else {
                    actualValue1 = actualValue1 * 10 + Float64(sender.tag)
                    updateResultLabel(value: actualValue1)
                }
            }
        }
    }
    
    
    @IBAction func operatorClicked(_ sender: UIButton) {
        
        numDigitsEntered = 0;

        // TAG 1 = + ; 2 = - ; 3 = x ; 4 = /
        if hasOperation {
            performOperation()
            updateResultLabel(value: resultValue)
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
            updateResultLabel(value: resultValue)
        } else {
            updateResultLabel(value: resultValue)
        }
        hasComma = false
        commaCounter = 0
        hasOperation = false
    }
    
    
    
    @IBAction func percentatgeCalculation(_ sender: UIButton) {
        
        numDigitsEntered = 0;
        
        if hasOperation {
            actualValue2 = actualValue2 / 100
            updateResultLabel(value: actualValue2)
        } else {
            actualValue1 = actualValue1 / 100
            updateResultLabel(value: actualValue1)
        }
        hasComma = false
        commaCounter = 0
    }
    
    
    @IBAction func PlusMinusClicked(_ sender: UIButton) {
        if hasOperation {
            actualValue2 = actualValue2 * -1
            updateResultLabel(value: actualValue2)
        } else {
            actualValue1 = actualValue1 * -1
            updateResultLabel(value: actualValue1)
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

