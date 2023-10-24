//
//  ViewController.swift
//  AC3
//
//  Created by Angel Garcia on 24/10/23.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var taskTextField: UITextField!
    
    @IBOutlet weak var addTaskButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func addButtonClicked(_ sender: UIButton) {
        print(taskTextField.text!)
    }
}
