//
//  WeatherAttributes.swift
//  Weather
//
//  Created by nicolas castello on 28/08/2022.
//

import Foundation

struct WeatherAttributes: Codable {
    var dt: Int?
    var main: TempDetail?
    var weather: [Weather]?
    var visibility: Int?
    var wind: Wind?
    var pop: Float?
    var sys: Sys?
    var dtTxt: String
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather,visibility, wind, pop, sys
        case dtTxt = "dt_txt"
    }
}

struct TempDetail: Codable {
    var temp: Float?
    var feelsLike: Float?
    var tempMin: Float?
    var humidity: Int?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin =  "temp_min"
        case humidity
    }
}

struct Weather: Codable {
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}

struct Wind: Codable {
    var speed: Float?
}

struct Sys: Codable {
    var pod: String?
}

enum PartOfTheDay: String {
    case itsMorning = "d"
    case itsNight = "n"
}


