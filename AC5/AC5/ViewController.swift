//
//  ViewController.swift
//  AC5
//
//  Created by Pol Valero on 3/11/23.
//

import UIKit

class ViewController: UIViewController {
    
    struct Weather {
        var date: String?
        var meteo: String?
        var meteoDescription: String?
        var temp: String?
        var minTemp: String?
        var maxTemp: String?
    }
    
    var weather: Weather = Weather()
    
    var weatherForecast: [Weather] = []

    override func viewDidLoad() {

        super.viewDidLoad()
        
        APIManager.shared.requestWeatherForCity("Barcelona", "es") { (response) in
            self.weather.meteo = response.main
            self.weather.meteoDescription = response.description
            self.weather.temp = response.temp
            self.weather.minTemp = response.tempMin
            self.weather.maxTemp = response.tempMax
         
            print(self.weather)
        }

        APIManager.shared.requestForecastForCity("Barcelona", "es") { (response) in
            
            for item in response.list {
                print("----------------")
                
                self.weatherForecast.append(Weather(date: item.date, meteo: item.main, meteoDescription: item.description, temp: item.temp))
                
                print(self.weatherForecast.last)
            }
        }

        // print the structure saved

    }


}

