//
//  ViewController.swift
//  AC5
//
//  Created by Pol Valero on 3/11/23.
//

import UIKit
import Lottie

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
    
    //UI WEATHER LABELS
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var meteoLabel: UILabel!
    
    @IBOutlet weak var maxMinTempLabel: UILabel!
    /*/              */
    
    //UI FORECAST LABELS
    @IBOutlet weak var d1DateLabel: UILabel!
    @IBOutlet weak var d1MeteoDescriptionLabel: UILabel!
    @IBOutlet weak var d1TempLabel: UILabel!
    
    @IBOutlet weak var d2DateLabel: UILabel!
    @IBOutlet weak var d2MeteoDescriptionLabel: UILabel!
    @IBOutlet weak var d2TempLabel: UILabel!
    
    @IBOutlet weak var d3DateLabel: UILabel!
    @IBOutlet weak var d3MeteoDescriptionLabel: UILabel!
    @IBOutlet weak var d3TempLabel: UILabel!
    
    
    @IBOutlet weak var d4DateLabel: UILabel!
    @IBOutlet weak var d4MeteoDescriptionLabel: UILabel!
    @IBOutlet weak var d4TempLabel: UILabel!

    @IBOutlet weak var d5DateLabel: UILabel!
    @IBOutlet weak var d5MeteoDescriptionLabel: UILabel!
    @IBOutlet weak var d5TempLabel: UILabel!
    /*/               */
    
    @IBOutlet weak var animationView: LottieAnimationView!
    
    
    
    func changeWeatherLabels() {
        cityLabel.text = "Barcelona"
        tempLabel.text = weather.temp! + "ºC"
        meteoLabel.text = weather.meteo! + " - " + weather.meteoDescription!
        maxMinTempLabel.text = "Max. " + weather.maxTemp! + "ºC  " + "Min. " + weather.minTemp! + "ºC "
    }
    
    func changeWeatherForecastLabels() {
        d1DateLabel.text = weatherForecast[0].date
        d1MeteoDescriptionLabel.text = weatherForecast[0].meteo
        d1TempLabel.text = weatherForecast[0].temp! + "ºC"
        
        d2DateLabel.text = weatherForecast[1].date
        d2MeteoDescriptionLabel.text = weatherForecast[1].meteo
        d2TempLabel.text = weatherForecast[1].temp! + "ºC"
        
        d3DateLabel.text = weatherForecast[2].date
        d3MeteoDescriptionLabel.text = weatherForecast[2].meteo
        d3TempLabel.text = weatherForecast[2].temp! + "ºC"
        
        d4DateLabel.text = weatherForecast[3].date
        d4MeteoDescriptionLabel.text = weatherForecast[3].meteo
        d4TempLabel.text = weatherForecast[3].temp! + "ºC"
        
        d5DateLabel.text = weatherForecast[4].date
        d5MeteoDescriptionLabel.text = weatherForecast[4].meteo
        d5TempLabel.text = weatherForecast[4].temp! + "ºC"
    }
    
    func changeWeatherAnimation(meteoType: String) {
        
        var animationName: String
        
        switch meteoType {
            case "Clouds":
                animationName = "clouds_animation"
            case "Clear":
                animationName = "sun_animation"
            case "Snow":
                animationName = "snow_animation"
            case "Rain":
                animationName = "rain_animation"
            case "Thunderstorm":
                animationName = "thunderstorm_animation"
            default:
            animationName = "sun_animation"
            
        }
        
        let subAnimationView = LottieAnimationView(name:animationName)
        animationView.contentMode = .scaleAspectFit
        
        subAnimationView.loopMode = .loop
        subAnimationView.animationSpeed = 0.5
        animationView.addSubview(subAnimationView)
        subAnimationView.frame = animationView.bounds
        subAnimationView.play()
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        APIManager.shared.requestWeatherForCity("Barcelona", "es") {
            (response) in DispatchQueue.main.async {
                self.weather.meteo = response.main
                self.weather.meteoDescription = response.description
                self.weather.temp = response.temp
                self.weather.minTemp = response.tempMin
                self.weather.maxTemp = response.tempMax
                
                //Only if we receive a valid response, we display the information
                if (self.weather.meteo != nil) {
                    self.changeWeatherLabels()
                    self.changeWeatherAnimation(meteoType: self.weather.meteo!)
                }
            }
        }
        

       

        APIManager.shared.requestForecastForCity("Barcelona", "es") {
            (response) in DispatchQueue.main.async {
                
                
                for item in response.list {
                    
                    self.weatherForecast.append(Weather(date: item.date, meteo: item.main, meteoDescription: item.description, temp: item.temp))
                    
                    //print(self.weatherForecast.last)
                }
                
                //Only if we have received the 5 day forecast, we display the information
                if (response.list.count == 5) {
                    self.changeWeatherForecastLabels();
                }
                
            }
        }


    }


}

