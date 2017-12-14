//
//  WeatherClass.swift
//  WeatcherApp
//
//  Created by Mateusz Matejczyk on 09.12.2017.
//  Copyright © 2017 Mateusz Matejczyk. All rights reserved.
//

import Foundation

struct Weather
{
    let summary: String
    let icon: String
    let temperature: Double
    
    enum SerializationError: Error
    {
        case missing(String)
        case invalid(String, Any)
    }
    
    init(json:[String: Any]) throws
    {
        guard let summary = json["summary"] as? String else {throw SerializationError.missing("Summary is missing")}
        
        guard let icon = json["icon"] as? String else {throw SerializationError.missing("Icon is missing")}
        
        guard let temperature = json["temperatureMax"] as? Double else {throw SerializationError.missing("Temperature is missing")}
        
        self.summary = summary
        self.icon = icon
        self.temperature = temperature
    }
    
    static let basePath = "https://api.darksky.net/forecast/f5eddea7702bd57b597af3e6991310c9/"//37.8267,-122.4233"
    
    static func forecast (withLocation location:String, completion: @escaping ([Weather]) -> ())
    {
        let url = basePath + location
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            var forecastArray: [Weather] = []
            
            if let data = data
            {
                do
                {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    {
                        if let dailyForecasts = json["daily"] as? [String: Any]
                        {
                            if let dailyData = dailyForecasts["data"] as? [[String: Any]]
                            {
                                for dataPoint in dailyData
                                {
                                    if let weatherObject = try? Weather(json: dataPoint)
                                    {
                                        forecastArray.append(weatherObject)
                                    }
                                }
                            }
                        }
                    }
                }
                catch
                {
                    print(error.localizedDescription)
                }
                completion(forecastArray)
            }
        }
        task.resume()
    }
}
