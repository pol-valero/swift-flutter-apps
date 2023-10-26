//
//  TableViewController.swift
//  AC4
//
//  Created by Pol Valero on 20/10/23.
//

import UIKit

class TableViewController: UITableViewController, AddTaskViewControllerDelegate {
    
    func addTaskViewControllerResponse(task: String?) {
        //print(task!)
        
        let newCell = CellInfo(title:task!, selector: false)
        
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
    
    struct CellInfo: Codable {
        var title: String
        var selector: Bool
    }
    
    
    var structData: [CellInfo] = []
    
    
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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        

        //cell.textLabel?.text = myData[indexPath.section][indexPath.row]
        
        cell.Title.text = dataS.title
        cell.Selector.isChecked = false

        return cell
    }
    

    
    //Aquestes dues funcions ens permeten fer automaticament el "swipe to delete"
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        
        //return section == 0 ? "A" : "B"

        
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
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
    ///////////////////////////////////////

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class CheckboxButton: UIButton {
    
    // Images
    let checkedImage = UIImage(named: "checkbox_checked")! as UIImage
    let uncheckedImage = UIImage(named: "checkbox_unchecked")! as UIImage
    
    // Bool property
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: UIControl.State.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
