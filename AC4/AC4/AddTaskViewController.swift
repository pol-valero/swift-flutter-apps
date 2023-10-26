//
//  ViewController.swift
//  AC3
//
//  Created by Angel Garcia on 24/10/23.
//

import UIKit

protocol AddTaskViewControllerDelegate {
    
    func addTaskViewControllerResponse(task: String?)
    
}

class AddTaskViewController: UIViewController {
    
    var delegate: AddTaskViewControllerDelegate?
    
    @IBOutlet weak var taskTextField: UITextField!
    
    @IBOutlet weak var addTaskButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func addButtonClicked(_ sender: UIButton) {
        //print(taskTextField.text!)
        
        if (!taskTextField.text!.isEmpty) {
            self.delegate?.addTaskViewControllerResponse(task: taskTextField.text)
            self.navigationController?.popViewController(animated: true)
       }
        
    }
}
