//
//  WeatherForecast.swift
//  Weather
//
//  Created by nicolas castello on 28/08/2022.
//

import Foundation
import UIKit

struct WeatherForecast: Codable {
    var list: [WeatherAttributes]?
    var city: City?
}

struct WeatherForecastCard {
    var weather: WeatherAttributes?
    var weatherImage: UIImage?
    var dayName: String?
}

