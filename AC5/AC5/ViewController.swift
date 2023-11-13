//
//  ViewController.swift
//  AC5
//
//  Created by Pol Valero on 3/11/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Start loading")
        APIManager.shared.requestWeatherForCity("Barcelona", "es") { (response) in
            print("Stop loading")
            print(response)
            print(response.main)
            print(response.temp)
            print(response.tempMax)
            print(response.tempMin)
            print(response.description)
            print(response)
        }

        print("Start loading")
        APIManager.shared.requestForecastForCity("Barcelona", "es") { (response) in
            print("Stop loading")
            for item in response.list {
                print(item.date)
                print("----------------")
                print(item.main)
                print(item.temp)
                print(item.tempMax)
                print(item.tempMin)
                print(item.description)
            }
        }

        // print the structure saved 

    }


}

