//
//  YahooWeather.swift
//  YahooWeatherApp
//
//  Created by MANOJ AHER on 5/23/18.
//  Copyright © 2018 MANOJ AHER. All rights reserved.
//

import UIKit

protocol JsonParser: class {
    func parseJson(_ dictionary: [String: Any])
}

class Units: JsonParser {
    var distance: String?
    var pressure: String?
    var speed: String?
    var temperature: String?
    
    func parseJson(_ dictionary: [String : Any]) {
        if let value = dictionary["distance"] as? String {
            distance = value
        }
        if let value = dictionary["pressure"] as? String {
            pressure = value
        }
        if let value = dictionary["speed"] as? String {
            speed = value
        }
        if let value = dictionary["temperature"] as? String {
            temperature = value
        }
    }
}

class Location: JsonParser {
    var city: String?
    var country: String?
    var region: String?
    
    func parseJson(_ dictionary: [String : Any]) {
        if let value = dictionary["city"] as? String {
            city = value
        }
        if let value = dictionary["country"] as? String {
            country = value
        }
        if let value = dictionary["region"] as? String {
            region = value
        }
    }
}

class Wind: JsonParser {
    var chill: Int?
    var direction: Int?
    var speed: Float?
    func parseJson(_ dictionary: [String : Any]) {
        if let value = dictionary["chill"] as? String, let chillValue = Int(value) {
            chill = chillValue
        }
        if let value = dictionary["direction"] as? String, let directionValue = Int(value) {
            direction = directionValue
        }
        if let value = dictionary["speed"] as? String, let speedValue = Float(value) {
            speed = speedValue
        }
    }
}

class Atmosphere: JsonParser {
    var humidity: Int?
    var pressure: Float?
    var rising: Int?
    var visibility: Float?
    func parseJson(_ dictionary: [String : Any]) {
        if let value = dictionary["humidity"] as? String, let humidityValue = Int(value) {
            humidity = humidityValue
        }
        if let value = dictionary["pressure"] as? String, let pressureValue = Float(value) {
            pressure = pressureValue
        }
        if let value = dictionary["rising"] as? String, let risingValue = Int(value) {
            rising = risingValue
        }
        if let value = dictionary["visibility"] as? String, let visibilityValue = Float(value) {
            visibility = visibilityValue
        }
    }
}

class Astronomy: JsonParser {
    var sunrise: String?
    var sunset: String?
    func parseJson(_ dictionary: [String : Any]) {
        if let value = dictionary["sunrise"] as? String {
            sunrise = value
        }
        if let value = dictionary["sunset"] as? String {
            sunset = value
        }
    }
}

enum CurrentDay: String {
    case Sun = "Sun", Mon = "Mon", Tue = "Tue", Wed = "Wed", Thu = "Thu", Fri = "Fri", Sat = "Sat"
}

class Forecast: JsonParser {
    var date: Date?
    var displayDate: String?
    var day: CurrentDay?
    var highTemprature: Int?
    var lowTemprature: Int?
    var status: String?
    
    func parseJson(_ dictionary: [String : Any]) {
        if let value = dictionary["date"] as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            if let date = dateFormatter.date(from: value) {
                self.date = date
                dateFormatter.dateFormat = "dd MMM"
                displayDate = dateFormatter.string(from: date)
            }
        }
        if let value = dictionary["day"] as? String {
            day = CurrentDay(rawValue: value)
        }
        if let value = dictionary["high"] as? String, let highValue = Int(value) {
            highTemprature = highValue
        }
        if let value = dictionary["low"] as? String, let lowValue = Int(value) {
            lowTemprature = lowValue
        }
        if let value = dictionary["text"] as? String {
            status = value
        }
    }
}

class Condition : JsonParser {
    var temp: String?
    var text : String?
    
    func parseJson(_ dictionary: [String : Any]) {
        if let value = dictionary["temp"] as? String {
            temp = value
        }
        if let value = dictionary["text"] as? String {
            text = value
        }
    }
}

class Weather: JsonParser {
    var condition: Condition?
    var units: Units?
    var location: Location?
    var wind: Wind?
    var atmosphere: Atmosphere?
    var astronomy: Astronomy?
    var todaysCondtion: Forecast?
    var forcast: [Forecast]?
    
    func parseJson(_ dictionary: [String : Any]) {
        
        if let astronomyDict = dictionary["astronomy"] as? [String: Any] {
            astronomy = Astronomy()
            astronomy!.parseJson(astronomyDict)
        }
        if let locationDict = dictionary["location"] as? [String : Any] {
            location = Location()
            location?.parseJson(locationDict)
        }
        if let atmosphereDict = dictionary["atmosphere"] as? [String : Any] {
            atmosphere = Atmosphere()
            atmosphere?.parseJson(atmosphereDict)
        }
        if let item = dictionary["item"] as? [String : Any], let forecastArray = item["forecast"] as? [[String: Any]] {
            var forecastItems = [Forecast]()
            forecastArray.forEach { (forecastDict) in
                let forecast = Forecast()
                forecast.parseJson(forecastDict)
                forecastItems.append(forecast)
            }
            forcast = forecastItems
        }
        if let item = dictionary["item"] as? [String : Any], let conditionDict = item["condition"] as? [String: Any] {
            condition = Condition()
            condition!.parseJson(conditionDict)
        }
    }
}
