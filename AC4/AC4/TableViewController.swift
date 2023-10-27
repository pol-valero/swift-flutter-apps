//
//  TableViewController.swift
//  AC4
//
//  Created by Pol Valero on 20/10/23.
//

import UIKit

class TableViewController: UITableViewController, AddTaskViewControllerDelegate {
    
    struct CellInfo: Codable {
        var id: Int
        var title: String
        var isCompleted: Bool
    }
    
    
    var structData: [CellInfo] = []
    
    func addTaskViewControllerResponse(task: String?) {
        
        let newCell = CellInfo(id: task.hashValue, title:task!, isCompleted: false)
        
        structData.append(newCell)
        
        let encoder = JSONEncoder()
        
        do {
            let encodedData = try encoder.encode(structData)
            UserDefaults.standard.set(encodedData, forKey: "remainders")
        } catch {
            print("Error while encoding")
        }
        
        
        tableView.reloadData();
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AddTaskViewController {
            vc.delegate = self
        }
    }
    
    override func viewDidLoad() {
        
        let encodedData = UserDefaults.standard.data(forKey: "remainders")
        
        let decoder = JSONDecoder()
        
        if (encodedData != nil) {
            do {
                structData = try decoder.decode([CellInfo].self, from: encodedData!)
            } catch {
                print("Error while decoding")
            }
        }
        
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return structData.count
    }

    //Objecte que te atribut section i atriut row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let dataS = structData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! CustomTableViewCell
        cell.Title.text = dataS.title
        cell.CheckboxButton.isChecked = dataS.isCompleted
        cell.CheckboxButton.tag = dataS.id

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            structData.remove(at: indexPath.row)
            
            let encoder = JSONEncoder()
            
            do {
                let encodedData = try encoder.encode(structData)
                UserDefaults.standard.set(encodedData, forKey: "remainders")
            } catch {
                print("Error while encoding")
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    
    @IBAction func checkButtonClicked(_ sender: UIButton) {
        for i in structData.indices {
            if (structData[i].id == sender.tag) {
                if (structData[i].isCompleted == true) {
                    structData[i].isCompleted = false
                } else {
                    structData[i].isCompleted = true
                }
            }
        }
        
        
        let encoder = JSONEncoder()
        
        do {
            let encodedData = try encoder.encode(structData)
            UserDefaults.standard.set(encodedData, forKey: "remainders")
        } catch {
            print("Error while encoding")
        }
        

    }
}
