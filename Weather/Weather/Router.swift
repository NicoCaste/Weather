//
//  Router.swift
//  Weather
//
//  Created by nicolas castello on 30/08/2022.
//

import Foundation
import UIKit

final class Router {
    
    static func goToWeatherDetail(navigation: UINavigationController, city: Geocoding) {
        let viewController = WeatherDetailViewController(city: city)
        navigation.pushViewController(viewController, animated: true)
    }
}
