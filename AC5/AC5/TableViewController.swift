//
//  TableViewController.swift
//  AC4
//
//  Created by Angel Garcia on 13/11/23.
//

import UIKit

class TableViewController: UITableViewController {
    
    var weatherData: WeatherResponseData?
    var forecastData: ForecastResponseData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Start loading")
        APIManager.shared.requestWeatherForCity("Barcelona", "es") { (response) in
            print("Stop loading")
            self.weatherData = response
            self.tableView.reloadData()
        }
        
        print("Start loading")
        APIManager.shared.requestForecastForCity("Barcelona", "es") { (response) in
            print("Stop loading")
            self.forecastData = response
            self.tableView.reloadData()
        }
        
        // print the structure saved 
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let forecastData = forecastData {
            return forecastData.list.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)
        
        if let forecastData = forecastData {
            let item = forecastData.list[indexPath.row]
            cell.textLabel?.text = item.date
            cell.detailTextLabel?.text = item.main
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let forecastData = forecastData {
            let item = forecastData.list[indexPath.row]
            print(item.date)
            print("----------------")
            print(item.main)
            print(item.temp)
            print(item.tempMax)
            print(item.tempMin)
            print(item.description)
        }
    }
    
}