//
//  ViewController.swift
//  Weather
//
//  Created by nicolas castello on 28/08/2022.
//

import UIKit

class HomeViewController: UIViewController {
    var service: AlamofireWebService?
    var callApi: WeatherApiRepository?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let weatherColor = getColorWeatherConditionFor(id: 501)
        self.view.gradientBackground(topColor: weatherColor.topColor, bottomColor: weatherColor.bottomColor)
    }
}
