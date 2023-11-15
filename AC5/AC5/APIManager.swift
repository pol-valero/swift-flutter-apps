//
//  APIManager.swift
//  NetworkDemo
//
//  Created by Alex Tarragó on 18/11/2019.
//  Modified by Angel García and Pol Valero on 13/11/2023
//  Copyright © 2019 Dribba GmbH. All rights reserved.
//

import Foundation


//https://openweathermap.org/current
private let weatherBaseURL = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=14d86d120590786888ce766c6ff78bb1&q="

private let forecastBaseURL = "https://api.openweathermap.org/data/2.5/forecast?units=metric&appid=14d86d120590786888ce766c6ff78bb1&q="

class APIManager {
    static let shared = APIManager()
    
    init(){ }

    // Network requests
    func requestWeatherForCity(_ city: String, _ countryCode: String,
                               callback: @escaping (_ data: WeatherResponseData) -> Void) {
        
        let request = NSMutableURLRequest(url: NSURL(string: "\(weatherBaseURL)\(city),\(countryCode)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"

        let session = URLSession.shared
        let dataTask = session.dataTask( with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse!.statusCode) // only 200 is a valid response
                
                if let data = data {
                  if let jsonString = String(data: data, encoding: .utf8) {

                    let data = self.convertToDictionary(text: jsonString)
                    //print(data)
                    
                    let main = (data!["weather"]! as! Array<Dictionary<String, Any>>).first!["main"]!
                    let desc = (data!["weather"]! as! Array<Dictionary<String, Any>>).first!["description"]!
                    
                    let temp = "\((data!["main"]! as! Dictionary<String, Any>)["temp"]!)"
                    let mxTp = "\((data!["main"]! as! Dictionary<String, Any>)["temp_max"]!)"
                    let miTp = "\((data!["main"]! as! Dictionary<String, Any>)["temp_min"]!)"

                    let responseData = WeatherResponseData(main: main as! String, description: desc as! String, temp: temp, tempMax: mxTp, tempMin: miTp)
                    
                    callback(responseData)
                    
                  }
                }
            }
            })
        dataTask.resume()
    }
    
    func requestForecastForCity(_ city: String, _ countryCode: String,
                                callback: @escaping (_ data: ForecastResponseData) -> Void) {
        
        let request = NSMutableURLRequest(url: NSURL(string: "\(forecastBaseURL)\(city),\(countryCode)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"

        let session = URLSession.shared
        let dataTask = session.dataTask( with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse!.statusCode) // only 200 is a valid response
                
                if let data = data {
                  if let jsonString = String(data: data, encoding: .utf8) {

                    let data = self.convertToDictionary(text: jsonString)
                    //print(data)
                    
                    var forecastList = [ForecastData]()
                    var lastDate = ""
                    
                    if let list = data!["list"] as? [[String: Any]] {
                        for item in list {
                            if (item["dt_txt"] as! String).contains("00:00:00") {
                                let main = (item["weather"]! as! Array<Dictionary<String, Any>>).first!["main"]!
                                let description = (item["weather"]! as! Array<Dictionary<String, Any>>).first!["description"]!
                                let temp = "\((item["main"]! as! Dictionary<String, Any>)["temp"]!)"
                                let tempMin = "\((item["main"]! as! Dictionary<String, Any>)["temp_max"]!)"
                                let tempMax = "\((item["main"]! as! Dictionary<String, Any>)["temp_min"]!)"
                                let date = (item["dt_txt"] as! String).components(separatedBy: " ").first!
                                
                                let responseData = ForecastData(main: main as! String, description: description as! String, temp: temp, tempMax: tempMax, tempMin: tempMin, date: date)
                                forecastList.append(responseData)
                            }
                        }
                    }
                    
                    let responseData = ForecastResponseData(list: forecastList)
                    
                    callback(responseData)
                    
                  }
                }
            }
            })
        dataTask.resume()
    }
     
    // Helpers
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

}

struct WeatherResponseData {
    var main: String
    var description: String
    var temp: String
    var tempMax: String
    var tempMin: String
}

struct ForecastResponseData {
    var list: [ForecastData]
}

struct ForecastData {
    var main: String
    var description: String
    var temp: String
    var tempMax: String
    var tempMin: String
    var date: String
}



