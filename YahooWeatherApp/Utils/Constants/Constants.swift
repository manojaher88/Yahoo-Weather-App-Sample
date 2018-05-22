//
//  Constants.swift
//  YahooWeatherApp
//
//  Created by MANOJ AHER on 5/23/18.
//  Copyright © 2018 MANOJ AHER. All rights reserved.
//

import Foundation
import UIKit

let baseURL = "https://query.yahooapis.com/v1/public/yql?q="

private let heavyRain = ["tornado", "tropical storm", "hurricane", "severe thunderstorms", "thunderstorms", "mixed rain and snow", "mixed rain and sleet", "mixed snow and sleet", "partly cloudy", "thundershowers", "isolated thundershowers", "mixed rain and hail", "isolated thunderstorms", "scattered thunderstorms", "scattered thunderstorms", "scattered showers"]
private let rain = ["freezing drizzle", "drizzle", "freezing rain", "showers", "showers", "snow flurries", "light snow showers"]
private let snow = ["blowing snow", "snow", "hail", "sleet", "dust", "foggy", "haze", "smoky", "blustery", "windy", "snow showers", "heavy snow", "scattered snow showers", "heavy snow", "snow showers"]
private let cold = ["cold", "cloudy", "mostly cloudy (night)", "mostly cloudy", "partly cloudy", "partly cloudy (day)", "clear"]
private let sunny = ["sunny", "fair", "fair (day)", "hot"]

func getImage(forWeatherStatus status: String)-> UIImage {
    var image = #imageLiteral(resourceName: "snowflake")
    let weatherStatus = status.lowercased()
    if heavyRain.contains(weatherStatus) {
        image = #imageLiteral(resourceName: "storm")
    } else if rain.contains(weatherStatus) {
        image = #imageLiteral(resourceName: "cloud")
    } else if cold.contains(weatherStatus) {
        image = #imageLiteral(resourceName: "snowflake")
    } else if sunny.contains(weatherStatus) {
        image = #imageLiteral(resourceName: "sun")
    }
    return image
}

func getQueryString(for location: Location)-> String? {
    if let city = location.city, let country =  location.country {
        let cityCountry = "\(city), \(country)"
        let query = baseURL + "select * from weather.forecast where woeid in (select woeid from geo.places(1) where text=\"\(cityCountry)\") and u=\"c\"&format=json"
        return query
    }
    return nil
}
